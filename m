Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A53C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B9B20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569262370;
	bh=5tDDKgWw72hL/Kj8mDZN6XB9KcgZBBMsronFxJwR3Wo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LeUDPzuuNpUWinDfvARKZ/db1A5XZXgriO8cYmFlWN61Dt1ou/1004ocDvme7y3nV
	 +7RSJHOL9BLJwQtJCjY0qNy37viE0Alykv69pCJh1Vkg+iRdJHu68EgwoaNqW2uQRq
	 NFKQTBukBq/GunKanIpXdHF9ImmylBqgJRSRmSEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440351AbfIWSMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:12:49 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38181 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438090AbfIWSMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:12:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id u28so10865160lfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 11:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R4shg+scIpJfCZC41SED7+qonFl33tfza4anQMhH3cw=;
        b=iFhS4Y7yp8j4dD31DmizpunLsN676aOnZOftmOzWSVKYsaIXYR5qCXzu4sfTZ71kMR
         4yn55X3l4wqby8Lln6hkzwjFw+M0XMEyj2M9ZSeSQtMYsMGdXP2LKdoZdyVLK5BRdt1u
         bYlGFZDsY+HEXSU5dWNJ/rfhbckx0y3OC9Amc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4shg+scIpJfCZC41SED7+qonFl33tfza4anQMhH3cw=;
        b=VfH62yZ19j5YNbt0eu2ZtbCvJQSDx9y83f3FqPyqLubeDXXM6tHjxNW8Wg0c43UIzI
         1RimcadyIYjX5PWfuH5vMaG9pjSpcnmVXfhEpGx5fQaSKjzyPVjQwlZfPB7fCKrDAdIA
         Jw9yQqDk0T7I4HyO9HMvkiJKB4dSFrrJ7jgR7XCD2lev0/2CkBKA+q0t7YvNxDvECuVm
         9cCNq2niu8N7/uTmy13UXcP/JT0Wqo/OX5hrPv+LDuAuaEllLXNrESWRu/0d3QGA9725
         h7xeZpEl94aCCQGYBM1rMO9mjSFui9/Nm51qA4dgqWrT1KVpUAbxY4ZZw3f0kamFBKbB
         cG3Q==
X-Gm-Message-State: APjAAAVOK44Wr7yNJlMttWB+U4XJmGaSFzmHCNg1D3/roTonu+Ykpipy
        HTKw0LhL2lB17KJQ3g44GREJqVTsR48=
X-Google-Smtp-Source: APXvYqxVd6+Rk4KQtZbLRvQKSZetaBp2hfkZngcl5k2XejmDhMsjmOP+svphSetZWs51yVU0LIrBww==
X-Received: by 2002:a19:f707:: with SMTP id z7mr558694lfe.142.1569262364868;
        Mon, 23 Sep 2019 11:12:44 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id e8sm2689080ljk.54.2019.09.23.11.12.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 11:12:44 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id b20so9291740ljj.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 11:12:43 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr434883ljs.156.1569262363228;
 Mon, 23 Sep 2019 11:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190919055312.3020652-1-songliubraving@fb.com> <20190923112744.GK2349@hirez.programming.kicks-ass.net>
In-Reply-To: <20190923112744.GK2349@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Sep 2019 11:12:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiRARoL=c0zSJbA9v8n7jqBnxaUyxOPGppoz9M4G+mahw@mail.gmail.com>
Message-ID: <CAHk-=wiRARoL=c0zSJbA9v8n7jqBnxaUyxOPGppoz9M4G+mahw@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/pti: Handle unaligned addr to PMD-mapped page in pti_clone_pgtable
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 4:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> I'm conflicted on this one... the only use of addr here is
> pti_user_pagetable_walk_pmd() and that already masks things, so the
> fixup is 'pointless'.

No it's not.

The *other* use of 'addr' is

        addr += PMD_SIZE;

and then repeat the loop.

And that repeat might then use it for the page-level case the next iteration.

> Also the location is weird; we'd want to do alignment enforcement before
> we commence the for-loop, methinks.

No. See again. The alignment is different for the different cases
inside the loop. Some do per-page stuff, some do per-pmd stuff, and
some do per-pud stuff.

And you don't know which you'll hit a-priori (because it's not limited
to the 'level' testing).

           Linus
