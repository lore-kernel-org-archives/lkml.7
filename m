Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1885BC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B1420675
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvZhAP0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfDZPME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:12:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38017 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDZPMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:12:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id k16so4930727wrn.5;
        Fri, 26 Apr 2019 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nengbmf3UFk38kNbsyQCXFn/Euh41z9D/p91cPTSh9s=;
        b=QvZhAP0L8uPCMODvHLnDOxAmvvvyyT///lljFr82OO8xiA71ZrI1ycBc6ghcC3enCP
         OU/+oIvaLQ4rsAUY2rZYahxDXkryOLwjGa8iZGD4mH4CHA3AgGAQpn28u7x5+MCnXxq7
         6U1BeMF9NOPG3AnFtmBWhish1qjuM2JO7rdXydfgYvw5X56q2VLLeoW18qQWcCIqhxRG
         5vLVFsxgor+9ZHKLuSeL08oPf+sXA0Jn+9YetqsLnN34lMLnw1kHpvojG64tHZvmu3vS
         Be7WIkyL1vI1SzfldF0v/buSxisq7zH2qU1EictruPzGtjojRW5SMxJoEGg0khZ50XWZ
         yoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nengbmf3UFk38kNbsyQCXFn/Euh41z9D/p91cPTSh9s=;
        b=PmqUSv9z7b+u/tPZp54KZdl8ogv5vofvVI2ewF1jW9TPMVyzshK9VFE/ukBVkitm0E
         ncASzkPmx+tCFaI7EJF71V9CgTw3HqI9khbP81Xhj8mltFs0Nq7WoEatm09Qu0ZYQawk
         yFYqQK/cuT4xsJqAbCKtvBYGiE1XjvrAhyKiLTmCmjVh8nc6tBdWwafDt5tbgo0le9Lw
         L29AJvaA0IRTmmIHFu8Ygr4Fhs1vLJjalSaYPIdPBge9jCLJLrgIMvijI+/fXV5opMY4
         M4LCaBnsnkT+BuIqGa/HU9thS9LttDgNbajDYFBqBPooqhWsoWuTE6rZNNQ19lSfPA9K
         l9jA==
X-Gm-Message-State: APjAAAXzfKIC5aSBUqzitF1w0e6LWa/hajMzpxu30a/QV9NYHk6G3a9W
        Yy7Ohyg5C7hSSe2GkTnApqE=
X-Google-Smtp-Source: APXvYqyNRiQRHDX+ueVjz0egUi5DSR7myygxrsTl2khl3w3aSeiN66nNYiGQIth/wFSuEyHu+PHBYg==
X-Received: by 2002:adf:f984:: with SMTP id f4mr12346554wrr.97.1556291520176;
        Fri, 26 Apr 2019 08:12:00 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id o16sm8103841wro.63.2019.04.26.08.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 08:11:58 -0700 (PDT)
Date:   Fri, 26 Apr 2019 17:11:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: tegra: Use relaxed versions of readl/writel
Message-ID: <20190426151157.GA19559@ulmo>
References: <20190424231708.21219-1-digetx@gmail.com>
 <d789f1bc-44d1-abf6-a046-7cf835416e8f@nvidia.com>
 <4a315b63-bc71-3c3e-f1ae-8638bcf4033d@gmail.com>
 <bff59709-426b-32d2-08eb-d8f51cd7d5c1@nvidia.com>
 <49392c02-6dcc-9a95-0035-27c4c0d14820@gmail.com>
 <242863b9-b75e-4b37-178a-5aa03e56d3e1@gmail.com>
 <d6d1e420-6707-f446-a531-4b38e4e82c19@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <d6d1e420-6707-f446-a531-4b38e4e82c19@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2019 at 04:03:08PM +0300, Dmitry Osipenko wrote:
> 26.04.2019 15:42, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > 26.04.2019 15:18, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> 26.04.2019 14:13, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>
> >>> On 26/04/2019 11:45, Dmitry Osipenko wrote:
> >>>> 26.04.2019 12:52, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>>
> >>>>> On 25/04/2019 00:17, Dmitry Osipenko wrote:
> >>>>>> The readl/writel functions are inserting memory barrier in order to
> >>>>>> ensure that memory stores are completed. On Tegra20 and Tegra30 th=
is
> >>>>>> results in L2 cache syncing which isn't a cheapest operation. The
> >>>>>> tegra20-apb-dma driver doesn't need to synchronize generic memory
> >>>>>> accesses, hence use the relaxed versions of the functions.
> >>>>>
> >>>>> Do you mean device-io accesses here as this is not generic memory?
> >>>>
> >>>> Yes. The IOMEM accesses within are always ordered and uncached, while
> >>>> generic memory accesses are out-of-order and cached.
> >>>>
> >>>>> Although there may not be any issues with this change, I think I ne=
ed a
> >>>>> bit more convincing that we should do this given that we have had it
> >>>>> this way for sometime and I would not like to see us introduce any
> >>>>> regressions as this point without being 100% certain we would not.
> >>>>> Ideally, if I had some good extensive tests I could run to hammer t=
he
> >>>>> DMA for all configurations with different combinations of channels
> >>>>> running simultaneously then we could test this, but right now I don=
't :-(
> >>>>>
> >>>>> Have you ...
> >>>>> 1. Tested both cyclic and scatter-gather transfers?
> >>>>> 2. Stress tested simultaneous transfers with various different
> >>>>>    configurations?
> >>>>> 3. Quantified the actual performance benefit of this change so we c=
an
> >>>>>    understand how much of a performance boost this offers?
> >>>>
> >>>> Actually I found a case where this change causes a problem, I'm seei=
ng
> >>>> I2C transfer timeout for touchscreen and it breaks the touch input.
> >>>> Indeed, I haven't tested this patch very well.
> >>>>
> >>>> And the fix is this:
> >>>>
> >>>> @@ -1592,6 +1592,8 @@ static int tegra_dma_runtime_suspend(struct de=
vice
> >>>> *dev)
> >>>>  						  TEGRA_APBDMA_CHAN_WCOUNT);
> >>>>  	}
> >>>>
> >>>> +	dsb();
> >>>> +
> >>>>  	clk_disable_unprepare(tdma->dma_clk);
> >>>>
> >>>>  	return 0;
> >>>>
> >>>>
> >>>> Apparently the problem is that CLK/DMA (PPSB/APB) accesses are
> >>>> incoherent and CPU disables clock before writes are reaching DMA con=
troller.
> >>>>
> >>>> I'd say that cyclic and scatter-gather transfers are now tested. I a=
lso
> >>>> made some more testing of simultaneous transfers.
> >>>>
> >>>> Quantifying performance probably won't be easy to make as the DMA
> >>>> read/writes are not on any kind of code's hot-path.
> >>>
> >>> So why make the change?
> >>
> >> For consistency.
> >>
> >>>> Jon, are you still insisting about to drop this patch or you will be
> >>>> fine with the v2 that will have the dsb() in place?
> >>>
> >>> If we can't quantify the performance gain, then it is difficult to
> >>> justify the change. I would also be concerned if that is the only pla=
ce
> >>> we need an explicit dsb.
> >>
> >> Maybe it won't hurt to add dsb to the ISR as well. But okay, let's drop
> >> this patch for now.
> >>
> >=20
> > Jon, it occurred to me that there still should be a problem with the
> > writel() ordering in the driver because writel() ensures that memory
> > stores are completed *before* the write occurs and hence translates into
> > iowmb() + writel_relaxed() [0]. Thus the last write will always happen
> > asynchronously in regards to clk accesses.
> >=20
> > [0]
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/arch/arm/include/asm/io.h#n311
> >=20
>=20
> Also please note that iowmb() translates into wmb() if
> CONFIG_ARM_DMA_MEM_BUFFERABLE=3Dy and sometime ago I was profiling host1x
> driver job submission performance and have seen cases where wmb() could
> take up to 1ms on T20 due to L2 syncing if there are outstanding memory
> writes in the cache (or even more, I don't remember exactly already how
> bad it was..).

This looks to be primarily caused by the fact that we have the L2X0
cache on Tegra20. So there's not really anything that can be done there
without potentially compromising correctness of the code.

> Altogether, I think the usage of readl/writel in pretty much all of
> Tegra drivers is plainly wrong and explicit dsb() shall be used in
> places where hardware synchronization is really needed.

I don't think that's an accurate observation. readl()/writel() are more
likely to be correct than the relaxed versions. You already saw yourself
that using the relaxed versions can easily introduce regressions.

Granted, readl()/writel() might add more memory barriers than strictly
necessary, and therefore they might in many cases be suboptimal. But, we
can't just go and engage in a wholesale conversion of all drivers. If we
do this, we need to very carefully audit every conversion to make sure
no regressions are introduced. This is especially complicated because
these would be subtle regressions and may be difficult to catch or
reproduce.

Also, we should avoid using primitives such as dsb in driver code to
avoid making the code too architecture specific.

Thierry

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzDH7gACgkQ3SOs138+
s6HpnRAAjUPeSFI7eArckd1+6JlXTu4SPB/6GELz98p8ctW4W6BHpqk1ZHqvyHbl
sCwoX1Um4s76x8/1oLL1s8UNw5C6OWq3njvTCpUtzm1eWirJqRM5l7kHkx7tuYOW
ULprcxAOZteJ6ITnPoCBj8Cv5nNKvABsq9F414GFz1Z+njbct2Fn5f4qDYhHeAok
0pz54c3YQOjEZ3Uw+ZbvhjQ/xWUglWgWueyMva1NaxLdYRUcZLsZklSWCAzjdzjd
d6bTmce+sugsiSvLdjqRP0WHyfajyN9wXaAk7ObUtMgsQa/z0L/U78BZJuwo2JFv
be5zi2YR0y9Rqn2HZyAoscidOhLWUtVWLIM2GVLmLPuRLVGCOA/64ydOa7xg+VyL
gNoqxrObFOdWRHsa1V0XIvsPRPF5frMBGssvhOnBpQ4/vhlhzH2K3rnqXuZHHJav
Hf1dR2xkHSm1SxjzGnTHrPudE0wuyUxIHMAo1E3fdAnDpFPfZap3NAIfvAeTL/Dv
javlx0BCVo747GWtaCQ823bfCaXHt6MNoIq1aSg/xa7E5IAYbjgxTXAwyvYe1Qsn
NV8VNkHDqgzQ/HLTq8Zva1+0pB9ggPIVvyGVT+8t3qUXlYWBSn2LxssEK/rgsnxO
epl20LpkIxiAAo5q4bfQ7XDI4aj69q4550Y5LjQdEC+c12Yx40o=
=wlM+
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
