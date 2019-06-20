Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF25C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092BA21537
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054434;
	bh=49GtFO9bkV4i66AG+0aAnRmWJ2ihM36M4UZfPiJZZHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=unEobt5oSp96GLMPjhcOqvrJ4xv+uoSB/s6T2gGs0Dk9K4bamDtLaYOiPQ8bkOeDG
	 zkWjPBTFMS3iW9m6eQ5xV799p4HL+fQ3iDeSINPrtXh3De8hIzSN6ZkC7wRzWWd2KS
	 TsQ4vzm/y2L+XNjo5LgBxVyivx9zal/FEou9+6Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfFTSNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729337AbfFTSNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:13:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9775C2082C;
        Thu, 20 Jun 2019 18:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054429;
        bh=49GtFO9bkV4i66AG+0aAnRmWJ2ihM36M4UZfPiJZZHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vsFrEHrgIOcl6P163NdG573O23cJpQ3YEobgWXhAtMiT/TMczm89XH82hHHjTXMiU
         PuzGFBv2hpXtsE8ahmMKKzkYSM/A6rvT5up1nWqPRH+TfiAK5KOeDYrdNbQKqnezno
         dL6QO0eSXVouZ1MmP8iccPOg9C8JhhSzj2rRksZk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Petrovskiy <alexpe@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 26/98] mlxsw: spectrum_flower: Fix TOS matching
Date:   Thu, 20 Jun 2019 19:56:53 +0200
Message-Id: <20190620174350.342488014@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Pirko <jiri@mellanox.com>

The TOS value was not extracted correctly. Fix it.

Fixes: 87996f91f739 ("mlxsw: spectrum_flower: Add support for ip tos")
Reported-by: Alexander Petrovskiy <alexpe@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
@@ -247,8 +247,8 @@ static int mlxsw_sp_flower_parse_ip(stru
 				       match.mask->tos & 0x3);
 
 	mlxsw_sp_acl_rulei_keymask_u32(rulei, MLXSW_AFK_ELEMENT_IP_DSCP,
-				       match.key->tos >> 6,
-				       match.mask->tos >> 6);
+				       match.key->tos >> 2,
+				       match.mask->tos >> 2);
 
 	return 0;
 }


