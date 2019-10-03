Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D904C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF058215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122153;
	bh=JJNj1JIfEKumpLPmvbYYR+Yiy/6Lw903RFyWTOdYqXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z/Ki2QdMkWOTy+qzA+GPmIrSD2FpYFbnocLxYWjxnAl4lF9EWLxBR+dabGg1hMuIf
	 6X4E1unJLMheL9qN2gicWiEyAwhRrFKujE9+ekeuZgtTzMoOABnVZipm23QlZr02Yx
	 /PkfqAR95nBp+sIube+x4ZqG13xbFkIqmXzSUuVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405665AbfJCRCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:02:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405195AbfJCQnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:43:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FC5C206BB;
        Thu,  3 Oct 2019 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120979;
        bh=JJNj1JIfEKumpLPmvbYYR+Yiy/6Lw903RFyWTOdYqXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fjKAqmzE+CcuBFKiStBDnzy4MbfYLr7nLlhWmy6Fd0a8qq2lkVhyKwbU8TrxV/TNH
         6JYatwG1C9trxkPLLUJNpuREc+1qJB8XTlhVZA9vskJs4Ag6ChQW0ATG32HAc34k6Q
         xiJIEhHAVacFfNJUKahx9KHYKmB1YJisEML1NfV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 073/344] arm64: dts: imx8mq: Correct OPP table according to latest datasheet
Date:   Thu,  3 Oct 2019 17:50:38 +0200
Message-Id: <20191003154547.338842324@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

[ Upstream commit 9eced3a2f224a62a233761e8af18c907c532e192 ]

According to latest datasheet (Rev.1, 10/2018) from below links,
in the consumer datasheet, 1.5GHz is mentioned as highest opp but
depends on speed grading fuse, and in the industrial datasheet,
1.3GHz is mentioned as highest opp but depends on speed grading
fuse. 1.5GHz and 1.3GHz opp use same voltage, so no need for
consumer part to support 1.3GHz opp, with same voltage, CPU should
run at highest frequency in order to go into idle as quick as
possible, this can save power.

That means for consumer part, 1GHz/1.5GHz are supported, for
industrial part, 800MHz/1.3GHz are supported, and then check the
speed grading fuse to limit the highest CPU frequency further.
Correct the market segment bits in opp table to make them work
according to datasheets.

https://www.nxp.com/docs/en/data-sheet/IMX8MDQLQIEC.pdf
https://www.nxp.com/docs/en/data-sheet/IMX8MDQLQCEC.pdf

Fixes: 12629c5c3749 ("arm64: dts: imx8mq: Add cpu speed grading and all OPPs")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 52aae341d0da5..d1f4eb197af26 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -169,15 +169,14 @@
 		opp-1300000000 {
 			opp-hz = /bits/ 64 <1300000000>;
 			opp-microvolt = <1000000>;
-			opp-supported-hw = <0xc>, <0x7>;
+			opp-supported-hw = <0xc>, <0x4>;
 			clock-latency-ns = <150000>;
 		};
 
 		opp-1500000000 {
 			opp-hz = /bits/ 64 <1500000000>;
 			opp-microvolt = <1000000>;
-			/* Consumer only but rely on speed grading */
-			opp-supported-hw = <0x8>, <0x7>;
+			opp-supported-hw = <0x8>, <0x3>;
 			clock-latency-ns = <150000>;
 		};
 	};
-- 
2.20.1



