Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F2FC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD8920650
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAAU8v7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389535AbfIEMqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:46:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42409 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731418AbfIEMqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:46:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id y1so1240361plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 05:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AR21odD9lkUkw6UTbUz0v0ot901NBSStVHxLTmWtokQ=;
        b=tAAU8v7jHjwov7FgdyjSS2n+TwN+DJEnPpo5BBWuRs+0ifGrSrcbTybiLFX+rtmgP6
         gTbAYKFUbGB9lDJLaF2TwJ71TXOC9ii9U3XPvSwDTVDOxFdvtqEXOupk3kFrncCzC2Hm
         FCVhcC3rEzfgS7MKtA0GE/WKQ+IBsPtd4xevP1W3gUkS5gCHXuqg9X+iCGeOaFY7Dr3Q
         6Dhs1v94FlRyKWiT991ZW39XbdrqKi7KKBCUse4G+IhaKFPQGQyu7C77ogKeVmajhLD3
         zUONdTy0cb7WIaUhIgLqerTKfxFxfZfNkKcalQEFZiLN80oMKKDppJv4NgC3DsByxk3Y
         DTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AR21odD9lkUkw6UTbUz0v0ot901NBSStVHxLTmWtokQ=;
        b=eR+69oYQxBCGIXibJxI1ARzoC1as52XVRLSywZR4FqdJcT3Jkt8uQVe5evSRlyr/Cl
         eaklLigxGY17H72ibPBCQqrEGi+rBB4XKNYgLHbjNY1GImiJhEonwhQjZvD83k9HG62k
         VCe82t1WcwMqZmYFm+aIBTbqdefi+b5Joc+c/r+8wrRcoZKiStQwyZxiYPx1Tzg7qXmc
         Gl2EVCabilimVTiERijUkaHsLG6vBj1wnR5uns7q9H2TjCVpvnqZ9Qr9ruQYPm8p6mRP
         CQTuln3RIVmABcYNQdunMG1tgTcoauGxuPUKHIoqLZIRC4ZbqHfRk/Sa0ECZR50F7vzw
         zbmQ==
X-Gm-Message-State: APjAAAXNV/Bkl9noUwqlt/724bGSSbUflwFP7Ko0ZrLIeX75Yi9bKTA/
        briPFaPx1DOtxQ9axj1Ixqs=
X-Google-Smtp-Source: APXvYqxxIiiCGHUr4lP9Eq+nSIH+iyXFJMCj2pkctamr2F3AQ30yECuCtFk6zvQO18+YJcfYkuLZFQ==
X-Received: by 2002:a17:902:169:: with SMTP id 96mr3027576plb.297.1567687580305;
        Thu, 05 Sep 2019 05:46:20 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com. [147.11.224.80])
        by smtp.gmail.com with ESMTPSA id k1sm2334268pfi.132.2019.09.05.05.46.19
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 05:46:19 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: dts: sifive: Add ethernet0 to the aliases node
Date:   Thu,  5 Sep 2019 05:46:14 -0700
Message-Id: <1567687574-22436-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U-Boot expects this alias to be in place in order to fix up the mac
address of the ethernet node.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index a9d48ff..9e55c22 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -13,6 +13,7 @@
 	aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
+		ethernet0 = &eth0;
 	};
 
 	chosen {
-- 
2.7.4

