Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A4CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4BA217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639895;
	bh=45/JiBrYveEN+Rj7Z+64oGLJm0MNpL+7SLALyvLUOq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KFFQhbaPc0h+3IlI8jmVd+6yh7QCELtJcpWTlRDGUJ6f2U9rlhapBERbSBF3Fz/bQ
	 jiSzYUDUuLgKXxPiviQ+uVGka1TxL6qOdMeXSjtlUOp9Arbzvpk7UTUQl8y6/mDeAX
	 P1642yFbYI1w/zhEalc0JpRBc9WEnbKDdFDaOZdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392248AbfEWTbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:31:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403863AbfEWTbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:31:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 404DC20879;
        Thu, 23 May 2019 19:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639890;
        bh=45/JiBrYveEN+Rj7Z+64oGLJm0MNpL+7SLALyvLUOq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S02OvLU6jCQ/QC3lDM1tuBuwxaJTjP+AKLZauUPemWE28yYYnjfxd8TSq0hrub2LP
         a8kqpPPshKdAYhUSF03NTbmi3ttXE/5c7PHKdcl45TCODcz0PMTJodtgV5Uoyj8odz
         xbMGugWUNXO0H7sr0J7fVjPv+5rrJINmhsAcsGjQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.1 122/122] ARM: dts: imx6q-logicpd: Reduce inrush current on start
Date:   Thu, 23 May 2019 21:07:24 +0200
Message-Id: <20190523181721.785614665@linuxfoundation.org>
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

commit dbb58e291cd47e594b64293bd91a4ce40626513c upstream.

The main 3.3V regulator sources a series of additional regulators.
This patch adds a small delay, so when the 3.3V regulator comes
on it delays a bit before the subsequent regulators can come on.
This reduces the inrush current a bit on the external DC power
supply to help prevent a situation where the sourcing power supply
cannot source enough current and overloads and the kit fails to
start.

Fixes: 1c207f911fe9 ("ARM: dts: imx: Add support for Logic PD i.MX6QD EVM")
Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
+++ b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
@@ -100,6 +100,7 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio1 26 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <70000>;
 		enable-active-high;
 		regulator-always-on;
 	};


