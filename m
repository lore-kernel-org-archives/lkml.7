Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6590FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BFD20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551917975;
	bh=GUrJ1pfAsToeH0u/tyVzs5bndWZkd/rKnAjtnADH8vo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CZCH1RuHjbkzz75phH5lOcvn19sSnltSrzN3fMp/p66cT2T6hAJxJn/KiXadm+0lH
	 CJKZn0Kayu3QhNGEUL9dQ2Wskt90ieUsHKAd0W9gqhouz7eA5KAU3HFWtbHEb+2m9A
	 8T/R0NWyntlxOtyepki5L220ggsdRJHrh4dzswhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfCGATd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:19:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36076 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCGATd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:19:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id v10so12583023lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cdv0Boad9qU3U+fOBS5IjHR0PUiEM4VoNG4DTYna6Ro=;
        b=Z7XVPximOLLEWG/Qclf0gTsZQRstxo37yxUJstX5FCRGpgGB1i+sM7Kuw+MGxBq1EA
         bwcGDJhXO++XuzdL+SWIgw5Ckr09J/g890cBhaKAVs89h+DOm24kw6U+bgN8kjcF49Wq
         Meop65eosN83YmeYEC8Z1KQb/vq7CXKdCp8vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdv0Boad9qU3U+fOBS5IjHR0PUiEM4VoNG4DTYna6Ro=;
        b=N6r4mwGkxcluPhW6Xolmz053qoqEvhdJFw9w4VOjXok5D+05WjFkhm21S1c3TRAOpe
         qFQCEzc0zsjwCbIDvD+IAnBAdV32YnhFAzg0iaOZ/03hoUH/lPE1SU0hijwH7r8Sz589
         Y3cZQ5R4m3CfOsI5sWzUn2klHVOhw0Bb0IopL7ODbsSuu8s4EfldTuUgpcUx/WQy91yy
         uo+04jKOjG+MZPJl9EAEdm4l7yDgn9C2F5vBt+6f+xKgiEVtEzG+4jhsRUK2AyRtWcg1
         /n36ZX+vM3V/JlIIhgTynhvMOK81Mr5narR2jSvtIkWHmw41p3ZspEPyNSgzyjbaXEIa
         yhSQ==
X-Gm-Message-State: APjAAAXqVdBcbNdoS+FiEDEP8h+11kTh6JrtAD9FbPBLIYIWGhdL2XMl
        H5GvJsWTIyvbr1qdkKhsKG1VhJmMZG8=
X-Google-Smtp-Source: APXvYqwGzpO0G7Be0IVPJ1fvDEnGPekHHimaj9F9/VtAHCvB+geUzh70g95Dt7n0UiuystlGCTMMew==
X-Received: by 2002:a2e:3a04:: with SMTP id h4mr4175097lja.50.1551917970592;
        Wed, 06 Mar 2019 16:19:30 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id w6sm557104lfl.14.2019.03.06.16.19.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 16:19:29 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id r123so10301649lff.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:19:29 -0800 (PST)
X-Received: by 2002:a19:6a0a:: with SMTP id u10mr4638170lfu.148.1551917969047;
 Wed, 06 Mar 2019 16:19:29 -0800 (PST)
MIME-Version: 1.0
References: <20190306103350.GA10570@kroah.com> <CAHk-=wjT+pPxi8favCu9V5ZtGZuTZybLuwnwtNLspFPmKgr42g@mail.gmail.com>
 <d596d6db449d4747b3eebf4cb42f6657ad42f989.camel@perches.com>
In-Reply-To: <d596d6db449d4747b3eebf4cb42f6657ad42f989.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Mar 2019 16:19:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi5D-fZBjiqo30XgmXJPpmLxTJvJKEDqHCAFiZo9QWC_w@mail.gmail.com>
Message-ID: <CAHk-=wi5D-fZBjiqo30XgmXJPpmLxTJvJKEDqHCAFiZo9QWC_w@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core patches for 5.1-rc1
To:     Joe Perches <joe@perches.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 4:09 PM Joe Perches <joe@perches.com> wrote:
> >
> > This is very funky, but that commit generates a new warning in a
> > totally unrelated area:
>
> Very very funky.
>
> Are you sure it's the __cold marking of an
> entirely unrelated function that isn't
> even used in the code with the new warning?

Yup, I bisected it, because it made no sense at all. There were no
changes to the driver itself in that pull request, but there was a new
warning.

> btw; what compiler version?

  gcc version 8.2.1 20181215 (Red Hat 8.2.1-6) (GCC)

FWIW,

               Linus
