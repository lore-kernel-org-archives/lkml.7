Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B897BCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3FC2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="lkmMltuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404205AbfJWJ6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:58:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40684 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404168AbfJWJ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:58:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id p59so6861445edp.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 02:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BmDPouxVk6it30/vik+XTYalvYPYU+sttbaOcqxWe8k=;
        b=lkmMltuZ/rmrh6wByUf6P17He3TtFKb+/zDEG9266MdGz2dHwPgA/DDUkgeKcajNVD
         1jYbawnxYxl5gGPFgMNDRE3UHgL9KIGEvsgOZjH+XhMQAJbXkvSm3neB6NBb4S//dH4O
         RVlHi8ZkXVljLJer3klnOVzJUu3Pqd75x95dQZPN+jt5xpja68wBTbt9gBnEt2fp06mO
         8dEPzhqD6OqVglmlVRIG4J4r5WjGPWq7DUUVBtv2++9S7pkFRLZCEnjPkHMnHMLfRuF1
         adPmRE8yUH26nGzfQgboNLycesY/6rFNKdpePKoWLg5WXLlrUnZUzTRJ5b2hHi6e6W0/
         odDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BmDPouxVk6it30/vik+XTYalvYPYU+sttbaOcqxWe8k=;
        b=IvjzRKu0LBK/eCKrVLvzlftX0WWkQytMPwF/SFsFV6kGn4RPqw1T0pTpXmsstQY7T2
         OCXepxbec7oxJfqkbYEV8nqIZpLgspAk79bcaDRC/GtT65GO0sGjOHNS83bUSB48T5gx
         rCprr/gdNggXHeo2eICVeeXZ2rXLbh6TYIeLdMPTHZ+0ffz9QNb6umyrVU6N3E3ouVms
         qjMxTsWz0lgvh9QhxfYEzyQ7q3dLIJJ9CpAn1da5z3tkztxm3/nVANnUTlriJL9F1NtU
         xxxRX5Ag1Q4uGNiQdsEN6S9zlfClG+DZnNDL5eibIG7UN0GkxIqQSVgWlMiexY8ngNDv
         MEOg==
X-Gm-Message-State: APjAAAWBmGuvCtxJNstXOeKTTtaOFGSREKCXS6dBHaHLtPYkZCNss9zy
        wTCknd5whl838NUkICEFAR8CaQ==
X-Google-Smtp-Source: APXvYqwwnJNkyjrhmSVe5LFXgH4GcnEmaTCDcRouJZWqVhNsj0iP0tU/IIwYvhapTTOZfxFlH/84TA==
X-Received: by 2002:a17:906:3b4e:: with SMTP id h14mr12796863ejf.111.1571824684170;
        Wed, 23 Oct 2019 02:58:04 -0700 (PDT)
Received: from netronome.com ([62.119.166.9])
        by smtp.gmail.com with ESMTPSA id s26sm880294eds.80.2019.10.23.02.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 02:58:03 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:57:59 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S . Miller " <davem@davemloft.net>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Blakey <paulb@mellanox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] flow_dissector: skip the ICMP dissector for
 non ICMP packets
Message-ID: <20191023095758.GB8732@netronome.com>
References: <20191021200948.23775-1-mcroce@redhat.com>
 <20191021200948.23775-3-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021200948.23775-3-mcroce@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 10:09:46PM +0200, Matteo Croce wrote:
> FLOW_DISSECTOR_KEY_ICMP is checked for every packet, not only ICMP ones.
> Even if the test overhead is probably negligible, move the
> ICMP dissector code under the big 'switch(ip_proto)' so it gets called
> only for ICMP packets.
> 
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

Reviewed-by: Simon Horman <simon.horman@netronome.com>

> ---
>  net/core/flow_dissector.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index affde70dad47..6443fac65ce8 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -203,6 +203,25 @@ __be32 __skb_flow_get_ports(const struct sk_buff *skb, int thoff, u8 ip_proto,
>  }
>  EXPORT_SYMBOL(__skb_flow_get_ports);
>  
> +/* If FLOW_DISSECTOR_KEY_ICMP is set, get the Type and Code from an ICMP packet
> + * using skb_flow_get_be16().
> + */
> +static void __skb_flow_dissect_icmp(const struct sk_buff *skb,
> +				    struct flow_dissector *flow_dissector,
> +				    void *target_container,
> +				    void *data, int thoff, int hlen)
> +{
> +	struct flow_dissector_key_icmp *key_icmp;
> +
> +	if (!dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_ICMP))
> +		return;
> +
> +	key_icmp = skb_flow_dissector_target(flow_dissector,
> +					     FLOW_DISSECTOR_KEY_ICMP,
> +					     target_container);
> +	key_icmp->icmp = skb_flow_get_be16(skb, thoff, data, hlen);
> +}
> +
>  void skb_flow_dissect_meta(const struct sk_buff *skb,
>  			   struct flow_dissector *flow_dissector,
>  			   void *target_container)
> @@ -853,7 +872,6 @@ bool __skb_flow_dissect(const struct net *net,
>  	struct flow_dissector_key_basic *key_basic;
>  	struct flow_dissector_key_addrs *key_addrs;
>  	struct flow_dissector_key_ports *key_ports;
> -	struct flow_dissector_key_icmp *key_icmp;
>  	struct flow_dissector_key_tags *key_tags;
>  	struct flow_dissector_key_vlan *key_vlan;
>  	struct bpf_prog *attached = NULL;
> @@ -1295,6 +1313,12 @@ bool __skb_flow_dissect(const struct net *net,
>  				       data, nhoff, hlen);
>  		break;
>  
> +	case IPPROTO_ICMP:
> +	case IPPROTO_ICMPV6:
> +		__skb_flow_dissect_icmp(skb, flow_dissector, target_container,
> +					data, nhoff, hlen);
> +		break;
> +
>  	default:
>  		break;
>  	}
> @@ -1308,14 +1332,6 @@ bool __skb_flow_dissect(const struct net *net,
>  							data, hlen);
>  	}
>  
> -	if (dissector_uses_key(flow_dissector,
> -			       FLOW_DISSECTOR_KEY_ICMP)) {
> -		key_icmp = skb_flow_dissector_target(flow_dissector,
> -						     FLOW_DISSECTOR_KEY_ICMP,
> -						     target_container);
> -		key_icmp->icmp = skb_flow_get_be16(skb, nhoff, data, hlen);
> -	}
> -
>  	/* Process result of IP proto processing */
>  	switch (fdret) {
>  	case FLOW_DISSECT_RET_PROTO_AGAIN:
> -- 
> 2.21.0
> 
