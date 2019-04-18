Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCE6C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31D32064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555612305;
	bh=9dYun8rVuXmR92OQcnQbnMiLZwOPW92CXr+aDxP4rjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sgdk/o5cRyDQfSz7DafTRzaXAR4bdA8m1WQPpyAMQO0zeaG4aVSKVjYVn9i+N84jm
	 jFXKREq871g73Ya6laLrk2CNoFxQkJrxY0a86UvFWsdX2LATca7mMfRmlK+cTpEbo9
	 2uDPa7B4LSYg8SAc7xOIK7k2wOxyQdfUmQihXfwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390122AbfDRSbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:31:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389998AbfDRSAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:00:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 353E7217FA;
        Thu, 18 Apr 2019 18:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610450;
        bh=9dYun8rVuXmR92OQcnQbnMiLZwOPW92CXr+aDxP4rjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IItwOSawb9KRR8tQICQlYw59WD3kjlXnsfbmMoPvm0XN32EB1b+meMUuy3IWJV9jm
         umc37DsqOdOeu7vw+nXgb66WbA7wYKNYZWqRVI+iR9m4bbqz8F+/E1tPN9FYK5YWPL
         /2nw+svPho5RFeBZlE8JTreUqifayRFNlAIl/HfI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yanjiang Jin <yanjiang.jin@hxt-semitech.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 067/110] pinctrl: core: make sure strcmp() doesnt get a null parameter
Date:   Thu, 18 Apr 2019 19:56:56 +0200
Message-Id: <20190418160444.716957105@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



