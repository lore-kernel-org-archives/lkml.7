Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F74BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94DE20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmwJJRfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfCGBQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:16:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47098 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfCGBQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:16:14 -0500
Received: by mail-pg1-f196.google.com with SMTP id 196so9856582pgf.13;
        Wed, 06 Mar 2019 17:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FL6kiwAgz96pQ98JZedchR3GSCd9oFl3sbdzbQ/tH+M=;
        b=dmwJJRfa/RNWMBv2p7CmuVAM7VOK6Ys6jbwY1uqHtdTkOAjB7JfSK93hKljxhfxxOX
         ubdsGcKS2Gb5khy+aXGUNpRRg6SCBOoSBU5u2P4uQVaKiey5HA8e3GL2F/lGDu8qJKoQ
         02vU2htzWmYlIra0MsveZ1VsKuJnLOo8FtuSVd658gUfDZ+P2FVi+8xz1FGp00DxzafM
         X+aZV164HAPHiE5BAtokrNFLOM/Yf3n+UJnaVr+AefkBM8mh6w4PAMG4Pp0mxM+Mz8rn
         yJ36vWhNAE/51IFr1FYtgij5wsj3n3/h0ddUOTWgNunV6ASR5J16MZdtCtYWmXYl+e6t
         UMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FL6kiwAgz96pQ98JZedchR3GSCd9oFl3sbdzbQ/tH+M=;
        b=MmSlvfsbs+P9aOuaoGMhIZG2hs17fnAIypBmEe4r9wVir602ZF332ylC4iVL6kjT2j
         /Yb95sr/YH8xrGSpjQT4Af56FfcPRiWzVkmnosFLHSzKGXH1ObvE/eIFfnfTlwCl8hoA
         SJYy0Iio0zz45qirV4xEL5qtFVlVyKu4/4Af4KSvLXuDiUO2OWyJDFWsMK6qJ7/X3XVA
         ZOXfRXMSxPZkjNQPR3bIjhWdMq1PKaoDExTN7vjN7s4WFIibKLyzX4XZuxbE5mx/XYMd
         gk+tRLVjfRbpwLx2Euj8HgRkMtLk/cE1V82WDZJl8874Vwm/Ymr2TZgx1utfL8ZWyFKA
         h4eg==
X-Gm-Message-State: APjAAAVigiU+zX+3d8+i0tpRtan1tK1ojWO0UOQ+rD7tujljS+xvuhpZ
        mFPcGoS/n9vpUX0FHqUGgpE=
X-Google-Smtp-Source: APXvYqwSXomYh6rizHhr7LvUV/A28SNrbUBWVhvF77fm2VRFth9Z0ZF/jvhNzw9f5EWNPW16qks4yg==
X-Received: by 2002:a65:568b:: with SMTP id v11mr9230756pgs.23.1551921373906;
        Wed, 06 Mar 2019 17:16:13 -0800 (PST)
Received: from myunghoj-Precision-5530 ([118.220.181.225])
        by smtp.gmail.com with ESMTPSA id r131sm4145744pgr.65.2019.03.06.17.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 17:16:13 -0800 (PST)
Date:   Thu, 7 Mar 2019 10:16:07 +0900
From:   Myungho Jung <mhjungk@gmail.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xfrm: Reset secpath in xfrm failure
Message-ID: <20190307011606.GA2002@myunghoj-Precision-5530>
References: <20190306215556.GA6104@myunghoj-Precision-5530>
 <1b3fc434-a5d2-286f-e7ef-027d165a5413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b3fc434-a5d2-286f-e7ef-027d165a5413@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 02:31:25PM -0800, Eric Dumazet wrote:
> 
> 
> On 03/06/2019 01:55 PM, Myungho Jung wrote:
> > In esp4_gro_receive() and esp6_gro_receive(), secpath can be allocated
> > without adding xfrm state to xvec. Then, sp->xvec[sp->len - 1] would
> > fail and result in dereferencing invalid pointer in esp4_gso_segment()
> > and esp6_gso_segment(). Reset secpath if xfrm function returns error.
> > 
> > Fixes: 7785bba299a8 ("esp: Add a software GRO codepath")
> > Reported-by: syzbot+b69368fd933c6c592f4c@syzkaller.appspotmail.com
> > Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> > ---
> > Changes in v2:
> >   - Add fixes tag.
> > 
> >  net/ipv4/esp4_offload.c | 9 +++++++--
> >  net/ipv6/esp6_offload.c | 9 +++++++--
> >  2 files changed, 14 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
> > index 8756e0e790d2..7329e40c73f6 100644
> > --- a/net/ipv4/esp4_offload.c
> > +++ b/net/ipv4/esp4_offload.c
> > @@ -51,14 +51,18 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
> >  		if (!sp)
> >  			goto out;
> >  
> > -		if (sp->len == XFRM_MAX_DEPTH)
> > +		if (sp->len == XFRM_MAX_DEPTH) {
> > +			secpath_reset(skb);
> >  			goto out;
> > +		}
> >  
> >  		x = xfrm_state_lookup(dev_net(skb->dev), skb->mark,
> >  				      (xfrm_address_t *)&ip_hdr(skb)->daddr,
> >  				      spi, IPPROTO_ESP, AF_INET);
> > -		if (!x)
> > +		if (!x) {
> > +			secpath_reset(skb);
> >  			goto out;
> > +		}
> >  
> 
> I suggest another exit label, so that you replace "goto out" by "goto out_reset";
> 
> diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
> index 8756e0e790d2a94a5b4a587c3bc3de0673baf2c4..76f754f6692696ba2aa8c9eb03b68b92d1e39ee1 100644
> --- a/net/ipv4/esp4_offload.c
> +++ b/net/ipv4/esp4_offload.c
> @@ -82,6 +82,8 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
>         xfrm_input(skb, IPPROTO_ESP, spi, -2);
>  
>         return ERR_PTR(-EINPROGRESS);
> +out_reset:
> +       secpath_reset(skb);
>  out:
>         skb_push(skb, offset);
>         NAPI_GRO_CB(skb)->same_flow = 0;
> 
> 
> 
> 
> >  		sp->xvec[sp->len++] = x;
> >  		sp->olen++;
> > @@ -66,6 +70,7 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
> >  		xo = xfrm_offload(skb);
> >  		if (!xo) {
> >  			xfrm_state_put(x);
> > +			secpath_reset(skb);
> >  			goto out;
> >  		}
> >  	}
> 
> 

Hi Eric,

Thanks for the suggestion. It looks better and clean. Let me update the fix to
v3.

Thanks,
Myungho
