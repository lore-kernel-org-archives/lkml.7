Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29086C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8542166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Nf9DBQGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbfKGIxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:53:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39059 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733209AbfKGIxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:53:22 -0500
Received: by mail-pf1-f195.google.com with SMTP id x28so2128440pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 00:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rTp8veXsbPSlIboKUPW27VEfaouXwybhFA3W6d1O8fo=;
        b=Nf9DBQGuiPv+DM370AIy9xr6rpoQTSkVEgQIjOjzF27ommG1tr9FxySdRD8FhsNjNH
         ag+mnLngc3Jagt6yR26vyv0BzdjXJ+24xdnO/Q4eFGlFMZOYgO7urSdkfRK1ndlofOAK
         lcepW1ADDTvPU5uyralgOwXE7UWiuZikY4+Onzim+MJWJ7lEl0TH9/6iLgbtMWMvdRZo
         9pKJu/admijRQcr1C2a8ycejgE396VPhIhplbgEb77lkcivKsrC6u2MNH9EAVZriy4uT
         Ll+IQr8zv8sfrHVPPHx5vAntlpIPhzvQp+S1oomn4RjbE6gy9Sv2Hz+HS2DRgRZNqG+L
         tSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rTp8veXsbPSlIboKUPW27VEfaouXwybhFA3W6d1O8fo=;
        b=Jr6dszPup8N0pSDDR4CeMh6oMPU+opYvG0JC97saMKLYMGSAvEHvUZ/hxpXsUmGCN8
         Sm05oQfCVrxgXyl3E2lY6sG1O7ThSLfLfm681/I5xdIvh8UhoOfM6o8Rr8b4AaYDHKps
         On1OrZl8o2lhRSqucsxAdU2gbvbCAucqZvVwsmxd4BixMZYiB+ElrPV5JI+0ELW59OZP
         d6SuGSIR3HoD/2EoL8BPMGwMB6jTzUfMX+GwiIUGBq/Nt+Gl6xwT9F21Ks2jOLj5IQEl
         Q9GpjfGKs14q6J0eOyy8hmylfetMBkfzo/HKkElZZGjTlv71jika+iBWPQ0qZDalnUAJ
         tJfQ==
X-Gm-Message-State: APjAAAU1BKKHX0PDxM6vhrhu9fWDoDbiPtFuVXNGNNcL029/elLuERUY
        OIflSTS77/H3TkYC4MecHpUEMg==
X-Google-Smtp-Source: APXvYqwjonCLe6lKUq8m5TTtxhcWb55hteTieYRwORhrcDOmYcewk+My9YdyJjeoZwrBij17ZnLBQA==
X-Received: by 2002:a63:cf45:: with SMTP id b5mr3072879pgj.36.1573116801206;
        Thu, 07 Nov 2019 00:53:21 -0800 (PST)
Received: from localhost.localdomain (36-228-119-18.dynamic-ip.hinet.net. [36.228.119.18])
        by smtp.gmail.com with ESMTPSA id a33sm2402361pgb.57.2019.11.07.00.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 00:53:20 -0800 (PST)
From:   Green Wan <green.wan@sifive.com>
Cc:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] riscv: dts: add support for PDMA device of HiFive Unleashed Rev A00
Date:   Thu,  7 Nov 2019 16:49:20 +0800
Message-Id: <20191107084955.7580-3-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107084955.7580-1-green.wan@sifive.com>
References: <20191107084955.7580-1-green.wan@sifive.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PDMA support to (arch/riscv/boot/dts/sifive/fu540-c000.dtsi)

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index afa43c7ea369..70a1891e7cd0 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -162,6 +162,13 @@
 			clocks = <&prci PRCI_CLK_TLCLK>;
 			status = "disabled";
 		};
+		dma: dma@3000000 {
+			compatible = "sifive,fu540-c000-pdma";
+			reg = <0x0 0x3000000 0x0 0x8000>;
+			interrupt-parent = <&plic0>;
+			interrupts = <23 24 25 26 27 28 29 30>;
+			#dma-cells = <1>;
+		};
 		uart1: serial@10011000 {
 			compatible = "sifive,fu540-c000-uart", "sifive,uart0";
 			reg = <0x0 0x10011000 0x0 0x1000>;
-- 
2.17.1

