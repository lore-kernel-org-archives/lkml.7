Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25ECC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 04:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15D72085B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 04:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i5esF3Bh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfJCENu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 00:13:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37000 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfJCENu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 00:13:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id c17so919586pgg.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 21:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=m8hFjA3x5J6UIifkesrHQlzvrEbWo1oOG3daGAO1Kds=;
        b=i5esF3BhGT+PZNcHTJPM4IJ2c8B0EtVNHjz2sMfWVyDlsdjvH7aGm8Wg+mM4Qx2XOH
         BnqQVYtNrj7kuwsnDdvUMlMYcwOAzlV2dR902apMkswWzx7YQhl8tbm29+fGzyz7hlmM
         k3mIYDi/88ELYvEX5xGjnCdjbDlDCgSGGT7g+N4xUgQ9fosAhu+PL/pVV6DdCduEvtBz
         kKpfrExbywrPHCTL0M007R8UWkyPISywv4P82868F0Huim8EIbofLfgyJJ4vscUMJyPm
         juJbyKfKO5qDuYvs4yqLhoiMmfB96tKSr48W8v3NgNcKfrUazNRpRi0F9xZr42na109D
         KPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m8hFjA3x5J6UIifkesrHQlzvrEbWo1oOG3daGAO1Kds=;
        b=fAswFgzPs9dikwsUe30YgrEMpnlh8M2saeeyUPGR4Qu/3nwGj4jPftNR8FfQpIShwn
         uKCfReSuAou1A2Sl0B11BtrTdNJl9lcKFdD+cEoKJSsyt/Si1v3GAAt0VR7gWpKxZKgD
         7OnC/+4qRVwyNNHLlx8HnZ/UmW/Yjjw3662aEAchSfkLZknOPKpTScAVt3BPLJzB1RnB
         MRISEHaAWQK68thUL1i2tHE385zuzOcg44KQ7/zbAerumOGG2zdaEVaMIoheKw71dcd4
         suZ2xMjiKmW39rMDSLA31U7DrSwdUSxNpdCunX6bsWhp493ug02lH16mjaO2XO152Vgw
         beHQ==
X-Gm-Message-State: APjAAAWcHzSs4PVX6PJm8wZ79HtRyLMC2dXEclsF0VlZpKOe2NQw85Jq
        QRrrNpouvqLIM+TiOF2gzuw/YQ==
X-Google-Smtp-Source: APXvYqyqK2FTREVQtaobYQa+y7zSAJtRxO4xSW9iXnj50Z6gIChwFgdcvlIk/Z34JnR9JfHmNz8qWw==
X-Received: by 2002:a65:5043:: with SMTP id k3mr7649733pgo.406.1570076029386;
        Wed, 02 Oct 2019 21:13:49 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i7sm704205pjs.1.2019.10.02.21.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 21:13:48 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sdm845: Add APSS watchdog node
Date:   Wed,  2 Oct 2019 21:13:45 -0700
Message-Id: <20191003041345.20912-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node describing the watchdog found in the application subsystem.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index f0b2db34ec4a..23915eab4187 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3488,6 +3488,12 @@
 			status = "disabled";
 		};
 
+		watchdog@17980000 {
+			compatible = "qcom,apss-wdt-sdm845", "qcom,kpss-wdt";
+			reg = <0 0x17980000 0 0x1000>;
+			clocks = <&sleep_clk>;
+		};
+
 		apss_shared: mailbox@17990000 {
 			compatible = "qcom,sdm845-apss-shared";
 			reg = <0 0x17990000 0 0x1000>;
-- 
2.18.0

