Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9C3C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 09:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EE12086A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 09:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552210480;
	bh=60ewPDAia41NIVV42sNmPJUuJc/qziXF9U6SoUmDdTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hr7SJ9r5mQhHIsYkrNX4el2uxtdMt+dOYUg+rsgL4aU1pqC+prhX4kTVxkZDbk7Lg
	 JXnOvPpW1lkTdRGxDnF2wSaMn58uJYZ8XZdHMAySyv4joq24CxL+JzjFSupReKmdeE
	 2iDslRokCdiAAdKords5Mh3rGAwtLS8wFS4zBmfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfCJJej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 05:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfCJJej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 05:34:39 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53F6F206BA;
        Sun, 10 Mar 2019 09:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552210478;
        bh=60ewPDAia41NIVV42sNmPJUuJc/qziXF9U6SoUmDdTM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EAd9rmPW0pXEvGTtGDCUyp5RO4BlliJmnscRWz3H3ZIGFxajd4UmK4zDVxGEsgLCI
         r13GqYkK3cJQnt53hZOlQ/JOmh2H8y0o+IJFORwTNyCY2Etr3R7z0bWn4l2CZJ9G14
         Rh7O631u1vQt+kNHKNcmQpklMzl70Xs8/VPfCEXQ=
Date:   Sun, 10 Mar 2019 09:34:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH v2] iio: proximity: as3935: fix use-after-free on device
 remove
Message-ID: <20190310093432.7751f45d@archlinux>
In-Reply-To: <CAGngYiW9h1d1uHKTKE08OR+V-gBB0qxKE=kmo9NriC=FJddUGA@mail.gmail.com>
References: <20190308175935.21904-1-TheSven73@gmail.com>
        <20190308202936.GA32641@arch>
        <CAGngYiVgEDTQxynjPDMO_ZApAX6uyvUL+iqyK-QHnhDz=E4eCw@mail.gmail.com>
        <20190308223249.GC32641@arch>
        <CAGngYiWSaJqtzUA+nUNJTcssUq1Y=UzYc2u8hDcKDjF6944o1Q@mail.gmail.com>
        <20190309102427.GA3565@arch>
        <CAGngYiW9h1d1uHKTKE08OR+V-gBB0qxKE=kmo9NriC=FJddUGA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Mar 2019 08:03:44 -0500
Sven Van Asbroeck <thesven73@gmail.com> wrote:

> On Sat, Mar 9, 2019 at 5:24 AM Tomasz Duszynski <tduszyns@gmail.com> wrote:
> >
> > What I meant is that delayed work initialization could stay where it was.
> > The reason you moved it is readability improvement so to me it is more
> > of a cleanup hence I suggested a separate patch. Up to you.  
> 
> Ah, I see what you mean now.
> 
> I'm ok with splitting this up, but we should probably ask the maintainer
> (Jonathan) what he prefers, because he's the one who will have to take
> two small patches instead of one. And the second patch is a one-liner.

I don't mind either way (definitely a marginal case!) but as we have
this one and the alignment tidy up is trivial...

Applied with the alignment tweaked to the togreg branch of iio.git
and pushed out as testing.

I'm not taking this the fast way or proposing it for stable as
whilst the race is there, I don't think anyone has actually managed
to trigger it.

Thanks,

Jonathan
