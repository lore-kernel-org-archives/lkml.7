Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6430C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B632073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJgBms1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLJDQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:16:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44830 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfLJDQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:16:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so8136361pgl.11;
        Mon, 09 Dec 2019 19:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=imXSRcF79p7zRU8eZILnFm4yRgZTTUTeHA1X9zKiY0U=;
        b=pJgBms1g1UcPpVX+vKw/N8r7Up30VtAHB1D7hKiulOf/aQnnHwStqiDLdZoOEHpkJo
         SeeUUHW+dCGkIJykyTK1E4NrEQSen+Le5wG2qezeFd0LAIHPNYwk82/58EA2YlfLIFWF
         4WWHSOTeFNcvkC7wR5hq6Ixqv4eFQBQ0c80wJdByCck9veLj48OB7wQix4/JD6kzxyrB
         Gyy6Q26xfMPQHIvzS/SPwuclF49thWTZWP6jJgya1wdzBuyFfMVEOCK960TdUp7SnK8D
         FXXvRkx7xx4HgucJQlDJINnx3dqsWFPfTujejG6gCTMJRrjFd99EoDMvBe/fpRszuU7y
         fk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=imXSRcF79p7zRU8eZILnFm4yRgZTTUTeHA1X9zKiY0U=;
        b=h+vV3o6ZekafwLeGiRrg3BelzFBD9n17i3fcIMUaE9cNYsjbpQ9aKlOOg6+Pf6ysJN
         jjiDXltBYizpdflupYSkehcWvnIGar0nre2RjmLpyCIYXvFSnmWWv0YY6daVjS+V9jho
         MPzXyWpllFfOm/gvvgnXWXHZdTo92lUCzKb6U70JWeVgcGQG4iRlMYMuO5anRa3cM5aI
         aRDgNFeqVapLx81zKVO1FsavlDWE7NSEWJADWcnIUnfhIbZtr9SusHG+sqMhX9Dr0+H7
         39tjQHdKKYH60u9iMsC3dNHFaGJ2CVMvfxfOqYtoK0VsTqRFCobN65oi0SR3h8fAHmDr
         EG0g==
X-Gm-Message-State: APjAAAUcq3hEtTZPm6Xu8rw70s334k0cT1wmlOZRcXXkH6ByBzwtl+GQ
        q82dBa1twcIZqpnehwlk23Q=
X-Google-Smtp-Source: APXvYqwRPEK+Z0oK7uYtjcgn3TFGrpgZn1B2hchI7Ns66z49hTRKr0VxYBSh1OQTRnoIYpA38gOcPg==
X-Received: by 2002:a63:4f05:: with SMTP id d5mr21867607pgb.341.1575947770087;
        Mon, 09 Dec 2019 19:16:10 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id s1sm956236pgk.9.2019.12.09.19.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 19:16:09 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@linux.intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] x86/platform/goldfish: add a check for platform_device_register_simple
Date:   Tue, 10 Dec 2019 11:15:59 +0800
Message-Id: <20191210031559.18715-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

goldfish_init() misses a check for platform_device_register_simple().
Add a check to fix it.

Fixes: ddd70cf93d78 ("goldfish: platform device for x86")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Use PLATFORM_DEVID_NONE instead of -1.
  - Use PTR_ERR_OR_ZERO() to simplify the code.

 arch/x86/platform/goldfish/goldfish.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/goldfish/goldfish.c b/arch/x86/platform/goldfish/goldfish.c
index 6b6f8b4360dd..736f3fba234d 100644
--- a/arch/x86/platform/goldfish/goldfish.c
+++ b/arch/x86/platform/goldfish/goldfish.c
@@ -44,11 +44,14 @@ __setup("goldfish", goldfish_setup);
 
 static int __init goldfish_init(void)
 {
+	struct platform_device *pdev;
+
 	if (!goldfish_enable)
 		return -ENODEV;
 
-	platform_device_register_simple("goldfish_pdev_bus", -1,
-					goldfish_pdev_bus_resources, 2);
-	return 0;
+	pdev =  platform_device_register_simple("goldfish_pdev_bus",
+					 PLATFORM_DEVID_NONE,
+					 goldfish_pdev_bus_resources, 2);
+	return PTR_ERR_OR_ZERO(pdev);
 }
 device_initcall(goldfish_init);
-- 
2.24.0

