Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D28C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E48B21479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="klIF7hty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388755AbfETPtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:49:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38525 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733264AbfETPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:49:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id b76so7429321pfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 08:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QFpmFkwPfpK4QifhWN1BadA/PBNjYiOBjDYO4Z/gfrU=;
        b=klIF7htybEJwE6Q126+cbgptyRZLkhF47QysvfGWMoKAN06piI1xdO/56Nif/l5zlQ
         z/247xEE3j0Fk12GoKr/m8GSjdIk6ZGLnjhqAfPjYhpLh1nq9vszkhXvqeuvL5yPUgJL
         172cAXvDDUi54+kRKFtyLHBR+3OaKJNZ/WtQcrEJhhxKfDXLxq7+wt3QI7FJYjkenoDr
         x6i5WjCjiKGSCirNPOoZvKbCzkdGmZNS+YhbUqqAFWyIT8db2mYD/Pl8fNKSi9Ln7XJr
         +pdKOpdfcm2bzODpbi67MVJg5kCGNJqfmaCM8yd/sgkj3jjheeVq6edpnQQGe9r6KKAZ
         R8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QFpmFkwPfpK4QifhWN1BadA/PBNjYiOBjDYO4Z/gfrU=;
        b=gOqMOg6uLGhBnCjQuNXLjou+/MFJZFoeJfoDPb+6v3G+Lfxl6oNMN3Vs0aDzVUaAs0
         8xxe0hwMSS/uMuALYNKXWDa6BryGJTkmEMiv771MmsiBIb7v5fhurL5J/srQpBWHSs4U
         omqIfkbj3CXj1gYeHNH69zmETABnVxEy025SHT3jeb4zUwGDvcyarvksQw9G2/6PK8I9
         35BSd3M1bon4I6I3kDPPR4oXiglDYbFQkTpvx+XWnWLmQPV1BHuwxtvJt9swuxeF4W33
         je0WglqocgaaiVlWZOotOakJtOj6txJ1VLWu8082JP7zAMXdw7sfEDmHWokqYAJp/NmC
         zq8w==
X-Gm-Message-State: APjAAAXoLLmmyNL587zmUqLFeRpcS7kXlvsfkPo8LhEfKtWPqPEBQ9Oq
        PylMPjSULuPOVAxg6JkQMrW77A==
X-Google-Smtp-Source: APXvYqwIA0fQeJewtrZCCggWUWQiyyg8jwb1kBLfxUcXdXqQ39LEz2IXO4LkKrXJkW2PPibRxtiQ4w==
X-Received: by 2002:a62:7995:: with SMTP id u143mr80904639pfc.61.1558367341183;
        Mon, 20 May 2019 08:49:01 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v81sm36496778pfa.16.2019.05.20.08.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 08:49:00 -0700 (PDT)
Date:   Mon, 20 May 2019 08:49:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     arnd@arndb.de, subashab@codeaurora.org, david.brown@linaro.org,
        agross@kernel.org, davem@davemloft.net,
        ilias.apalodimas@linaro.org, cpratapa@codeaurora.org,
        syadagir@codeaurora.org, evgreen@chromium.org, benchan@google.com,
        ejcaruso@google.com, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] net: qualcomm: rmnet: don't use C bit-fields in
 rmnet checksum header
Message-ID: <20190520154926.GS2085@tuxbook-pro>
References: <20190520135354.18628-1-elder@linaro.org>
 <20190520135354.18628-5-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520135354.18628-5-elder@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20 May 06:53 PDT 2019, Alex Elder wrote:

> Replace the use of C bit-fields in the rmnet_map_ul_csum_header
> structure with a single integral structure member, and use field
> masks to encode or get values within that member.
> 
> Note that the previous C bit-fields were defined with CPU local
> endianness.  Their values were computed and then forecfully converted
> to network byte order in rmnet_map_ipv4_ul_csum_header().  Simplify
> that function, and properly define the new csum_info member as a big
> endian value.
> 
> Make similar simplifications in rmnet_map_ipv6_ul_csum_header().
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  .../net/ethernet/qualcomm/rmnet/rmnet_map.h   |  9 ++--
>  .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 50 ++++++++-----------
>  2 files changed, 26 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
> index a56209645c81..f3231c26badd 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
> @@ -60,11 +60,14 @@ struct rmnet_map_dl_csum_trailer {
>  
>  struct rmnet_map_ul_csum_header {
>  	__be16 csum_start_offset;
> -	u16 csum_insert_offset:14;
> -	u16 udp_ip4_ind:1;
> -	u16 csum_enabled:1;
> +	__be16 csum_info;	/* RMNET_MAP_UL_* */
>  } __aligned(1);
>  
> +/* NOTE:  These field masks are defined in CPU byte order */
> +#define RMNET_MAP_UL_CSUM_INSERT_FMASK	GENMASK(13, 0)
> +#define RMNET_MAP_UL_CSUM_UDP_FMASK	GENMASK(14, 14)   /* 0: IP; 1: UDP */
> +#define RMNET_MAP_UL_CSUM_ENABLED_FMASK	GENMASK(15, 15)
> +
>  #define RMNET_MAP_COMMAND_REQUEST     0
>  #define RMNET_MAP_COMMAND_ACK         1
>  #define RMNET_MAP_COMMAND_UNSUPPORTED 2
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index 10d2d582a9ce..72b64114505a 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> @@ -207,22 +207,18 @@ rmnet_map_ipv4_ul_csum_header(void *iphdr,
>  			      struct rmnet_map_ul_csum_header *ul_header,
>  			      struct sk_buff *skb)
>  {
> -	struct iphdr *ip4h = (struct iphdr *)iphdr;
> -	__be16 *hdr = (__be16 *)ul_header, offset;
> +	struct iphdr *ip4h = iphdr;
> +	u16 offset;
> +	u16 val;
>  
> -	offset = htons((__force u16)(skb_transport_header(skb) -
> -				     (unsigned char *)iphdr));
> -	ul_header->csum_start_offset = offset;
> -	ul_header->csum_insert_offset = skb->csum_offset;
> -	ul_header->csum_enabled = 1;
> +	offset = skb_transport_header(skb) - (unsigned char *)iphdr;
> +	ul_header->csum_start_offset = htons(offset);
> +
> +	val = u16_encode_bits(skb->csum_offset, RMNET_MAP_UL_CSUM_INSERT_FMASK);
> +	val |= RMNET_MAP_UL_CSUM_ENABLED_FMASK;
>  	if (ip4h->protocol == IPPROTO_UDP)
> -		ul_header->udp_ip4_ind = 1;
> -	else
> -		ul_header->udp_ip4_ind = 0;
> -
> -	/* Changing remaining fields to network order */
> -	hdr++;
> -	*hdr = htons((__force u16)*hdr);
> +		val |= RMNET_MAP_UL_CSUM_UDP_FMASK;
> +	ul_header->csum_info = htons(val);
>  
>  	skb->ip_summed = CHECKSUM_NONE;
>  
> @@ -249,18 +245,16 @@ rmnet_map_ipv6_ul_csum_header(void *ip6hdr,
>  			      struct rmnet_map_ul_csum_header *ul_header,
>  			      struct sk_buff *skb)
>  {
> -	__be16 *hdr = (__be16 *)ul_header, offset;
> +	u16 offset;
> +	u16 val;
>  
> -	offset = htons((__force u16)(skb_transport_header(skb) -
> -				     (unsigned char *)ip6hdr));
> -	ul_header->csum_start_offset = offset;
> -	ul_header->csum_insert_offset = skb->csum_offset;
> -	ul_header->csum_enabled = 1;
> -	ul_header->udp_ip4_ind = 0;
> +	offset = skb_transport_header(skb) - (unsigned char *)ip6hdr;
> +	ul_header->csum_start_offset = htons(offset);
>  
> -	/* Changing remaining fields to network order */
> -	hdr++;
> -	*hdr = htons((__force u16)*hdr);
> +	val = u16_encode_bits(skb->csum_offset, RMNET_MAP_UL_CSUM_INSERT_FMASK);
> +	val |= RMNET_MAP_UL_CSUM_ENABLED_FMASK;
> +	/* Not UDP, so that field is 0 */
> +	ul_header->csum_info = htons(val);
>  
>  	skb->ip_summed = CHECKSUM_NONE;
>  
> @@ -400,8 +394,7 @@ void rmnet_map_checksum_uplink_packet(struct sk_buff *skb,
>  	struct rmnet_map_ul_csum_header *ul_header;
>  	void *iphdr;
>  
> -	ul_header = (struct rmnet_map_ul_csum_header *)
> -		    skb_push(skb, sizeof(struct rmnet_map_ul_csum_header));
> +	ul_header = skb_push(skb, sizeof(*ul_header));
>  
>  	if (unlikely(!(orig_dev->features &
>  		     (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM))))
> @@ -428,10 +421,7 @@ void rmnet_map_checksum_uplink_packet(struct sk_buff *skb,
>  	}
>  
>  sw_csum:
> -	ul_header->csum_start_offset = 0;
> -	ul_header->csum_insert_offset = 0;
> -	ul_header->csum_enabled = 0;
> -	ul_header->udp_ip4_ind = 0;
> +	memset(ul_header, 0, sizeof(*ul_header));
>  
>  	priv->stats.csum_sw++;
>  }
> -- 
> 2.20.1
> 
