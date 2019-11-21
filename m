Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D49C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D469206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lFzeH9x5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKUKOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:14:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38453 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfKUKOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:14:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so3649863wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 02:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0wg42Ie2oicewNtAQ2/KQD6s/n4R5PzVImaC+y7L2/I=;
        b=lFzeH9x56IU0xzBmSWRZ6DcwLxw1LdGEIJ5MlxSDkIZqsb0vFRQ5uS/KuSKEhv4Rpe
         zXtQOFjQ5v/kTiNdmSeeMdIpd/tLUgDYdIlHZJY++DJQqDyXRl+O2emaVMMdfEMYpbXS
         lPPASwiAaZXdpBiEx8xmrla3280an3xZAkQlbeDlAHyRTMheWJ1BWs1RBZaPlkYk5ZyR
         zGBc4uGluDTwDdqqFLevoP1HfKsU1jK4h2lDg+opAN/Rlpuf7/yfRyLVCalk44pvBFjL
         Q3Uo0kH1qvOW1GrBmhdrITJLvv8OKVb0Z4+4oPyHHtRSxHaUFITEv1aOgLAmvTvJhIBF
         5OEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0wg42Ie2oicewNtAQ2/KQD6s/n4R5PzVImaC+y7L2/I=;
        b=qpNCSOu6bCZbaAXghAMzINpWL8gzSn2OZqi+rSQRoMwQ0Mc58sEn1YtDPG/F0noWFl
         mZzOKxhhOW13VOHOUpI+nNwVpgTeAvAQRsS3kLIU5I8CqsO640X277M70AIRSVIzN/tC
         vxb8H9RhUFreZKSWg5vY+e8KJc81ic7oa9DZ5A/UCAvmeyH5oMV8fOx+Z5n4AJiiHxjg
         U2bL7sDDkb5Dg097yy24cVQQnuKcV3z46RaBZ08t02lkc6QtH6hxEbAgu9BqpEUpPj7z
         VdxC58eQDBZ+4uxX0F6Tval4iJa1nbF8oQ6LYKIR7y/tvJMrKfmkLik5yPn7X1xMQ6tU
         iOIg==
X-Gm-Message-State: APjAAAXPACY/zfMEwcORPhw7UwFOKE+XHy3lOsrwBbleNOeNj1sfte3X
        xk7jD3dqlFdV9T5yOS3ndxXPLA==
X-Google-Smtp-Source: APXvYqxaDVnzGeg++beFGsQYq3Z9at9EOfwRlpJHiF3RSAfp90GcgPYTGGemHS3Jb/bwbNGcDgkpQA==
X-Received: by 2002:a5d:4608:: with SMTP id t8mr9739630wrq.91.1574331273780;
        Thu, 21 Nov 2019 02:14:33 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o21sm1289932wmc.17.2019.11.21.02.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 02:14:33 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     mjourdan@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: meson-sm1: add video decoder compatible
Date:   Thu, 21 Nov 2019 11:14:29 +0100
Message-Id: <20191121101429.23831-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191121101429.23831-1-narmstrong@baylibre.com>
References: <20191121101429.23831-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the video decoder specific compatible for Amlogic SM1 SoC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 521573f3a5ba..b94a4eae973f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -138,6 +138,10 @@
 	compatible = "amlogic,meson-sm1-pwrc";
 };
 
+&vdec {
+	compatible = "amlogic,sm1-vdec";
+};
+
 &vpu {
 	power-domains = <&pwrc PWRC_SM1_VPU_ID>;
 };
-- 
2.22.0

