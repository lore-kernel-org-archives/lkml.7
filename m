Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD7AC04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FBA206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="h8vjQ7b7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfLIXoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:44:09 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:39823 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfLIXoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:44:09 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 414D823061;
        Tue, 10 Dec 2019 00:44:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1575935047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K66pbM+Fv3RvbrM97OMe2n8P9YUrIMeUwtk+G3iABdc=;
        b=h8vjQ7b70YcaW9DXpZRNl9lHtaoFQvlc2kO31t4fa5Y68t021zz8Ymgo3ZcIn/WjxT4l3Q
        bZyepj6vhKRuLHAY7GckJZHcQOGB4c0HqLz9YokxLZuAaJu+ZxpcXXRBwku/IWqJEMa/PG
        CzdA0uZhuGhn/xTyOXAGT9EMIftoy4w=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Yuantian Tang <andy.tang@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 1/5] arm64: dts: ls1028a: fix typo in TMU calibration data
Date:   Tue, 10 Dec 2019 00:43:46 +0100
Message-Id: <20191209234350.18994-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191209234350.18994-1-michael@walle.cc>
References: <20191209234350.18994-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 414D823061
X-Spamd-Result: default: False [6.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.705];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The temperature sensor may jump backwards because there is a wrong
calibration value. Both values have to be monotonically increasing.
Fix it.

This was tested on a custom board.

Fixes: 571cebfe8e2b ("arm64: dts: ls1028a: Add Thermal Monitor Unit node")
Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Tang Yuantian <andy.tang@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 8e8a77eb596a..06082c932531 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -584,7 +584,7 @@
 					       0x00010004 0x0000003d
 					       0x00010005 0x00000045
 					       0x00010006 0x0000004d
-					       0x00010007 0x00000045
+					       0x00010007 0x00000055
 					       0x00010008 0x0000005e
 					       0x00010009 0x00000066
 					       0x0001000a 0x0000006e
-- 
2.20.1

