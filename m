Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36EECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F2A20882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y/N7A3iU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfJUMho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:37:44 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55404 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfJUMhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UAufsu3nJsKPFGLcmHSRIICkk6jhTpBPs8ucFPOVo0E=; b=y/N7A3iU4w1jIlhOQHp1YSft7J
        c2DOulzr5zb6FlEi+hjBoj/CbAtOjvj6Lxopi7WaBuA0Rto8WKE2qW/jDBiFdQKrjT5YZOOcGEi23
        L9cfOkJ4mLfnzjJhd/OxjrF8vJfpS1C2dkhNWNJMpzTfu1LfxAb0tVMCxdxt7TEIPUTk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iMWwO-0004KY-Dw; Mon, 21 Oct 2019 14:37:40 +0200
Date:   Mon, 21 Oct 2019 14:37:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vivien Didelot <vivien.didelot@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 02/16] net: dsa: add ports list in the switch
 fabric
Message-ID: <20191021123740.GC16084@lunn.ch>
References: <20191020031941.3805884-1-vivien.didelot@gmail.com>
 <20191020031941.3805884-3-vivien.didelot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020031941.3805884-3-vivien.didelot@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static struct dsa_port *dsa_port_touch(struct dsa_switch *ds, int index)
> +{
> +	struct dsa_switch_tree *dst = ds->dst;
> +	struct dsa_port *dp;
> +
> +	dp = &ds->ports[index];
> +
> +	dp->ds = ds;
> +	dp->index = index;
> +
> +	INIT_LIST_HEAD(&dp->list);
> +	list_add(&dp->list, &dst->ports);
> +
> +	return dp;
> +}

Bike shedding, but i don't particularly like the name touch.  How
about list. The opposite would then be delist, if we ever need it?

Otherwise:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
