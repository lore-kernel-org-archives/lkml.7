Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E54C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883C12087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412173;
	bh=njn+LxlYIRN0HL1iO0v8pl6v9lxKn4uLlYjkfi1zK8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xhY8VOWdVnUPevvmeU67qc9VR5WKCv5f6LCgaG4hayN+Scn6k1GddGPCjYlJR7GO7
	 Zexug3daaKNGHvHxi6+KlPAe2kK1SHbdObYTY8bgIz/jlescBoIeGaKCJDL4B9w8So
	 YQHJGJ+5ULkqeFl+UisauGM7KcLpVZXYvjjgZaUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfCLRgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbfCLRQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:47 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4233217D8;
        Tue, 12 Mar 2019 17:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411006;
        bh=njn+LxlYIRN0HL1iO0v8pl6v9lxKn4uLlYjkfi1zK8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ntbj7onR5wkjXIFgc770JL4vFDyfBTVAWYid6i1IKSYld2yJ2fItZKE1FIQdZwiHm
         mFX6u3hkP7d76mHgsZ0ihE92ox1fDHNnsw4wztFPLwIrgSXPb2Egdq8tky6/pUiZiW
         v+E9b4XexblXbtlatQQcyAhfAF30QrNKDDm9qKyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhou Yanjie <zhouyanjie@cduestc.edu.cn>,
        Paul Burton <paul.burton@mips.com>,
        linux-mips <linux-mips@vger.kernel.org>,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        ralf@linux-mips.org, jhogan@kernel.org, mark.rutland@arm.com,
        malat@debian.org, ezequiel@collabora.co.uk, ulf.hansson@linaro.org,
        syq <syq@debian.org>, "jiaxun.yang" <jiaxun.yang@flygoat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 093/135] DTS: CI20: Fix bugs in ci20s device tree.
Date:   Tue, 12 Mar 2019 10:09:00 -0700
Message-Id: <20190312170349.760389664@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1ca1c87f91d9dc50d6a38e2177b2032996e7901c ]

According to the Schematic, the hardware of ci20 leads to uart3,
but not to uart2. Uart2 is miswritten in the original code.

Signed-off-by: Zhou Yanjie <zhouyanjie@cduestc.edu.cn>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips <linux-mips@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Cc: devicetree@vger.kernel.org
Cc: robh+dt@kernel.org
Cc: ralf@linux-mips.org
Cc: jhogan@kernel.org
Cc: mark.rutland@arm.com
Cc: malat@debian.org
Cc: ezequiel@collabora.co.uk
Cc: ulf.hansson@linaro.org
Cc: syq <syq@debian.org>
Cc: jiaxun.yang <jiaxun.yang@flygoat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index a4cc52214dbd..dad4aa0ebdd8 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -54,7 +54,7 @@
 	status = "okay";
 
 	pinctrl-names = "default";
-	pinctrl-0 = <&pins_uart2>;
+	pinctrl-0 = <&pins_uart3>;
 };
 
 &uart4 {
@@ -174,9 +174,9 @@
 		bias-disable;
 	};
 
-	pins_uart2: uart2 {
-		function = "uart2";
-		groups = "uart2-data", "uart2-hwflow";
+	pins_uart3: uart3 {
+		function = "uart3";
+		groups = "uart3-data", "uart3-hwflow";
 		bias-disable;
 	};
 
-- 
2.19.1



