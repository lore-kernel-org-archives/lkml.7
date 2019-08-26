Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CAFC3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 01:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC2320815
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 01:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qEUlffBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfHZB4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 21:56:55 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:22272 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfHZB4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 21:56:55 -0400
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x7Q1uoqm018930
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 10:56:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x7Q1uoqm018930
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566784611;
        bh=Xw+wxYvXUGE3fRV+Doiiivavq+mUL1vvPgjRzYtJ358=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qEUlffBnvbyTRi4uQhlTUH+vofgwb9EaW33590XA9MrcgGTzxogl/oHgBozFk3o+y
         dDlDvn619VpEhOGIcZgbOvezBV8e15WgO5j2bPZ28u3/T/xFnG5AOVo5mk810x4yEM
         hPG3ps/8mTkGsS7Ausrg+7oLoD7S3YiOiXO29Td/QYtpKKwu+Fhng5kKhl2oZkwM4/
         iRmVXEldM/JCjJ6jK5WNJnJvlxl15g04T9dnVvHJx23jf8JpaPIChkW9rW3jLhmaqd
         J1gED6X+yT42OJUiAqwnDzEYTGFglAWCWfTMtLWmwVP/gFZuJtP31z/wrkRKZiYIg7
         QgLFwkXGrp+gA==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id y7so5179222uae.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 18:56:51 -0700 (PDT)
X-Gm-Message-State: APjAAAUE+TLfuN11oCZIqzhNwSbxxJUlv4nvSBqGD5pbsqvnlPQ3ICeg
        PpKWf01ZZQ7YlsYEM8AsUk9UeCY35knmhq9Bgn8=
X-Google-Smtp-Source: APXvYqzdRMKAVamOOE+1e4sp/Bzd54Y2ifvgVrHPozgaBDgPJcD9G9g8zSB4pXJdG2r6CZRzYRRos2G+z4U8cxBoK20=
X-Received: by 2002:ab0:4261:: with SMTP id i88mr7473666uai.95.1566784610044;
 Sun, 25 Aug 2019 18:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190506223334.1834-1-nicoleotsuka@gmail.com> <20190506223334.1834-3-nicoleotsuka@gmail.com>
 <CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com> <20190823221103.GA3604@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190823221103.GA3604@Asurada-Nvidia.nvidia.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 26 Aug 2019 10:56:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNARrCviBr5j=2Lridh+MfbN1CFPU51cbpKDxNG6XKeQgdw@mail.gmail.com>
Message-ID: <CAK7LNARrCviBr5j=2Lridh+MfbN1CFPU51cbpKDxNG6XKeQgdw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dma-contiguous: Use fallback alloc_pages for
 single pages
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>, vdumpa@nvidia.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thierry Reding <treding@nvidia.com>,
        Kees Cook <keescook@chromium.org>, iamjoonsoo.kim@lge.com,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On Sat, Aug 24, 2019 at 7:10 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Fri, Aug 23, 2019 at 09:49:46PM +0900, Masahiro Yamada wrote:

> >
> > Reverting this commit fixed the problem.
>
> We are having another problem with the new API and Christoph
> submitted a patch at: https://lkml.org/lkml/2019/8/20/86
>
> Would it be possible for you to test to see if it can fix?


It is included in 5.3-rc6

I tested 5.3-rc6 in on my board,
but I still see the same DMA fauilure.


Masahiro





> We can revert my fallback change after all, if Christoph's
> patch doesn't work for you either.
>
> Thanks
> Nicolin



-- 
Best Regards
Masahiro Yamada
