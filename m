Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52C0C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A9E20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfFRIA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:00:28 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60056 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRIA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:00:27 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hd92S-0004n1-2f; Tue, 18 Jun 2019 16:00:20 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hd92N-0004gc-RN; Tue, 18 Jun 2019 16:00:15 +0800
Date:   Tue, 18 Jun 2019 16:00:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipsec: select CRYPTO_HASH for xfrm_algo
Message-ID: <20190618080015.xe3fq2ltifybjds6@gondor.apana.org.au>
References: <20190618071514.2222319-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618071514.2222319-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 09:14:51AM +0200, Arnd Bergmann wrote:
> kernelci.org reports failed builds on arc because of what looks
> like an old missed 'select' statement:
> 
> net/xfrm/xfrm_algo.o: In function `xfrm_probe_algs':
> xfrm_algo.c:(.text+0x1e8): undefined reference to `crypto_has_ahash'
> 
> I don't see this in randconfig builds on other architectures, but
> it's fairly clear we want to select the hash code for it, like we
> do for all its other users.
> 
> Fixes: 17bc19702221 ("ipsec: Use skcipher and ahash when probing algorithms")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/xfrm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
> index c967fc3c38c8..a5c967efe5f4 100644
> --- a/net/xfrm/Kconfig
> +++ b/net/xfrm/Kconfig
> @@ -15,6 +15,7 @@ config XFRM_ALGO
>  	tristate
>  	select XFRM
>  	select CRYPTO
> +	select CRYPTO_HASH

You should also select CRYPTO_BLKCIPHER.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
