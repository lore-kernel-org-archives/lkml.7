Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464E8CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173992166E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571658334;
	bh=kXNR3wT0/UVOuL9IMKXFJQDaSuOBaG3FsYDFFGkst5o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XVXjOsY7A7CJkz3X+6fJtJMtMBk4dCUVSrwJ+sD29p/2lvPsreNTegl6Bo9XCCqc3
	 m3bqqUqKaZvop8hFEOVwUvi9NvE8fKqVwZMqRA/HOf+opiim3f40BDDnA/a/WXh4dE
	 7BYMT5T23/fkH7IBD2diYL7nNdnKnPeeXwEVWLmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfJULpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:45:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34803 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbfJULpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:45:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19so12968727lja.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 04:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dwxj+uOUwiu2R0WFfBHrgW9ls+QdQwTPDol7q0pKZ3g=;
        b=DiJhkOHHFUpKDOyxqHB4vaKmVpAstfvhXZIH4GkcCFzoF5QWbnyBOFNNm6UpRicVgI
         nEoYUkbP8FlO//n5TfoPf37YJpVoTBQsy12/8bfGZf9e+74Opqtm7XODV/VV7FRUaCYG
         SETbygzuap2Mr/iVlQcyZCqAWCkC1rtzVkHhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dwxj+uOUwiu2R0WFfBHrgW9ls+QdQwTPDol7q0pKZ3g=;
        b=uHdsD7K1D4nBYzUZ83JbEeU7xZvQW5GpEgk7fr816EabelPG9eSWMF6yjGqHimV1Wr
         6sIkay0JX+94Qn4R0trmDyDCm74/gVPx2FtsqoJdVvoJkSs/HwZWUr391ZQS9L10DdAk
         VLNzAzCGMJm/0BjS0ffEqaPoDeHSt95zY7afilyZihD+JUQkTNkvtrLgUXqzcJwrKSdV
         Z6lzXu6W95TxkUakbMq24hAIzBZuxjuIf5VSUnK5c5CxT2BCxXaKey39teTKP4L3IYkD
         zGzCNj9vF587BJxEFKcVGn1v48AHGE6B+n/aKqQ3lV/v9FImtP8/TFjOAbysNyFkyxML
         eiEQ==
X-Gm-Message-State: APjAAAVPrMRgSMUf/AF5RieCkMNjilcw4MgsLRKNAROEFOVAl8i7gTRD
        mjkMDY4Ml87WwcXnw35MR9iADHDiqhdolw==
X-Google-Smtp-Source: APXvYqyyX04l88SbnqYWVMsLXQlUIpE4qUWOcB5TcIM+9Hd1KCb622jE+DZ7ZJrPSr/7EztN47qytw==
X-Received: by 2002:a2e:9cc9:: with SMTP id g9mr14308079ljj.178.1571658329087;
        Mon, 21 Oct 2019 04:45:29 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 10sm1622035lfy.57.2019.10.21.04.45.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 04:45:27 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id j19so12968543lja.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 04:45:27 -0700 (PDT)
X-Received: by 2002:a2e:9848:: with SMTP id e8mr14847939ljj.148.1571658327338;
 Mon, 21 Oct 2019 04:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191017234348.wcbbo2njexn7ixpk@willie-the-truck>
 <CAHk-=wjPZYxiTs3F0Vbrd3kRizJGq-rQ_jqH1+8XR9Ai_kBoXg@mail.gmail.com>
 <20191018174153.slpmkvsz45hb6cts@willie-the-truck> <CAHk-=whmtB98b8=YL2b8HzPKRadk2A9pL0aasmvgebhePrDP9w@mail.gmail.com>
 <20191021064658.GB22042@gmail.com>
In-Reply-To: <20191021064658.GB22042@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Oct 2019 07:45:11 -0400
X-Gmail-Original-Message-ID: <CAHk-=wgxm_w-BCEuBOFnRpTwQuCYwMtsDNz3cW0MDGEmQZTUGg@mail.gmail.com>
Message-ID: <CAHk-=wgxm_w-BCEuBOFnRpTwQuCYwMtsDNz3cW0MDGEmQZTUGg@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: Fixes for -rc4
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 2:47 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> I think at least once I ran into that and sent you a 'slightly wrong'
> diffstat - and maybe there's also been a few cases where you noticed
> diffstats that didn't match your merge result, double checked it yourself
> and didn't complain about it because you knew that this is a "git
> request-pull" artifact?

Right. If I see a diffstat that doesn't match, I just look at what a
non-merged diffstat would have looked like, and if that matches I know
what happened.

There are other reasons why diffstats won't match, of course. Like me
just having merged part of the same commits from another source (or
multiple trees applying the same patch). So it's not _just_ due to
multiple merge bases that the mis-match can happen.

> Most of the time I notice it like Will did because the diffstat is
> obviously weird and it's good to check pull requests a second (and a
> third :-) time as well, but it's possible to have relatively small
> distances between the merge bases where the diffstat doesn't look
> 'obviously' bogus and mistakes can slip through.

Yup.

> Anyway, a small Git feature request: it would be super useful if "git
> request-pull" output was a bit more dependable and at least warned about
> this and didn't include what is, from the viewpoint of the person doing
> the merge, a bogus diffstat.

Well, warning for it would be fairly simple. Giving the "right" result
isn't simple, though, since the merge might need manual fixup to
succeed.

The warning you can check yourself: just do

    git merge-base --all upstream mybranch

and if you get more than one result, you know you are in the situation
where a diff from the merge base might not work (it *might* work, but
probably won't).

You can play around with it yourself, of course. Look at the
git-request-puill.sh script, it says something like this:

  merge_base=$(git merge-base $baserev $headrev) ||
  die "fatal: No commits in common between $base and $head"

and you could add something like

  all_merge_bases="$(git merge-base --all $baserev $headrev)"

and then add a warning if "all_merge_bases" doesn't match "merge_base".

                Linus
