Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB4BC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D3620830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbfCZIOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:14:47 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43063 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfCZIOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:14:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id v32so13488550qtc.10;
        Tue, 26 Mar 2019 01:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m8vRqvLF+v/2M9JQn5TgrIRGsTTM589rALNf+mSc2jw=;
        b=Y6+/rTZHMh8bkVy3n0wnhqhz6FjRXn0Arp0j28zE13oMj2Bquc/bZYJPz5tQDmrdv0
         C8uDUzA6Qke179mLP6/NdDleW2siIQJoiViODakliUzfMEBITVtjiJNE1CAdqU0p/h8d
         L2OY1oilMNU3K6XFlJ+nabDC6fwJP0nfXv/dyUwmUygueyudzLj6NNHvcTY/zNtfoBjW
         F0pKdBM5bgpEhVLCRL23vjtzeiQuS0XeDa88f+loV/e2dJE+8qd0ctDi8t7hC39fuRSW
         KrdywnbPV5trwmDVPiMRMtBehz+G4p+1hZSGG7PN+CJMImtXYmWb5IwvdXxk8XQm2T0e
         c5PA==
X-Gm-Message-State: APjAAAVEh2BXsmEqKrt8yQMaiWz1lN7BqC/ckZZkS+/mK2ki4D8oioDZ
        KgkFuPV3S3y/JqoCBH0/j3B6YUQaRFwAmDvayG0=
X-Google-Smtp-Source: APXvYqwwGgL71G6oLX8UKHJ3/xEVXubVBaQrNyDCtVl4KIgGRY78prVdnMoMxjPypWAIZACSb4Cas81wULbMRzQ8M5M=
X-Received: by 2002:ac8:2692:: with SMTP id 18mr24422023qto.343.1553588085441;
 Tue, 26 Mar 2019 01:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190322154425.3852517-1-arnd@arndb.de> <20190322154425.3852517-18-arnd@arndb.de>
 <20190326012731.GA30723@kroah.com>
In-Reply-To: <20190326012731.GA30723@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Mar 2019 09:14:28 +0100
Message-ID: <CAK8P3a1fO0Mga1naZFOPXLqkTSwtUrt3YJEvE876M7pM6x-Ahg@mail.gmail.com>
Subject: Re: [BACKPORT 4.4.y 17/25] mmc: core: don't try to switch block size
 for dual rate mode
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "# 3.4.x" <stable@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Jiong Wu <lohengrin1024@gmail.com>,
        Martin Hicks <mort@bork.org>,
        Ziyuan Xu <xzy.xu@rock-chips.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 2:27 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 22, 2019 at 04:44:08PM +0100, Arnd Bergmann wrote:
> > From: Ziyuan Xu <xzy.xu@rock-chips.com>
> >
> > Per spec, block size should always be 512 bytes for dual rate mode,
> > so any attempts to switch the block size under dual rate mode should
> > be neglected.
> >
> > Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > (cherry picked from commit 1712c9373f98ae8ed41599a8d7841a6fba29c264)
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/mmc/core/core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index df074f8c7cb7..3e17268b9994 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2406,7 +2406,8 @@ int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
> >  {
> >       struct mmc_command cmd = {0};
> >
> > -     if (mmc_card_blockaddr(card) || mmc_card_ddr52(card))
> > +     if (mmc_card_blockaddr(card) || mmc_card_ddr52(card) ||
> > +         mmc_card_hs400(card) || mmc_card_hs400es(card))
>
> This breaks the build, there is no mmc_card_hs400es() call in 4.4.y.
>
> How did this build for you?

I had a larger set of backported patches and then dropped others
that did not look like stable material, but then did not rebuild again
afterwards. I'll make sure to do that next time.

     Arnd
