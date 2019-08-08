Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7141C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CCC2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291636;
	bh=8ENjWFfUfTAXG63YmnXa2SuLcNCqlbcW4RGfdmVmPJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X/oQiktnnyrdgfIByvwuXQwu8THYsmspUJSHxtnw61EcPl1oFBgNI2SS2jyb1zbEi
	 jhq1FMqXPHk+KcDSq2B+guhysq9Vt2+2zKYHp537FxPhlGE2ph951mp8egljrkoFLV
	 lIZoOY1mFh7Td/fryUoA1pa0k6DO5RBsTDvWAVI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405070AbfHHTJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405054AbfHHTJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:09:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0F0A2173E;
        Thu,  8 Aug 2019 19:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291349;
        bh=8ENjWFfUfTAXG63YmnXa2SuLcNCqlbcW4RGfdmVmPJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wZ3o8UsA/OQxNaPKKp/psHeKFV+bYq2nPn1C6sImguAmaLOOCJXJHdhc6uDsvKuq0
         IbkSjZQgyTJrj3zK6SF8E/ZqAmB9G31SR7cJMk1cofYZZ3tliKMcrQCUgpegm8IkRy
         bjAgfZ8BfHAv9wG4eshHUbhtWbOl0ImHUqG+Bc3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20van=20Dorst?= <opensource@vdorst.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 26/45] net: phylink: Fix flow control for fixed-link
Date:   Thu,  8 Aug 2019 21:05:12 +0200
Message-Id: <20190808190455.188589554@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190453.827571908@linuxfoundation.org>
References: <20190808190453.827571908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ren� van Dorst" <opensource@vdorst.com>

[ Upstream commit 8aace4f3eba2a3ceb431e18683ea0e1ecbade5cd ]

In phylink_parse_fixedlink() the pl->link_config.advertising bits are AND
with pl->supported, pl->supported is zeroed and only the speed/duplex
modes and MII bits are set.
So pl->link_config.advertising always loses the flow control/pause bits.

By setting Pause and Asym_Pause bits in pl->supported, the flow control
work again when devicetree "pause" is set in fixes-link node and the MAC
advertise that is supports pause.

Results with this patch.

Legend:
- DT = 'Pause' is set in the fixed-link in devicetree.
- validate() = ‘Yes’ means phylink_set(mask, Pause) is set in the
  validate().
- flow = results reported my link is Up line.

+-----+------------+-------+
| DT  | validate() | flow  |
+-----+------------+-------+
| Yes | Yes        | rx/tx |
| No  | Yes        | off   |
| Yes | No         | off   |
+-----+------------+-------+

Fixes: 9525ae83959b ("phylink: add phylink infrastructure")
Signed-off-by: René van Dorst <opensource@vdorst.com>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phylink.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -226,6 +226,8 @@ static int phylink_parse_fixedlink(struc
 			       __ETHTOOL_LINK_MODE_MASK_NBITS, true);
 	linkmode_zero(pl->supported);
 	phylink_set(pl->supported, MII);
+	phylink_set(pl->supported, Pause);
+	phylink_set(pl->supported, Asym_Pause);
 	if (s) {
 		__set_bit(s->bit, pl->supported);
 	} else {


