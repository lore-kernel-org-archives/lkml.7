Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAE2C2D0DA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5709C20748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577643383;
	bh=sslbX3x4OU3RFp84ix1ezig+c0izi2IYrxJHfiJII88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D7S5n6S/op7aBgKP56VgQ97bpTrQ3i0XJLyrY4/9CpIr3sMsU1uvBL3WwVmHPyNXZ
	 e+9BQD96oZ2DWsTxlcLgB6ZHiFfxCDu3EYwQPnr9H64W9UeYa1GFdi/2obF1K4Qgyf
	 cIE4KZgxL4FP100Rt3Qx8s25YvdaXdbAcJn9nGUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfL2RYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:24:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbfL2RY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:24:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A790C20722;
        Sun, 29 Dec 2019 17:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640265;
        bh=sslbX3x4OU3RFp84ix1ezig+c0izi2IYrxJHfiJII88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vj2ZkAbwIArV6ESDyMEr5hm4rU42sCMCccL6wFGOqp1dY+FIBhNDIkWLNMEAYk+HO
         PYukEISyvHHY4XA5pwRaKu4AOBXDoM90VevmFaseKRvBiT189IxWeNqSsTzBqeFUhM
         jexh6q/jXh2v8L+wNDbzZLe+JoA2eGW6AwOaF+hI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Elena Petrova <lenaptr@google.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 038/161] pinctrl: devicetree: Avoid taking direct reference to device name string
Date:   Sun, 29 Dec 2019 18:18:06 +0100
Message-Id: <20191229162411.529458684@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162355.500086350@linuxfoundation.org>
References: <20191229162355.500086350@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

[ Upstream commit be4c60b563edee3712d392aaeb0943a768df7023 ]

When populating the pinctrl mapping table entries for a device, the
'dev_name' field for each entry is initialised to point directly at the
string returned by 'dev_name()' for the device and subsequently used by
'create_pinctrl()' when looking up the mappings for the device being
probed.

This is unreliable in the presence of calls to 'dev_set_name()', which may
reallocate the device name string leaving the pinctrl mappings with a
dangling reference. This then leads to a use-after-free every time the
name is dereferenced by a device probe:

  | BUG: KASAN: invalid-access in strcmp+0x20/0x64
  | Read of size 1 at addr 13ffffc153494b00 by task modprobe/590
  | Pointer tag: [13], memory tag: [fe]
  |
  | Call trace:
  |  __kasan_report+0x16c/0x1dc
  |  kasan_report+0x10/0x18
  |  check_memory_region
  |  __hwasan_load1_noabort+0x4c/0x54
  |  strcmp+0x20/0x64
  |  create_pinctrl+0x18c/0x7f4
  |  pinctrl_get+0x90/0x114
  |  devm_pinctrl_get+0x44/0x98
  |  pinctrl_bind_pins+0x5c/0x450
  |  really_probe+0x1c8/0x9a4
  |  driver_probe_device+0x120/0x1d8

Follow the example of sysfs, and duplicate the device name string before
stashing it away in the pinctrl mapping entries.

Cc: Linus Walleij <linus.walleij@linaro.org>
Reported-by: Elena Petrova <lenaptr@google.com>
Tested-by: Elena Petrova <lenaptr@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20191002124206.22928-1-will@kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/devicetree.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index c4aa411f5935..3a7c2d6e4d5f 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -40,6 +40,13 @@ struct pinctrl_dt_map {
 static void dt_free_map(struct pinctrl_dev *pctldev,
 		     struct pinctrl_map *map, unsigned num_maps)
 {
+	int i;
+
+	for (i = 0; i < num_maps; ++i) {
+		kfree_const(map[i].dev_name);
+		map[i].dev_name = NULL;
+	}
+
 	if (pctldev) {
 		const struct pinctrl_ops *ops = pctldev->desc->pctlops;
 		if (ops->dt_free_map)
@@ -74,7 +81,13 @@ static int dt_remember_or_free_map(struct pinctrl *p, const char *statename,
 
 	/* Initialize common mapping table entry fields */
 	for (i = 0; i < num_maps; i++) {
-		map[i].dev_name = dev_name(p->dev);
+		const char *devname;
+
+		devname = kstrdup_const(dev_name(p->dev), GFP_KERNEL);
+		if (!devname)
+			goto err_free_map;
+
+		map[i].dev_name = devname;
 		map[i].name = statename;
 		if (pctldev)
 			map[i].ctrl_dev_name = dev_name(pctldev->dev);
@@ -82,10 +95,8 @@ static int dt_remember_or_free_map(struct pinctrl *p, const char *statename,
 
 	/* Remember the converted mapping table entries */
 	dt_map = kzalloc(sizeof(*dt_map), GFP_KERNEL);
-	if (!dt_map) {
-		dt_free_map(pctldev, map, num_maps);
-		return -ENOMEM;
-	}
+	if (!dt_map)
+		goto err_free_map;
 
 	dt_map->pctldev = pctldev;
 	dt_map->map = map;
@@ -93,6 +104,10 @@ static int dt_remember_or_free_map(struct pinctrl *p, const char *statename,
 	list_add_tail(&dt_map->node, &p->dt_maps);
 
 	return pinctrl_register_map(map, num_maps, false);
+
+err_free_map:
+	dt_free_map(pctldev, map, num_maps);
+	return -ENOMEM;
 }
 
 struct pinctrl_dev *of_pinctrl_get(struct device_node *np)
-- 
2.20.1



