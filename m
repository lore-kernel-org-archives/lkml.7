Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CB9C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3127320B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570638090;
	bh=LEzIqYLEwZd653HisuQ3ELs+bt1nadciXzOjOdsyZQE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qxUwhzi3gGFs9eu5gvR34Ug4yAk04LPTfErK54a+bLjF3ztSAY0WXywDIJNYkKkgZ
	 2ty7sYXucrDhJxFkcS+0U/AImcv4CA75sh6Lbzg9ZLw3DfUuZLBcyroMTlluVEN/Jn
	 9SxKQn4yC8DZQGLsV8Upvrb5WNCF4KiTX/qY3c90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbfJIQV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:21:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41361 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfJIQV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:21:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id r2so2109441lfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=irS7MxIYNB2GnGgL6wf/xO0qtWPCVd7suxRiO2KO4D4=;
        b=hgOaZG0duKaUR4d25pSryy7RdP9qviemEvzHvt19d0TSAxr0BfqQR3ZWYSTwR0r+9u
         i9iGymA9O3sH36uqhsrDUmdMcx0o8kfeXMJ8ye9WqAc6tizygENJM3wRYYfRkyG/AtPb
         7SOGImdQZPDoEJKjK/Y9RwyexInoc9meO+hR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=irS7MxIYNB2GnGgL6wf/xO0qtWPCVd7suxRiO2KO4D4=;
        b=s7qNf92+8rGOw0CTPGshX55OfmaeOfOa7+icxWPft9EuMagAAZf/ZfPAKdYSNxJt+8
         +Qlzk/AbjGQwf7wqM/TNVh81otUcbbaoVjcXenf0iMcEvsg56C/hYrNROGbusq9BfkEg
         K3vPGIe7yEAav8Bh7ectR3zDuguPLxdtumz265H1T3pxhuUjmquIoK8pMJUCAk+J2o2u
         ncdbh3e6pMKlvyoSrk1DvNNoBA5favPsaxlIbXi/3KZ3sJVK8WfYcMUZQhx5UJ+bRgZj
         BK/MU5Iv0oPH3Y4sImkuiB3whjpDs7kSHi8tHPLr6DL5hJz2WpnJQo+7mmqPdGuuXXZC
         vu5A==
X-Gm-Message-State: APjAAAVzxZsd9zLN0me4+ZEIUaQ0MJWm8XDW0xGKAzITGMYoy4WU07XW
        IZ7bHWs9M4QQ+XAWRh5jeLhW0JH97vk=
X-Google-Smtp-Source: APXvYqx6Hzcam3Ypq+uO0EThIbAXbuamzgKedPDH9H04UCAxe/N17wkL0ltqQAX02aff/F4sfTqLiQ==
X-Received: by 2002:a19:4b8f:: with SMTP id y137mr2730491lfa.19.1570638086080;
        Wed, 09 Oct 2019 09:21:26 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id g3sm561999lja.61.2019.10.09.09.21.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 09:21:25 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id y23so3088426lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:21:25 -0700 (PDT)
X-Received: by 2002:a2e:8315:: with SMTP id a21mr2891882ljh.133.1570638084772;
 Wed, 09 Oct 2019 09:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191008091508.2682-1-thomas_os@shipmail.org> <20191008091508.2682-4-thomas_os@shipmail.org>
 <20191009152737.p42w7w456zklxz72@box>
In-Reply-To: <20191009152737.p42w7w456zklxz72@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Oct 2019 09:21:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4waroKr-Xtcv+5pTxBcHxGEj-g73eQvXVawML_C0EXw@mail.gmail.com>
Message-ID: <CAHk-=wh4waroKr-Xtcv+5pTxBcHxGEj-g73eQvXVawML_C0EXw@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] mm: pagewalk: Don't split transhuge pmds when a
 pmd_entry is present
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 8:27 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> Do we have any current user that expect split_huge_pmd() in this scenario.

No. There are no current users of the pmd callback and the pte
callback at all, that I could find.

But it looks like the new drm use does want a "I can't handle the
hugepage, please split it and I'll fo the ptes instead".

> That's hacky.
>
> Maybe just use an error code for this? -EAGAIN?

I actually like the PAGE_WALK_FALLBACK thing as more documentation
than "it's an error, but not one you return", although I do detest the
particular value chosen, which is just a nasty bitpattern.

Maybe it could use an error value, just one that makes no sense, and
is hidden by the PAGE_WALK_FALLBACK define, ie something like

  #define PAGE_WALK_FALLBACK (-ECHILD)

or something like that.

And I suspect the conditional would be cleaner if it was written something like

        if (!err)
                continue;
        if (err != PAGE_WALK_FALLBACK)
                break;
        err = 0;
        if (pmd_trans_unstable(pmd))
                goto again;
        .. do the split ..

and skip the WARN_ON() and the odd "non-zero but smaller than MAX test"

            Linus
