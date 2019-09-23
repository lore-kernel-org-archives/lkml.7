Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919FAC4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615C02089F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569261850;
	bh=L5sCV4pvrBNYv4Inilae+JS/iE6orzTuw62KtFc3ZZY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=E9bBcmMGczUn+nG4E5zhuNZ/9b/gFAjDuRrT7kJjFIV2Z7UZD0W25bl2osRTF4d/z
	 jds3gAxPS08uQxkOe6lBt561IvOHC7bbsFDTfH4ZdbY2cRWaHaRV1ZyvKFCtH9MaHT
	 SlCP4vmnWGHhErK28WQVBUjKxn9U9zJqC1bWFBoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440292AbfIWSEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:04:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44553 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440281AbfIWSEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:04:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id m13so14577397ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1kR+G8ndtoJyKRtN7szpcKy6yBwnoxfBwdrDmTb45aE=;
        b=EDc55+UsUt1hlLqTRQpm9TOS1K4q0juc5fBusxwSGEQlx/lYD5sqi5FdaUC/djpdP9
         fDW9guWgKyH5BjpKHGpvmcwvc2vRi5SCMb7hmXB4ugChfSwNDNWcht7pLo3VtEFR5Mug
         PetSOXu5wrIuFLoWC3lwUyfioMD/N0vuwvNWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1kR+G8ndtoJyKRtN7szpcKy6yBwnoxfBwdrDmTb45aE=;
        b=aT1psBtCt3BYNPJjbhnxGtMK9TMU0Q15xlZ6Gti9Rf8nQGK2F+MtoBBQx0713kH31U
         fz5ZJ0A8Vx9J+BJxaNbh/dvRa85CXJAu0qcMTqCJFKVgJpWVSi+/hqNspDmRt8xQyHkG
         VDYpra7uRP2E1MAX7Ds0dTPiRxBlb5o+0AW0leVmMT/hn7hDfMFVnxanhq0Te/XXlKtg
         ANs17wv67yyRt+gm3xMVyYfbMxXQYsbwLDl65Fm8SMDf6yfyEh7la2P8mUu8Nu5D/g6u
         byDmH6MHxcA/we8ZVUYfc/LUbiu76WEg+Kkl/0urIn+7pl+1tqxVhc8A8ASCOTsInSp6
         87Hg==
X-Gm-Message-State: APjAAAUzPKYjOXLJ+wZoU9Qp4AXEUk7urJiVT8Qu4otOX5TE8QZ7OSKo
        NwPGZLyr1CpbzYKhV1lmwjmNJyDEP3c=
X-Google-Smtp-Source: APXvYqyharrfMWYVfGuuLK+UQ5vYLtBWbTbMDsQsdrxot1d6GKxaXm6kKrSf82UV0CjYZrskbI3tGg==
X-Received: by 2002:a2e:96d5:: with SMTP id d21mr358102ljj.187.1569261846954;
        Mon, 23 Sep 2019 11:04:06 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id r75sm2366407lff.7.2019.09.23.11.04.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 11:04:05 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id r134so10826066lff.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 11:04:05 -0700 (PDT)
X-Received: by 2002:a19:2489:: with SMTP id k131mr508976lfk.52.1569261845024;
 Mon, 23 Sep 2019 11:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190923042523.10027-1-peterx@redhat.com> <20190923042523.10027-6-peterx@redhat.com>
In-Reply-To: <20190923042523.10027-6-peterx@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Sep 2019 11:03:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNGtUaXtRv1wniw3hfxFnU7SO7ZuisFSVg0btvROcW6w@mail.gmail.com>
Message-ID: <CAHk-=wiNGtUaXtRv1wniw3hfxFnU7SO7ZuisFSVg0btvROcW6w@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] mm: Return faster for non-fatal signals in user
 mode faults
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Marty McFadden <mcfadden8@llnl.gov>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 9:26 PM Peter Xu <peterx@redhat.com> wrote:
>
> This patch is a preparation of removing that special path by allowing
> the page fault to return even faster if we were interrupted by a
> non-fatal signal during a user-mode page fault handling routine.

So I really wish saome other vm person would also review these things,
but looking over this series once more, this is the patch I probably
like the least.

And the reason I like it the least is that I have a hard time
explaining to myself what the code does and why, and why it's so full
of this pattern:

> -       if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +       if ((fault & VM_FAULT_RETRY) &&
> +           fault_should_check_signal(user_mode(regs)))
>                 return;

which isn't all that pretty.

Why isn't this just

  static bool fault_signal_pending(unsigned int fault_flags, struct
pt_regs *regs)
  {
        return (fault_flags & VM_FAULT_RETRY) &&
                (fatal_signal_pending(current) ||
                 (user_mode(regs) && signal_pending(current)));
  }

and then most of the users would be something like

        if (fault_signal_pending(fault, regs))
                return;

and the exceptions could do their own thing.

Now the code is prettier and more understandable, I feel.

And if something doesn't follow this pattern, maybe it either _should_
follow that pattern or it should just not use the helper but explain
why it has an unusual pattern.

             Linus
