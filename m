Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CE1C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E26216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934427;
	bh=Rq1qE4Q+NB15mQzhFLDDE6hKkM47OvHr+VRz5Ui1n4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lPicD19MfanwczYKQ5ncSkwA7f0qh3jZW+mWH0v+t4WovjL2pH2odNFxyi2IBQnj1
	 dEYPkhKCQPO6RfrOq+PpQYXdqwHROcDjQEd6Dh5IPzRVQRJ3d0A270iK6vXQmBjsws
	 jFtKHffTCQ98/CvcoVsl1eespl/vH8bDQxrcWOGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfGLM1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728531AbfGLM1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:27:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C19621019;
        Fri, 12 Jul 2019 12:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934419;
        bh=Rq1qE4Q+NB15mQzhFLDDE6hKkM47OvHr+VRz5Ui1n4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WHOKmxoqntiKzBWzqQJrp642TfS/pKrHtdFK+oatXRsXXpkoFHSX0NaW6JOio993f
         CkDweI0fryafF/m/WhuwY/HJxabf2iVGWnnjDE7sDgz1orTXLXpHE5M5ELF+L0E99V
         zih9jZyvAFaLBVcKuUm+yzR1OJ/F9IpqvkSuNNis=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 049/138] Input: imx_keypad - make sure keyboard can always wake up system
Date:   Fri, 12 Jul 2019 14:18:33 +0200
Message-Id: <20190712121630.544937655@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ce9a53eb3dbca89e7ad86673d94ab886e9bea704 ]

There are several scenarios that keyboard can NOT wake up system
from suspend, e.g., if a keyboard is depressed between system
device suspend phase and device noirq suspend phase, the keyboard
ISR will be called and both keyboard depress and release interrupts
will be disabled, then keyboard will no longer be able to wake up
system. Another scenario would be, if a keyboard is kept depressed,
and then system goes into suspend, the expected behavior would be
when keyboard is released, system will be waked up, but current
implementation can NOT achieve that, because both depress and release
interrupts are disabled in ISR, and the event check is still in
progress.

To fix these issues, need to make sure keyboard's depress or release
interrupt is enabled after noirq device suspend phase, this patch
moves the suspend/resume callback to noirq suspend/resume phase, and
enable the corresponding interrupt according to current keyboard status.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/imx_keypad.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 539cb670de41..ae9c51cc85f9 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -526,11 +526,12 @@ static int imx_keypad_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused imx_kbd_suspend(struct device *dev)
+static int __maybe_unused imx_kbd_noirq_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct imx_keypad *kbd = platform_get_drvdata(pdev);
 	struct input_dev *input_dev = kbd->input_dev;
+	unsigned short reg_val = readw(kbd->mmio_base + KPSR);
 
 	/* imx kbd can wake up system even clock is disabled */
 	mutex_lock(&input_dev->mutex);
@@ -540,13 +541,20 @@ static int __maybe_unused imx_kbd_suspend(struct device *dev)
 
 	mutex_unlock(&input_dev->mutex);
 
-	if (device_may_wakeup(&pdev->dev))
+	if (device_may_wakeup(&pdev->dev)) {
+		if (reg_val & KBD_STAT_KPKD)
+			reg_val |= KBD_STAT_KRIE;
+		if (reg_val & KBD_STAT_KPKR)
+			reg_val |= KBD_STAT_KDIE;
+		writew(reg_val, kbd->mmio_base + KPSR);
+
 		enable_irq_wake(kbd->irq);
+	}
 
 	return 0;
 }
 
-static int __maybe_unused imx_kbd_resume(struct device *dev)
+static int __maybe_unused imx_kbd_noirq_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct imx_keypad *kbd = platform_get_drvdata(pdev);
@@ -570,7 +578,9 @@ static int __maybe_unused imx_kbd_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(imx_kbd_pm_ops, imx_kbd_suspend, imx_kbd_resume);
+static const struct dev_pm_ops imx_kbd_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_kbd_noirq_suspend, imx_kbd_noirq_resume)
+};
 
 static struct platform_driver imx_keypad_driver = {
 	.driver		= {
-- 
2.20.1



