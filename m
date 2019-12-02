Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A21DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E21D20665
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="j0V/rYCy";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="j0V/rYCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfLBRss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:48:48 -0500
Received: from node.akkea.ca ([192.155.83.177]:34770 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727855AbfLBRsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:48:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id B62A94E2010;
        Mon,  2 Dec 2019 17:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1575308922; bh=CpVCZDDbV8uONbAOWgK1IYDM4Mmn8FjXn3PCDH2bR4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=j0V/rYCy0j9OOJs9b0zzjvCfxNIrV4m4PevJsbWiW6riW7EUmUPZpJtI8WiQnBxug
         7kPJUz8JhPc8EBwIxxeT6PwsJDj1AJExVp1droQt7kaEKhG+1C/7VLZljv558EJncH
         JJTKUrFHh9KmkQAhoQPZeUI2mpYu4MVCdfD0v15Y=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id etR8VgNhfgfP; Mon,  2 Dec 2019 17:48:42 +0000 (UTC)
Received: from thinkpad-tablet.cg.shawcable.net (S0106905851b613e9.cg.shawcable.net [70.77.244.40])
        by node.akkea.ca (Postfix) with ESMTPSA id 933D74E2003;
        Mon,  2 Dec 2019 17:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1575308922; bh=CpVCZDDbV8uONbAOWgK1IYDM4Mmn8FjXn3PCDH2bR4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=j0V/rYCy0j9OOJs9b0zzjvCfxNIrV4m4PevJsbWiW6riW7EUmUPZpJtI8WiQnBxug
         7kPJUz8JhPc8EBwIxxeT6PwsJDj1AJExVp1droQt7kaEKhG+1C/7VLZljv558EJncH
         JJTKUrFHh9KmkQAhoQPZeUI2mpYu4MVCdfD0v15Y=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     kernel@puri.sm
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH 2/2] ASoC: gtm601: add the broadmobi interface
Date:   Mon,  2 Dec 2019 10:48:31 -0700
Message-Id: <20191202174831.13638-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202174831.13638-1-angus@akkea.ca>
References: <20191202174831.13638-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadmobi BM818 uses a different sample rate and channels from the
option modem.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 Documentation/devicetree/bindings/sound/gtm601.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/gtm601.txt b/Documentation/devicetree/bindings/sound/gtm601.txt
index 5efc8c068de0..efa32a486c4a 100644
--- a/Documentation/devicetree/bindings/sound/gtm601.txt
+++ b/Documentation/devicetree/bindings/sound/gtm601.txt
@@ -1,10 +1,16 @@
 GTM601 UMTS modem audio interface CODEC
 
-This device has no configuration interface. Sample rate is fixed - 8kHz.
+This device has no configuration interface. The sample rate and channels are
+based on the compatible string
+	"option,gtm601" = 8kHz mono
+	"broadmobi,bm818" = 48KHz stereo
 
 Required properties:
 
-  - compatible : "option,gtm601"
+  - compatible : one of
+	"option,gtm601"
+	"broadmobi,bm818"
+
 
 Example:
 
-- 
2.17.1

