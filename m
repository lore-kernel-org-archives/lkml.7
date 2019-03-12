Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6DAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A707B2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413908;
	bh=aqwcRsou3omsl0U7oxXsBRH41wtvOff4J6L2rJ6r+20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=08gmw5MtvmOgwQtbQDv3ZjT0SzDIWdxuSB9RaRpFwmquzB5R15oqTHg1SDD6vEPZL
	 RvlUpHO+o/TtTH3tDlwm+897bzn0HAKKaAkgTgdnnSgZp7wh6LS4+3Bu5AaGHEhdTP
	 OMyCS0dr3pKahl8XLQnCWgCWxAYS5AhmdliG2Iu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfCLSFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727603AbfCLRMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:43 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 369E52183E;
        Tue, 12 Mar 2019 17:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410762;
        bh=aqwcRsou3omsl0U7oxXsBRH41wtvOff4J6L2rJ6r+20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e70MVnaXa75Jxq6aSgg6dY0j7kFRtBXkEYptRrFLgZPQoTQqvgDWbd9GJ77vgKbkU
         Ymf4ArXXfJTR6LIO/Jvp8IFMbbTQmZlXp/cW9JgPNgeSuXodpkgLcoMUbbu9n8UfVh
         RqAMNr/qY8JZdlWqoY5symOR54LhUWB6hfZvi8Hk=
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
Subject: [PATCH 4.20 095/171] DTS: CI20: Fix bugs in ci20s device tree.
Date:   Tue, 12 Mar 2019 10:07:55 -0700
Message-Id: <20190312170356.160461164@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 50cff3cbcc6d..4f7b1fa31cf5 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -76,7 +76,7 @@
 	status = "okay";
 
 	pinctrl-names = "default";
-	pinctrl-0 = <&pins_uart2>;
+	pinctrl-0 = <&pins_uart3>;
 };
 
 &uart4 {
@@ -196,9 +196,9 @@
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



