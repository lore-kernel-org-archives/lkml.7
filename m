Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F15CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D37A2067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="U/f2h7Ju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbfKAMo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:44:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38963 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730580AbfKAMm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id y3so10122555ljj.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KU/n1Q/VNXJbWwIQys/qt9rGcT4PXz5RLqrj6x2UwvM=;
        b=U/f2h7JuYhwgX+OxayXYbuI3nx0fL2I+VDpk0pE1JfCFpTOAsakC6TS3OYY61jFEGH
         Es7TiE/xRGdQOT/qPHZ/2VmMSA9H1E30CayCMWjQG4u5WbohQrKEwC61GH+dWiK6VIVk
         eLCUnrHW+TjhzZPa8JfiyQxWMYcrT3/fzJKb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KU/n1Q/VNXJbWwIQys/qt9rGcT4PXz5RLqrj6x2UwvM=;
        b=Y+ebb121kbbMq90lekwpuyyYAw+OAS4c06dD8exJMja44GQ63BKQ7RlJxVRihSgaNz
         n1+fbcavL+lM648WG9mUoCRwp4ldF9lYWj34DcrdKeu82TH9avU9oINlZ9V12OwSQuzr
         TcUSiPvCXr0hr9P2zCWDkpU+CZUAa4I/HZa0kcG6oVPxLUotSKuPO4NDn44BVeWqbpmH
         /tmHOGv8u7tdsRY0DAYOSecIla37qEDC8+l96tG/M1l2aaqxaPwEJyl8YxCTfT4QqBQm
         K+rqPEEjr3RjLr6mG2DmluPYyCUc3PWcyTRHJETtc7XBcUDXVTWaA3cwKDQwDjXrcMBO
         +7GQ==
X-Gm-Message-State: APjAAAXmIfyofMp7Ctx4Cv2YsReP/K7deeCENNtS2fImnaf8nyAX77Q2
        eGtq+JqaJ8W+jQL+nTqEokr/UA==
X-Google-Smtp-Source: APXvYqwpYar3cadRMDA9V3X/W/gSCAb+1mtgi5R0km/i5QsofsD6KmUR//aDEr/XEPgCrUcqdgAl9w==
X-Received: by 2002:a2e:89d3:: with SMTP id c19mr8219074ljk.201.1572612143860;
        Fri, 01 Nov 2019 05:42:23 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:23 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 07/36] soc: fsl: qe: qe.c: guard use of pvr_version_is() with CONFIG_PPC32
Date:   Fri,  1 Nov 2019 13:41:41 +0100
Message-Id: <20191101124210.14510-8-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e5c5c8d23fef (soc/fsl/qe: only apply QE_General4 workaround on
affected SoCs) introduced use of pvr_version_is(), saying

    The QE_General4 workaround is only valid for the MPC832x and MPC836x
    SoCs. The other SoCs that embed a QUICC engine are not affected by this
    hardware bug and thus can use the computed divisors (this was
    successfully tested on the T1040).

I'm reading the above as saying that the errata does not apply to the
ARM-based SOCs with QUICC engine. In any case, use of pvr_version_is()
must be guarded by CONFIG_PPC32 before we can remove the PPC32
dependency from CONFIG_QUICC_ENGINE, so introduce qe_general4_errata()
to keep the necessary #ifdeffery localized to a trivial helper.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 85737e6f5b62..1d8aa62c7ddf 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -197,6 +197,14 @@ EXPORT_SYMBOL(qe_get_brg_clk);
 #define PVR_VER_836x	0x8083
 #define PVR_VER_832x	0x8084
 
+static bool qe_general4_errata(void)
+{
+#ifdef CONFIG_PPC32
+	return pvr_version_is(PVR_VER_836x) || pvr_version_is(PVR_VER_832x);
+#endif
+	return false;
+}
+
 /* Program the BRG to the given sampling rate and multiplier
  *
  * @brg: the BRG, QE_BRG1 - QE_BRG16
@@ -223,7 +231,7 @@ int qe_setbrg(enum qe_clock brg, unsigned int rate, unsigned int multiplier)
 	/* Errata QE_General4, which affects some MPC832x and MPC836x SOCs, says
 	   that the BRG divisor must be even if you're not using divide-by-16
 	   mode. */
-	if (pvr_version_is(PVR_VER_836x) || pvr_version_is(PVR_VER_832x))
+	if (qe_general4_errata())
 		if (!div16 && (divisor & 1) && (divisor > 3))
 			divisor++;
 
-- 
2.23.0

