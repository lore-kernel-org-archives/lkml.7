Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9DAC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995B121904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gL1H47rw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfDXAMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:12:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38753 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbfDXAMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:12:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so8309065pfo.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 17:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bWw7tCOYFUmrF3MbsaqS63bY/sBFyYYb6lg0EQ1v3PY=;
        b=gL1H47rwprPlDyj4cPMidqqSvcuSzUvywnSgs17rL0glg8ImmIlOt9zcCSy+ndm5Xm
         JfSZwaNRQIx1sJQCXxVDA3R7Snw1XYJWu2vbJ6IyFcsB3J/e8UGjCNfA79xdyGAdG4s1
         r6fPU/nXY8gUdl27nkMfrGERCuJ9UOJqd2Ga4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bWw7tCOYFUmrF3MbsaqS63bY/sBFyYYb6lg0EQ1v3PY=;
        b=ErVGwxvDhp0ot7okMA6q6CTlCKduWFWsUTxLsM5IHlJvauLWJLrdZUE0mk4+HW9EhM
         zMZUkcaHr/Rk+NbQpv12A4gKIbhFaRLKZzsq9krpABZ7zOdPb/bbWYGFT0wizk1D6PM7
         xg4ZkgzItG9raVdUQ2956rBVq2RGYbBk+Iq0i4svYhSByHBesPH4AVcaAISGeWqyEVTZ
         mNEfns3KrwXrCjat69q+XGs+tJwUmrh4Mx0zySCIzPAqeBzizcWRjuYXGyVv4vwsFXoo
         CYIjmTeG5XthMD2b7BR0S+sTr663qK5oBoDcEvW6MCSXaZNi73Xv78NnFNHCQDvD6MRj
         7X2A==
X-Gm-Message-State: APjAAAVfYXmyJgVW1b5NSsTp7IXiAURbhPJGUOf1hGXJtWh6j9Un6D0B
        3PMhoGvk7LeQe9hP8g71Df56ag==
X-Google-Smtp-Source: APXvYqxJUGUs/fDg2hnBdfRQEAPGspq8/ExCGxNKythf9SD17YYa6DE4Kz1r1cWYSciAcOxQwK+VGA==
X-Received: by 2002:aa7:8190:: with SMTP id g16mr30017235pfi.92.1556064736153;
        Tue, 23 Apr 2019 17:12:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id g4sm22911495pfo.38.2019.04.23.17.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 17:12:15 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] ARM: dts: qcom-apq8064: Fix DSI PHY ref clk phandle
Date:   Tue, 23 Apr 2019 17:12:10 -0700
Message-Id: <20190424001210.201672-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3560af5a56b5 ("ARM: dts: qcom-apq8064: Set 'xo_board' as
ref clock of the DSI PHY") specifies the non-existing phandle
'xo_board' as DSI PHY ref clk. Fix this by using the correct
phandle is 'cxo_board'.

Fixes: 3560af5a56b5 ("ARM: dts: qcom-apq8064: Set 'xo_board' as ref clock of the DSI PHY")

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 2fff5074f2d7..65975df6a8c3 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -1305,7 +1305,7 @@
 			reg-names = "dsi_pll", "dsi_phy", "dsi_phy_regulator";
 			clock-names = "iface_clk", "ref";
 			clocks = <&mmcc DSI_M_AHB_CLK>,
-				 <&xo_board>;
+				 <&cxo_board>;
 		};
 
 
-- 
2.21.0.593.g511ec345e18-goog

