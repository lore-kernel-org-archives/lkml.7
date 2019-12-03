Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7853C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDEF2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412731;
	bh=JxEp9mup7CCnqaZyUZA3/WKdzQze1ncSfpwctIWZd+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H2NEeBR1qcGLeSPSxjDNZMrzeg5JUWFS5OFJnqKdpL6TJg1qHnqEl8DQT8ngl1Q+a
	 +YsHpNR90T9TNoiDajhsK0h4ual+nEMzbSJuY+1OczdxeLY5w/IfqEjfzfAP5lFmq4
	 lBGs03u+AODLJbIGxOBwPd5fLDn0Pk/Ggvum2gqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfLCWiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:38:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbfLCWis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:38:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00CDB20684;
        Tue,  3 Dec 2019 22:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412727;
        bh=JxEp9mup7CCnqaZyUZA3/WKdzQze1ncSfpwctIWZd+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQwM8M0tVzI3Kj4WEPvHmv9DgO1uv8VuBv5lA0/ibTkdlW9N7nYdFl08wqTBliWmL
         7/z5ESItJDfdZcPMIvMClcZjC2Ea1lbdtW/NEvP10NgFOVbVDMgTIEBgjAr6M+sTW3
         5GCV2bRKT/BxJqB2y+AB7JzVbp8N3L4BEe2s2++M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Alan J. Wylie" <alan@wylie.me.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 39/46] r8169: fix jumbo configuration for RTL8168evl
Date:   Tue,  3 Dec 2019 23:35:59 +0100
Message-Id: <20191203212801.134488734@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203212705.175425505@linuxfoundation.org>
References: <20191203212705.175425505@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 14012c9f3bb922b9e0751ba43d15cc580a6049bf ]

Alan reported [0] that network is broken since the referenced commit
when using jumbo frames. This commit isn't wrong, it just revealed
another issue that has been existing before. According to the vendor
driver the RTL8168e-specific jumbo config doesn't apply for RTL8168evl.

[0] https://lkml.org/lkml/2019/11/30/119

Fixes: 4ebcb113edcc ("r8169: fix jumbo packet handling on resume from suspend")
Reported-by: Alan J. Wylie <alan@wylie.me.uk>
Tested-by: Alan J. Wylie <alan@wylie.me.uk>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4118,7 +4118,7 @@ static void rtl_hw_jumbo_enable(struct r
 	case RTL_GIGA_MAC_VER_27 ... RTL_GIGA_MAC_VER_28:
 		r8168dp_hw_jumbo_enable(tp);
 		break;
-	case RTL_GIGA_MAC_VER_31 ... RTL_GIGA_MAC_VER_34:
+	case RTL_GIGA_MAC_VER_31 ... RTL_GIGA_MAC_VER_33:
 		r8168e_hw_jumbo_enable(tp);
 		break;
 	default:


