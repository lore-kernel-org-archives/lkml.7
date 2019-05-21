Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7F2C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B240221743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rVPESzlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfEUJfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:35:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43259 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfEUJf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:35:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id gn7so4007274plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 02:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=snr6I7xOlJyQUxx9e5KJWRPzOk5/RPGil0u5RknK1co=;
        b=rVPESzloEoFaSm5eQVX+SSjgn2ZsbWsXtAubks8NdodjIma1kybM3H7lhAqtQdgdAV
         clp9h5CkSJa2HT4/kfjRDBUErdWd8NUlKVMz7EI4G9oSHjOLfVg+xwmahACy9O4lIsrG
         xBnNq11FyV62nviOis7Kt9LMBoQiyhmjQiS3iVHHQxyR5OBTzlfDtui1q1cO3fnF6Np9
         LQLAKENmgf621qZS3qr0dQW4fB4AYgzSZlLhR6N4C/LDBMvnAMRFkfYXGZR9Utn3Sien
         NLpOLL+DorAVv1FL32ViodUCMOimKafPcHVxEX1uLz2twuTW/BU/k7pBn7wrfVw/9daO
         3F0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=snr6I7xOlJyQUxx9e5KJWRPzOk5/RPGil0u5RknK1co=;
        b=LmQrDs9F1davPERqp/Jao2iH0BlZ+kepSOUtmjBtahQ6ICZnTXnoeLjwezsSIyWP1m
         eC2vDwUpI+IfO/vBwXmp9TReYRlqjNLOaYQmX2BE6ym9jiLPdLN8Eyj0TeuUEwBIqJEd
         10IzhK1dQFzOkwD7ZYDdvX18EfMH9SMuJGk/sOi/yLbXitx/nTLk/fXxNYtvKEQp79IJ
         b0xwRbIxYaIt5R5uKGK39CzBBUA+9/3a5CjadOSVOV9aj1zujq1E05updVDeP7lbP5HZ
         utgsGkzsmv92FhlIoz7cciIOLnbuPm45pmyvNybz09CrDrCMCg88ScOXF4tYmTYSBX1t
         PQHA==
X-Gm-Message-State: APjAAAW9MtPV3ETdsPg8SaDEfl2IF49V0imK9KQ2ehY8rYnd0OpSqDCY
        bdrsks6j+D/b61fAj9MTRcZSB7LOAnXdYQ==
X-Google-Smtp-Source: APXvYqxblgRSQgNYff41+kJRYh4Og5BQ8zoVZkjZcLjl8sKf00ZpyEGZOIT/R9ZECXRvs2o0hW9Abw==
X-Received: by 2002:a17:902:aa45:: with SMTP id c5mr80617108plr.144.1558431328331;
        Tue, 21 May 2019 02:35:28 -0700 (PDT)
Received: from localhost ([49.248.189.249])
        by smtp.gmail.com with ESMTPSA id t18sm30938459pgm.69.2019.05.21.02.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 02:35:27 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        niklas.cassel@linaro.org, marc.w.gonzalez@free.fr,
        sibis@codeaurora.org, daniel.lezcano@linaro.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/9] arm64: dts: fsl: ls1028a: Fix entry-method property to reflect documentation
Date:   Tue, 21 May 2019 15:05:11 +0530
Message-Id: <fcc19fb14343088b7f757cc9d6f699ede01dbb13.1558430617.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1558430617.git.amit.kucheria@linaro.org>
References: <cover.1558430617.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1558430617.git.amit.kucheria@linaro.org>
References: <cover.1558430617.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idle-states binding documentation[1] mentions that the
'entry-method' property is required on 64-bit platforms and must be set
to "psci".

We fixed up all uses of the entry-method property in
commit e9880240e4f4 ("arm64: dts: Fix various entry-method properties to
reflect documentation"). But a new one has appeared. Fix it up.

[1] Documentation/devicetree/bindings/arm/idle-states.txt (see
idle-states node)

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 2896bbcfa3bb..42e7822a0227 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -51,7 +51,7 @@
 		 * PSCI node is not added default, U-boot will add missing
 		 * parts if it determines to use PSCI.
 		 */
-		entry-method = "arm,psci";
+		entry-method = "psci";
 
 		CPU_PH20: cpu-ph20 {
 			compatible = "arm,idle-state";
-- 
2.17.1

