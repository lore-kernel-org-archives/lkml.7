Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A214FC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746EB2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efTQfkRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfLTMhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:37:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58158 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727298AbfLTMhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576845459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tej/n4A7UHRnvHhgibQAxYCuLBCu3uUQkoxEy/wczjQ=;
        b=efTQfkRZFR9DqOcuPWqdjgjQRzkkHB7odZYBfqtthJF8tT4JajBu5cLVjDGeHLDbSvC8vW
        ms/EmI39S4h54pkDYO3ou9tR6QgC3VWLrdYmY/9G3eIsgZ7gqNKDaY30TM6xmve1ef+YTJ
        7gvgWQychV/wNiEO3ecI6D5AlrxQYx8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-zWBiBxNiM-2PJbHI_oYDmg-1; Fri, 20 Dec 2019 07:37:37 -0500
X-MC-Unique: zWBiBxNiM-2PJbHI_oYDmg-1
Received: by mail-lj1-f198.google.com with SMTP id z17so2830074ljz.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 04:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tej/n4A7UHRnvHhgibQAxYCuLBCu3uUQkoxEy/wczjQ=;
        b=O78RhPKDv8DFs9z/0Xzb5ubzMcJYZMNxT+q3PK1nOrUWmMRyFdto5pccrH8qljJRgl
         sRXXIqJzsR6/INHR5WMmWNy7apxtT/G7xRSielT5pmTVUH3WO6i1AWGG4+jjYkdyuVz5
         FbRWLU+z0QO15w347kYRAtpIeFEF8LDdCAGwYbz9USA3ZLNqCnXl3rO24skgBdZWEkZE
         lPY0ywLAeixXB5sO5fi9X/daHNG1kokpOz8lE4O2BqonWwSY2WvXzoHmgWb2vs210Oik
         BZGZY96Ff/ZvmzQ02Lr7wN6ic36BlshbjieF8E0Lc1fPIuDTS+iARCyYDDVrWjMF8Z+M
         M6Lw==
X-Gm-Message-State: APjAAAU17bRVH2CQIPpHrKJTpmcjOcEz0zRDFNlpRSyyi0bhmDhSUxvi
        O4J4syoZBZk90u65CbjCItHHa3lYsWYUtaJan71mEDGpBJyrmGrFavpgYVJOGcD4D8fAQqClm/T
        a0MV2CU4KIjU7OO4NSHatiu4GIoIUW6dlQDRjZ0eV
X-Received: by 2002:a2e:8651:: with SMTP id i17mr1302211ljj.121.1576845455904;
        Fri, 20 Dec 2019 04:37:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjcFwLWNXUWhpwZbSBTQMMtBvo1yLTIpd7B1ajcwgvUn0r3M/kG8StilrMXG5hkksOQ+A/qz6YwkFNsV2FPpg=
X-Received: by 2002:a2e:8651:: with SMTP id i17mr1302188ljj.121.1576845455600;
 Fri, 20 Dec 2019 04:37:35 -0800 (PST)
MIME-Version: 1.0
References: <20191217155102.46039-1-mcroce@redhat.com> <cf5b01f8-b4e4-90da-0ee7-b1d81ee6d342@cumulusnetworks.com>
In-Reply-To: <cf5b01f8-b4e4-90da-0ee7-b1d81ee6d342@cumulusnetworks.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Fri, 20 Dec 2019 13:36:59 +0100
Message-ID: <CAGnkfhxaT9_WL4UR8qurjBTkkdkuZFbfTQucLjoKOP-1eDEoTw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] openvswitch: add TTL decrement action
To:     Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc:     netdev <netdev@vger.kernel.org>, ovs dev <dev@openvswitch.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Bindiya Kurle <bindiyakurle@gmail.com>,
        Simon Horman <simon.horman@netronome.com>,
        Ben Pfaff <blp@ovn.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 5:30 PM Nikolay Aleksandrov
<nikolay@cumulusnetworks.com> wrote:
>
> On 17/12/2019 17:51, Matteo Croce wrote:
> > New action to decrement TTL instead of setting it to a fixed value.
> > This action will decrement the TTL and, in case of expired TTL, drop it
> > or execute an action passed via a nested attribute.
> > The default TTL expired action is to drop the packet.
> >
> > Supports both IPv4 and IPv6 via the ttl and hop_limit fields, respectively.
> >
> > Tested with a corresponding change in the userspace:
> >
> >     # ovs-dpctl dump-flows
> >     in_port(2),eth(),eth_type(0x0800), packets:0, bytes:0, used:never, actions:dec_ttl{ttl<=1 action:(drop)},1,1
> >     in_port(1),eth(),eth_type(0x0800), packets:0, bytes:0, used:never, actions:dec_ttl{ttl<=1 action:(drop)},1,2
> >     in_port(1),eth(),eth_type(0x0806), packets:0, bytes:0, used:never, actions:2
> >     in_port(2),eth(),eth_type(0x0806), packets:0, bytes:0, used:never, actions:1
> >
> >     # ping -c1 192.168.0.2 -t 42
> >     IP (tos 0x0, ttl 41, id 61647, offset 0, flags [DF], proto ICMP (1), length 84)
> >         192.168.0.1 > 192.168.0.2: ICMP echo request, id 386, seq 1, length 64
> >     # ping -c1 192.168.0.2 -t 120
> >     IP (tos 0x0, ttl 119, id 62070, offset 0, flags [DF], proto ICMP (1), length 84)
> >         192.168.0.1 > 192.168.0.2: ICMP echo request, id 388, seq 1, length 64
> >     # ping -c1 192.168.0.2 -t 1
> >     #
> >
> > Co-authored-by: Bindiya Kurle <bindiyakurle@gmail.com>
> > Signed-off-by: Bindiya Kurle <bindiyakurle@gmail.com>
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
> > ---
> >  include/uapi/linux/openvswitch.h |  22 +++++++
> >  net/openvswitch/actions.c        |  71 +++++++++++++++++++++
> >  net/openvswitch/flow_netlink.c   | 105 +++++++++++++++++++++++++++++++
> >  3 files changed, 198 insertions(+)
> >
>
> Hi Matteo,
>
> [snip]
> > +}
> > +
> >  /* When 'last' is true, sample() should always consume the 'skb'.
> >   * Otherwise, sample() should keep 'skb' intact regardless what
> >   * actions are executed within sample().
> > @@ -1176,6 +1201,44 @@ static int execute_check_pkt_len(struct datapath *dp, struct sk_buff *skb,
> >                            nla_len(actions), last, clone_flow_key);
> >  }
> >
> > +static int execute_dec_ttl(struct sk_buff *skb, struct sw_flow_key *key)
> > +{
> > +     int err;
> > +
> > +     if (skb->protocol == htons(ETH_P_IPV6)) {
> > +             struct ipv6hdr *nh = ipv6_hdr(skb);
> > +
> > +             err = skb_ensure_writable(skb, skb_network_offset(skb) +
> > +                                       sizeof(*nh));
>
> skb_ensure_writable() calls pskb_may_pull() which may reallocate so nh might become invalid.
> It seems the IPv4 version below is ok as the ptr is reloaded.
>

Right

> One q as I don't know ovs that much - can this action be called only with
> skb->protocol ==  ETH_P_IP/IPV6 ? I.e. Are we sure that if it's not v6, then it must be v4 ?
>

I'm adding a check in validate_and_copy_dec_ttl() so only ipv4/ipv6
packet will pass.

Thanks,

-- 
Matteo Croce
per aspera ad upstream

