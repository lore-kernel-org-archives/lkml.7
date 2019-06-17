Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C077EC31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2252238D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAZptm6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfFQIgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:36:00 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36413 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFQIf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:35:59 -0400
Received: by mail-vs1-f68.google.com with SMTP id l20so5604870vsp.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 01:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=513oun3fB/AaoCJhmRCGHz1Y6XSqMQqHeEu/q0dIm08=;
        b=OAZptm6VC4b+K0M7ElRWchl9EZAfB89DTnfSe3yHFU+2S4lwzWgBPmE6iuE5XFZyzo
         FgBRIMkZU4upnNpjaWcfJWrclWPrsOwLNFhwHgZ4JmebDqVn8P+k0Sq+vW4yIAMBgqtx
         ZZhaopSyRpGIb4dPYIdgsrgNa0IRaDzkOTelq6yt2LlSMgMMDS5pxM6qgvkwFYNxAA3d
         ZWjGgpQSkLn61fAy9ZCfLbMpnN9sfnOP03lTe3Xt9FpP7QhSYLS14QUzU1EL2sVt+lIA
         qOPgnipxQ4U4h5D18u62zPWYOAOHH5jLTKvbvsmCuX6CqV3P0KBRNLjw+M3al9MJ0uAC
         /W2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=513oun3fB/AaoCJhmRCGHz1Y6XSqMQqHeEu/q0dIm08=;
        b=UDs/OarXSHtrKnIlVDl/3J9Fxbwdcnd5X/kA1gf2hrWgzIzOJ2ZjtTpsKlOWES0F5D
         0uhhm48VI9tKx1tqVsG+b5lIJxmuPTH5OJ6QUs9qMv7IkmVPb96oS/ICMhCAT+phkMGT
         SZINp7qVvoSkViy/4wVPUPo3p954oHu1NEwJChr48iH74YQDVa2pSH4qSIMt8CPdMNnb
         Zt8TFDB9LJPHZE60SyGGbigJFot4YhWWL7ezYoRWr/PNryYJIZoIkOO0S0o1J5fBoiIN
         erLR0pFt4PoF5UNQdXSxL7JeaGAhyL6z2XguuhAlZjXJ3A92wTnA2XEZDm97RQJ4bk6G
         8Nag==
X-Gm-Message-State: APjAAAV0b/qad+yQct6I8dBp08IydhPaJ8eIter98OQI27L10Tr9OvcR
        9gfa5d/lgezk/9rxccxs3Ap5kOnD6OokV3Ge1jk=
X-Google-Smtp-Source: APXvYqwtqbWRSMO4Znby4vX8AqPIsOcUVTZEBPHgSl/65LTRhjvizzEq8X1MT7PFaD7fnUlxHyDyZxfsJBph47bLF/I=
X-Received: by 2002:a67:d410:: with SMTP id c16mr52008964vsj.61.1560760558769;
 Mon, 17 Jun 2019 01:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190611092144.11194-1-oded.gabbay@gmail.com> <20190611095857.GB24058@kroah.com>
 <20190611151753.GA11404@infradead.org> <20190611152655.GA3972@kroah.com>
 <CAFCwf11DKi+pfvvGR2zN4jvwTQZ9-Lm=OXBs+ZU=E-eFfJOi7A@mail.gmail.com>
 <20190616095554.GA5156@infradead.org> <CAFCwf11XU1JydbS-wswXBzm4t-fxLjGyXuHCqrNxTsWzLraSZQ@mail.gmail.com>
 <20190617081943.GA11274@infradead.org>
In-Reply-To: <20190617081943.GA11274@infradead.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 17 Jun 2019 11:35:32 +0300
Message-ID: <CAFCwf11y_K9oKHWkwBGQs1T_S8x+6=tyecpQ-Y7JKs8tQ6oBgA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:19 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sun, Jun 16, 2019 at 02:24:08PM +0300, Oded Gabbay wrote:
> > So the alternative is that my device won't work on POWER9.
>
> The alternative is that we fix the powerpc code to do the right
> thing, which already is in progress.
Great, I agree this is the correct approach, and that's why I wrote in
my earlier email:

"I'll of course monitor the PPC code upstream and if they will manage
to push a fix to their current DMA mask limitation (that will allow
setting dma mask of 48 bits and without setting bit 59 in outbound
transactions), I will modify my code accordingly and then this hack
won't be necessary. But for now, it is what it is."

So I don't get it why you object for this temporary fix in my driver.

Thanks,
Oded
