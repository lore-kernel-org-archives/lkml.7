Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CFBC41514
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 00:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24D720651
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 00:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j45DEIZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfHMAEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 20:04:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42603 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfHMAEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 20:04:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id j7so21080194ota.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 17:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hzo1eKAep9i0qhpDX70sNk2Pbj0GpjM4DfNd2KKwDRI=;
        b=j45DEIZLaaEgSfO1vni8mgZGeUXMdlD5ryIBWBskCuBYx967JbbQX15YUx5aqqBDD/
         uyhJ8ngOhyD8KvmZhhQPXftKLeBo4n9gaZICSkgymDrP/NleClGKrg1NWFhkCEiDBTXE
         beDhJvg0sreyQ5624oebkio+3GkaOQbJ4Xn0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hzo1eKAep9i0qhpDX70sNk2Pbj0GpjM4DfNd2KKwDRI=;
        b=XhtGTF0MzGN+smKVqD4wNFm6nv1Ir2ogtnpNgQuCeMLhLukmODnaJZlzOIWMF0aq5M
         8hC5FSjevxrCVX3+bHzwz0/9LxKVAz3Tp/Ag4662g6X2z8xGsm5uDrVdzvo+Y2QUB0Jm
         HXazHPkR3tVvZsgfIYVw8cXCsjAqN+cZXfW1yejGvvNmb/Gj9DCCH5i+WE+F5PrtNI3B
         EbjG0Uq4OAbxH7WsmRVGWa1HKclTXhJl+A0Svt2bv1T8av/I4LVbIEfWzLBH+tiPrtSA
         nXs4jbfn8X7tyoq7Z9RzOJ1P2xt9hhS4AtXXgmxQCLZ7ylpjyDAhbUiuYrk0b3L2jJBK
         aAWg==
X-Gm-Message-State: APjAAAWAlmXEYVA+BYfqsD3Z/+DZFVvZANDFE+1SpLvJnJr9emnTqsgB
        aNy+bvlOagcjv411jyhBqkb075bUV6c=
X-Google-Smtp-Source: APXvYqyo8MfTr3qyGOxTAyKMbikeM6CRZ8qzQqfu1ESVrY+d+kgQrI+C7UCeCuUH7VHgsw9hsxnSIg==
X-Received: by 2002:a05:6830:120e:: with SMTP id r14mr21449450otp.4.1565654648477;
        Mon, 12 Aug 2019 17:04:08 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id q5sm35538220oih.2.2019.08.12.17.04.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 17:04:08 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id e12so21569178otp.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 17:04:07 -0700 (PDT)
X-Received: by 2002:a6b:e013:: with SMTP id z19mr10853986iog.141.1565654647521;
 Mon, 12 Aug 2019 17:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190805124935.819068648@linuxfoundation.org> <20190805124936.173376284@linuxfoundation.org>
 <20190805144723.GC24265@amd>
In-Reply-To: <20190805144723.GC24265@amd>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 12 Aug 2019 17:04:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vcdq+Z8NQdQrweT0LhzvBiWEd4GQ=QLDEQyGL2=b6r_Q@mail.gmail.com>
Message-ID: <CAD=FV=Vcdq+Z8NQdQrweT0LhzvBiWEd4GQ=QLDEQyGL2=b6r_Q@mail.gmail.com>
Subject: Re: [PATCH 4.19 04/74] ARM: dts: rockchip: Mark that the rk3288 timer
 might stop in suspend
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 5, 2019 at 7:47 AM Pavel Machek <pavel@denx.de> wrote:
>
> On Mon 2019-08-05 15:02:17, Greg Kroah-Hartman wrote:
> > [ Upstream commit 8ef1ba39a9fa53d2205e633bc9b21840a275908e ]
> >
> > This is similar to commit e6186820a745 ("arm64: dts: rockchip: Arch
> > counter doesn't tick in system suspend").  Specifically on the rk3288
> > it can be seen that the timer stops ticking in suspend if we end up
> > running through the "osc_disable" path in rk3288_slp_mode_set().  In
> > that path the 24 MHz clock will turn off and the timer stops.
> >
> > To test this, I ran this on a Chrome OS filesystem:
> >   before=$(date); \
> >   suspend_stress_test -c1 --suspend_min=30 --suspend_max=31; \
> >   echo ${before}; date
> >
> > ...and I found that unless I plug in a device that requests USB wakeup
> > to be active that the two calls to "date" would show that fewer than
> > 30 seconds passed.
> >
> > NOTE: deep suspend (where the 24 MHz clock gets disabled) isn't
> > supported yet on upstream Linux so this was tested on a downstream
> > kernel.
>
> I guess this does no harm, but deep sleep is unlikely to be suppored
> in the stable kernels, so ... is it good idea there?

People do merge stable kernels into local trees which have extra
patches (which might enable deep sleep).  Chrome OS is an example of
this.  If the patch does no harm then merging it seems nice.

That being said: we already have this in the Chrome OS tree, so unless
someone else is also mering stable into their tree and trying to
support rk3288 with deep sleep, this patch is unlikely to matter.
...so if everyone doesn't want it then it won't bother me.

-Doug
