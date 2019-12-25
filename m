Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45C4C2D0D0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 01:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A547206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 01:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nsIyRfJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfLYBGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 20:06:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38769 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfLYBGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 20:06:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so3518452wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 17:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Mty/FeKQ1wDgVa8w9Nr+2aawC0goo22XNed8kugKhM=;
        b=nsIyRfJeBDJmdHJW7QotBn8a3e4KqpfpPdrhMxitrdrEjPmQn1BokouaEDljANB+uA
         opRGU1cauaPWkweuiuT8vOtRcs2xf4cYnzJRW8SM8noie3rNoQhmqULNQ+YQ+yUZeszO
         +V+JRBXJWXFtxNpHcgrixH74Q75GI7pmz00QsxBeMau+1SBy946gjmsMc4v7VZhupoNz
         CNBByMQ5klAnkYFuGixbXAG77ctfE+VToqt2r2kvKHtZjYgtA4bktiPoVPaWPmDZRPLQ
         OCM+xY5JPtS8ee2SA+AVjndjqoDdccPHmPbAYibnU+0CgQ+2F4iEY0inxSprZAW9+RdB
         /DCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Mty/FeKQ1wDgVa8w9Nr+2aawC0goo22XNed8kugKhM=;
        b=rVBr9CtuYIWrm2gTAnoNcsj2mN3kFBZPdTvxd4n/sYbbxvHqJUUmXsKXFckJPHblc1
         QM5Z9/iUE0n6Y5JgeukhvHm/9LHC7QX1Uk2n8t0YBLHgaQTHBZclMZXfodAM/2DW5P+S
         47EOZPUWVyXl8ML4jht+vx4EDKhaaKScEEMLqKNJlQHH5ZskUR4+QUx4+kwponsIKTsC
         fBwfsuh1jCK831fIKA1lB9ZjHmiZWjEtHQptuVJNSoA9iE26ZqvODe1X1MwlX3vLNLQD
         nrnzVVAAba421EpMFUJMdb+zZXPgyDoJG60qarPgIVYtlP3ekxKZFYSTLREgud9CsrOc
         QglQ==
X-Gm-Message-State: APjAAAVY2XH8ShNtQEJsc5MQu4vL1cr7hiCiSll8cREAGzGHebNNV7Gt
        f5sEGYIawgM4yfquVwffaac=
X-Google-Smtp-Source: APXvYqzl0orMCs0Tq92Fg5kOXV4XxPYq1w8bznh03vYxz3Kod5nZFWE6+Lls2gxHOsub3gUlCCjyVw==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr6802974wmc.20.1577235983449;
        Tue, 24 Dec 2019 17:06:23 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id x26sm4066127wmc.30.2019.12.24.17.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 17:06:22 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/3] ARM: dts: meson8: use the actual frequency for the GPU's 182.1MHz OPP
Date:   Wed, 25 Dec 2019 02:06:06 +0100
Message-Id: <20191225010607.1504239-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191225010607.1504239-1-martin.blumenstingl@googlemail.com>
References: <20191225010607.1504239-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock setup on Meson8 cannot achieve a Mali frequency of exactly
182.15MHz. The vendor driver uses "FCLK_DIV7 / 2" for this frequency,
which translates to 2550MHz / 7 / 2 = 182142857Hz.
Update the GPU operating point to that specific frequency to not confuse
myself when comparing the frequency from the .dts with the actual clock
rate on the system.

Fixes: 7d3f6b536e72c9 ("ARM: dts: meson8: add the Mali-450 MP6 GPU")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index b35d7444c1f4..eedb92526968 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -130,8 +130,8 @@ opp-1992000000 {
 	gpu_opp_table: gpu-opp-table {
 		compatible = "operating-points-v2";
 
-		opp-182150000 {
-			opp-hz = /bits/ 64 <182150000>;
+		opp-182142857 {
+			opp-hz = /bits/ 64 <182142857>;
 			opp-microvolt = <1150000>;
 		};
 		opp-318750000 {
-- 
2.24.1

