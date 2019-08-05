Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87AFC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB082147A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asd7Fg8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbfHETzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:55:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40799 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfHETzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:55:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id b17so58998310lff.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VkZbfC+EpkQaPEsPSx9ocRYh+3TkiZxKiNMzxlWu3nY=;
        b=asd7Fg8eJdbHaUl/GE3/fiESkYN2MkQbklldaifFBdBmP1aAFynBKD7kWJJUuT/MNb
         xzJNvzEBk6Bxo/QtY8i6KO8yPipV4a5El88ztGISyiSv5i5Zii16+FPrC3pToeTHOLFQ
         6iL3ZBCvyTPzQ9gW9yC/flhRzMJ3xVDAgzbF1VvYm6eBbZLwCSycU/1wngnT2IgNmMey
         iSScBlmmOnvba6tj02T5cqIVMYit182lKLXabZlkKOLjPC3Y7tE//5HrU8whbFzzHrKP
         hR/+IDuYXjXkv00FKs1bk7QYoU3UBHMsNpdLlRIxv/maWRgYFMar3/W28bpXha7J2h5F
         /44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VkZbfC+EpkQaPEsPSx9ocRYh+3TkiZxKiNMzxlWu3nY=;
        b=LislCtAakSnWDlKz2OqR49FZxYZVO/3+BLoFfwIak6+Xo5ImJlMmegG0ax2d4FzUhD
         u4UZz3P8NngV8MAAuJXqj45WD31ZFe7jRigwR0h+TCkSB05rR1ZYfy8itnV4Z6WLEb8r
         cQRqXEnlra00RhG6gLSko235dUsnYVFeceu43Xlk2XO8lcT6HLVJZluwTs2n9P88g4gi
         5VBMvXtlPIE478FOajD3bOqS0pqn/SFRCcB4xKanRK99QPLD4fUEsiUTCUjNSeg7IVjd
         3pzRf49OTamYLG5AgLk2BymMTiX304ypD5I9OUiHncKtmqQ1u2oQmkDXQ4qjdapMFGG0
         vjtw==
X-Gm-Message-State: APjAAAXPQn908hpWd7jISyQKWLSHusUkZmDOECIOjrPbxnIA80qj+Vax
        K56uqfEEcy/3pLknQrWAN1s=
X-Google-Smtp-Source: APXvYqyY9qWwAG2jf9rcD9EksskZzYxVzDHABpiv5f7kSALonkfju/RXxcTaqdJw5nPFDF8khBJyQw==
X-Received: by 2002:a05:6512:15a:: with SMTP id m26mr70998580lfo.71.1565034930052;
        Mon, 05 Aug 2019 12:55:30 -0700 (PDT)
Received: from rikard (h-158-174-186-115.NA.cust.bahnhof.se. [158.174.186.115])
        by smtp.gmail.com with ESMTPSA id m17sm15000408lfj.22.2019.08.05.12.55.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 12:55:29 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Mon, 5 Aug 2019 21:55:26 +0200
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] linux/bits.h: Add compile time sanity check of GENMASK
 inputs
Message-ID: <20190805195526.GA869@rikard>
References: <20190731190309.19909-1-rikard.falkeborn@gmail.com>
 <47d29791addc075431737aff4b64531a668d4c1b.camel@perches.com>
 <CAK7LNAQdgUOsjWtWFnXm66DPnYFRp=i69DMyr+q4+NT+SPCQxA@mail.gmail.com>
 <2b782cf609330f53b6ecc5b75a8a4b49898483eb.camel@perches.com>
 <CAK7LNASw+Fraio3t=bZw-FzJihScTuDR=p2EktFVOmdLH4GTGA@mail.gmail.com>
 <20190802181853.GA809@rikard>
 <CAK7LNAT+cNxna4SER04MdkBsq_LDg4TwYR_U1ioNNxYOZWXigA@mail.gmail.com>
 <CAK7LNAQv-5epL8DYDaUdHsQEQ=Va676t_6TgsaSYC30Eix=iyw@mail.gmail.com>
 <20190803183637.GA831@rikard>
 <CAK7LNASBndh4yJKVdeMb7RQGopUzEUSNXPQcUgQdB8PiJetMuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASBndh4yJKVdeMb7RQGopUzEUSNXPQcUgQdB8PiJetMuQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2019 at 03:45:16PM +0900, Masahiro Yamada wrote:
> On Sun, Aug 4, 2019 at 3:36 AM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
> >
> > On Sat, Aug 03, 2019 at 12:12:46PM +0900, Masahiro Yamada wrote:
> > > On Sat, Aug 3, 2019 at 12:03 PM Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > >
> > > >
> > > > BTW, v2 is already inconsistent.
> > > > If you wanted GENMASK_INPUT_CHECK() to return 'unsigned long',,
> > > > you would have to cast (low) > (high) as well:
> > > >
> > > >                (unsigned long)((low) > (high)), UL(0))))
> > > >
> > > > This is totally redundant, and weird.
> > >
> > > I take back this comment.
> > > You added (unsigned long) to the beginning of this macro.
> > > So, the type is consistent, but I believe all casts should be removed.
> >
> > Maybe you're right. BUILD_BUG_ON_ZERO returns size_t regardless of
> > inputs. I was worried that on some platform, size_t would be larger than
> > unsigned long (as far as I could see, the standard does not give any
> > guarantees), and thus all of a sudden GENMASK would be 8 bytes instead
> > of 4, but perhaps that is not a problem?
> 
> 
> How about adding (int) cast to BUILD_BUG_ON_ZERO() ?

I'll have a look.
