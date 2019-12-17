Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E56C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6237921775
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576613511;
	bh=cT3r649N+jO/u/Qq9seetjAyy4DEefYVYxZi/qb4jtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u3dF6O12PfKo91FBcXk1WL16VRtjRFtyySRXc4GGSUKHsoQWcxTYaJ8sFkp+0LUHC
	 1yjKlmE8a7JiphC9LTsPS+fxNRu+QCkHKHHUPfNcO3T/xiEoBEZO5OlhXQWKPP60Bz
	 3r4Z7u3dFq2Mkk1NpSI9It3epUi73gdRPZSM44jY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfLQULu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:11:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbfLQULW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:11:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29E6A21775;
        Tue, 17 Dec 2019 20:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576613481;
        bh=cT3r649N+jO/u/Qq9seetjAyy4DEefYVYxZi/qb4jtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZKuW0/396teeOXTqNBHP7GB5FG2gwkELNX3KsfGMStZSoZDySj0grProXPD1qel3R
         xDCBFAg/2mzZDlFsPAWDI21FZejbXrdZpwWnCle5q8OCkiOkXwKVUzKzgeyic06/gK
         lbkX9xkcxHco6O90EkoPeNkVH3Ro3rjcya744ol8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 37/37] r8169: add missing RX enabling for WoL on RTL8125
Date:   Tue, 17 Dec 2019 21:09:58 +0100
Message-Id: <20191217200736.750777872@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217200721.741054904@linuxfoundation.org>
References: <20191217200721.741054904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 00222d1394104f0fd6c01ca9f578afec9e0f148b ]

RTL8125 also requires to enable RX for WoL.

v2: add missing Fixes tag

Fixes: f1bce4ad2f1c ("r8169: add support for RTL8125")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3920,7 +3920,7 @@ static void rtl_wol_suspend_quirk(struct
 	case RTL_GIGA_MAC_VER_32:
 	case RTL_GIGA_MAC_VER_33:
 	case RTL_GIGA_MAC_VER_34:
-	case RTL_GIGA_MAC_VER_37 ... RTL_GIGA_MAC_VER_51:
+	case RTL_GIGA_MAC_VER_37 ... RTL_GIGA_MAC_VER_61:
 		RTL_W32(tp, RxConfig, RTL_R32(tp, RxConfig) |
 			AcceptBroadcast | AcceptMulticast | AcceptMyPhys);
 		break;


