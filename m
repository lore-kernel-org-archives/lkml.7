Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C19C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 20:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24752799C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 20:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfFBUyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 16:54:19 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48372 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfFBUyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 16:54:18 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D35961411E114;
        Sun,  2 Jun 2019 13:54:17 -0700 (PDT)
Date:   Sun, 02 Jun 2019 13:54:17 -0700 (PDT)
Message-Id: <20190602.135417.1658688470668746683.davem@davemloft.net>
To:     nikita.yoush@cogentembedded.com
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        hkallweit1@gmail.com, marek.behun@nic.cz,
        rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, cphealy@gmail.com
Subject: Re: [PATCH] net: dsa: mv88e6xxx: avoid error message on remove
 from VLAN 0
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190531073514.2171-1-nikita.yoush@cogentembedded.com>
References: <20190531073514.2171-1-nikita.yoush@cogentembedded.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 02 Jun 2019 13:54:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Date: Fri, 31 May 2019 10:35:14 +0300

> When non-bridged, non-vlan'ed mv88e6xxx port is moving down, error
> message is logged:
> 
> failed to kill vid 0081/0 for device eth_cu_1000_4
> 
> This is caused by call from __vlan_vid_del() with vin set to zero, over
> call chain this results into _mv88e6xxx_port_vlan_del() called with
> vid=0, and mv88e6xxx_vtu_get() called from there returns -EINVAL.
> 
> On symmetric path moving port up, call goes through
> mv88e6xxx_port_vlan_prepare() that calls mv88e6xxx_port_check_hw_vlan()
> that returns -EOPNOTSUPP for zero vid.
> 
> This patch changes mv88e6xxx_vtu_get() to also return -EOPNOTSUPP for
> zero vid, then this error code is explicitly cleared in
> dsa_slave_vlan_rx_kill_vid() and error message is no longer logged.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Applied.
