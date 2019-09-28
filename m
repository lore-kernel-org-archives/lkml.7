Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E68C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 20:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFE42081B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 20:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569704389;
	bh=dHDQcB7svL+eaSBP54YSK8pf/T/f1vQZyVio5FhayY4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cD3nWqkRWXad6n2h1/TyYag1+qZnbKrZwhX45tPSvlT65X7sf0IMiZbvX2B4a6V6d
	 ivM5ZSIpLtNi9Hymqo4qFScp4gkDulKNBFRv9swem2AXjD+wKTTkwtjRDQ0/wkAtdK
	 OkB4uMCJuTRkvfwWlAaDRvceQOiO1atTx7izxAug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfI1U7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 16:59:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34756 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfI1U7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 16:59:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id r22so4331648lfm.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nA9XhvmDPP8zs4JjFJOeuslROAGPKec0VWKiDgsMsAo=;
        b=KRjbob1tCwjO/4jj3ojiuB847HVXl9G3M3ASy8896FQecUQKkH8RBaQGBAfLo10wgC
         5Wtk1CVZ9RRM0oi/PQuiyCxKBXmdArn14By6S/8TM9oV+tPdagEWeiX+DNez5JG7Q5BM
         WYxuQ/5vFBl/OQqgpeNL/iaJDj9FOMM3O4ffY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nA9XhvmDPP8zs4JjFJOeuslROAGPKec0VWKiDgsMsAo=;
        b=TOPFMuGENJ+XsrUXGVGpip51PGl7mQissKuOI1JqEM7UrzICfkdJ5SL5XikNP03xyL
         n96UJL6r1Syz2QOg56E9T1829+NIvxmaGDbDNXNlYb7ARnkirkzjcb9as9/zwzTLTAcU
         ZW7zaKGZHR10tgQrlrNWc7kqZAwF7m/7i3IVTHm2DbxNjk4F4XdUhl8/kPkRfD97S7su
         oI4sLaEKdXYvoDiD7JgB+a+pJ+dWXAgdHG6QcCjtey3JzQo63wa2g+c4Ol2sQPGzGlpz
         FKP9703ZrQQ65SOwBrsK3JMOQn5raf4+pQubqOcvbK5vsQZUTN2tWW2ZBwR+k3rbFEf2
         dPDw==
X-Gm-Message-State: APjAAAWokAwV5Q9+HaWARzmZfmh/bZA/vaUiYUb6r9x5b/XtZB3LZC2k
        fMHo2jNML/6i6EEgoDnQLTqUSHxuZ+c=
X-Google-Smtp-Source: APXvYqzgc0spkHVDJJrrKCRAUxx5QBstaZ18oxLz4Ui2CMry7K70LKs1LeJI4o9Qf54p1xyaqk7DmA==
X-Received: by 2002:ac2:4a8f:: with SMTP id l15mr6931075lfp.21.1569704384110;
        Sat, 28 Sep 2019 13:59:44 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 196sm1529898ljj.76.2019.09.28.13.59.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2019 13:59:42 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id c195so4300735lfg.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 13:59:42 -0700 (PDT)
X-Received: by 2002:a19:7d55:: with SMTP id y82mr6858954lfc.106.1569704382232;
 Sat, 28 Sep 2019 13:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1909041252230.94813@chino.kir.corp.google.com>
 <20190904205522.GA9871@redhat.com> <alpine.DEB.2.21.1909051400380.217933@chino.kir.corp.google.com>
 <20190909193020.GD2063@dhcp22.suse.cz> <20190925070817.GH23050@dhcp22.suse.cz>
 <alpine.DEB.2.21.1909261149380.39830@chino.kir.corp.google.com> <20190927074803.GB26848@dhcp22.suse.cz>
In-Reply-To: <20190927074803.GB26848@dhcp22.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 28 Sep 2019 13:59:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgba5zOJtGBFCBP3Oc1m4ma+AR+80s=hy=BbvNr3GqEmA@mail.gmail.com>
Message-ID: <CAHk-=wgba5zOJtGBFCBP3Oc1m4ma+AR+80s=hy=BbvNr3GqEmA@mail.gmail.com>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote hugepages
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 12:48 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> -       page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
> +       if (!order)
> +               page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
>         if (page)
>                 goto got_pg;
>
> The whole point of handling this in the page allocator directly is to
> have a unified solutions rather than have each specific caller invent
> its own way to achieve higher locality.

The above just looks hacky.

Why would order-0 be special?

It really is hugepages that are special - small orders don't generally
need a lot of compaction. and this secondary get_page_from_freelist()
is not primarily about compaction, it's about relaxing some of the
other constraints, and the actual alloc_flags have changed from the
initial ones.

I really think that you're missing the big picture. We want node
locality, and we want big pages, but those "we want" simply shouldn't
be as black-and-white as they sometimes are today. In fact, the whole
black-and-white thing is completely crazy for anything but some
test-load.

I will just do the reverts and apply David's two patches on top. We
now have the time to actually test the behavior, and we're not just
before a release.

The thing is, David has numbers, and the patches make _sense_. There's
a description of what they do, there are comments, but the *code*
makes sense too. Much more sense than the above kind of insane hack.
David's patches literally do two things:

 - [3/4] just admit that the allocation failed when you're trying to
allocate a huge-page and compaction wasn't successful

 - [4/4] when that huge-page allocation failed, retry on another node
when appropriate

That's _literally_ what David's two patches do. The above is purely
the English translation of the patches.

And I claim that the English translation also ends up being
_sensible_. I go look at those two statements, and my reaction "yeah,
that makes sense".

So there were numbers, there was "this is sensible", and there were no
indications that those sensible choices would actually be problematic.
Nobody has actually argued against the patches making sense. Nobody
has even argued that the patches would be wrong. The _only_ argument
against them were literally "what if this changes something subtle",
together with patches like the above that do _not_ make sense either
on a big picture level or even locally on a small level.

The reason I didn't apply those patches for 5.3 was that they came in
very late, and there were horrendous numbers for the 5.2 behavior that
caused those two big reverts. But the patches made sense back then,
the timing for them just didn't.

I was hoping this would just get done in the mm tree, but clearly it
isn't, and I'll just do my own mm branch and merge the patches that
way.

                Linus
