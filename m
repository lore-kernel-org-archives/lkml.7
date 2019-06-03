Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D390AC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3D527F4B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559553377;
	bh=FpGC7zNDZKZlqla5pNTMp1CqYjfpbbybo+aQhWG8avc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d62m3lP4ErUFlZyiXaTUNROKGVxR4IQexm8JQEI4CzkEi9O6nAzsD1EUBn23xMJ3i
	 mnPR7ew/qNUfa64x0nwdx/13yynrQWJJlGoFsSFt/hvN7/KnMZJlFKcvxEQaQRtTGP
	 BFNsM0a28/aICl9EpWMwvkygTmTCPN0NBc0W0zZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfFCJQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:32878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728717AbfFCJMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:12:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 543A521923;
        Mon,  3 Jun 2019 09:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559553172;
        bh=FpGC7zNDZKZlqla5pNTMp1CqYjfpbbybo+aQhWG8avc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uwdBC+zEGjxX4bVlFei7znwU4+QEHs2DaCE/y30Vy7b0/YSa/Xt1BILc4f8gjwm3N
         mKvuvUcUAjlLcQWVQ+R3QmBhVIRTEovxF2tBjsB2g5W9rv7RZaF115FphwIk4EH9bK
         C2Gg1yhVMJQZsCpZHOVOOb9eId6LZAfNYtaC7x40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 11/40] net: dsa: mv88e6xxx: fix handling of upper half of STATS_TYPE_PORT
Date:   Mon,  3 Jun 2019 11:09:04 +0200
Message-Id: <20190603090523.327595439@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603090522.617635820@linuxfoundation.org>
References: <20190603090522.617635820@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

[ Upstream commit 84b3fd1fc9592d431e23b077e692fa4e3fd0f086 ]

Currently, the upper half of a 4-byte STATS_TYPE_PORT statistic ends
up in bits 47:32 of the return value, instead of bits 31:16 as they
should.

Fixes: 6e46e2d821bb ("net: dsa: mv88e6xxx: Fix u64 statistics")
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -910,7 +910,7 @@ static uint64_t _mv88e6xxx_get_ethtool_s
 			err = mv88e6xxx_port_read(chip, port, s->reg + 1, &reg);
 			if (err)
 				return U64_MAX;
-			high = reg;
+			low |= ((u32)reg) << 16;
 		}
 		break;
 	case STATS_TYPE_BANK1:


