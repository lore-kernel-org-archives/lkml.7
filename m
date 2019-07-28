Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE301C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 14:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44EE2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 14:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfG1Oat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 10:30:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42261 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfG1Oas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 10:30:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so9153219wrr.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 07:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=vb4NbrtSRUsf3dQV3XWshgt1WA+5yX1CPQ8KnsegmM4=;
        b=r5TR4oFNj9LxfFyn7cZQ+cO02fToZpqqt3gcfr4FPAAf7EHQLvAT96y6blWdOFKOK3
         U5ocRuAs9ufyUliqV/o1Dg8CdY5Gy4JucHsL+AEBASYprgl/U11vchqduqrVhmskp9Og
         lg7o0WJjfcae5dcB+ZrktxLrfQoBuGIkr9nv7glFR8wd7qvLlxeO887RjS6MCernKCUl
         aSFlyeLcWMfQ8/FYwIOJcU4WlpeUQsIHADTXTwZ3B+cK/Jpx4lVzCtMpF2aaCsA6RFF5
         hTMOne5WS87bqe4OMBhAJ4TVVpjjy/RKkq/WJ8Bmmw/JXMePXMEXDEeFll6yF7mmAD22
         6i4Q==
X-Gm-Message-State: APjAAAXTOwLwWzFEunpuLHJqN2d7bZ/8UERga02V7lzUaoHZYtKMCSSY
        BpVEF1dtlybmsp195JyKGQTHsw==
X-Google-Smtp-Source: APXvYqycovQTEB5crW1+IiqAx5VXBFu8X1UipcJ29XYvHP1S4X7c4NyZV6okQiWUA/OQytX6kW7sPw==
X-Received: by 2002:adf:f104:: with SMTP id r4mr23609017wro.140.1564324246508;
        Sun, 28 Jul 2019 07:30:46 -0700 (PDT)
Received: from mcroce-redhat (host221-208-dynamic.27-79-r.retail.telecomitalia.it. [79.27.208.221])
        by smtp.gmail.com with ESMTPSA id p14sm47735455wrx.17.2019.07.28.07.30.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 07:30:46 -0700 (PDT)
Date:   Sun, 28 Jul 2019 16:30:40 +0200
From:   Matteo Croce <mcroce@redhat.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next] mvpp2: document HW checksum behaviour
Message-ID: <CAGnkfhz+PezeLT+gyXdsnyJz2dnKpYkcb2HbqvXJoLdzNxuC6g@mail.gmail.com>
In-Reply-To: <CAGnkfhycOc8mvqeQDBcnXueUjrFQMC7hdfAOkxr5k0+xc_tnDw@mail.gmail.com>
References: <20190725231546.23878-1-mcroce@redhat.com>
 <20190726125715.GB5031@kwain>
 <CAGnkfhycOc8mvqeQDBcnXueUjrFQMC7hdfAOkxr5k0+xc_tnDw@mail.gmail.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 3:36 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> On Fri, Jul 26, 2019 at 2:57 PM Antoine Tenart
> <antoine.tenart@bootlin.com> wrote:
> >
> > Hi Matteo,
> >
> > On Fri, Jul 26, 2019 at 01:15:46AM +0200, Matteo Croce wrote:
> > > The hardware can only offload checksum calculation on first port
> > > due to the Tx FIFO size limitation. Document this in a comment.
> > >
> > > Fixes: 576193f2d579 ("net: mvpp2: jumbo frames support")
> > > Signed-off-by: Matteo Croce <mcroce@redhat.com>
> >
> > Looks good. Please note there's a similar code path in the probe.
> > You could also add a comment there (or move this check/comment in a
> > common place).
> >
> > Thanks!
> > Antoine
> >
>
> Hi Antoine,
>
> I was making a v2, when I looked at the mvpp2_port_probe() which does:
>
> --------------------------------%<------------------------------
> features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
> NETIF_F_TSO;
>
> if (port->pool_long->id == MVPP2_BM_JUMBO && port->id != 0) {
>     dev->features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
>     dev->hw_features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
> }
>
> dev->vlan_features |= features;
> -------------------------------->%------------------------------
>
> Is it ok to remove NETIF_F_IP*_CSUM from dev->features and
> dev->hw_features but keep it in dev->vlan_features?
>
> Regards,
> --
> Matteo Croce
> per aspera ad upstream

Hi all,

probably dev->vlan_features is safe to keep the CSUM features to avoid
unnecessary calculation in some cases, but I have another question.
Does the PP2 hardware support checksumming within any offset? I
replaced 'NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM' with NETIF_F_HW_CSUM and
then stacked 5 VxLANS on top of a mvpp2 device, to have the last IP
header at offset 264:

ip link set $dev up
ip addr add 192.168.0.$last/24 dev $dev

for i in {1..5}; do
	ip link add vx$i type vxlan id $i dstport 4789 remote 192.168.$((i-1)).$other
	ip link set vx$i up
	ip addr add 192.168.$i.$last/24 dev vx$i
done

00:51:82:11:22:00 > 3c:fd:fe:9c:60:6c, ethertype IPv4 (0x0800), length 348: 192.168.0.1.33625 > 192.168.0.2.4789: VXLAN, flags [I] (0x08), vni 1
02:25:60:da:87:03 > 92:20:05:45:3d:d3, ethertype IPv4 (0x0800), length 298: 192.168.1.1.33625 > 192.168.1.2.4789: VXLAN, flags [I] (0x08), vni 2
12:20:97:15:8f:aa > 66:08:23:c7:72:ea, ethertype IPv4 (0x0800), length 248: 192.168.2.1.33625 > 192.168.2.2.4789: VXLAN, flags [I] (0x08), vni 3
c6:1c:b9:fd:9d:28 > 22:ca:cb:6a:ea:68, ethertype IPv4 (0x0800), length 198: 192.168.3.1.33625 > 192.168.3.2.4789: VXLAN, flags [I] (0x08), vni 4
02:34:5f:45:a5:9d > d2:4e:d4:d7:42:31, ethertype IPv4 (0x0800), length 148: 192.168.4.1.34504 > 192.168.4.2.4789: VXLAN, flags [I] (0x08), vni 5
a2:99:fd:9c:1b:05 > 5a:81:3b:fc:6a:07, ethertype IPv4 (0x0800), length 98: 192.168.5.1 > 192.168.5.2: ICMP echo request, id 1654, seq 156, length 64

It seems that the HW is capable of doing it, can someone with a
datasheet confirm this?

Regards,
-- 
Matteo Croce
per aspera ad upstream
