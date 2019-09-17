Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFEAC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 06:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B500421848
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 06:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VlcCfH31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392493AbfIQGYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 02:24:13 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34922 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387513AbfIQGYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 02:24:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17so1059388plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 23:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OFOaylH6u5pbrPHCYuJfQmib6XY1jyUZj3KgxSUlnf8=;
        b=VlcCfH31PMt3ExcsC2X+/sezp4PAAIN5vh85oD9LKcNDNxU/ELwo/z72zixRvnixc0
         ZdVkMvqvZ96CyFBdGNDyQfkdmp6uc6WACA4SL5KtZbU3u16Pljd9Jbel0mp2RqLA95kC
         8rHEW+tvi6OmAqfND6Nw/rOOGk/pEHV2lgYEI+X/aVlA67zIC/iNM9FvVmHvIhGVwUgK
         iZgnLzHh29kUZxFHoRueOtZAoF8LxbvSw25XJ2AzXNF6vAMKk0tgj/zi3QXy/v5FjBdF
         2Vmigu6dMOss3EbiPeQ9IHIVD3JZCbkV5f9ZapvzT+iuvfExoC5yuRjGQsGCGDjoSdI6
         6KCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OFOaylH6u5pbrPHCYuJfQmib6XY1jyUZj3KgxSUlnf8=;
        b=RwuPIxlGWlTKlOrdYy63aO/8ZXy2ZVjQqChWMYZNjCwnqIfcA2dsQ2sP7A2FNUbmwz
         J8LDvpGrjrLN3tjzeLbyXC4EwM0WiPuxEDfDlKhLqsbKncTfYTJh8V/JGMhGxbTv9cia
         cnU0oxpRYPwMZufeOJmt9jHXqA3vXtgH0pGvTMAHvbSPqHwL6K1wMyJBdabCExQwfb9F
         MdUpKN+BQN3K2uq/aYcCJrZHAeHOVZBW1231AL6/Vn4B4AJGgr9vseaIkPGi5TmUoZNF
         C2q7VHyqiE9EQemPZ9367S0sGiBXzSjDDZxT8so28uZ/Y72E4HKQOe6hS6jGUMh2gFWj
         uaOg==
X-Gm-Message-State: APjAAAUoySKVTMo8DALEBG7bBFt2ZbF5r6bqBNpobBmwZcZGf9MOWUEM
        zuZAuz/kl0b5tbbgUAeQ+bbcHA==
X-Google-Smtp-Source: APXvYqwLe8dHC49vL+zoSKTIa0C+ovX5FQBv7ioYIkPQEBvBXsr1KFZTQa+ddZ91fZ4imVDjyl687w==
X-Received: by 2002:a17:902:8492:: with SMTP id c18mr2040072plo.279.1568701450621;
        Mon, 16 Sep 2019 23:24:10 -0700 (PDT)
Received: from localhost.localdomain (111-241-124-228.dynamic-ip.hinet.net. [111.241.124.228])
        by smtp.gmail.com with ESMTPSA id m16sm1180463pgb.84.2019.09.16.23.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 23:24:10 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
Cc:     linux-hackers@sifive.com, Green Wan <green.wan@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yash Shah <yash.shah@sifive.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] riscv: dts: add support for PDMA device of HiFive Unleashed Rev A00
Date:   Tue, 17 Sep 2019 14:23:45 +0800
Message-Id: <20190917062350.825-1-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
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
index 42b5ec223100..d3030d7fb45c 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -164,6 +164,13 @@
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

