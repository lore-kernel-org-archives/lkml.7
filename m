Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8D5C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3882168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="b/mSLrdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389697AbfJAPaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:30:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44213 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389331AbfJAPaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:30:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id r16so12294711edq.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D6rwdQuzbBcUxWZZncZROX4Ah+5TrThN6WKgdQvRsUg=;
        b=b/mSLrdTRVfqDHj/9HRQk6yODFEMhxukqsa5TEjnJ8pBk1dfaU/98Hi6hazOtWIA86
         o3h3/ZNr5K44XmOQjQItE2Cq4ntvGpkeN6wo/zE3Kp1pY6E9bezDS288HttHeyy+bmq5
         i7T2SU+VOxiWTa+n1KKCA708WbDO5DxllE7IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6rwdQuzbBcUxWZZncZROX4Ah+5TrThN6WKgdQvRsUg=;
        b=FxApsiEsRXxPIuE7nMIHlVbssVMMKZbKvXIsxHzP5gbsVTNUqI3F41J9pJs+i7YV95
         QOlE7nK6oK9hP4hXFaOdktUq7Q6LDLXbjnOd+sNVl9JmWDO9XppLsGZzmamtULVRMETr
         S+uRHKLfqDoEFN2oHy5yTQBgg1beSBs7Fvbki3wgwbcyCHrFgLx4rNdcrJPhQKadGxOq
         Pw+gh7GoDfqKpfBMuvcwlXE95/mRgZ8LiUlus8W5baiKoncRN2VweXBfxFqRJvwO2Qwi
         xTCv6aQUWI0MY05rU8oMknYDUJMIGqzDJ1X3xfm8aeFOxRe5L+alpiU+QgykkoDeIrNt
         4M+w==
X-Gm-Message-State: APjAAAX5f7XU79AlwE58WzZPcXRLt2Q72H6Qol8sG7C0MZKNFlVWqeyR
        /NQlz1vHCZp/6JfL3F5DQr5IjGBevZZ4x+uL+ZlXwg==
X-Google-Smtp-Source: APXvYqxT03JoqR8yFbNYvQcmos/qzoG9ldT3lGu/A5dOxkFAfQOe0H0A36nW4H/RBLKLALaHHV15NkPuFkfhob5+vhI=
X-Received: by 2002:a50:95a3:: with SMTP id w32mr26171562eda.211.1569943819124;
 Tue, 01 Oct 2019 08:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <1db9d050-7ccd-0576-7710-156f22517025@fortanix.com>
In-Reply-To: <1db9d050-7ccd-0576-7710-156f22517025@fortanix.com>
From:   Roopa Prabhu <roopa@cumulusnetworks.com>
Date:   Tue, 1 Oct 2019 08:30:08 -0700
Message-ID: <CAJieiUgo8mr6+WTiVK_nneqbTP02hJR0yomjXSgf-0K3+hV+EA@mail.gmail.com>
Subject: Re: [RFC PATCH] Don't copy mark from encapsulated packet when routing VXLAN
To:     Jethro Beekman <jethro@fortanix.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Petr Machata <petrm@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Litao jiao <jiaolitao@raisecom.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 11:27 PM Jethro Beekman <jethro@fortanix.com> wrote:
>
> When using rule-based routing to send traffic via VXLAN, a routing
> loop may occur. Say you have the following routing setup:
>
> ip rule add from all fwmark 0x2/0x2 lookup 2
> ip route add table 2 default via 10.244.2.0 dev vxlan1 onlink
>
> The intention is to route packets with mark 2 through VXLAN, and
> this works fine. However, the current vxlan code copies the mark
> to the encapsulated packet. Immediately after egress on the VXLAN
> interface, the encapsulated packet is routed, with no opportunity
> to mangle the encapsulated packet. The mark is copied from the
> inner packet to the outer packet, and the same routing rule and
> table shown above will apply, resulting in ELOOP.
>
> This patch simply doesn't copy the mark from the encapsulated packet.
> I don't intend this code to land as is, but I want to start a
> discussion on how to make separate routing of VXLAN inner and
> encapsulated traffic easier.

yeah, i think the patch as is will break users who use mark to
influence the underlay route lookup.
When you say the mark is copied into the packet, what exactly are you
seeing and where is the copy happening ?



>
> Signed-off-by: Jethro Beekman <jethro@fortanix.com>
> ---
>  drivers/net/vxlan.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
> index 3d9bcc9..f9ed1b7 100644
> --- a/drivers/net/vxlan.c
> +++ b/drivers/net/vxlan.c
> @@ -2236,7 +2236,6 @@ static struct rtable *vxlan_get_route(struct vxlan_dev *vxlan, struct net_device
>         memset(&fl4, 0, sizeof(fl4));
>         fl4.flowi4_oif = oif;
>         fl4.flowi4_tos = RT_TOS(tos);
> -       fl4.flowi4_mark = skb->mark;
>         fl4.flowi4_proto = IPPROTO_UDP;
>         fl4.daddr = daddr;
>         fl4.saddr = *saddr;
> @@ -2294,7 +2293,6 @@ static struct dst_entry *vxlan6_get_route(struct vxlan_dev *vxlan,
>         fl6.daddr = *daddr;
>         fl6.saddr = *saddr;
>         fl6.flowlabel = ip6_make_flowinfo(RT_TOS(tos), label);
> -       fl6.flowi6_mark = skb->mark;
>         fl6.flowi6_proto = IPPROTO_UDP;
>         fl6.fl6_dport = dport;
>         fl6.fl6_sport = sport;
> --
> 2.7.4
>
>
