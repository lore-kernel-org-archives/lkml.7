Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58411C43215
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 20:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C2120836
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 20:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="nugwZk+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfKXUwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 15:52:05 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:10830 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfKXUwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 15:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574628722;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=mDUqPV5Qhr6G4j4fBcrxLNAXwyQc//1k5IFuN2hMhPg=;
        b=nugwZk+FtE9t1Mjo2rwpW5Fodoi+BzVbWDG7KH8K/VpaPU0KZxlRasoL8Y6bTPUVxo
        ocxhi0GNK9vYlrFAZ5B0QP+QpTGo2JNZOQat7jv/qKy2uPQy6STcGqyu7FAF2WdIK8/y
        LTWH9bZ+4R9lv2Gfn/5iPz2vplT1I33nSDlVECFQ+szS0uuVJzg0WxKx2vBnRrvp7t27
        NkYsjnx9hOSIC4T0s4k/EeE8Zr24I9OuJ9rHBwf3YybqbgpRFHJrok1k9P6hEEot2C35
        Wce2OHY0BtZYTPQN2PdReQLe+wNo0W9sbHMbbDa/l/Le6fkzShQ9Rqt4GA6pyRwbH7in
        o+Ng==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQ7IOGU5qzCBwY93scQxp"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vAOKq2CZP
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 24 Nov 2019 21:52:02 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] ARM: dts: ux500: Use "arm,pl031" compatible for PL031
Date:   Sun, 24 Nov 2019 21:51:10 +0100
Message-Id: <20191124205110.48031-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ux500 device tree uses "arm,rtc-pl031" as compatible for PL031.
All other boards in Linux describe it using "arm,pl031" instead.
This works because the compatible is not actually used in Linux:
AMBA devices get probed based on "arm,primecell" and their peripheral ID.

Nevertheless, some other projects (e.g. U-Boot) rely on the compatible
to probe the device with the correct driver. Those will look for
"arm,pl031" instead of "arm,rtc-pl031", preventing the RTC from being
probed.

Change it to "arm,pl031" to match all other boards.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 51ac65b78be0..0a5b88702b16 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -324,7 +324,7 @@
 		};
 
 		rtc@80154000 {
-			compatible = "arm,rtc-pl031", "arm,primecell";
+			compatible = "arm,pl031", "arm,primecell";
 			reg = <0x80154000 0x1000>;
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
 
-- 
2.24.0

