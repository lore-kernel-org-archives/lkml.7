Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED619C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2F521655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430045;
	bh=Exx+AByECjW/cyf2rHihUkW6qhpA8Y+pR0Nze4y/8pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F3T1pHGx5nzaPmxMPS02RUn9fW7RrZJadwTamLLkmdsU8QxmiX3kQzKQt42l7BJFe
	 VDONKj5lR9Hje8kRN6xkeeriHOflvwl8QeAm0nL0/kLZs3ZP+8RF+4bmo8FaAusVf7
	 wX4dub/ePHYojvBLB9qYd2p2YuLF2PJg8loeEXxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390970AbfG2TyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:54:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404020AbfG2Txj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:53:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17E532171F;
        Mon, 29 Jul 2019 19:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564430018;
        bh=Exx+AByECjW/cyf2rHihUkW6qhpA8Y+pR0Nze4y/8pw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L6+gdCxl453kPj1ysklWTSSTGOWgyat4cVgyvrhClL2M285SVj3oVhu0LOjzm8nMO
         rtQuDefqsO9OPQNomVrbD9i7xrCdl6/EnHc/R38j4rpKXOi/HRfQQBeOMrR2C53ArP
         danUc/OfoE91Z2kjDOvMax0b19xZQMQW2xhkdHr4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 5.2 171/215] Revert "usb: usb251xb: Add US lanes inversion dts-bindings"
Date:   Mon, 29 Jul 2019 21:22:47 +0200
Message-Id: <20190729190809.535528563@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

commit bafe64e5f0edaa689e72e2f8dc236641da37fed4 upstream.

This reverts commit 3342ce35a1, as there is no need for this separate
property and it breaks compatibility with existing devicetree files
(arch/arm64/boot/dts/freescale/imx8mq.dtsi).

CC: stable@vger.kernel.org #5.2
Fixes: 3342ce35a183 ("usb: usb251xb: Add US lanes inversion dts-bindings")
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Link: https://lore.kernel.org/r/20190719084407.28041-1-l.stach@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/usb/usb251xb.txt |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/Documentation/devicetree/bindings/usb/usb251xb.txt
+++ b/Documentation/devicetree/bindings/usb/usb251xb.txt
@@ -64,10 +64,8 @@ Optional properties :
  - power-on-time-ms : Specifies the time it takes from the time the host
 	initiates the power-on sequence to a port until the port has adequate
 	power. The value is given in ms in a 0 - 510 range (default is 100ms).
- - swap-dx-lanes : Specifies the downstream ports which will swap the
-	differential-pair (D+/D-), default is not-swapped.
- - swap-us-lanes : Selects the upstream port differential-pair (D+/D-)
-	swapping (boolean, default is not-swapped)
+ - swap-dx-lanes : Specifies the ports which will swap the differential-pair
+	(D+/D-), default is not-swapped.
 
 Examples:
 	usb2512b@2c {


