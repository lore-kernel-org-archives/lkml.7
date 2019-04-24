Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87E6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76958218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116735;
	bh=6qAI7fJ7e2F0lJsxg6+VSFVCrcR0c9EDtMrck61P3eE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bne/Juk9/0gBr4jpICaCd6zRGzBemCa4rnFCLUoq3QxVeo4jHh9H7SfwToUSmZExI
	 r/CrPtgXhNBfPOwxsp2sHzAlDz/Xm7+ynFogaGAUYofgC7sU/QGsHvkPFr3k40a9jY
	 6U3EDc8BdkjTVjdCoouEaTVdrK4R2fcuL8plw3nM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbfDXOiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731292AbfDXOfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:35:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 259682089F;
        Wed, 24 Apr 2019 14:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116508;
        bh=6qAI7fJ7e2F0lJsxg6+VSFVCrcR0c9EDtMrck61P3eE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NUUSwYsUVyajP0esFDwI46qA7ISJc7zxotvrMd4wuX/4zQswbez37QGvSVRhOFk8f
         FyHODQTSWj90OGPkL71CmoPt5R4rCQlSXRxOprQLO1ie85fHCD6RixGoq1hdNdNzJ4
         HJGC869jcrqi7jcwkxdZBumq0ezEGudlDLfPGFUQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 35/66] mfd: twl-core: Disable IRQ while suspended
Date:   Wed, 24 Apr 2019 10:33:09 -0400
Message-Id: <20190424143341.27665-35-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Kemnade <andreas@kemnade.info>

[ Upstream commit 20bb907f7dc82ecc9e135ad7067ac7eb69c81222 ]

Since commit 6e2bd956936 ("i2c: omap: Use noirq system sleep pm ops to idle device for suspend")
on gta04 we have handle_twl4030_pih() called in situations where pm_runtime_get()
in i2c-omap.c returns -EACCES.

[   86.474365] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
[   86.485473] printk: Suspending console(s) (use no_console_suspend to debug)
[   86.555572] Disabling non-boot CPUs ...
[   86.555664] Successfully put all powerdomains to target state
[   86.563720] twl: Read failed (mod 1, reg 0x01 count 1)
[   86.563751] twl4030: I2C error -13 reading PIH ISR
[   86.563812] twl: Read failed (mod 1, reg 0x01 count 1)
[   86.563812] twl4030: I2C error -13 reading PIH ISR
[   86.563873] twl: Read failed (mod 1, reg 0x01 count 1)
[   86.563903] twl4030: I2C error -13 reading PIH ISR

This happens when we wakeup via something behing twl4030 (powerbutton or rtc
alarm). This goes on for minutes until the system is finally resumed.
Disable the irq on suspend and enable it on resume to avoid
having i2c access problems when the irq registers are checked.

Fixes: 6e2bd956936 ("i2c: omap: Use noirq system sleep pm ops to idle device for suspend")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/mfd/twl-core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 299016bc46d9..104477b512a2 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1245,6 +1245,28 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	return status;
 }
 
+static int __maybe_unused twl_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (client->irq)
+		disable_irq(client->irq);
+
+	return 0;
+}
+
+static int __maybe_unused twl_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (client->irq)
+		enable_irq(client->irq);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(twl_dev_pm_ops, twl_suspend, twl_resume);
+
 static const struct i2c_device_id twl_ids[] = {
 	{ "twl4030", TWL4030_VAUX2 },	/* "Triton 2" */
 	{ "twl5030", 0 },		/* T2 updated */
@@ -1262,6 +1284,7 @@ static const struct i2c_device_id twl_ids[] = {
 /* One Client Driver , 4 Clients */
 static struct i2c_driver twl_driver = {
 	.driver.name	= DRIVER_NAME,
+	.driver.pm	= &twl_dev_pm_ops,
 	.id_table	= twl_ids,
 	.probe		= twl_probe,
 	.remove		= twl_remove,
-- 
2.19.1

