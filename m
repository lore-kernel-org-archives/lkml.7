Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3835FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C73521D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="i58fVaUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504502AbfJYMlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:41:22 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45848 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440295AbfJYMlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:12 -0400
Received: by mail-lf1-f66.google.com with SMTP id v8so1610030lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fgKnxJ1wOt4EIZwRcA9XPxDbDGGhVcBvHA7yIdz2HCY=;
        b=i58fVaUPnJK7wm55cSIpzM94MYvaZzY+Sn1vefsKSTwyL6EPMdUr7hZeg8dREi+Hkr
         Ab6iCLKcMZsjQXTlNye4xQSNgvGRtroKi8gtUrwuSep0SzBezpStEJCBtnaSuh6YKwJU
         G2R+j1/b4sM4dOTtAUkxpe5bHoyj2eRQlcXHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fgKnxJ1wOt4EIZwRcA9XPxDbDGGhVcBvHA7yIdz2HCY=;
        b=hTWWncupYEgnwvSMLEcwjlicRv4FoCdytwSXi5O9K5juPTaF+IXMPZEY43qjltZ0kI
         rMzX/HqlPaaGs7GYB5iv8bAFjp5KcRyJGGDyjwnxdNbO/DgPCznOINGDFYTVWYig3XB9
         gSylNWzIoIEGC0Dz7zYJfr5gsvuuFxaHVuOAdU34QUMe3Fwl3J7J4E3iLwiMzll2dkwh
         WYaXykgEY871F6OQsFH3fNfm7QK78Pk1sBuc9I+2uh5nZrzeglZN3gN/HYkWQX+szS+l
         74D6Lcqkx69ISpIB7HqtUZUPFX8Byta2jJzAptLoFp6S3UxtcaamOPu39O2vxhQkJq6P
         p4Pg==
X-Gm-Message-State: APjAAAXrKzAQlVd77tpG9AECrlOwdt6Fim1Rv5mdh6vXf6o6n2WPin+m
        eFlC3ylrqlCBsAdfoYF7r2HQ4Q==
X-Google-Smtp-Source: APXvYqyIT2xLWVoaJP+X3MZLfQiywdsydM/+DaqNZhO2Hd1pHXm0z/JSsmbXZuo+4b142OCkiN3qWA==
X-Received: by 2002:ac2:4436:: with SMTP id w22mr2568863lfl.161.1572007268911;
        Fri, 25 Oct 2019 05:41:08 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:41:08 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 05/23] soc: fsl: qe: qe.c: guard use of pvr_version_is() with CONFIG_PPC32
Date:   Fri, 25 Oct 2019 14:40:40 +0200
Message-Id: <20191025124058.22580-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025124058.22580-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
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
index bcdec37b25ca..0ddf83d8e3ce 100644
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

