Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D49CCA9EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7304214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Nhf2YH2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733135AbfJ1H7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:59:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46141 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733125AbfJ1H7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:59:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id b25so6340455pfi.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 00:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rTp8veXsbPSlIboKUPW27VEfaouXwybhFA3W6d1O8fo=;
        b=Nhf2YH2LsGxBcx7yIKRbk3dyTrz8MeW1xjaYAUFLDZP8QChbJJ0bzWoT6V3pLJ3t13
         EznfckCTNYAdsW0SvcCWR0OOFdIET8hQI9lOonu2OuqmByjlKP5J2Sz7T48KiZqu+6x+
         EBYLXoXrJDJnvVyVY8oA3XzYZmc+dSpnusAjR5JbXyH9eDjtWPaKz5Ny7Fap0sndmbsG
         YDespJ0XT/A5ffgwKnx8x6Il/6MUpOVBKCoszEKNFXsJYU3yPvg1ALqOhUwNTJ/O1hrP
         GWCuwN+l5Sg3GiN8X3Hk/6akJF8t+EdT+JNt+MKCuKD8NxZLAT9uR3qS3WE20iJTSae3
         sQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rTp8veXsbPSlIboKUPW27VEfaouXwybhFA3W6d1O8fo=;
        b=EXEfRg54cF0cuGPEE+0FoAKI9dBxAhlQhryOWYagC1+SHIFIZQvPRxXlFx0tRsfOFt
         tka9g/MFAtabIovGmeOs9+ky9gb8mGol8jAsyoAjoWWXGZ87bxxHO/yII5IpZM8YVOZp
         7MkX9r290voiO9+4+GiJFC7D8sJSXrDGCMBqi/gYusEFUu/P1xhAhYyngjg5SnlPKUnA
         AD2b2PyJlGfOZUue8Ps0A6EF6tsQnR9bvxcq8Q6N5wrBc2ENaKj/j801F1Rixp6KpM6u
         RB751WpcwMe/0vpPda92gM9Y0VT35Rum4ulv8Z3Q4jEZRQxk6JdRzZo9daqNrTH9AvTD
         zFiQ==
X-Gm-Message-State: APjAAAVStepwH0ov+MPcu9QCW9Z8Kp3iLf4XGvc2P4W0F3AXqgcoF+6q
        WyTW48EHcoMoK7bo8wqnu2FYxQ==
X-Google-Smtp-Source: APXvYqx+JIR+yzkCTCD7Bbm0NZp9TiSO96dmNSrfppX02pO25pWjTQLw3ymkAK+lbP8F1+zHbf7yeQ==
X-Received: by 2002:a17:90a:ac02:: with SMTP id o2mr11693235pjq.83.1572249559634;
        Mon, 28 Oct 2019 00:59:19 -0700 (PDT)
Received: from localhost.localdomain (111-241-170-106.dynamic-ip.hinet.net. [111.241.170.106])
        by smtp.gmail.com with ESMTPSA id y36sm9504752pgk.66.2019.10.28.00.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 00:59:19 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
Cc:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Yash Shah <yash.shah@sifive.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] riscv: dts: add support for PDMA device of HiFive Unleashed Rev A00
Date:   Mon, 28 Oct 2019 15:56:21 +0800
Message-Id: <20191028075658.12143-3-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028075658.12143-1-green.wan@sifive.com>
References: <20191028075658.12143-1-green.wan@sifive.com>
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

