Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101B9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D669F2183F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553910038;
	bh=eBZUywteNKvuDQ3xoiq3Xg8hQIPWQ4S+HTBb1ym2EiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hJdZGkGqaelS0MyvOAHPIvzIHPAnc5kbImwh3UIhCrzIRxWlQTGBMSxu2yHCzz0ah
	 MlUfZKJBi8y5/C2lB9XGf6UYk4QJLqoqTfOSYrAW71VGNHSxk2c7CJlQO1X+5Uj+5V
	 qhWPMyqJvtJmeF5Xgy7TehYE+QkA5mxvKlPKRkh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbfC3B3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730941AbfC3B33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:29:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D69E2217F5;
        Sat, 30 Mar 2019 01:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909368;
        bh=eBZUywteNKvuDQ3xoiq3Xg8hQIPWQ4S+HTBb1ym2EiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PBB+Z4zN5or8naJMMurz+xp1HuEt8nb5nJDYCv03jPJgzZWuZ5M8nUjLh0dz+TRES
         XwUBQzIZ/usjhVFX5dULW7gsFALUSNCkNniQnHucawKhix27JrrOSyn86mqHtspqna
         Fi/7mmmVIIKd/zqSfsIithri0WIYZv9J7pKGr7sc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yanjiang Jin <yanjiang.jin@hxt-semitech.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 15/57] pinctrl: core: make sure strcmp() doesn't get a null parameter
Date:   Fri, 29 Mar 2019 21:28:08 -0400
Message-Id: <20190330012854.32212-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330012854.32212-1-sashal@kernel.org>
References: <20190330012854.32212-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanjiang Jin <yanjiang.jin@hxt-semitech.com>

[ Upstream commit 54a58185bfafb5af5045fb8388c45daa373f90f3 ]

Some drivers, for example, QCOM's qdf2xxx, set groups[gpio].name only
when gpio is valid, and leave invalid gpio names as null.
If we want to access the sys node "pinconf-groups",
pinctrl_get_group_selector() -> get_group_name() may return a null
pointer if group_selector is invalid, then the below Kernel panic
would happen since strcmp() uses this null pointer to do comparison.

 Unable to handle kernel NULL pointer dereference at ss 00000000
el:Internal error: Oops: 9600000[ 143.080279]
SMP
 CPU: 19 PID: 2493 Comm: read_all Tainted: G O
.aarch64 #1
 Hardware name: HXT Semiconductor HXT REP-2 System
 PC is at strcmp+0x18/0x154
 LR is at pinctrl_get_group_selector+0x6c/0xe8
 Process read_all (pid: 2493, stack limit =
 Call trace:
 Exception stack
  strcmp+0x18/0x154
  pin_config_group_get+0x64/0xd8
  pinconf_generic_dump_one+0xd8/0x1c0
  pinconf_generic_dump_pins+0x94/0xc8
  pinconf_groups_show+0xb4/0x104
  seq_read+0x178/0x464
  full_proxy_read+0x6c/0xac
  __vfs_read+0x58/0x178
  vfs_read+0x94/0x164
  SyS_read+0x60/0xc0
  __sys_trace_return+0x0/0x4
 --[ end trace]--
 Kernel panic - not syncing: Fatal exception

Signed-off-by: Yanjiang Jin <yanjiang.jin@hxt-semitech.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index a3dd777e3ce8..c6ff4d5fa482 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -627,7 +627,7 @@ static int pinctrl_generic_group_name_to_selector(struct pinctrl_dev *pctldev,
 	while (selector < ngroups) {
 		const char *gname = ops->get_group_name(pctldev, selector);
 
-		if (!strcmp(function, gname))
+		if (gname && !strcmp(function, gname))
 			return selector;
 
 		selector++;
@@ -743,7 +743,7 @@ int pinctrl_get_group_selector(struct pinctrl_dev *pctldev,
 	while (group_selector < ngroups) {
 		const char *gname = pctlops->get_group_name(pctldev,
 							    group_selector);
-		if (!strcmp(gname, pin_group)) {
+		if (gname && !strcmp(gname, pin_group)) {
 			dev_dbg(pctldev->dev,
 				"found group selector %u for %s\n",
 				group_selector,
-- 
2.19.1

