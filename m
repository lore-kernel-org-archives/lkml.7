Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B70EECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625EC2190F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570637243;
	bh=omuvI8tcWIRVZXmB2kCfE78huCBZH0SWW5F75XvFvWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=irygIzUgIdebjg3XNmrR1CC23d0WRBUda+sUQnbnaPX69Fcxb9LuPL9+to3JXzkCS
	 +NMgXJ1KvV5sReqCP7Am0FLyyd6Y8fFxLJtzhwr1RfWOfXLR75yMf3hDU+KbpAK8uk
	 k0G07h2zCIP7pXtOIXJpSpkImBaK02CRSpXSn95w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbfJIQHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:07:22 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35935 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbfJIQHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:07:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id x80so2098514lff.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rELG+/plJf3q+d36O9HDInY1Dcun/TTnnrXLzjvo97I=;
        b=TPnX+oMwcZyLImXtu7vSmBJQjvRZnSeQpjwCcSjIw1iXfTFPyHdDvmfv+2sxkpfUyj
         JFzZ1ddVjpVh5f2wFQpWMAb1+pTNRk6pnMCBs485QzCeAoFiVhQRRIOvJXJq1c8093k8
         4e41ajmn2pB8buojmlyKC7PzJa0CJ57eJp4cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rELG+/plJf3q+d36O9HDInY1Dcun/TTnnrXLzjvo97I=;
        b=s/0Ln7Pld1jfikZMtrj/rGlVbsb0DDsTE1j/vxlPfRmojqO38derewYzNo+G0Eln0B
         RxsnVNBIMNL3mOKyt+aqZpgqk4WqWz4FzHzD5Fiav7OFe730jvFwjRsEtFVVvBewNAFt
         5bswWTBhQ8quiUO+kGdCXpTwX1cNNIhWXFk5YS90evR8YBKEvRo9Bp5Au0Rm+YCG0Tv6
         iib09cVZsED6OkX30Us6G9fDVFx07tKiglYeq0rwVaxHGfDpZFiFvZbBHrRRBLx2/Mo5
         JycvD28Gttqzqf09oLq8lz8OzO1WRkoqLlapYUwcDxo+kYPmwjeABEpk0RJ2WJ5FaUwT
         UlDA==
X-Gm-Message-State: APjAAAWMeJtV/H/ZEs5bzCqdw3bYQF5zR9wJKKuIFIqWZUQ7xqMmfsBF
        7nPc5JWrVYMWsuZLFS1OnI3JM6rp5m8=
X-Google-Smtp-Source: APXvYqw3G2cuz7qdvPPQi9EMel/ifloICn7seBmuSxhsZ++7U2pzlKrdyXqCerIocL5HakIaU2PSgw==
X-Received: by 2002:a19:f707:: with SMTP id z7mr2511154lfe.162.1570637239228;
        Wed, 09 Oct 2019 09:07:19 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id i6sm568201lfo.83.2019.10.09.09.07.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 09:07:17 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id y23so3040363lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:07:17 -0700 (PDT)
X-Received: by 2002:a2e:9117:: with SMTP id m23mr2902767ljg.82.1570637236839;
 Wed, 09 Oct 2019 09:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191008091508.2682-1-thomas_os@shipmail.org> <20191008091508.2682-3-thomas_os@shipmail.org>
 <20191009151400.bserdtpoczmawqn5@box>
In-Reply-To: <20191009151400.bserdtpoczmawqn5@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Oct 2019 09:07:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=zsXPmSTJJgEgVr4ebgwTQ-wx-P1c7+koJAK-h2f_vQ@mail.gmail.com>
Message-ID: <CAHk-=wh=zsXPmSTJJgEgVr4ebgwTQ-wx-P1c7+koJAK-h2f_vQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] mm: pagewalk: Take the pagetable lock in walk_pte_range()
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

On Wed, Oct 9, 2019 at 8:14 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> If ->pte_entry() fails on the first entry of the page table, pte - 1 will
> point out side the page table.
>
> And the '- 1' is totally unnecessary as we break the loop before pte++ on
> the last iteration.

Good catch. Too much copying the wrong pattern from other sources.

I do wish we didn't have this pattern of "update pte, then do
pte_unmap as long as it's in the same page". Yeah, it avoids a
variable, but still... But it is what it is, and we just need to be
careful.

             Linus
