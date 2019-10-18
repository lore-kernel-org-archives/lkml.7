Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD5ACA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544542089C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Rt1bniV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442630AbfJRMPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:15:52 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:59916 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2442523AbfJRMPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:15:50 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6FECDC09CA;
        Fri, 18 Oct 2019 12:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571400950; bh=AIGwTQLYhX+M2s0W3a/AMO9FziLVCQioUIaBsq9d96A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rt1bniV3LejIVIV7NJQxKdQWHdcXTBqriWJY6ykguvGIxpmTBn2tpVk5ahEfPDEGj
         a/P4a+fk2h9RQZwUM2xWBwb5Qb9cXkopU5LH66Wh4KpZ29oHiLOc9PtMghrP0ZU49m
         DACGWA1X/zayTWRshs5pbJPI0PfzSmrS3mDjWjK5O7ivutKMDj4SYq4vXNNt6qVXef
         0KLkyaRihmm2WbVMXWNZnPDRJb1wqTH0NSZbmkSIkJZWDlfScEbs2BOn5mJFTsT+zG
         jguDKuAQbzF6kPue0aiUAx3rDjxRqRils5ZjfL5GRFnjkUtsHApTKKPp5p1QcqqBgR
         cHuU+L6weoT3w==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id CC852A0069;
        Fri, 18 Oct 2019 12:15:48 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [RFC 3/6] ARC: HAPS: use same UART configuration everywhere
Date:   Fri, 18 Oct 2019 15:15:42 +0300
Message-Id: <20191018121545.8907-4-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191018121545.8907-1-Eugeniy.Paltsev@synopsys.com>
References: <20191018121545.8907-1-Eugeniy.Paltsev@synopsys.com>
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

