Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C43C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D97E21721
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvxvNFt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406068AbfFKRW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:22:27 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41397 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405821AbfFKRWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:22:25 -0400
Received: by mail-vs1-f66.google.com with SMTP id g24so8438594vso.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ch5ySbq0FmSA2XajIVEvQlmmFhHNIePL/QuQTBUXjwE=;
        b=BvxvNFt2CuRdvPDlu+YFPGTgJ0ILAjwFJunihoBUnffJQ6arR0U0poSOngu54e31oM
         yX2FndF/g5urg4zuLG7xfVHMK42maMFVSTpmEbMgWWPBDBrmVUmTA7zoQc6XA6KtJD7b
         n8AHQVrCvlKCojNGcjKziVI7e/dqruYe0fOczUG/4HftPDxxm9sg1Cc6hAHNDBep9imZ
         XCmoUcmOESEHWXRd+aZ46Yxyf9fi+CP/DC+Vk++8ZJdGh3HyhS89+DeAk1SrYID7JOHQ
         7KTqbEUqb16tINbU3onFOC6K4/NMO4O/bFKSJ7gt+vCiwepfkHdS+xDh7LuPaz3GJtgs
         fFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ch5ySbq0FmSA2XajIVEvQlmmFhHNIePL/QuQTBUXjwE=;
        b=p55T8K+a6xpKD+C9bSzlHlf1oLIbovplcE2k0y67xjYVC63xFa8iI6Ot43f+B4ch73
         wbq43Llq3epl0qW8NuV558I0o7IoK2ehw39FU20kCpDcjB2JRv11z0WQ71c6d/4c9IlE
         0G2tbNYDBSOIaTEJNUznSLfbV1Yj7lbN5lYsmXV7MaNGrjiUNlNH37XJfw2Jro4tsLO+
         6LF0p/dcnnDR44QSg/v9Ica+YKaFzhtEXD7J9Jl8Gu6oWyfUL1/+JhHlMOeJWS0ficzp
         OmesXzFh3baOa++uiLWKPqZNssd1W1eO3g34/B5ZYhhUrTIC/1fj0rUbbNEDid4tddOE
         oKOA==
X-Gm-Message-State: APjAAAXzss9MDx1yC+Q9dWgNS3OJlPeNAyp9nJHK3HJQ958XgN8CBZTy
        fN1stfHWXZk78VHmvmcPN3MfKHDDmm9vFbf2mbk=
X-Google-Smtp-Source: APXvYqxxtk2fyTdB5HLiUpLv+cHy2F//+aDjWV45YDWLO4QWQ+SzCCmrZzf6DWcxyJaIog0QW8ScWSukBqD64YkZ1RE=
X-Received: by 2002:a67:d410:: with SMTP id c16mr32239283vsj.61.1560273743742;
 Tue, 11 Jun 2019 10:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf11EM9+NDML9hQmk9-rPzSmDmAyVLW+qOfs6h62dGK6H9A@mail.gmail.com>
 <20190611140725.GA28902@infradead.org>
In-Reply-To: <20190611140725.GA28902@infradead.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 11 Jun 2019 20:21:58 +0300
Message-ID: <CAFCwf13WgnbxHe2wpb3mnw2PLWCgor=136_VSSPQCVodu17uvA@mail.gmail.com>
Subject: Re: Question - check in runtime which architecture am I running on
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linuxppc-dev@ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 5:07 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jun 11, 2019 at 03:30:08PM +0300, Oded Gabbay wrote:
> > Hello POWER developers,
> >
> > I'm trying to find out if there is an internal kernel API so that a
> > PCI driver can call it to check if its PCI device is running inside a
> > POWER9 machine. Alternatively, if that's not available, if it is
> > running on a machine with powerpc architecture.
>
> Your driver has absolutely not business knowing this.
>
> >
> > I need this information as my device (Goya AI accelerator)
> > unfortunately needs a slightly different configuration of its PCIe
> > controller in case of POWER9 (need to set bit 59 to be 1 in all
> > outbound transactions).
>
> No, it doesn't.  You can query the output from dma_get_required_mask
> to optimize for the DMA addresses you get, and otherwise you simply
> set the maximum dma mask you support.  That is about the control you
> get, and nothing else is a drivers business.

I don't want to conduct two discussions as I saw you answered on my patch.
I'll add the ppc mailing list to my patch.
Oded
