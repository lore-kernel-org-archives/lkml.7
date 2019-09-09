Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD48DC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E6321924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudbear.ru header.i=@cloudbear.ru header.b="NabCOuLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391415AbfIIRTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 13:19:42 -0400
Received: from forward105j.mail.yandex.net ([5.45.198.248]:51449 "EHLO
        forward105j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726998AbfIIRTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 13:19:41 -0400
Received: from mxback12g.mail.yandex.net (mxback12g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:91])
        by forward105j.mail.yandex.net (Yandex) with ESMTP id 5B1DDB210AD;
        Mon,  9 Sep 2019 20:19:39 +0300 (MSK)
Received: from smtp4p.mail.yandex.net (smtp4p.mail.yandex.net [2a02:6b8:0:1402::15:6])
        by mxback12g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id y7Go9rAfas-Jcti3Y5H;
        Mon, 09 Sep 2019 20:19:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cloudbear.ru; s=mail; t=1568049579;
        bh=r84Kqo/HGSOXp2gbIzeEvSukvJmucKofPxYZFL2hinQ=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=NabCOuLEFysLtc69zbf8UfSUX5Wpvyc6Jy6ioaFd8WzJzUFZO1ZOzZuATgIpfgW6W
         /niWpleeO2+TF8K9Eexdv8ISjWQRTNxN/aMd9/HmQ/pEJgPrrODRg+JA9Ma/EZUNe7
         NzjjaIugxXa+tieCQDVP+DO1kRxLyVICTeqT4EMQ=
Authentication-Results: mxback12g.mail.yandex.net; dkim=pass header.i=@cloudbear.ru
Received: by smtp4p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id rCsZlLVxqi-JbTSpp4N;
        Mon, 09 Sep 2019 20:19:37 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Vitaly Gaiduk <vitaly.gaiduk@cloudbear.ru>
To:     davem@davemloft.net, robh+dt@kernel.org, f.fainelli@gmail.com
Cc:     Vitaly Gaiduk <vitaly.gaiduk@cloudbear.ru>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Trent Piepho <tpiepho@impinj.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] net: phy: dp83867: Add documentation for SGMII mode type
Date:   Mon,  9 Sep 2019 20:19:25 +0300
Message-Id: <1568049566-16708-2-git-send-email-vitaly.gaiduk@cloudbear.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568049566-16708-1-git-send-email-vitaly.gaiduk@cloudbear.ru>
References: <1568047940-14490-2-git-send-email-vitaly.gaiduk@cloudbear.ru>
 <1568049566-16708-1-git-send-email-vitaly.gaiduk@cloudbear.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation of ti,sgmii-ref-clock-output-enable
which can be used to select SGMII mode type (4 or 6-wire).

Signed-off-by: Vitaly Gaiduk <vitaly.gaiduk@cloudbear.ru>
---
Changes in v4:
- Fixed the wording of property

 Documentation/devicetree/bindings/net/ti,dp83867.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.txt b/Documentation/devicetree/bindings/net/ti,dp83867.txt
index db6aa3f..388ff48 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83867.txt
+++ b/Documentation/devicetree/bindings/net/ti,dp83867.txt
@@ -37,6 +37,10 @@ Optional property:
 			      for applicable values.  The CLK_OUT pin can also
 			      be disabled by this property.  When omitted, the
 			      PHY's default will be left as is.
+	- ti,sgmii-ref-clock-output-enable - This denotes which
+				    SGMII configuration is used (4 or 6-wire modes).
+				    Some MACs work with differential SGMII clock.
+				    See data manual for details.

 Note: ti,min-output-impedance and ti,max-output-impedance are mutually
       exclusive. When both properties are present ti,max-output-impedance
--
2.7.4

