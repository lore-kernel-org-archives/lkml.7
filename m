Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438C7C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E6320815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fAwHIQTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfETUIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 16:08:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39557 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfETUIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:08:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id w8so15997325wrl.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 13:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e0VqE+rZMvBKHIYBXL3p+1cgiNolIPVKif3ndVE931w=;
        b=fAwHIQTNJ7LYfS+npQAVAly5KBNMIBkvINFdruuroIDO75vDaATN0YQ2foFWKpHzu/
         DSawlpfon0AAuxAVzkGqqLRAx1FfhXEyPs7azowQLJ3KSjmEd/Xcqd5Dq2PaLRMasqUG
         2hATUsp1o2StoIAtb7ijeSqNElRx/atHKiFy4BaN9tAgWgTe+MrYVuotpSbKKY8LqUmU
         L9Fg3pKbeMpAtHI2qKWyZ+om8x6v49RkQmW5mrsyk3WFtd+Z0HvrUNuCL9AbAz4d9hmg
         atEN0Y4vmdFCjDbs9ixH3va+1vSF3XTXR97RlQ/J1DPdem4pFEuQpNSxqLIuz7fQyOSe
         NsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e0VqE+rZMvBKHIYBXL3p+1cgiNolIPVKif3ndVE931w=;
        b=aA0DKVutLlpSRK9IuUdAkPXblmtDDIEqQ4dF6nyAw4OXVCUCmJLmte+xcjbElrPCWD
         2T4KxfW4GSzccTJXs9IfHpSlNH6jvdGTc1SZgVkFEPDWptXkxneNMV7fHxhf/6Z/4mIV
         fmJNkUGyzmCz1GEF+P4ijkFv5Rac8cz32FgBgKBAliOKPqg67okxw8WYbDIqwYAtFAOa
         JiG+8zSfUn/zVdZEz1JTmP1QwByaEdsRwtQxIDKucHuxDGn+ALct8HPCuaBQ1Rj2XXiP
         716WdGHP408nhaBiTLf91p0aLrTJWUbvBKvxxnGklDYy+O7W9fCxw+5FdaiLDDoTYdL4
         FPSQ==
X-Gm-Message-State: APjAAAX2SPZtSHLM7a1tXZi0CMtPFCC/WRCSLeXEWVjkxkM96x/WdwrL
        xC5sAWo+yL0GAVGrGH6HQ7E=
X-Google-Smtp-Source: APXvYqzMIgHXiFAjB2iqJtd7q4ohra7zn99jfRowf8TpuHE3QE0mc1sJ2+E0VGNp4HgzyiK1FT+wcA==
X-Received: by 2002:adf:ec0f:: with SMTP id x15mr46678862wrn.120.1558382927766;
        Mon, 20 May 2019 13:08:47 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133EE71009C356FA1F0E19AF9.dip0.t-ipconnect.de. [2003:f1:33ee:7100:9c35:6fa1:f0e1:9af9])
        by smtp.googlemail.com with ESMTPSA id i185sm918627wmg.32.2019.05.20.13.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 13:08:47 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     balbes-150@yandex.ru, linux-amlogic@lists.infradead.org,
        khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] ARM: dts: meson8m2: mxiii-plus: rename the DCDC2 regulator
Date:   Mon, 20 May 2019 22:08:38 +0200
Message-Id: <20190520200839.22715-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520200839.22715-1-martin.blumenstingl@googlemail.com>
References: <20190520200839.22715-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DCDC2 regulator output is actually called "VDD_EE" in various
Meson8b board schematics. This matches with what Amlogic names it in the
most part of their vendor kernel (there are a few places where it's
actually called VDDAO, schematics of EC-100 suggest that the regulator
output is used for both signals).
While here, also give the regulator an alias as it supplies the Mali GPU
so a phandle to it will be required later on.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
index 29d830ae4bf4..c7d9cf035e22 100644
--- a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
+++ b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
@@ -114,8 +114,9 @@
 				regulator-always-on;
 			};
 
-			DCDC2 {
-				regulator-name = "VDDAO";
+			vddee: DCDC2 {
+				/* the output is also used as VDDAO */
+				regulator-name = "VDD_EE";
 				regulator-min-microvolt = <950000>;
 				regulator-max-microvolt = <1150000>;
 				regulator-boot-on;
-- 
2.21.0

