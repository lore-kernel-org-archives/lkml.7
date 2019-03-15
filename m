Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C18DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C9D218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfCOGY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 02:24:58 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:52030 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfCOGY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 02:24:58 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1h4gGr-0007Mj-9m; Fri, 15 Mar 2019 14:24:45 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1h4gGk-0000aI-Mg; Fri, 15 Mar 2019 14:24:38 +0800
Date:   Fri, 15 Mar 2019 14:24:38 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Su Yanjun <suyj.fnst@cn.fujitsu.com>
Cc:     steffen.klassert@secunet.com, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH] xfrm6_tunnel: Fix potential panic when unloading
 xfrm6_tunnel module
Message-ID: <20190315062438.id3664ccow5uxgvt@gondor.apana.org.au>
References: <1552546782-102587-1-git-send-email-suyj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552546782-102587-1-git-send-email-suyj.fnst@cn.fujitsu.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 02:59:42PM +0800, Su Yanjun wrote:
> When unloading xfrm6_tunnel module, xfrm6_tunnel_fini directly
> frees the xfrm6_tunnel_spi_kmem. Maybe someone has gotten the
> xfrm6_tunnel_spi, so need to wait it.
> 
> Fixes: 91cc3bb0b04ff("xfrm6_tunnel: RCU conversion")
> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
> ---
>  net/ipv6/xfrm6_tunnel.c | 4 ++++
>  1 file changed, 4 insertions(+)

This looks good to me.  And it's not just the matter of accessing
freed memory.  A worse problem would be trying to execute code
from an unloaded module.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

> diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
> index bc65db7..12cb3aa 100644
> --- a/net/ipv6/xfrm6_tunnel.c
> +++ b/net/ipv6/xfrm6_tunnel.c
> @@ -402,6 +402,10 @@ static void __exit xfrm6_tunnel_fini(void)
>  	xfrm6_tunnel_deregister(&xfrm6_tunnel_handler, AF_INET6);
>  	xfrm_unregister_type(&xfrm6_tunnel_type, AF_INET6);
>  	unregister_pernet_subsys(&xfrm6_tunnel_net_ops);
> +	/* Someone maybe has gotten the xfrm6_tunnel_spi.
> +	 * So need to wait it.
> +	 */
> +	rcu_barrier();
>  	kmem_cache_destroy(xfrm6_tunnel_spi_kmem);
>  }

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
