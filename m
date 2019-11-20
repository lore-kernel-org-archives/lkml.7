Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6040BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EEA21823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VRTVeIQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfKTL32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:29:28 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:53904 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728376AbfKTL31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:29:27 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E1464C2EDC;
        Wed, 20 Nov 2019 11:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1574249367; bh=lFwY4rXDWlnRNRI1YBEWXe6HkH2a1VgO8bBpeCWzBjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRTVeIQZeJ7N10a+6JLAJq+gKUFNeU7quiJcv0SzR4VvNEsp3cUlfZTytKWZ3hc8w
         z00WAWzSdjMoCgNWD3cC2ZR5HU/0RYIzvx5rIeNGj5cNMzlFS5+TX0ys7eoyxAONln
         A889JzWrZIEgxmkRnGDdF/L7Xuhwcddph1rKvRq93AeDCbdEZqOAe26j5uQ48M2C9M
         wObCbSoz2Qt7UGyiOj8jIiEoU7HkCWfcFy5gWKEtN1S47KRIdFje/8Ar4Oh9BmCo6O
         f/ct5zEizO8por2ix9QxGEJuvwxJtvQasJeBcDIZeCFr6afjAVUu62lCTNEG+3jMOz
         qwxxFj9HoHXRw==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.76])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4C644A005E;
        Wed, 20 Nov 2019 11:29:25 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 2/2] ARC: [plat-axs10x]: remove hardcoded video mode from bootargs
Date:   Wed, 20 Nov 2019 14:29:23 +0300
Message-Id: <20191120112923.431-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191120112923.431-1-Eugeniy.Paltsev@synopsys.com>
References: <20191120112923.431-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now have pixel clock PLL driver and we can change pixel clock rate
so we don't need to enforce one exact video mode. Moreover enforcing
video mode is harmful in case of we enforce mode which isn't
supported by the monitor we are using.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v1->v2:
 * None.

 arch/arc/boot/dts/axs101.dts     | 2 +-
 arch/arc/boot/dts/axs103_idu.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/boot/dts/axs101.dts b/arch/arc/boot/dts/axs101.dts
index 305a7f9658e0..c4cfc5f4f427 100644
--- a/arch/arc/boot/dts/axs101.dts
+++ b/arch/arc/boot/dts/axs101.dts
@@ -14,6 +14,6 @@
 	compatible = "snps,axs101", "snps,arc-sdp";
 
 	chosen {
-		bootargs = "earlycon=uart8250,mmio32,0xe0022000,115200n8 console=tty0 console=ttyS3,115200n8 consoleblank=0 video=1280x720@60 print-fatal-signals=1";
+		bootargs = "earlycon=uart8250,mmio32,0xe0022000,115200n8 console=tty0 console=ttyS3,115200n8 consoleblank=0 print-fatal-signals=1";
 	};
 };
diff --git a/arch/arc/boot/dts/axs103_idu.dts b/arch/arc/boot/dts/axs103_idu.dts
index 46c9136cbf2b..a934b92a8c30 100644
--- a/arch/arc/boot/dts/axs103_idu.dts
+++ b/arch/arc/boot/dts/axs103_idu.dts
@@ -17,6 +17,6 @@
 	compatible = "snps,axs103", "snps,arc-sdp";
 
 	chosen {
-		bootargs = "earlycon=uart8250,mmio32,0xe0022000,115200n8 console=tty0 console=ttyS3,115200n8 print-fatal-signals=1 consoleblank=0 video=1280x720@60";
+		bootargs = "earlycon=uart8250,mmio32,0xe0022000,115200n8 console=tty0 console=ttyS3,115200n8 print-fatal-signals=1 consoleblank=0";
 	};
 };
-- 
2.21.0

