Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFDDC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45964216C8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfGZOgi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:36:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40959 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfGZOgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:36:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id m8so18100683lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 07:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ESrjKMJPqUK9pinmPi7bcie4M3UhRDC8HVVE4OSwOk8=;
        b=WMT9WU8oLxRw6kIAX7I+JAyy5PsEp5qCpKgAY+sxMtmPjhkKZcyfAykczz7TPq09Ie
         zo9CVy+2ZcXqE3haWdNt/3K7M/zPXYaIxrrLLLIPyWW1ivpTLPs74HHuc9/N9PQBEtpv
         frJEwAf4jXBV13lR9lt6sOkR5jMwtBXXsbw0Z/KiG8LbEFs38YN2yzTEtihucg/S4Ed9
         VRiyI7FJ94XCw4hqm6syp+D2r1Fimjz0q93/bxnFDQh0ItiERdH0INrpfxlLGQK3wiQQ
         XVc09nswV48LqoNMp3uAosJGT88Lp6joxFxW9NJccIvdXa6VE/RvLwRG7lwbhDxqRH3D
         A1DQ==
X-Gm-Message-State: APjAAAV3cO7H7onKqTb+vC8jl7DLn2SPbNh7hkCPw/CIQDf0e6vzYUh2
        PByE5oYF3+NZdYAFN8HzqvHk+Ct6hoczqqvHu130wA==
X-Google-Smtp-Source: APXvYqxGabCoWIrfGSKoR5ai3Kt1u7OzRh9if17wFc8MUP8mbfI1gzaVQkmeiAhee7824imVd7L8ZqoB3bPUr44To2Q=
X-Received: by 2002:a2e:8756:: with SMTP id q22mr50549544ljj.108.1564151795781;
 Fri, 26 Jul 2019 07:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190725231546.23878-1-mcroce@redhat.com> <20190726125715.GB5031@kwain>
In-Reply-To: <20190726125715.GB5031@kwain>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Fri, 26 Jul 2019 16:35:59 +0200
Message-ID: <CAGnkfhy_h_UfoefRmBjQgUgiX+954fQjX2kqa2hPLbKpLHU4rg@mail.gmail.com>
Subject: Re: [PATCH net-next] mvpp2: document HW checksum behaviour
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     netdev <netdev@vger.kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 2:57 PM Antoine Tenart
<antoine.tenart@bootlin.com> wrote:
>
> Hi Matteo,
>
> On Fri, Jul 26, 2019 at 01:15:46AM +0200, Matteo Croce wrote:
> > The hardware can only offload checksum calculation on first port due to
> > the Tx FIFO size limitation. Document this in a comment.
> >
> > Fixes: 576193f2d579 ("net: mvpp2: jumbo frames support")
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
>
> Looks good. Please note there's a similar code path in the probe. You
> could also add a comment there (or move this check/comment in a common
> place).
>
> Thanks!
> Antoine
>
> > ---
> >  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > index d8e5241097a9..2f7286bd203b 100644
> > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > @@ -843,7 +843,10 @@ static int mvpp2_bm_update_mtu(struct net_device *dev, int mtu)
> >               /* Add port to new short & long pool */
> >               mvpp2_swf_bm_pool_init(port);
> >
> > -             /* Update L4 checksum when jumbo enable/disable on port */
> > +             /* Update L4 checksum when jumbo enable/disable on port.
> > +              * Only port 0 supports hardware checksum offload due to
> > +              * the Tx FIFO size limitation.
> > +              */
> >               if (new_long_pool == MVPP2_BM_JUMBO && port->id != 0) {
> >                       dev->features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
> >                       dev->hw_features &= ~(NETIF_F_IP_CSUM |
> > --
> > 2.21.0
> >
>
> --
> Antoine Ténart, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

I see, there is a similar statement in mvpp2_port_probe().
What about adding a static function which sets the flag, and add the
comment there instead of duplicating the comment?

-- 
Matteo Croce
per aspera ad upstream
