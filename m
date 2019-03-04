Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04892C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8529206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tehbl+iL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbfCDN0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:26:22 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45722 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbfCDN0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CcXkJR0K8l/JwAJGw4v3ASDsnbQebYOnLOqsHHLjaiI=; b=tehbl+iLMJB3JfWwwemPk7aWg5
        TLRqMwglUE3NT2TymvldtVkt5jGV5Y6vIAwk/g1qLlKIjhkIIrdG5XL0SledJHV8u2mjF64UWFF7g
        sx30RQAziaeNU4ZSDpwE6OINWCg/DN5xxU00SIbRw4p5TuIVN+QeQltozwVn50JA1dD4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h0nbl-0003WB-LL; Mon, 04 Mar 2019 14:26:17 +0100
Date:   Mon, 4 Mar 2019 14:26:17 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH -next] net: dsa: mv88e6xxx: Fix build warning when
 CONFIG_NET_DSA_LEGACY is n
Message-ID: <20190304132617.GB26378@lunn.ch>
References: <1551703381-52115-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1551703381-52115-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 08:43:01PM +0800, Shaokun Zhang wrote:
> When CONFIG_NET_DSA_LEGACY is n, there is a GCC bulid warning:
> drivers/net/dsa/mv88e6xxx/chip.c:4623:13: warning: ‘mv88e6xxx_ports_cmode_init’ defined but not used [-Wunused-function]
> static void mv88e6xxx_ports_cmode_init(struct mv88e6xxx_chip *chip)
> Let's fix it.

Hi Shaokun, Heiner

Although this fixes the warning, i suspect there i something wrong
with the original patch adding mv88e6390x_port_set_cmode(). It should
also be used without CONFIG_NET_DSA_LEGACY.

     Andrew


> 
> Fixes: ed8fe20205ac ("net: dsa: mv88e6xxx: prevent interrupt storm caused by mv88e6390x_port_set_cmode")
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Vivien Didelot <vivien.didelot@gmail.com> 
> Cc: Florian Fainelli <f.fainelli@gmail.com> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  drivers/net/dsa/mv88e6xxx/chip.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index e4ad16b2dc38..168d4898c36f 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -4620,14 +4620,6 @@ static int mv88e6xxx_smi_init(struct mv88e6xxx_chip *chip,
>  	return 0;
>  }
>  
> -static void mv88e6xxx_ports_cmode_init(struct mv88e6xxx_chip *chip)
> -{
> -	int i;
> -
> -	for (i = 0; i < mv88e6xxx_num_ports(chip); i++)
> -		chip->ports[i].cmode = MV88E6XXX_PORT_STS_CMODE_INVALID;
> -}
> -
>  static enum dsa_tag_protocol mv88e6xxx_get_tag_protocol(struct dsa_switch *ds,
>  							int port)
>  {
> @@ -4637,6 +4629,14 @@ static enum dsa_tag_protocol mv88e6xxx_get_tag_protocol(struct dsa_switch *ds,
>  }
>  
>  #if IS_ENABLED(CONFIG_NET_DSA_LEGACY)
> +static void mv88e6xxx_ports_cmode_init(struct mv88e6xxx_chip *chip)
> +{
> +	int i;
> +
> +	for (i = 0; i < mv88e6xxx_num_ports(chip); i++)
> +		chip->ports[i].cmode = MV88E6XXX_PORT_STS_CMODE_INVALID;
> +}
> +
>  static const char *mv88e6xxx_drv_probe(struct device *dsa_dev,
>  				       struct device *host_dev, int sw_addr,
>  				       void **priv)
> -- 
> 2.7.4
> 
