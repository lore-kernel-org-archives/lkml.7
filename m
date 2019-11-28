Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC9BC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A644221771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="EmkDyXuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfK1O5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:57:17 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39186 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfK1O5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:15 -0500
Received: by mail-lf1-f67.google.com with SMTP id f18so20234844lfj.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mcPtC9aaHvQVHiMDeuHeO5Xd/IlCVhW66bWYCmG15ow=;
        b=EmkDyXuqAdU0mDbWeNds+sBE9QLEmfHaO5I4B4TTXCJ9nRxpp5C+xuDFdZRQxt7wq2
         AAF6YpMlfKCAZKeLvo6uLKsU7IKJhjEFyvK1PKAnNcZ1JPXmzW6AQ7+M5NqvWw4qYv/l
         x2IqPboiEsuPFc8Yr+/a4hs0i7+HayMlTcKoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mcPtC9aaHvQVHiMDeuHeO5Xd/IlCVhW66bWYCmG15ow=;
        b=EO5wuZxqjZ4CrlT0PstmENkE/YHfFZ9Jfn9p4U3Acjp3v5VInQMuGy7K7VxCldQvfw
         Kg2q1WNcOOMYOl0cnDKi37oBWpO246fuCntp0fe4TAK0Oj+dDG6Ta9xouqfjnJW6x9dY
         L5eDMIF7WHLFm+yIePUyNM44qMdgxm2xdIF7TWEWhT9hCwJ0VfqRvpimjHeE0BHyXSNm
         UCjF40T+vTzGOutlxQ9ofmYc5hRXbtl2qOSMxhe1M3kxzGCANaFKIPVnl8pXntvN+/Zl
         MNEYJ99jV05U3pkSLjOIYBv/hCIKIZ0on261XRtI6JlgHt1AB7MbcVfnAj2exSWZGezf
         mggw==
X-Gm-Message-State: APjAAAVDPKghS7ybiQI6AHaCNRi4/SgOPsTxT63guBt5Tuw++GB5+apP
        9FqVfB66lMytWN61MrY+dt30jQ==
X-Google-Smtp-Source: APXvYqySVaYODKYk+svlcgwOVHhmUKL1Q2Wk/1XqF1/sAAQz/dRwqwnYV2cQVtTbY6URwH9ffRGCHg==
X-Received: by 2002:a19:22cc:: with SMTP id i195mr32346136lfi.148.1574953033803;
        Thu, 28 Nov 2019 06:57:13 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:13 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 07/49] soc: fsl: qe: qe.c: guard use of pvr_version_is() with CONFIG_PPC32
Date:   Thu, 28 Nov 2019 15:55:12 +0100
Message-Id: <20191128145554.1297-8-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
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

Reviewed-by: Timur Tabi <timur@kernel.org>
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

