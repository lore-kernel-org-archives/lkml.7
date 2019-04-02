Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B15C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327042082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SycVQCli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfDBUyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:54:41 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47766 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbfDBUyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KE8xu+mnv2/jvbJMKEsAcEhZ7uxBYf6QxnsXUqdIiD0=; b=SycVQCliq6AvQl4MH+cRwHjYK6
        Oa5TPZv1JSijEHAYin9UooN0yRFVGg0sQwxSpUF0iqCQeb+axEO/Ati3qFqLnvaZ1f5JxzK/LwjQC
        1bTVBN4oMsnqmMN5/KgxEMIIUl6fmCnsniWGQjTE7Ic86FN3jjoPFR7fQvTIg0tgT/Sw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hBQQX-00010g-HZ; Tue, 02 Apr 2019 22:54:37 +0200
Date:   Tue, 2 Apr 2019 22:54:37 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        georg.waibel@sensor-technik.de
Subject: Re: [PATCH net-next 05/17] net: dsa: Add more convenient functions
 for installing port VLANs
Message-ID: <20190402205437.GF22349@lunn.ch>
References: <20190331174232.22060-1-olteanv@gmail.com>
 <20190331174232.22060-6-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331174232.22060-6-olteanv@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 08:42:20PM +0300, Vladimir Oltean wrote:
> This hides the need to perform a two-phase transaction and construct a
> switchdev_obj_port_vlan struct.
> 
> Call graph (including a function that will be introduced in a follow-up
> patch) looks like this now (same for the *_vlan_del function):
> 
> dsa_slave_vlan_rx_add_vid   dsa_port_setup_8021q_tagging
>             |                        |
>             |                        |
>             |          +-------------+
>             |          |
>             v          v
>          __dsa_port_vlan_add     dsa_slave_port_obj_add
>                   |                         |
>                   +-------+         +-------+
>                           |         |
>                           v         v
>                        dsa_port_vlan_add
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> ---
>  net/dsa/dsa_priv.h |  2 ++
>  net/dsa/port.c     | 31 +++++++++++++++++++++++++++++++
>  net/dsa/slave.c    | 16 ++--------------
>  3 files changed, 35 insertions(+), 14 deletions(-)
> 
> diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
> index 093b7d145eb1..766d015f6f38 100644
> --- a/net/dsa/dsa_priv.h
> +++ b/net/dsa/dsa_priv.h
> @@ -169,6 +169,8 @@ int dsa_port_vlan_add(struct dsa_port *dp,
>  		      struct switchdev_trans *trans);
>  int dsa_port_vlan_del(struct dsa_port *dp,
>  		      const struct switchdev_obj_port_vlan *vlan);
> +int __dsa_port_vlan_add(struct dsa_port *dp, u16 vid, u16 flags);
> +int __dsa_port_vlan_del(struct dsa_port *dp, u16 vid);
>  int dsa_port_link_register_of(struct dsa_port *dp);
>  void dsa_port_link_unregister_of(struct dsa_port *dp);
>  
> diff --git a/net/dsa/port.c b/net/dsa/port.c
> index a86fe3be1261..10065a622ada 100644
> --- a/net/dsa/port.c
> +++ b/net/dsa/port.c
> @@ -326,6 +326,37 @@ int dsa_port_vlan_del(struct dsa_port *dp,
>  	return 0;
>  }
>  
> +int __dsa_port_vlan_add(struct dsa_port *dp, u16 vid, u16 flags)
> +{

Hi Vladimir

Maybe call this dsa_port_vlan_add_trans()?

I don't like the __, especially when the symbol is not static.

  Andrew
