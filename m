Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96141C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD5D206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FkPmcXAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfH0KD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 06:03:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43234 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfH0KDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:03:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id y8so18136356wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 03:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ceHNjOjYXXqKJbeAE7JQVGIbYL1u1AYoPi0HEmNDPSc=;
        b=FkPmcXARScleAA98yh1f0hvd5zGL3cap9/yDJQXtGHNOjJ+x51S5P9/OnrVC99ODXV
         H4enT2hrCybB4x2rM/H0KuMJsda8I0SKMgZ6uYSaqmO0ao5hzZq02mDDCIXX9uX0SOmA
         cmOtHZqMLfB0TDlJVfbXjnUHg8XwxCwNHij6go1d/I6YxMZtS05Rj2iBd90fqe6OhSex
         m3aofztGTUYBhOY9k3aumMwZglrjYSaC3SHMdXBkS6OGRQo95sldJVbxALu/LJ6yFik3
         U3Tw+NIDIsHXOZSUFSX4yZDJ8sp7mvyu9wY22BcF0PPmQqkfsm9y5cdrqagpdwLpoQ++
         xF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ceHNjOjYXXqKJbeAE7JQVGIbYL1u1AYoPi0HEmNDPSc=;
        b=aYq0MwPqG/ZVMEya6eUJpxL0VZmkjt+BAQ+GVwZQs8eu2+/LBelg7R2qHmSrQGMYmX
         KIOuJ5lzOTViDsmdZz8VhKuhKDbdrJ0Cxmv5HN7JVPNN6Igeu1xXW6wGHTo2QB4JAW0j
         DE3d1WV/97bHIPrL7dZq1ZhIoiq8THf9FFgZXcuF5Y6iJ4kSfXVgEgUs7Srqf6HSpkx7
         rki5xdCKKMODfOopczLfFe/OXgpaPhA1xqwESBRbAIon0DeAVTysnb6SA2NihheOKSvF
         IPVzn2yWn18Ffh7uOQyrkRpwQnWyd5GFpCFlupnOpCEdPx8nWnGFhR2B06sMeFiEhCgo
         ZX0Q==
X-Gm-Message-State: APjAAAUOfcaBzZEccUWh6hXDu55/hPt0MwKTKsOCb9798lL+jyD9gPkz
        V5GjuG0oOG8ucclirGS74sG86A==
X-Google-Smtp-Source: APXvYqyHrsjIv6iA69VxrzeSvvkWJVA1ZCYStwgFPwlD6yYAE9WHbvTRzmgTR7jqHjpRqAb+QBnU5w==
X-Received: by 2002:adf:fe85:: with SMTP id l5mr26701545wrr.5.1566900192806;
        Tue, 27 Aug 2019 03:03:12 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o25sm1816289wmc.36.2019.08.27.03.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 03:03:12 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/3] arm64: dts: meson-g12b: specify suspend OPP
Date:   Tue, 27 Aug 2019 12:03:07 +0200
Message-Id: <20190827100307.21661-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190827100307.21661-1-narmstrong@baylibre.com>
References: <20190827100307.21661-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag the 1,2GHz OPPs as suspend OPP to be set before going in suspend mode.

It has been reported that using various OPPs can lead to error or
resume with a different OPP from the ROM, thus use this safe OPP as
it is the default OPP used by the BL2 boot firmware on the 2 clusters.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi | 2 ++
 arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi
index d61f43052a34..00ea181bc018 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi
@@ -39,6 +39,7 @@
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <781000>;
+			opp-suspend;
 		};
 
 		opp-1398000000 {
@@ -99,6 +100,7 @@
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <751000>;
+			opp-suspend;
 		};
 
 		opp-1398000000 {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
index 046cc332d07f..d68323c6c780 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
@@ -39,6 +39,7 @@
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <731000>;
+			opp-suspend;
 		};
 
 		opp-1398000000 {
@@ -99,6 +100,7 @@
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <771000>;
+			opp-suspend;
 		};
 
 		opp-1398000000 {
-- 
2.22.0

