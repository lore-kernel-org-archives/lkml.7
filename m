Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19808C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D574A20657
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfCDEqS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 23:46:18 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56806 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCDEqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 23:46:18 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9371B14D07B7B;
        Sun,  3 Mar 2019 20:46:17 -0800 (PST)
Date:   Sun, 03 Mar 2019 20:46:16 -0800 (PST)
Message-Id: <20190303.204616.903361775194909365.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, hkallweit1@gmail.com,
        michal.vokac@ysoft.com, andrew@lunn.ch, vivien.didelot@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: Use prepare/commit phase in
 dsa_slave_vlan_rx_add_vid()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190301183726.30900-1-f.fainelli@gmail.com>
References: <20190301183726.30900-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 03 Mar 2019 20:46:17 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri,  1 Mar 2019 10:37:25 -0800

> We were skipping the prepare phase which causes some problems with at
> least a couple of drivers:
> 
> - mv88e6xxx chooses to skip programming VID = 0 with -EOPNOTSUPP in
>   the prepare phase, but we would still try to force this VID since we
>   would only call the commit phase and so we would get the driver to
>   return -EINVAL instead
> 
> - qca8k does not currently have a port_vlan_add() callback implemented,
>   yet we would try to call that unconditionally leading to a NPD
> 
> Fix both issues by conforming to the current model doing a
> prepare/commit phase, this makes us consistent throughout the code and
> assumptions.
> 
> Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> Reported-by: Michal Vok·Ë <michal.vokac@ysoft.com>
> Fixes: 061f6a505ac3 ("net: dsa: Add ndo_vlan_rx_{add, kill}_vid implementation")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied, thanks Florian.
