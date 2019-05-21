Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3CDC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F062173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfEUMWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:22:55 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58716 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbfEUMWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:22:55 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hT3n4-00016s-0Q; Tue, 21 May 2019 20:22:46 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hT3mw-0003Hs-T0; Tue, 21 May 2019 20:22:38 +0800
Date:   Tue, 21 May 2019 20:22:38 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Anirudh Gupta <anirudhrudr@gmail.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Anirudh Gupta <anirudh.gupta@sophos.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] xfrm: Fix xfrm sel prefix length validation
Message-ID: <20190521122238.qip43s44pgl7ihea@gondor.apana.org.au>
References: <20190521082247.67732-1-anirudh.gupta@sophos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521082247.67732-1-anirudh.gupta@sophos.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 01:52:47PM +0530, Anirudh Gupta wrote:
> Family of src/dst can be different from family of selector src/dst.
> Use xfrm selector family to validate address prefix length,
> while verifying new sa from userspace.
> 
> Validated patch with this command:
> ip xfrm state add src 1.1.6.1 dst 1.1.6.2 proto esp spi 4260196 \
> reqid 20004 mode tunnel aead "rfc4106(gcm(aes))" \
> 0x1111016400000000000000000000000044440001 128 \
> sel src 1011:1:4::2/128 sel dst 1021:1:4::2/128 dev Port5
> 
> Fixes: 07bf7908950a ("xfrm: Validate address prefix lengths in the xfrm selector.")
> Signed-off-by: Anirudh Gupta <anirudh.gupta@sophos.com>
> ---
>  net/xfrm/xfrm_user.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index eb8d14389601..1d1fe2208ab5 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -150,6 +150,23 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
>  
>  	err = -EINVAL;
>  	switch (p->family) {
> +	case AF_INET:
> +		break;
> +
> +	case AF_INET6:
> +#if IS_ENABLED(CONFIG_IPV6)
> +		break;
> +#else
> +		err = -EAFNOSUPPORT;
> +		goto out;
> +#endif
> +
> +	default:
> +		goto out;
> +	}
> +
> +	err = -EINVAL;

This is not needed because you already set it at the start.

Otherwise this looks good to me.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
