Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B01C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 05:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAD020715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 05:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYEhuf0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKNFdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 00:33:44 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45651 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfKNFdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 00:33:43 -0500
Received: by mail-lf1-f68.google.com with SMTP id v8so3911364lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 21:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hlxXISlHgvgxQVX7a0oSoBMgtYJmQzfQCH804Ekjahk=;
        b=RYEhuf0nlP1NnAjn+C3HFZXL6sWwN5JnPBpgOhvcpgRCjwaTt7S28+rHkH7G4mKjHF
         JwMvY6kO89ch9r47AxymeUt6gQlJ+yg7E/d7LCvxMyxWE40OcVLyarfEbKll1fx14pQs
         lTA6jvG+CpfB3XohLrpVemQnDe0qH535C2zBn0vY9sZLAVOljNVV/HwkX+oD1KeO306e
         dzOxAMdFqeqOAUNtpLsM1X8uOxQg8onk7++bbFtTwPBaj19qWEV4hn/miRc/Qzajd+Vf
         4pXMvadiVlLODCx7bn/JAGcfmG+WREyR88ZAarkUKoYubgTI6ArIFy53RxoUrupwErRY
         sb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hlxXISlHgvgxQVX7a0oSoBMgtYJmQzfQCH804Ekjahk=;
        b=mx4ziHhZJ/BWK6orUsuH1l46iY0YkiMS4d0RyHsYY/Dtf17PsNufxPmmeuq2plds35
         76CfQBzRbNP5/iH5VpVWj0egeYOMnZyX4xs6ZwsQ8Yx/WuekxZftj825BoBmhOXQJG3q
         WrHoFwOtHn1bJQz/sOfAWGibTdaDBlV51GqCFdPidx+P0Jcebx2fgPV70zO48qC8YDhp
         pt5zMJr27sDbYlHZaEo060AKvnkE4gH+B0IbOPAW/wkuNaD5r7DAZ08iAPuo11yd3FUL
         hHplgr1p/qhiz0nEu6kpQ1jypLHCCuIeeEeqwdEDK53zUb1MeukzuzIOohWSA7oqgDRR
         tO/w==
X-Gm-Message-State: APjAAAXgErTWJQbez5FVgIAdmiGQiOFtw8DP+GjSH82f8NFoCexju3vy
        viZq/El73M25NSjbMQbHPmPt+S+4RnQ3tBJ5GBBeFA==
X-Google-Smtp-Source: APXvYqwG8ieHlYRuz3jM86+PN7ilP65cTzag/LR2P38xH849z6xUHMzkTYozXtctvxB19clr0OEhUkA29M4vvH7RmN8=
X-Received: by 2002:a19:f107:: with SMTP id p7mr5179412lfh.91.1573709621587;
 Wed, 13 Nov 2019 21:33:41 -0800 (PST)
MIME-Version: 1.0
References: <85a5484bc1f3dd53ce6f92700ad8b35f30a0b096.1571812029.git.baolin.wang@linaro.org>
 <20191114045005.GI952516@vkoul-mobl>
In-Reply-To: <20191114045005.GI952516@vkoul-mobl>
From:   "(Exiting) Baolin Wang" <baolin.wang@linaro.org>
Date:   Thu, 14 Nov 2019 13:33:30 +0800
Message-ID: <CAMz4kuL8by3BzFYocO5eZ0YdA5aUoCjybMHwDC4HsVSzr1Pt6Q@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sprd: Add wrap address support for link-list mode
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        eric.long@unisoc.com, baolin.wang7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 at 12:50, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 23-10-19, 14:31, Baolin Wang wrote:
> > From: Eric Long <eric.long@unisoc.com>
> >
> > The Spreadtrum Audio compress offload mode will use 2-stage DMA transfer
> > to save power. That means we can request 2 dma channels, one for source
> > channel, and another one for destination channel. Once the source channel's
> > transaction is done, it will trigger the destination channel's transaction
> > automatically by hardware signal.
> >
> > In this case, the source channel will transfer data from IRAM buffer to
> > the DSP fifo to decoding/encoding, once IRAM buffer is empty by transferring
> > done, the destination channel will start to transfer data from DDR buffer
> > to IRAM buffer. Since the destination channel will use link-list mode to
> > fill the IRAM data, and IRAM buffer is allocated by 32K, and DDR buffer
> > is larger to 2M, that means we need lots of link-list nodes to do a cyclic
> > transfer, instead wasting lots of link-list memory, we can use wrap address
> > support to reduce link-list node number, which means when the transfer
> > address reaches the wrap address, the transfer address will jump to the
> > wrap_to address specified by wrap_to register, and only 2 link-list nodes
> > can do a cyclic transfer to transfer data from DDR to IRAM.
> >
> > Thus this patch adds wrap address to support this case.
>
> This fails to apply, can you please rebase and resend!

Sure, sorry for the trouble. Will rebase and resend. Thanks.

-- 
Baolin Wang
Best Regards
