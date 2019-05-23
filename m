Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B60C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82C920879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639902;
	bh=AzMTh1vZQeWbpKWEDylc1KVid3P1tp+dRLMikeQDZwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xQSEviwQnD3fYefqTcTb0FVCF7HIlI0hWzaPDM3xY+NXYBKo7lkDypazgXot/1Ibd
	 HhSRHVV/KIyHIxxKXGJv/ATqDtoRxFh3i9E7a2Dwpa39Nn1b4XEr6s7u5BAuA6othJ
	 o7DdCSp8hkIFbHQhhMWNw1ttbaOlXTJCLY5PA3n0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403870AbfEWTbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403851AbfEWTb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:31:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 822C0206BA;
        Thu, 23 May 2019 19:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639888;
        bh=AzMTh1vZQeWbpKWEDylc1KVid3P1tp+dRLMikeQDZwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NLPELoWmM4gv+kyYHISjdhkXphPy4rTGmbCEP/6uhwb9nJqShEc9p3FiIAxs4Pu8u
         YkN9euDZWQcC4+SXiAsRpqm7DuI0zhcGeyGEXcqveWJtDldHkARIYBWG43BDKey/RB
         ZImExQ3uCfFXnBTAwmsts8+Jrc8UWlKurBbLkVsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.1 121/122] ARM: dts: imx6q-logicpd: Reduce inrush current on USBH1
Date:   Thu, 23 May 2019 21:07:23 +0200
Message-Id: <20190523181721.602021710@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

commit 7aedca875074b33795bc77066b325898b1eb8032 upstream.

Some USB peripherals draw more power, and the sourcing regulator
take a little time to turn on.  This patch fixes an issue where
some devices occasionally do not get detected, because the power
isn't quite ready when communication starts, so we add a bit
of a delay.

Fixes: 1c207f911fe9 ("ARM: dts: imx: Add support for Logic PD i.MX6QD EVM")
Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
+++ b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
@@ -88,6 +88,7 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <70000>;
 		enable-active-high;
 	};
 


