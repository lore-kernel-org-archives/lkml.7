Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107F4ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB2321835
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3UqyF4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbfJNNLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:11:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44976 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfJNNLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:11:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id q15so7999666pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 06:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IkhUxI/cuatLueNhPw35isDgOKo7L+7bC3FLEO0Oaxw=;
        b=c3UqyF4/zasaXCdf3v34YxktIHDSJVJePa4Fll1ChyITLykL6bYrwIifXDgxznwUNd
         1KnWFD0GbZH7eIMcu15/fArGWE0Mn3zrfIMX8tYVaNQxL8r5VRS6DsWmnQ4Jbuz9q5cJ
         HTWu02vEYgHLJEzFzakbuaX//tFWgGGtTfvXqrAqiY14Yu83EShTjmEsfA/xqG2ST8Za
         IOShyUL7GC8sg6q1F0Y4kknE8fg+K6KMmxujj4sFbFz3TegPE37EggjwZvhT37Ujmo0s
         bqNiNAp0WD2e5bgtAtBFc5Aqnn6qETe5lueiuM/lrSlF1PDfoiDrVFBI//rjMaUvrDIv
         8N/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IkhUxI/cuatLueNhPw35isDgOKo7L+7bC3FLEO0Oaxw=;
        b=OT6/HnVFX3C+W0BZN1/2IRoD0CmFbPXBzUyB8Z7FgF/07jgXdiyrJKHa6FJ1TsFzIc
         FsitaY793iAcnvRZUUAgEMH0XK4m8449zte98nurfHYROU47sR1nVvR9kSW4VWEYwQ2p
         lR6NC4z3VDCUCtZ42Lv6O4CYiLlrZQtmfLzsi+WQTxhbROvz6NXtkS+VjzLMz0k5qW8v
         hy3opjlBYhdvPOxuDKajJoc9uUoYaoYA4EAl0rTIS6LdEaxj2xN5hSNDQiZRsF4R2+7M
         33rfSaBxY8BA9dglgk8lFYTDNy9laxDil7ROAaO82DcYfgXGFmUIiOsJZguMjAHoA6LW
         cIHw==
X-Gm-Message-State: APjAAAXr/nqsIlw/k3HwaHS5hlMeaQLEetltjry7ZjSoifrtnWyh27Mc
        wvntp8EvEF/R+geEF5IaCsMGUGlbe/ZqmnSNoko=
X-Google-Smtp-Source: APXvYqx2sCYKTZu6Ql9kmkA6LrGokSM6LsXUxypU2dTIqJ5aOl2FL+/OO4hsJmKnIuvYGUUdsxSJC+pFdemQg1WRTms=
X-Received: by 2002:a17:902:9881:: with SMTP id s1mr30804278plp.18.1571058664842;
 Mon, 14 Oct 2019 06:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190917065959.5560-1-linux@rasmusvillemoes.dk>
 <20191011133617.9963-1-linux@rasmusvillemoes.dk> <20191011133617.9963-2-linux@rasmusvillemoes.dk>
 <20191014130247.rag2g7qz54uiw54z@pathway.suse.cz>
In-Reply-To: <20191014130247.rag2g7qz54uiw54z@pathway.suse.cz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 14 Oct 2019 16:10:54 +0300
Message-ID: <CAHp75Vc1Tk7i1TCtT6RnfyBbt2F_skK8DEQ5iky1=spW06qsdQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] printf: add support for printing symbolic error names
To:     Petr Mladek <pmladek@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 4:02 PM Petr Mladek <pmladek@suse.com> wrote:
> On Fri 2019-10-11 15:36:17, Rasmus Villemoes wrote:
> > It has been suggested several times to extend vsnprintf() to be able
> > to convert the numeric value of ENOSPC to print "ENOSPC". This
> > implements that as a %p extension: With %pe, one can do

> > +const char *errname(int err)
> > +{
> > +     bool pos = err > 0;
> > +     const char *name = __errname(err > 0 ? err : -err);
> > +
> > +     return name ? name + pos : NULL;
>
> This made me to check C standard. It seems that "true" really has
> to be "1".

You may guarantee it by using !!.

     return name ? name + !!(err > 0) : NULL;


But to me it seems like forgotten use of pos in the other case above.

Anyway, I would rather do

abs(err) in the first place

and simple use name + 1 in the second as you suggested with maybe a
comment that we skip E letter.

> But I think that I am not the only one who is not sure.
> I would prefer to make it less tricky and use, for example:
>
>         const char *name = __errname(err > 0 ? err : -err);
>         if (!name)
>                 return NULL;
>
>         return err > 0 ? name + 1 : name;

> > +}


-- 
With Best Regards,
Andy Shevchenko
