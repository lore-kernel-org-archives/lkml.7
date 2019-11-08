Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2998EFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D45206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240336;
	bh=Eo4M+CcVoL5z+LaKljF9jKB5DJ888zaDFmwooiIRzxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1TckGvPeaZ0+n577taIujlUHUa6L2Os1WYfQm6Rgxt7TPDxmd0T4wqf/YDzcJdwuP
	 N/OEz0W6Qpxso152J5pRpL4C7en/JfSyWK02rEpQJSkUhJlEsWSXO4sF/JG3c0rtKN
	 Q8xsKgWktc+r4p94jYpmGyKNyRqaHy8YAjzhXRiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391078AbfKHTMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:12:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:41392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730154AbfKHTJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:09:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 328272087E;
        Fri,  8 Nov 2019 19:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573240174;
        bh=Eo4M+CcVoL5z+LaKljF9jKB5DJ888zaDFmwooiIRzxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kQA8enWiMIOpgYYeG6qN8TSjRT901Bpc44W6nHYA3BEdKyy72VmcuHxpoVzL8OZfg
         bnUZ7f/ylv46fuqclpkzCwBeNkXcr+7PHJceRZNdWWPUx1MgPpY2tliHeLknSaCIcI
         V3U8L1lgPwQH4YDQj5FwI/bP8nY/FqqyoZqlaUB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aya Levin <ayal@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.3 112/140] net/mlx5e: Initialize on stack link modes bitmap
Date:   Fri,  8 Nov 2019 19:50:40 +0100
Message-Id: <20191108174911.905416820@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aya Levin <ayal@mellanox.com>

[ Upstream commit 926b37f76fb0a22fe93c8873c819fd167180e85c ]

Initialize link modes bitmap on stack before using it, otherwise the
outcome of ethtool set link ksettings might have unexpected values.

Fixes: 4b95840a6ced ("net/mlx5e: Fix matching of speed to PRM link modes")
Signed-off-by: Aya Levin <ayal@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1021,7 +1021,7 @@ static bool ext_link_mode_requested(cons
 {
 #define MLX5E_MIN_PTYS_EXT_LINK_MODE_BIT ETHTOOL_LINK_MODE_50000baseKR_Full_BIT
 	int size = __ETHTOOL_LINK_MODE_MASK_NBITS - MLX5E_MIN_PTYS_EXT_LINK_MODE_BIT;
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(modes);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(modes) = {0,};
 
 	bitmap_set(modes, MLX5E_MIN_PTYS_EXT_LINK_MODE_BIT, size);
 	return bitmap_intersects(modes, adver, __ETHTOOL_LINK_MODE_MASK_NBITS);


