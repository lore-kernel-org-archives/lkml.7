Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2DBC742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0007208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562935214;
	bh=zL6aqGAa5so6ji5VyfQpcIsTR3nG6SR8l5QdORUrsn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rHyyVXUUJGKIgoTI4BQmv0O/CtS0FpbQVfkA1YIsbI4xm5HkkZ7zaHaPwlajNmb20
	 vYfTeNDGry+f44OM1iHG5iV7EfVg2M59UZV4nezaR7fomVUhvuqU88rQZge/8+IE9m
	 DeschndejvC8HAPy2816Gxu1KGwMajnqD3b66odA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfGLM0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:26:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbfGLMZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:25:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACBC6208E4;
        Fri, 12 Jul 2019 12:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934353;
        bh=zL6aqGAa5so6ji5VyfQpcIsTR3nG6SR8l5QdORUrsn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AfMQqqezNvJBvbbyG5cUnclSUNSe1FdqvCAHa0VbVUT4g30/9Roy3qaYRUn1R7Uc/
         +coO5pvHQfRPQdGCwwunpdN+sixd95nvyC42YpAHfr596qnM+eUBfZPmxWNzma89Sq
         v2+NjNtaDNuM7bdD3vUOJfSVlK9jc6RVkbn9V0QU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 004/138] ARM: dts: dra76x: Disable rtc target module
Date:   Fri, 12 Jul 2019 14:17:48 +0200
Message-Id: <20190712121628.899564305@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f7b9cb944a5d41fdede4e928a47e9d5fce5169d7 ]

rtc is fused out on dra76 and accessing target module
register is causing a boot crash hence disable it.

Fixes: 549fce068a3112 ("ARM: dts: dra7: Add l4 interconnect hierarchy and ti-sysc data")
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/dra7-l4.dtsi | 2 +-
 arch/arm/boot/dts/dra76x.dtsi  | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 414f1cd68733..73f5c050f586 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -3543,7 +3543,7 @@
 			};
 		};
 
-		target-module@38000 {			/* 0x48838000, ap 29 12.0 */
+		rtctarget: target-module@38000 {			/* 0x48838000, ap 29 12.0 */
 			compatible = "ti,sysc-omap4-simple", "ti,sysc";
 			ti,hwmods = "rtcss";
 			reg = <0x38074 0x4>,
diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
index 9ee45aa365d8..5c437271d307 100644
--- a/arch/arm/boot/dts/dra76x.dtsi
+++ b/arch/arm/boot/dts/dra76x.dtsi
@@ -81,3 +81,7 @@
 		reg = <0x3fc>;
 	};
 };
+
+&rtctarget {
+	status = "disabled";
+};
-- 
2.20.1



