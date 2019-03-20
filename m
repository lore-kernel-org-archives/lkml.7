Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB04C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E1F21873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ISHXmiqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfCTUOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:14:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34446 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfCTUOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:14:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id v64so2727925pfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pzF3BIq/bSUrt5CiUncmfOK09+4gjk83OwCemwmZOC4=;
        b=ISHXmiqji7ZAl3cOwKGcGQYdywmxiykkyZrWAoB41PY7EfkDHCe48W13KqCCiTUoVh
         ahdYus4RPs0zWi0rRYkmThH7ABHLbyARGHg0YbvveSdF3Qpq6Vsy4T8lC6i+2x8kaEgG
         sGcQBfWPw47B+om3sCcWZNCy9oOODLKYtgbTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pzF3BIq/bSUrt5CiUncmfOK09+4gjk83OwCemwmZOC4=;
        b=etSJG3bvDvAELkEwCpZW0d/zwZTflB/T7HVI24KDPQ+2La5lsgk+kLd9WsDyfy1dsm
         QHiVW/NKOLRAz4sf1yC1jdNZW0F50BXsRbA+gefgUp04ktadS3C2eJ/fykS9vyXj5owZ
         dVj6tc2HzPUYbamiKnAkSyAwlxNHm8Cxyqjkw0iXWu60HHjqKI4u7UJuaf6o1PqHQllN
         pvzggPnOs3O0RO+Hdymp4VIFrqV2xn24e+15JqcT+46wgON3D3RVfKozivLvCg8wRqPd
         R3rKfrCxlyTLsC8C8pj++ohX80O31I9ZJOqESif1zpQAe3CeGlNRDrazh/DHboiRt8fT
         JxoA==
X-Gm-Message-State: APjAAAUL3gUCi12BQs4uDzXVQWI+fDNU7OY2Snwa3L5e193YTefKBV1d
        r87hKzggpnUMkhqK1B7BctJ0DA==
X-Google-Smtp-Source: APXvYqygQqT0Fn+zIyI4V89ZqEdcJ07iT2KEcX7LKombmuwHs0lA+QsdHql0VLtKPWKkhenNtjh2Rg==
X-Received: by 2002:a63:2045:: with SMTP id r5mr2959436pgm.394.1553112873100;
        Wed, 20 Mar 2019 13:14:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id z77sm6220388pfi.155.2019.03.20.13.14.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 13:14:32 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     mka@chromium.org, ryandcase@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] ARM: dts: rockchip: Fix gpu opp node names for rk3288
Date:   Wed, 20 Mar 2019 13:14:00 -0700
Message-Id: <20190320201402.114309-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
In-Reply-To: <20190320201402.114309-1-dianders@chromium.org>
References: <20190320201402.114309-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree compiler yells like this:
  Warning (unit_address_vs_reg):
  /gpu-opp-table/opp@100000000:
  node has a unit name, but no reg property

Let's match the cpu opp node names and use a dash.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/rk3288.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index e9f454248398..79cd3c53e737 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1282,27 +1282,27 @@
 	gpu_opp_table: gpu-opp-table {
 		compatible = "operating-points-v2";
 
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 			opp-microvolt = <950000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 			opp-microvolt = <950000>;
 		};
-		opp@300000000 {
+		opp-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
 			opp-microvolt = <1000000>;
 		};
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			opp-microvolt = <1100000>;
 		};
-		opp@500000000 {
+		opp-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
 			opp-microvolt = <1200000>;
 		};
-		opp@600000000 {
+		opp-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <1250000>;
 		};
-- 
2.21.0.225.g810b269d1ac-goog

