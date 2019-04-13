Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F4EC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAB62084D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="k5Clp3Zr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfDMPXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 11:23:50 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60245 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbfDMPXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 11:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=llPHfjNAHLrYgmIpuNndSfuVIATey19O9cUE+EFo2vs=; b=k5Clp3ZrNBA/Yz1+wqhEbOC0uE
        hB3H+gDmCMUyc/2BUw3y39zC/nXnnOYcY2IKwKF0vdo648Uc8AN8rBXdcrHre0BdnIgW/W6elAgR9
        Mp7DPfuotd59pHUnUha3+1ZwpVj1Co3O5RdBJuaODY3K2MxrQGV7hLbkA1ujksSEnKA8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hFKUl-0004rh-8s; Sat, 13 Apr 2019 17:23:07 +0200
Date:   Sat, 13 Apr 2019 17:23:07 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, georg.waibel@sensor-technik.de
Subject: Re: [PATCH v3 net-next 12/24] net: dsa: Copy the vlan_filtering
 setting on the CPU port if it's global
Message-ID: <20190413152307.GD17901@lunn.ch>
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-13-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413012822.30931-13-olteanv@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 04:28:10AM +0300, Vladimir Oltean wrote:
> The current behavior is not as obvious as one would assume (which is
> that, if the driver set vlan_filtering_is_global = 1, then checking any
> dp->vlan_filtering would yield the same result). Only the ports which
> are actively enslaved into a bridge would have vlan_filtering set.
> 
> This makes it tricky for drivers to check what the global state is.
> Moreover, the most obvious place to check for this setting, the CPU
> port, is not populated since it's not being enslaved to the bridge.
> So fix this and make the CPU port hold the global state of VLAN
> filtering on this switch.
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> ---
> Changes in v3:
> Patch is new.
> 
>  net/dsa/port.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/dsa/port.c b/net/dsa/port.c
> index c8eb2cbcea6e..acb4ed1f9929 100644
> --- a/net/dsa/port.c
> +++ b/net/dsa/port.c
> @@ -190,6 +190,8 @@ static bool dsa_port_can_apply_vlan_filtering(struct dsa_port *dp,
>  int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
>  			    struct switchdev_trans *trans)
>  {
> +	/* Violate a const pointer here */
> +	struct dsa_port *cpu_dp = (struct dsa_port *)dp->cpu_dp;

Hi Vladimir

As compilers get more picky, i expect that is going to result in a
warning. 

Since this is a switch global attribute, putting it in dsa_switch
would be better, next to vlan_filteris_is_global.

	Andrew
