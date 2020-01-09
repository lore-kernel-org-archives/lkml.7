Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5407CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2838A2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="nx5UGTtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbgAINwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:52:31 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:35720 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbgAINw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:52:29 -0500
Received: by mail-wm1-f42.google.com with SMTP id p17so2941784wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K7qiBD3jGRUcHWoFC2hnyMKPOIBb13dj8QhjT8ONsas=;
        b=nx5UGTtM+N44G5BfUdc3Hoj00fE93TiIJ0OTpxjq1JPUPs+YTEFkJU0EPhmhKSMdpY
         GhJPWXpNjCPzvGUsDdKGOMZb7xZudXYtkF9UGyP7wfllFAkothn8FMz2JKvyrki5FBtK
         j4P3Al8Q/wbAEZKPJaZrYxYLsZzBWAAhd/YahAfiFt67OxwmathgPog0CaEqdrFV5ICq
         RLI96sdHUMdQ+iHC8RUksj+lNrSj/JCEJNJCgb9Vu01X4/xqYlKVDx0Iofd5LSZvfzjL
         OAGDqmj8E6JTBqaxg1CHGV26yg+tAkvZO0t15qLBamNWhW3SusJbLgs7L66kcwsDA5qz
         pPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=K7qiBD3jGRUcHWoFC2hnyMKPOIBb13dj8QhjT8ONsas=;
        b=tAjdOt6xNW8MEKlvZkALpx7lYPXq5GZrjkuJ+W6bSfxAV6OPonmPhG2mJqNYzJefS1
         dnaR7f0OMYH3Cswz0SJPFkbcHY/flqb9aItV4NCqH/o2dUs1yRn5Gk9ARD3r9gFjh1XX
         hB63nkDTx6Ub5uLVHy2be9INPtDwFZ9qh3CJ7UgtF34pO2gFLqE166k8NwpA9IgAfmZu
         glB42QbwNxEkKeZ3M+5V443OdM75eCYvtAye/ejTfARp+QVIYBYoXTIRvMntyDPf3oSm
         awszGYGycJLPqriU6TrCN7NvSskWnWPlh8r1ROyz0pWoVh+LRRgzq2ylDHGA/tziUMGF
         AZQQ==
X-Gm-Message-State: APjAAAXbWwiJR4rp6f3mSRSrdajj1u0S1F5kUAqtMPMY4z4fC1HZ+qjh
        BQ8TnhWeKgKC7u8mPIZietQyyQ==
X-Google-Smtp-Source: APXvYqza39AuRdSj+WTPtS0AXsMxw2OjmXIO7LOV133rsNOr259smnP3qqSflId6/fIhXVciJNR8Eg==
X-Received: by 2002:a1c:7205:: with SMTP id n5mr5243604wmc.9.1578577947211;
        Thu, 09 Jan 2020 05:52:27 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id v17sm7903169wrt.91.2020.01.09.05.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 05:52:26 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-arm-kernel@lists.infradead.org, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] arm64: zynqmp: Remove addition number in node name
Date:   Thu,  9 Jan 2020 14:52:16 +0100
Message-Id: <34e9e2001a874428b3e3fb3c73799589783a6278.1578577931.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1578577931.git.michal.simek@xilinx.com>
References: <cover.1578577931.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change is coming from mainline review that's why this patch is
sync.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Add missing patch

 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
index b75235ae7d30..4a86efa32d68 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
@@ -123,7 +123,7 @@ &spi0 {
 	status = "okay";
 	num-cs = <1>;
 
-	spi0_flash0: flash0@0 {
+	spi0_flash0: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "sst,sst25wf080", "jedec,spi-nor";
@@ -141,7 +141,7 @@ &spi1 {
 	status = "okay";
 	num-cs = <1>;
 
-	spi1_flash0: flash0@0 {
+	spi1_flash0: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "atmel,at45db041e", "atmel,at45", "atmel,dataflash";
-- 
2.24.0

