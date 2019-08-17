Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E38FC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 07:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610D32086C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 07:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566027491;
	bh=Jt6MOlOxp4Jo1PmEKOHMGQLwzsFy2ko5exKk6XhQOuU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wQA7AbxMZ9oj64fisE67/DtKFXgbkK3CSOwBGSumXb+JQ/CNyZ3yRH0Qp4Qey/YRr
	 TwTdiZjUzlHDdj66ARfJRsCFC1d+HT57wYd4qdkHMqhJtRRBBjBL7J1Opj1JHzYnC3
	 8Yff4X4VUNPcQPLzhnikCwxgop5RASZrFLX0fAnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfHQHiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 03:38:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43914 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfHQHiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 03:38:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id c19so5561173lfm.10
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 00:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qjmefjZhoyebLftZlaWwOgZmDLyOFDxgkvKQNDD6muU=;
        b=ROBhpTcYE5sMsKscWoxHvuN7/rDEB2KBhTYVGBrSf8McXkjaPUHTa+vvnR7jS1c/98
         Yu6WhN2x/RHdyfcAwhc/BsVF52q/Dl9W3Rtsq3Qr7rrbg5HT3lgtH2ByzJiZhVIANWGB
         WyzMcJJ8ndT8ewyDylRfnDShKXqexN+HkPk/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjmefjZhoyebLftZlaWwOgZmDLyOFDxgkvKQNDD6muU=;
        b=tJcAt2nxTxq1iymErT3ur16UuhtcYMxtfsJPCkWeim8G7iowfABNuq1gZpy4Jgs8dB
         dOKMRMkHFgAhrWrwoa0egh/eA5SOUs5nVkzd3eFmcDDKKkLRsF45sa3UotOcfPHKnB6l
         OxK4mgRKtGN44wcOd5NddQ+S3ZKNojCFJyePLA7YuKyWzoiln4ILiHG7pULlOEF+qOws
         YEuK/eVFP9WUns79Xwf8/KFYMxOjejddskEiHpaPZ2WdzmDOJvcv4Bdu6QWUIRQ2V+8f
         f8uhkrWpXX9h0sEq8C4pg/dN0vAsQe04asmB9h8VJeRZP0+VFdVXoXT1KEC1LfQ+H0p7
         Cjtg==
X-Gm-Message-State: APjAAAXHPYSY+bKYxW1j6FcjyfFpxl78angtJLtMXeUcGyQ3ZJDwBeJk
        sNaI6zl/7eJov8By8V0wUNv3qp+GzKI=
X-Google-Smtp-Source: APXvYqwVDkkDkyN4fsGGXgpWmFhQ4hrFfsohg+XQk2g4K71tndpdyho7jOIaTlJ5eqJGASyc9gxgsw==
X-Received: by 2002:a19:9111:: with SMTP id t17mr7092380lfd.113.1566027486985;
        Sat, 17 Aug 2019 00:38:06 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id n2sm1282663lfl.62.2019.08.17.00.38.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2019 00:38:05 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id x18so7263103ljh.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 00:38:05 -0700 (PDT)
X-Received: by 2002:a2e:3a0e:: with SMTP id h14mr7640810lja.180.1566027485396;
 Sat, 17 Aug 2019 00:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190808154240.9384-1-hch@lst.de> <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com>
 <20190816062751.GA16169@infradead.org> <20190816115735.GB5412@mellanox.com>
 <20190816123258.GA22140@lst.de> <20190816140623.4e3a5f04ea1c08925ac4581f@linux-foundation.org>
 <20190817164124.683d67ff@canb.auug.org.au>
In-Reply-To: <20190817164124.683d67ff@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 17 Aug 2019 00:37:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheUwELKxhouLs4b==w9DxMrCPh2R_FTsTeVi0=d0S_OA@mail.gmail.com>
Message-ID: <CAHk-=wheUwELKxhouLs4b==w9DxMrCPh2R_FTsTeVi0=d0S_OA@mail.gmail.com>
Subject: Re: cleanup the walk_page_range interface
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 11:41 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> I certainly prefer that method of API change :-)
> (see the current "keys: Replace uid/gid/perm permissions checking with
> an ACL" in linux-next

Side note: I will *not* be pulling that again.

It was broken last time, and without more people reviewing the code,
I' m not pulling it for 5.4 either even if David has an additional
commit on top that might have fixed the original problem.

There's still a pending kernel test report on commit f771fde82051
("keys: Simplify key description management") from another of David's
pulls for 5.3 - one that didn't get reverted.

David, look in your inbox for a kernel test report about

  kernel BUG at security/keys/keyring.c:1245!

(It's the

        BUG_ON(index_key->desc_len == 0);

line - the line numbers have since changed, and it's line 1304 in the
current tree).

I'm not sure why _that_ BUG_ON() now triggers, but I wonder if it's
because 'desc_len' went from a 'size_t' to an 'u8', and now a desc_len
of 256 is 0. Or something. The point being that there have been too
many bugs in the pulls and nobody but David apparently ever had
anything to do with any of the development. This code needs more eyes,
not more random changes.

So I won't be compounding on that workflow problem next merge window.

                  Linus
