Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4E3C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7325A21019
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIGeZss5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfEVSqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:46:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35043 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbfEVSqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:46:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id t1so1768014pgc.2;
        Wed, 22 May 2019 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GmGzWLHRhAiFHdLO6sJ1o+baERaywOCM8lSPrMQvma4=;
        b=oIGeZss5BNTBJcdtowR+26iCRL4R4Fx9g7Qgo20cHvKWUFUy2aZ8eonGKSgpstWskl
         3HEFFLEs2l5SU+/FOvNIzLc+VprONyDe3l0YBe4JNXd0VUdf2/E+cEmAswoEv9ufAmBv
         dcj9amWmV01GudIV5EbexapIqVk6E9itihrZsI5N9QWi5jIBVhtJxVcuAc7KYVGQu915
         KdGs/Ae+730mGjN8LDiXhcDW+MX2c0FhIsg5DbD2bZBzbj31uRHTsJPYQIFBtbJJIvbY
         H7P8fNZeF6xQoy2TFa6DKfFkXgrDPRu2mvQ/3vEru1ZL7EXMwqFEgaDK1SCLOeR7/Ith
         2THQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GmGzWLHRhAiFHdLO6sJ1o+baERaywOCM8lSPrMQvma4=;
        b=Vz0I/1S1WbKoyMlsW+QwaRPa4K5a7l8lUVZjtGY5TLbzYgVHUOGbVv7z0zjNeuC5QU
         5B/QtIWIiRqsy3Hw/Y1bFpqdsBfbabG0tSwMXTNr3imnC/eWjXPGGJ7AbGehqWE9v0Ld
         cNTLGIxLH9eaX7JlJV6cNiD1voNxaJV0Rwc3gGfBwEBtf0kmHvWCWuvF5Zpm/yvZm6fj
         tGWif3c86v53aInk2JcXhkj8ZPfX9hvIeIEfGT0Zupmer3RouDvaMAuia5k1KRcAHZD7
         MK74VX8lHsp+HKNecm7L1e58gi81iiMwWNq65swycDD7sEonqaYv9S76/X6r5xHL+1Sf
         arXA==
X-Gm-Message-State: APjAAAVooi9gpeNx0juGdkYPfmeXDu8CTC8J3Ls/5JxJootdPZeSc17F
        Q2E+YpqsN0B1kk1TMgr4T3Abzo3d
X-Google-Smtp-Source: APXvYqx5MVPCTwB1TvOzSQ+U+LjSQYLhgOCeldaVnfeKLh7uDytNdcFNe+vlJzLK/zdCNC/iIWLAYg==
X-Received: by 2002:a63:c94f:: with SMTP id y15mr28257342pgg.159.1558550774800;
        Wed, 22 May 2019 11:46:14 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 25sm2439585pfp.76.2019.05.22.11.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 11:46:14 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS
        CPUFREQ DRIVER), "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS CPUFREQ DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 1/2] cpufreq: brcmstb-avs-cpufreq: Fix initial command check
Date:   Wed, 22 May 2019 11:45:46 -0700
Message-Id: <20190522184547.31791-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184547.31791-1-f.fainelli@gmail.com>
References: <20190522184547.31791-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a logical error in brcm_avs_is_firmware_loaded() whereby if the
firmware returns -EINVAL, we will be reporting this as an error. The
comment is correct, the code was not.

Fixes: de322e085995 ("cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index e6f9cbe5835f..6ed53ca8aa98 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -446,8 +446,8 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
 	rc = brcm_avs_get_pmap(priv, NULL);
 	magic = readl(priv->base + AVS_MBOX_MAGIC);
 
-	return (magic == AVS_FIRMWARE_MAGIC) && (rc != -ENOTSUPP) &&
-		(rc != -EINVAL);
+	return (magic == AVS_FIRMWARE_MAGIC) && ((rc != -ENOTSUPP) ||
+		(rc != -EINVAL));
 }
 
 static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
-- 
2.17.1

