Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE054CA9EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8510521872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZDueIeYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391711AbfJWMo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:44:27 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:37292 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391698AbfJWMoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:44:25 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F1E81C0CD6;
        Wed, 23 Oct 2019 12:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571834665; bh=AIGwTQLYhX+M2s0W3a/AMO9FziLVCQioUIaBsq9d96A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDueIeYiCA9D1mUgjA+n2oyUXRNMrKE/UpgwhxXRiC9UjrX92exjUacYJ/tnH5Fhf
         ri04Nru8Fgc9QETZbQK/saa6tBA+zxOmsKL4LesB/K2Ztz7ySRHoBrOkA3wAQZk2Il
         UkE/nXtaWByh35kdXuybFCfu6NwKX4/MCBt0gPqzUEvPXQoDBUqb5B6pdIrw5+v5E8
         b8xNFdhk+lGbdHRmHXmLLBoyFOdTHk3KwotMbjX/UWPo0QXkQSSmPfnlOemLCaDpgR
         TCi4iZzSFZrtxLBBwXATZSr2kMiuCFJDqliDmBwq8GddKWO5DisLKj7+AkfruHBAxU
         UzId60Hcwc//g==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id 484B3A0067;
        Wed, 23 Oct 2019 12:44:23 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 3/8] ARC: HAPS: use same UART configuration everywhere
Date:   Wed, 23 Oct 2019 15:44:12 +0300
Message-Id: <20191023124417.5770-4-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023124417.5770-1-Eugeniy.Paltsev@synopsys.com>
References: <20191023124417.5770-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason we use ns8250 UART compatible on UP HAPS
configuration and ns16550a (which is ns8250 with FIFO support)
on SMP HAPS configuration.
Given that we have same UART IP with same IP configuration
on both HAPS configuration use ns16550a compatible everywhere.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/boot/dts/haps_hs.dts     | 2 +-
 arch/arc/boot/dts/haps_hs_idu.dts | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arc/boot/dts/haps_hs.dts b/arch/arc/boot/dts/haps_hs.dts
index 44bc522fdec8..11fad2f79056 100644
--- a/arch/arc/boot/dts/haps_hs.dts
+++ b/arch/arc/boot/dts/haps_hs.dts
@@ -47,7 +47,7 @@
 		};
 
 		uart0: serial@f0000000 {
-			compatible = "ns8250";
+			compatible = "ns16550a";
 			reg = <0xf0000000 0x2000>;
 			interrupts = <24>;
 			clock-frequency = <50000000>;
diff --git a/arch/arc/boot/dts/haps_hs_idu.dts b/arch/arc/boot/dts/haps_hs_idu.dts
index 4d6971cf5f9f..738c76cd07b3 100644
--- a/arch/arc/boot/dts/haps_hs_idu.dts
+++ b/arch/arc/boot/dts/haps_hs_idu.dts
@@ -54,7 +54,6 @@
 		};
 
 		uart0: serial@f0000000 {
-			/* compatible = "ns8250"; Doesn't use FIFOs */
 			compatible = "ns16550a";
 			reg = <0xf0000000 0x2000>;
 			interrupt-parent = <&idu_intc>;
-- 
2.21.0

