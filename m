Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB7AC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E008A217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bucknell-edu.20150623.gappssmtp.com header.i=@bucknell-edu.20150623.gappssmtp.com header.b="Ju2Lpf0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfH3St7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:49:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41012 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbfH3St7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:49:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id i4so8677556qtj.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bucknell-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/oeAbS1CC60Y42Nny5f1uOk6CmGpLvMuH1oViee/fJU=;
        b=Ju2Lpf0s7ikdaSMRB1Gsw+0RqR40Mws4LJ2nsZQKCchkxXgutKvr/aUl5edFBWDGue
         qUfNdpQ8KQrbZpdR7Bp5YLY6jfsn4UDKX3z1sKZ7oKMFy1lx7+U7a2ms7//bMY/E5m7b
         fZNcrwmaII5ON2ki5yX0fhwfxIZ7NS1KcSr6L69XXcJlZ+NSJr3z3CTPGSa4aglLIDcq
         14VBg2Z48Aa63IcRwHk8rL84o4W09qm3duupEX4bBDzz1Pmj2M0SO2CHhox7CVO29Lu9
         lTlemP8AUbxS85SeCw7WBzHTSi2dF71jTrj+r0Gc3UOEFTzxzhp0Xi4W+rEOtlLraq3m
         dDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/oeAbS1CC60Y42Nny5f1uOk6CmGpLvMuH1oViee/fJU=;
        b=JhtMZqGHi//m/qeACM10nwRbTRuzP/JJYA24qlVLkUj1kyPvRBqiaM3JYfwYDvvg/5
         445gbg/1SBt1DyjhTRmLkC+rSh1oC3FG5w6M/xipraWZmTBEOUQ7un0vtGlcD/C1DrJ7
         UVEZK05SSpITgF6TYzdyh06EMKh/bLFMK/7D/I5oORBuxYLzAC/NuVtsU2zRQHLw03K2
         RWGAOUlOXpu4YzXJ4BQXOfbxGCmY9+Y7brNK0/T7jjNvfXwzRmmOFRceK/5hYH02xhGZ
         pTOr04XWyZJsjU1EshgCl+1exW9CHe8K8+OrzdnGiGWAgswMUxq3gipsg40xRdQNka46
         vrSg==
X-Gm-Message-State: APjAAAXVkXuoNo8V9gjWNEfYDVklnoWPqesoITsGjcFdTeTDPIxQX5dA
        QgZ41okbqk0HN5T60lC9C2Yjdw==
X-Google-Smtp-Source: APXvYqzCUslGM/S9oYM6bosZohdbVGzYid2+UOx6iy6znVih4hL5u1MVNpo5h4mXtpcCE3Zn/aGCNA==
X-Received: by 2002:ac8:6717:: with SMTP id e23mr16126272qtp.27.1567190998658;
        Fri, 30 Aug 2019 11:49:58 -0700 (PDT)
Received: from pop-os.localdomain (c-73-112-175-71.hsd1.nj.comcast.net. [73.112.175.71])
        by smtp.gmail.com with ESMTPSA id j137sm1228937qke.64.2019.08.30.11.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Aug 2019 11:49:57 -0700 (PDT)
Date:   Fri, 30 Aug 2019 14:49:55 -0400
From:   "Ryan M. Collins" <rmc032@bucknell.edu>
To:     Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: bcmgenet: use ethtool_op_get_ts_info()
Message-ID: <20190830184955.GA27521@pop-os.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change enables the use of SW timestamping on the Raspberry Pi 4.

bcmgenet's transmit function bcmgenet_xmit() implements software
timestamping. However the SOF_TIMESTAMPING_TX_SOFTWARE capability was
missing and only SOF_TIMESTAMPING_RX_SOFTWARE was announced. By using
ethtool_ops bcmgenet_ethtool_ops() as get_ts_info(), the
SOF_TIMESTAMPING_TX_SOFTWARE capability is announced.

Similar to commit a8f5cb9e7991 ("smsc95xx: use ethtool_op_get_ts_info()")

Signed-off-by: Ryan M. Collins <rmc032@bucknell.edu>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 1586316eb6f1..12cb77ef1081 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1124,6 +1124,7 @@ static const struct ethtool_ops bcmgenet_ethtool_ops = {
 	.set_coalesce		= bcmgenet_set_coalesce,
 	.get_link_ksettings	= bcmgenet_get_link_ksettings,
 	.set_link_ksettings	= bcmgenet_set_link_ksettings,
+	.get_ts_info		= ethtool_op_get_ts_info,
 };
 
 /* Power down the unimac, based on mode. */
-- 
2.23.0

