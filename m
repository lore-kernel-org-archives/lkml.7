Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E78C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B06A20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/hk7dvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403963AbfETRRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:17:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43610 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403945AbfETRRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:17:13 -0400
Received: by mail-pl1-f195.google.com with SMTP id gn7so2847109plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ScUZ/xpgU2aTY1Nb5OViipRU9LRxmOkzl5eEkgamu+4=;
        b=u/hk7dvb2PAmI5IFI5yr57lW7tUAYqA5xkIZlFRA5Iv/dRJt+p39pMkD0Bbt5qf4xm
         Ytjuma54OmHG5jIU3bN5wO/eY8VWRtz0gJlwP6zFmUgNcYs+mH6Wj84zJgnnEt+xtn8Y
         VHxtGaYR2PRh6e/C0ppGWI+o87sfWKSQZr81kvBh5mmB9bbMed3sf/+93nClSlMc0Wq5
         PrH18U4Q6YvGpYLGx+O3rkDw77jUQ1FUjjDKpN3+cDiUp//siqAyubcvryZIFP4kSKnw
         +uKYUBZOwsvbFWWxAJ4ClKclBe4NPg6OZZS166JxwXbmTRur4MYX2NdkwpLfrOunPAjC
         5Hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ScUZ/xpgU2aTY1Nb5OViipRU9LRxmOkzl5eEkgamu+4=;
        b=QiS/tBHA+cyd0KlPCanYTgnSgHd/mntgBqljoqKZ6XeiuCTKrkLexJzu9rXE2Fo5bE
         3VKJ00yjwZKm40Eg3/ppatotLXVTch4JEJ0FnxWVTyb6iIORFa1eIJJkOqE4+i2zvQbX
         n7K+j2Gcs99Lw/soyiRdKkoylrfjH+GGVf6SJYR01nNl1+6HqMBo7dhichIjqT0+U06w
         byCplX5AWLdmhZZnwpUvyjAz7VFlhbb5h/PMx9Tw9KMMwVyZWbpgu9Z9F+1lxyr+HwZd
         ea0XJeO9qButpnu9Yx/QRMasxCKbg9rZKPd8ehjAJ1rPwnzxXcB0WK+GsP4X4jv6KNRQ
         CtSw==
X-Gm-Message-State: APjAAAW35TI6dm2ZsO3IhVqheKYlIjP0Idcj81SBGGUuEiYxlCev3CBD
        CuI58FvscuueUMDkRgj3SV8/bQ==
X-Google-Smtp-Source: APXvYqxJH9e/9PMebXHaD9faSRZhhWJCU9i4asOXuPPssxo8pt9GHh9pom+TaB6TkWIjSBUjbqJe9Q==
X-Received: by 2002:a17:902:24c7:: with SMTP id l7mr27347835plg.192.1558372632896;
        Mon, 20 May 2019 10:17:12 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m12sm15083945pgi.56.2019.05.20.10.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 10:17:12 -0700 (PDT)
Date:   Mon, 20 May 2019 10:17:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     arnd@arndb.de, subashab@codeaurora.org, david.brown@linaro.org,
        agross@kernel.org, davem@davemloft.net,
        ilias.apalodimas@linaro.org, cpratapa@codeaurora.org,
        syadagir@codeaurora.org, evgreen@chromium.org, benchan@google.com,
        ejcaruso@google.com, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] net: qualcomm: rmnet: get rid of a variable in
 rmnet_map_ipv4_ul_csum_header()
Message-ID: <20190520171739.GU2085@tuxbook-pro>
References: <20190520135354.18628-1-elder@linaro.org>
 <20190520135354.18628-7-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520135354.18628-7-elder@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20 May 06:53 PDT 2019, Alex Elder wrote:

> The value passed as an argument to rmnet_map_ipv4_ul_csum_header()
> is always an IPv4 header.  Just have the type of the argument
> reflect that rather than obscuring that with a void pointer.  Rename
> it to be consistent with rmnet_map_ipv6_ul_csum_header().
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index a95111cdcd29..61b7dbab2056 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> @@ -203,26 +203,25 @@ static void rmnet_map_complement_ipv4_txporthdr_csum_field(void *iphdr)
>  }
>  
>  static void
> -rmnet_map_ipv4_ul_csum_header(void *iphdr,
> +rmnet_map_ipv4_ul_csum_header(struct iphdr *ip4hdr,
>  			      struct rmnet_map_ul_csum_header *ul_header,
>  			      struct sk_buff *skb)
>  {
> -	struct iphdr *ip4h = iphdr;
>  	u16 offset;
>  	u16 val;
>  
> -	offset = skb_transport_header(skb) - (unsigned char *)iphdr;
> +	offset = skb_transport_header(skb) - (unsigned char *)ip4hdr;
>  	ul_header->csum_start_offset = htons(offset);
>  
>  	val = u16_encode_bits(skb->csum_offset, RMNET_MAP_UL_CSUM_INSERT_FMASK);
>  	val |= RMNET_MAP_UL_CSUM_ENABLED_FMASK;
> -	if (ip4h->protocol == IPPROTO_UDP)
> +	if (ip4hdr->protocol == IPPROTO_UDP)
>  		val |= RMNET_MAP_UL_CSUM_UDP_FMASK;
>  	ul_header->csum_info = htons(val);
>  
>  	skb->ip_summed = CHECKSUM_NONE;
>  
> -	rmnet_map_complement_ipv4_txporthdr_csum_field(iphdr);
> +	rmnet_map_complement_ipv4_txporthdr_csum_field(ip4hdr);
>  }
>  
>  #if IS_ENABLED(CONFIG_IPV6)
> -- 
> 2.20.1
> 
