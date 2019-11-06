Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64766C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A48207FA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onjprryL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfKFQoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:44:32 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42743 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfKFQob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:44:31 -0500
Received: by mail-yw1-f68.google.com with SMTP id z67so668830ywb.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 08:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RnIAWuMyz7kDieVNrBUbl2Gvb5/kFTUXSVFfu5Y2MNA=;
        b=onjprryLGJm1op2xyFSo6LKEns+ebTE+WwtbI/KR7L/OuP/jFfOc8vreiDstWJZR5i
         /u34Zaq7MWWxqSd+SGkwtkDpk6tS0d1kTZDR2FdEyd5oj0PFBrd23iUcJfhicjIfPRhy
         zDhP2KmoNL1ZQuLofdscn7ApRDNAtL336tUiKYbvcHRxgSBAagFZWasEnyp1e1HLC7SV
         vCWBlOdp6ZIWKkwM3LLZD9WTkMHawaX303IekXO0G/MYohKPwMddc3BeRW3SwykXDyxV
         zbd3kZe8KO2SHQAFQnfg84pdBayvETXJemPlECfLm1cL1+X3jUEd9SHgDl5zzoVeYSMm
         3FCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RnIAWuMyz7kDieVNrBUbl2Gvb5/kFTUXSVFfu5Y2MNA=;
        b=hofE2P19CvrafkmR0c//tmnmo30zQ91oOtK+KpwnM8v8I7ePoJsoB5ZD4th+VoN9lP
         49qIXc+n1sgC55KdQvCbfmZmoasBJ9LisjE4Ng68VVEA2BPOhHVpWlE2y6uaEcZqnyha
         vpzge8JZlT3denjqd6KN9EWRrT+KXrxGDXGPZKvHjK4RgtINuTrllByn/vAtPN5esgMX
         7/mvcZaz2I/sFv3P7ySsM7P1d/0/59Aj7DSKL3z3Zf/7sj2UP/I17yHyGFFBrEf/l7vB
         QarO1/7E89kqIWYQGmwgW+Q/++JlRGDDxLntdohzz7j7XQHZWyUOZeaZ2LuJcwDNRm0X
         ccrQ==
X-Gm-Message-State: APjAAAV8FZnSuGQbyUMG7Gm7J9nU4iXT2ckessohOOVIARXfUR8e/LFc
        H0cflQHGsF/cHZ3cwlh6r7xlUKoHkpWur+1KgMg=
X-Google-Smtp-Source: APXvYqw5uvqnnms4M9LntHdMzBZDGmmovjOZaUoXw0nc8YS06THSQKVbnZiwnNAj2zKs+Hfa6nXYPA9UZA7vULRnsXE=
X-Received: by 2002:a81:8415:: with SMTP id u21mr2283731ywf.129.1573058670927;
 Wed, 06 Nov 2019 08:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20191106030542.868541-1-dima@arista.com> <20191106030542.868541-44-dima@arista.com>
 <CAMo8Bf+q0j81VZeUQdvCkXt131uzSBfJ0N7RTe7+NpjRkVpzdA@mail.gmail.com> <20191106081541.soxefwyvu3o72tqg@pathway.suse.cz>
In-Reply-To: <20191106081541.soxefwyvu3o72tqg@pathway.suse.cz>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 6 Nov 2019 08:44:19 -0800
Message-ID: <CAMo8Bf+ASTba15G7xj=zLTnnCaU=SeHiEO6Ab-0MCcJMiOXNkw@mail.gmail.com>
Subject: Re: [PATCH 43/50] xtensa: Add show_stack_loglvl()
To:     Petr Mladek <pmladek@suse.com>
Cc:     Dmitry Safonov <dima@arista.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 12:15 AM Petr Mladek <pmladek@suse.com> wrote:
> > >         for (i = 0; i < kstack_depth_to_print; i++) {
> > >                 if (kstack_end(sp))
> > >                         break;
> > > -               pr_cont(" %08lx", *sp++);
> > > +               printk("%s %08lx", loglvl, *sp++);
>
> KERN_CONT can be combined with any other loglevel.
> So you could keep using pr_cont() together with explicit loglevel:
>
>                         pr_cont("%s %08lx", loglvl, *sp++);
>
> It should fix the problems reported below.
>
> Well, the preferred solution would be to snprintf() the continuous
> line into a temporary buffer. And printk() it when it is complete.
> pr_cont() is not reliable when more CPUs print at the same time.

Good point. Let me do this cleanup.

-- 
Thanks.
-- Max
