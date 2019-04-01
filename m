Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1D6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C2321925
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138325;
	bh=TxwP5QpPqwckR7PXtDVN7Oj1+LgCbLU/0ESAyaPK37Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H3EFyXPvILleaRt1qbgnLVTjcKpbuOd7UsqBxzosnopOzCH2P0UXMCF0pnt2ANQaZ
	 6ihLDdiDoUaPq4F3Ce+2yW0ASuXeZgxVdsWG3FJp6l7jeHG9UFRxygZL8BuVKO87R6
	 xOsvrLm0Txzu4DXYPIMdajO2jw2O3C3O3rBCXhM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfDARFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfDARFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:05:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3DBB21925;
        Mon,  1 Apr 2019 17:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138322;
        bh=TxwP5QpPqwckR7PXtDVN7Oj1+LgCbLU/0ESAyaPK37Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vF6rZKE41ufQzlNl1pTT8F5IqgywRprM2yrCzoLvuZp4Qa/xS+NJmTkItotXhKd5X
         5P1mLUYXcz3UpHG3gb5kBTQ+zK+yO5egyJDgwfdK1JWyi95jPavzv4yYLLwSgducUg
         JJesZmJoHm3XEzOkFbzh56VMS9F6H5+d/bIdPAOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 032/146] net: mii: Fix PAUSE cap advertisement from linkmode_adv_to_lcl_adv_t() helper
Date:   Mon,  1 Apr 2019 19:00:44 +0200
Message-Id: <20190401170051.243261394@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudiu Manoil <claudiu.manoil@nxp.com>

[ Upstream commit 7f07e5f1f778605e98cf2156d4db1ff3a3a1a74a ]

With a recent link mode advertisement code update this helper
providing local pause capability translation used for flow
control link mode negotiation got broken.
For eth drivers using this helper, the issue is apparent only
if either PAUSE or ASYM_PAUSE is being advertised.

Fixes: 3c1bcc8614db ("net: ethernet: Convert phydev advertize and supported from u32 to link mode")
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mii.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/mii.h
+++ b/include/linux/mii.h
@@ -469,7 +469,7 @@ static inline u32 linkmode_adv_to_lcl_ad
 	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Pause_BIT,
 			      advertising))
 		lcl_adv |= ADVERTISE_PAUSE_CAP;
-	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
 			      advertising))
 		lcl_adv |= ADVERTISE_PAUSE_ASYM;
 


