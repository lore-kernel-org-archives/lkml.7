Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E6DC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 00:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B865E2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 00:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="fhB2iXQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfFUAdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 20:33:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35371 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfFUAdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 20:33:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so2459887pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 17:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VWCFU1NtUy1SLx0P04uvsBj+Xrz/jdAYg/mA6p5ibZI=;
        b=fhB2iXQOxt0Df3GjN40VkZ9tXjPjZNZoZO3igKZZxEYyR3nven7fpjRelb3jUm2Sfo
         Il/TUTEZNtgolHPyvbLRktFPs9V48tjRCgAURSb1mOTme54GZzjN1z9o5+P9M6Ovwp+F
         6BzRKexLuOi/kSJoVCOlSmEcUTMa85wsRN5xqor+cYmRRyOMUiitJU538yqxO2NQFBdx
         Jo6Xob8iNHVZrayIJgmpDsGGgNNSsI7S1wtAk2GrfbuyJm0wANKfNKdDpU/GUsEDM0sy
         KmT4DFvnifcmiuIxfIn1/expYZchYkOd9AfNfJlP0hjk/tID7iw0V+yAR6lrH1R+3MO+
         fsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VWCFU1NtUy1SLx0P04uvsBj+Xrz/jdAYg/mA6p5ibZI=;
        b=ldCrLSLL82EPzZGpiPfafiB0jnwMyGXDdzq7HoxDNDfIiQ+sETkckWOP+obiaYGwJB
         3twqF+gbdkfgV9EcMyh2dKzxBplr88y3903q5Ot8LbtMEN+RWiHk/aJ6E1zwMd8YvxkK
         jc3uQAwDwmPfSG2IH3koWiVLMoVqW32OSZQFzezI+4E+A04zgj5FJF/G34ra4fMjkTwy
         uUo2Ll0wRMIbp2NsY/ldHPtu0u+qjhoJAb2GkF6G1vwwaVO2IwylJ+LwGcgMSON/cvz5
         ZqlQN4EY+IzcWh6N8UCtyUFGZ5BG0pqx4PtPuLMxKtE5/f1H/kzXnNqHHLAc9g72joFL
         OXlw==
X-Gm-Message-State: APjAAAVsZeCY9J4CZOXCvgQnyDZ9Jm/1cz/BDSlRIFIZc5FOuGTjDK0y
        ypDvxI3xaJ7c/E5WLs5hbINieg==
X-Google-Smtp-Source: APXvYqx8XHF2lzyJRvlD0WQnCu3FXRxUp23oyFjChE34lsemufCBaNkdLqKB5bQVDLc8iKIqu0qW7Q==
X-Received: by 2002:a63:e001:: with SMTP id e1mr15482674pgh.306.1561077199414;
        Thu, 20 Jun 2019 17:33:19 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id q198sm625125pfq.155.2019.06.20.17.33.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 17:33:18 -0700 (PDT)
Date:   Thu, 20 Jun 2019 17:33:17 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Yuehaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, sdf@google.com, jianbol@mellanox.com,
        jiri@mellanox.com, mirq-linux@rere.qmqm.pl, willemb@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] flow_dissector: Fix vlan header offset in
 __skb_flow_dissect
Message-ID: <20190621003317.GE1383@mini-arch>
References: <20190619160132.38416-1-yuehaibing@huawei.com>
 <20190619183938.GA19111@mini-arch>
 <00a5d09f-a23e-661f-60c0-75fba6227451@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a5d09f-a23e-661f-60c0-75fba6227451@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20, Yuehaibing wrote:
> On 2019/6/20 2:39, Stanislav Fomichev wrote:
> > On 06/20, YueHaibing wrote:
> >> We build vlan on top of bonding interface, which vlan offload
> >> is off, bond mode is 802.3ad (LACP) and xmit_hash_policy is
> >> BOND_XMIT_POLICY_ENCAP34.
> >>
> >> __skb_flow_dissect() fails to get information from protocol headers
> >> encapsulated within vlan, because 'nhoff' is points to IP header,
> >> so bond hashing is based on layer 2 info, which fails to distribute
> >> packets across slaves.
> >>
> >> Fixes: d5709f7ab776 ("flow_dissector: For stripped vlan, get vlan info from skb->vlan_tci")
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >> ---
> >>  net/core/flow_dissector.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> >> index 415b95f..2a52abb 100644
> >> --- a/net/core/flow_dissector.c
> >> +++ b/net/core/flow_dissector.c
> >> @@ -785,6 +785,9 @@ bool __skb_flow_dissect(const struct sk_buff *skb,
> >>  		    skb && skb_vlan_tag_present(skb)) {
> >>  			proto = skb->protocol;
> >>  		} else {
> >> +			if (dissector_vlan == FLOW_DISSECTOR_KEY_MAX)
> >> +				nhoff -=  sizeof(*vlan);
> >> +
> > Should we instead fix the place where the skb is allocated to properly
> > pull vlan (skb_vlan_untag)? I'm not sure this particular place is
> > supposed to work with an skb. Having an skb with nhoff pointing to
> > IP header but missing skb_vlan_tag_present() when with
> > proto==ETH_P_8021xx seems weird.
> 
> The skb is a forwarded vxlan packet, it send through vlan interface like this:
> 
>    vlan_dev_hard_start_xmit
>     --> __vlan_hwaccel_put_tag //vlan_tci and VLAN_TAG_PRESENT is set
>     --> dev_queue_xmit
>         --> validate_xmit_skb
>           --> validate_xmit_vlan // vlan_hw_offload_capable is false
>              --> __vlan_hwaccel_push_inside //here skb_push vlan_hlen, then clear skb->tci
> 
>     --> bond_start_xmit
>        --> bond_xmit_hash
>          --> __skb_flow_dissect // nhoff point to IP header
>             -->  case htons(ETH_P_8021Q)
>             // skb_vlan_tag_present is false, so
>               vlan = __skb_header_pointer(skb, nhoff, sizeof(_vlan), //vlan point to ip header wrongly
I see, so bonding device propagates hw VLAN support from the slaves.
If one of the slaves doesn't have it, its disabled for the bond device.
Any idea why we do that? Why not pass skbs to the slave devices
instead and let them handle the hw/sw vlan implementation?
I see the propagation was added in 278339a42a1b 10 years ago and
I don't see any rationale in the commit description.
Somebody with more context should probably chime in :-)
