Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE484C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9E220663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csYbmlqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfHMIXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:23:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34379 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfHMIXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:23:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so49016934plt.1;
        Tue, 13 Aug 2019 01:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=stvogd1hkvJXZgKB6OLWaibDhlbVIThoBJwPFux4Mto=;
        b=csYbmlqBYBEZ0wo+pfsMfUVQxz+qxIomUn5IJJkfYIkRteILtiwvkfJ5KgtAgolKfj
         dTmRf7+7kNPKW5D12vAlPjC5UBhUcnByJGuXHBMiaU15rs3vdFAZNGP9OGd8rFYrt/TN
         c2jKPh8BGoFdGNOjUt3nPt11HgCJA/AMwWhSH3F2n0lLiFx7zHM04VTEWgCSiy2v6nvh
         BqlUlQTdh7JGSEIOpOrJJHK/9nVMlvsORaLEwnUpM2GbpmctOcpPD6cXNIwpPUapryqG
         fQq3+6AvZiCMT9IgtUiNCxZrWs2WaWzPQTKLGOJCtPGJoWiM2C5bGNE+aPnMamA2U0im
         qehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stvogd1hkvJXZgKB6OLWaibDhlbVIThoBJwPFux4Mto=;
        b=dJZJ419CteXCz2H6w5YGuKrNAeLklswOI6sbWlf4ZZSn0qwob47Qy/Oq9ys9nVSoO0
         hOE1cA0MUgnYpMTXYMC3qybNd8zA5Un1GfMrdjjlOJqYC42b0SkKesE9HyeifcrlM6m8
         wXwm0LZsF6sQw7vm2lbeTd5YkUtIJ9UaRbeI1/yJhamqJI06KTV+o4RGF1DUbaUqTiXW
         TXNxVJ1dq5LFA1IJ1EUEPtiBmrGXdROCM6Ze9tSOagAqrTJWtPLp6Dh1VqwCkXIzxLoS
         HWv/E1XrLlgb6V/opyFI3o0xt5RUGloikTlgbYmvO9Wr5NClcF6bllRjZCDa5DuUJ1dt
         fbFw==
X-Gm-Message-State: APjAAAVZp0QxybN8PZcD8r16qQUpYcpDN+WmMROdjPymZCL5ql3mQCkJ
        Enpu0oq+gzmeB66Z/Dyj+A3u5rS4zJI3AOxSFgs=
X-Google-Smtp-Source: APXvYqzV4aOqpDg5RTevHTInlk7N9+aOJl0HMiG38aQT8avNQkmUWiiBAbGJuiJTqjQrPn1S9id3aDivQM87fQCyJTE=
X-Received: by 2002:a17:902:9348:: with SMTP id g8mr3815480plp.18.1565684627093;
 Tue, 13 Aug 2019 01:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190809190130.30773-1-kai.heng.feng@canonical.com>
 <CAHp75VeGs8K+da+4CaqNjm_ci86KoLcmhY8GaJO7jm__J0TcSQ@mail.gmail.com>
 <93860D98-9CB7-4D3D-8917-E15591BD1EC4@canonical.com> <20190813061228.GH6670@kroah.com>
In-Reply-To: <20190813061228.GH6670@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 13 Aug 2019 11:23:35 +0300
Message-ID: <CAHp75VedrnJDOoJGuYJiFAx3ODGAMFx7nTKuoErNn3NWYSn_gA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] serial: 8250_pci: Add support for Sunix serial boards
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Morris Ku <morris_ku@sunix.com>,
        Debbie Liu <debbie_liu@sunix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 9:12 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Aug 13, 2019 at 12:36:40PM +0800, Kai-Heng Feng wrote:
> > at 21:18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Fri, Aug 9, 2019 at 10:05 PM Kai-Heng Feng
> > > <kai.heng.feng@canonical.com> wrote:

> > > Can you, please, split out the Sunix quirk driver to a separate module
> > > (see examples like: 8250_exar, 8250_lpss, 8250_mid)?
> > > And then with a fewer LOCs add a new boards.
> >
> > Greg asked Sunix to use existing 8250_pci.c instead of its own module.
> > It only needs a special setup function, other parts are just 8250_pci.
>
> Agreed.  And this patch is already in my tree :)
>
> If people really worry about size issues, start carving this up by
> different configuration options, or yes, split it up into tiny modules
> (but note the overhead there when things get too tiny, it's a
> diminishing return).

It's always a trade off and associative pros and cons. If Sunix is a
simple one, I tend to agree that 8250_pci is a good place. For rather
big quirk modules, like Exar one, the separate sounds better (and as
we can see from retrospective of maintenance).

>
> > Why does split them a better idea? I even think of squashing 8250_moxa into
> > 8250_pci.
>
> I would agree with you, I bet you save space if you do that.



-- 
With Best Regards,
Andy Shevchenko
