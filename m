Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50593C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2153720715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+r91EgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfKVPdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:33:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44688 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726613AbfKVPdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574436815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5C12GgcTY0zhHvfc5alR7dZZkdq889gwCFU8mlBSBN0=;
        b=e+r91EgLsnE8dES1A918tQZFb8pidD775P96hJm0pGH/o43EglGLIVJzM0venTGlDwomYR
        1vu87NZSGDAFd6/fhOCLyuMOW69gpvcmLpN9iQZgEoIWksv5CoxEvky+S5II8LeGsNoJ+c
        Ph5oBYrODsd8JAUfsDhuPGSR1/TjHT4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-zsyS7aZQNW-DNpIhGG_4iA-1; Fri, 22 Nov 2019 10:33:34 -0500
Received: by mail-lj1-f197.google.com with SMTP id l12so1424070lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 07:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65btR7z2BlqMjeqEbWLXwPhueWcbk0tpVSyBBjhkef0=;
        b=SlWIPSmSSy32boTnI38lh6sX34KZAmeO+Do7yOkAnuVy9FzRzt3KVX0VOyjrg4+eOT
         o6Vq8W8M28E9eVKSCvHabb0ln1hLFr8zew3YJEczjAU5U8qWCYTtaaEUlJPZ/aP9R6xn
         YcgK5GobeHeBfD18jWgkA6wYZrW93rrqW6OFbor0Tn5ylvAoEtjsvkfjE79saB88ErGr
         mDmCPdvcNjDs0Rjk6SiRXCLVQCYws4FlReBMdp5NVFw/sj5WCMNx6TXOfYaBRCEfWQ4i
         z/537/bhr26ODHVpTcz5FqbSnnz0T49i1bI0pY6zHIF8XjmXPM59Ao7//tMfJn/1idia
         BfTA==
X-Gm-Message-State: APjAAAVvIZOcgikxO6A+0nELv+yVkhWDusZH/Qknj3rLv9fGBYpWUbdQ
        aGluhlnonHg6AGCwTY0sG0ZHqdqj+ohN7Jr0cLQsh7cyHW0W+u7I3EGTgbd+iiU5CUfm57O4WLV
        2V5Wv7cFY5babuhU6w6Iadbbjhk0bSv/pXPNe4UJG
X-Received: by 2002:ac2:5195:: with SMTP id u21mr12330492lfi.97.1574436812303;
        Fri, 22 Nov 2019 07:33:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqz3o47+GO92mLSjMespumwenCR2b8vMAGBEZt21DgLIiaEN7EjAjwJGJwC3a4ScJYZfeHcAn/WVPWoIlz3oOU0=
X-Received: by 2002:ac2:5195:: with SMTP id u21mr12330485lfi.97.1574436812053;
 Fri, 22 Nov 2019 07:33:32 -0800 (PST)
MIME-Version: 1.0
References: <20191112102518.4406-1-mcroce@redhat.com> <20191112150046.2aehmeoq7ri6duwo@netronome.com>
 <CAGnkfhyt7wV-qDODQL1DtDoW0anoehVX7zoVk8y_C4WB0tMuUw@mail.gmail.com> <20191118161951.GF3988@ovn.org>
In-Reply-To: <20191118161951.GF3988@ovn.org>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Fri, 22 Nov 2019 16:32:55 +0100
Message-ID: <CAGnkfhz-KbSMCw3rUG3u4fZkzr3pz2qL4Vjd6zjLsmcTHN0J_Q@mail.gmail.com>
Subject: Re: [ovs-dev] [PATCH net-next] openvswitch: add TTL decrement action
To:     Ben Pfaff <blp@ovn.org>
Cc:     Simon Horman <simon.horman@netronome.com>, dev@openvswitch.org,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bindiya Kurle <bindiyakurle@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
X-MC-Unique: zsyS7aZQNW-DNpIhGG_4iA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 5:20 PM Ben Pfaff <blp@ovn.org> wrote:
>
> On Tue, Nov 12, 2019 at 04:46:12PM +0100, Matteo Croce wrote:
> > On Tue, Nov 12, 2019 at 4:00 PM Simon Horman <simon.horman@netronome.co=
m> wrote:
> > >
> > > On Tue, Nov 12, 2019 at 11:25:18AM +0100, Matteo Croce wrote:
> > > > New action to decrement TTL instead of setting it to a fixed value.
> > > > This action will decrement the TTL and, in case of expired TTL, sen=
d the
> > > > packet to userspace via output_userspace() to take care of it.
> > > >
> > > > Supports both IPv4 and IPv6 via the ttl and hop_limit fields, respe=
ctively.
> > > >
> > >
> > > Usually OVS achieves this behaviour by matching on the TTL and
> > > setting it to the desired value, pre-calculated as TTL -1.
> > > With that in mind could you explain the motivation for this
> > > change?
> > >
> >
> > Hi,
> >
> > the problem is that OVS creates a flow for each ttl it see. I can let
> > vswitchd create 255 flows with like this:
> >
> > $ for i in {2..255}; do ping 192.168.0.2 -t $i -c1 -w1 &>/dev/null & do=
ne
> > $ ovs-dpctl dump-flows |fgrep -c 'set(ipv4(ttl'
> > 255
>
> Sure, you can easily invent a situation.  In real traffic there's not
> usually such a variety of TTLs for a flow that matches on the number of
> fields that OVS usually needs to match.  Do you see a real problem given
> actual traffic in practice?
>

Hi Ben,

yes, my situation was a bit artificious, but you can get a similar
situation in practice.

Imagine a router with some subnetworks behind it on N levels, with
some nodes hosting virtual machines.
Windows and Linux have different default TTL values, 128 and 64
respectively, so you could see N*2 different TTL values.

Bye,



--
Matteo Croce
per aspera ad upstream

