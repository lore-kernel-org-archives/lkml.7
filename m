Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC61C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3999221743
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="TgLed18j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387615AbfGYNbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:31:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38964 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfGYNbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:31:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id u25so34407514wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=U+dLjEf1u94onlzPHtYLzX6YYU/MqKMGMSUygWmmq7o=;
        b=TgLed18jiWpMlH7QEBFZCmoMCVBWqYimXqrMbZRHkdJ8SJXQKIk8W1YtLBSAG0OFkq
         SbUiuCckWsjmV3XSbZAHwOmJAkMB+2OMr/7n735ICLwwApujkWcSDBIuerOMjlWcOmwP
         l4Sdf7tiA+OanTdbxdppAz+OyMqREKOuMYdQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U+dLjEf1u94onlzPHtYLzX6YYU/MqKMGMSUygWmmq7o=;
        b=JeIJdCW2kpHmivp4mUFn5DTssTcdF4P9aahuGJ9gtGUTkc1eT8vO8AbVUR+4PJPK6w
         BarPQDNV85fqRrqQ+S129xH1pwm6m6bYLXLYuPg1t7mHluLv7W6R/caMQTBiB92+61uu
         ZcqpJV8wBqTM2G2E5bAaMJRWKE/9YtTPBHVB17B7AUQoszGScR8cawoDApFqZKT6CNTs
         7JzL31Z3FjmIdxiQEPONzYdp2wMCQrkUa45IXE2ZSsmSCdUDx/ixHlI+Mi+g81y2dNmb
         mgCoFAA2jBaOEgt0I8X0eTv3SOF3qd5HaN1UuAtuj4Oh6lfFH2q6nhFTc3YH5jKcQ+Tu
         aJdQ==
X-Gm-Message-State: APjAAAV9y9lkFhCtD8F6lMFBPmBmJuBeiLpWIIGzsSbSjqNcy5l4s0ug
        OFhmv/XALqXWuX1bBO/5su/shjdpwUk=
X-Google-Smtp-Source: APXvYqzUi5WFrE2+eAUYjEGdYJ87YceB4K/Ob0SCx6t+a28s5UAaYHJsZDK3Oaep/g88VrKK2IrMjw==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr83185351wmj.116.1564059964769;
        Thu, 25 Jul 2019 06:06:04 -0700 (PDT)
Received: from [192.168.0.107] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id i13sm42718497wrr.73.2019.07.25.06.06.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 06:06:04 -0700 (PDT)
Subject: Re: [PATCH] net: bridge: Allow bridge to joing multicast groups
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, allan.nielsen@microchip.com
References: <1564055044-27593-1-git-send-email-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <7e7a7015-6072-d884-b2ba-0a51177245ab@cumulusnetworks.com>
Date:   Thu, 25 Jul 2019 16:06:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1564055044-27593-1-git-send-email-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2019 14:44, Horatiu Vultur wrote:
> There is no way to configure the bridge, to receive only specific link
> layer multicast addresses. From the description of the command 'bridge
> fdb append' is supposed to do that, but there was no way to notify the
> network driver that the bridge joined a group, because LLADDR was added
> to the unicast netdev_hw_addr_list.
> 
> Therefore update fdb_add_entry to check if the NLM_F_APPEND flag is set
> and if the source is NULL, which represent the bridge itself. Then add
> address to multicast netdev_hw_addr_list for each bridge interfaces.
> And then the .ndo_set_rx_mode function on the driver is called. To notify
> the driver that the list of multicast mac addresses changed.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_fdb.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 3 deletions(-)
> 

Hi,
I'm sorry but this patch is wrong on many levels, some notes below. In general
NLM_F_APPEND is only used in vxlan, the bridge does not handle that flag at all.
FDB is only for *unicast*, nothing is joined and no multicast should be used with fdbs.
MDB is used for multicast handling, but both of these are used for forwarding.
The reason the static fdbs are added to the filter is for non-promisc ports, so they can
receive traffic destined for these FDBs for forwarding.
If you'd like to join any multicast group please use the standard way, if you'd like to join
it only on a specific port - join it only on that port (or ports) and the bridge and you'll
have the effect that you're describing. What do you mean there's no way ?

In addition you're allowing a mix of mcast functions to be called with unicast addresses
and vice versa, it is not that big of a deal because the kernel will simply return an error
but still makes no sense.

Nacked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index b1d3248..d93746d 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -175,6 +175,29 @@ static void fdb_add_hw_addr(struct net_bridge *br, const unsigned char *addr)
>  	}
>  }
>  
> +static void fdb_add_hw_maddr(struct net_bridge *br, const unsigned char *addr)
> +{
> +	int err;
> +	struct net_bridge_port *p;
> +
> +	ASSERT_RTNL();
> +
> +	list_for_each_entry(p, &br->port_list, list) {
> +		if (!br_promisc_port(p)) {
> +			err = dev_mc_add(p->dev, addr);
> +			if (err)
> +				goto undo;
> +		}
> +	}
> +
> +	return;
> +undo:
> +	list_for_each_entry_continue_reverse(p, &br->port_list, list) {
> +		if (!br_promisc_port(p))
> +			dev_mc_del(p->dev, addr);
> +	}
> +}
> +
>  /* When a static FDB entry is deleted, the HW address from that entry is
>   * also removed from the bridge private HW address list and updates all
>   * the ports with needed information.
> @@ -192,13 +215,27 @@ static void fdb_del_hw_addr(struct net_bridge *br, const unsigned char *addr)
>  	}
>  }
>  
> +static void fdb_del_hw_maddr(struct net_bridge *br, const unsigned char *addr)
> +{
> +	struct net_bridge_port *p;
> +
> +	ASSERT_RTNL();
> +
> +	list_for_each_entry(p, &br->port_list, list) {
> +		if (!br_promisc_port(p))
> +			dev_mc_del(p->dev, addr);
> +	}
> +}
> +
>  static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f,
>  		       bool swdev_notify)
>  {
>  	trace_fdb_delete(br, f);
>  
> -	if (f->is_static)
> +	if (f->is_static) {
>  		fdb_del_hw_addr(br, f->key.addr.addr);
> +		fdb_del_hw_maddr(br, f->key.addr.addr);

Walking over all ports again for each static delete is a no-go.

> +	}
>  
>  	hlist_del_init_rcu(&f->fdb_node);
>  	rhashtable_remove_fast(&br->fdb_hash_tbl, &f->rhnode,
> @@ -843,13 +880,19 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>  			fdb->is_local = 1;
>  			if (!fdb->is_static) {
>  				fdb->is_static = 1;
> -				fdb_add_hw_addr(br, addr);
> +				if (flags & NLM_F_APPEND && !source)
> +					fdb_add_hw_maddr(br, addr);
> +				else
> +					fdb_add_hw_addr(br, addr);
>  			}
>  		} else if (state & NUD_NOARP) {
>  			fdb->is_local = 0;
>  			if (!fdb->is_static) {
>  				fdb->is_static = 1;
> -				fdb_add_hw_addr(br, addr);
> +				if (flags & NLM_F_APPEND && !source)
> +					fdb_add_hw_maddr(br, addr);
> +				else
> +					fdb_add_hw_addr(br, addr);
>  			}
>  		} else {
>  			fdb->is_local = 0;
> 

