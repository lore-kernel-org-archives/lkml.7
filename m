Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A95FC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A064216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562601010;
	bh=KN8yo2h0Np7Tkvslz4tJ96KO/9Ldc81JlWakUjBIEY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jelmhekNsWecj2UwY/SmXGBLlHGwomJl9BsuNxwGzCKDcjypPVrJeJIqw267qB6pP
	 UdFLAuTmZCsEQw5XiKpddSzxC4LKlgzyZMptaRByfT1ggmbPTWveHk1jdckKY8MGDs
	 oxOYgQhcWZdUO8aVZdr2KdtS3jgjknKO9/GwuvI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389127AbfGHPuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732378AbfGHPPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:15:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BD07214C6;
        Mon,  8 Jul 2019 15:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562598938;
        bh=KN8yo2h0Np7Tkvslz4tJ96KO/9Ldc81JlWakUjBIEY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uoKwMmZtR8UaB0+4O+c9kBebtk6ey0nTGcp+iRAJwBY7694P4xUyGkAHgIIv2x/mw
         lV7K7qA+q5yAbMV2YISlN+/r7dn/XMeKKlWQ313g+1482CTsa4O147Tqj+SqaukrUj
         JWOAACKVdjiB64zT38+5mVc9TQbSEwc0v0sHF1SQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 4.4 23/73] ARM: imx: cpuidle-imx6sx: Restrict the SW2ISO increase to i.MX6SX
Date:   Mon,  8 Jul 2019 17:12:33 +0200
Message-Id: <20190708150521.712595310@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

commit b25af2ff7c07bd19af74e3f64ff82e2880d13d81 upstream.

Since commit 1e434b703248 ("ARM: imx: update the cpu power up timing
setting on i.mx6sx") some characters loss is noticed on i.MX6ULL UART
as reported by Christoph Niedermaier.

The intention of such commit was to increase the SW2ISO field for i.MX6SX
only, but since cpuidle-imx6sx is also used on i.MX6UL/i.MX6ULL this caused
unintended side effects on other SoCs.

Fix this problem by keeping the original SW2ISO value for i.MX6UL/i.MX6ULL
and only increase SW2ISO in the i.MX6SX case.

Cc: stable@vger.kernel.org
Fixes: 1e434b703248 ("ARM: imx: update the cpu power up timing setting on i.mx6sx")
Reported-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Tested-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
Tested-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-imx/cpuidle-imx6sx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arm/mach-imx/cpuidle-imx6sx.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
@@ -14,6 +14,7 @@
 
 #include "common.h"
 #include "cpuidle.h"
+#include "hardware.h"
 
 static int imx6sx_idle_finish(unsigned long val)
 {
@@ -97,7 +98,7 @@ int __init imx6sx_cpuidle_init(void)
 	 * except for power up sw2iso which need to be
 	 * larger than LDO ramp up time.
 	 */
-	imx_gpc_set_arm_power_up_timing(0xf, 1);
+	imx_gpc_set_arm_power_up_timing(cpu_is_imx6sx() ? 0xf : 0x2, 1);
 	imx_gpc_set_arm_power_down_timing(1, 1);
 
 	return cpuidle_register(&imx6sx_cpuidle_driver, NULL);


