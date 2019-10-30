Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268FCCA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 07:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11FB20874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 07:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572418957;
	bh=1yqCg+h4IXZL8j8aQxs51mSz00JxiV5G4EM5WAge67Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mm9xwa/mXYXt8Ac4Xmu+Q8Gfn+zBtNgx8xpOwUUInPACk88KOy5S95og6ek/kCYg9
	 aannix37Pkyow8SCacO0GFgWsA+Qe8ANkDFz1xW9lr0L0zRGA2NQ4hniTCY/mF3eEr
	 AySxqz+Gs/RqHA1PCgzs/mQbMEv5d89csk1NF32w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfJ3HCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 03:02:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37843 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfJ3HCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 03:02:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id v2so1389470lji.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 00:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JkPxjSTbXJRVlSsGsdM45+hTs410YbmCCQkse72XJ4Y=;
        b=EJUY1JQv+QdQjb/gEObNMcJ78C0IhEJfrdoWxqU34kB9i8Bg/sWh/y3mgavhGW/PEq
         vhD7pUJS4U+vzBOM2zuUAC9zkjBi+8tmMTFlpxoi0FPmyW1RXKur3WY5NqokJ0g4R2wy
         7TiXXVvHYhvBEsiZolrKl8XydGUo3K1rzh3Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkPxjSTbXJRVlSsGsdM45+hTs410YbmCCQkse72XJ4Y=;
        b=n+6UKQCTSG7C2kZuwpwAQLsg5KShxiBi/fk8psjlOzhGC9N/+mibKd2ZoydFTw3HTZ
         3wk92kh2xpFN0XPBmz7q6Tq+Ux/prF1nVliS7IHj6bFqEYLV91HBYa6BbvNYMtwAOCwn
         ots+SMdvCA3g3gQ5GPwnYAbGF+Zc5RxGm/JHjSLUNmU96peXVf5y9qYjE8OiuzMsg9g3
         5Siic4fgMYsn8yE3ba9/+mD3TJ5MKus8QYSNcBXpTsnrcJi3tAtsZSh2Pbl7Cme66DBJ
         smR+3JqaSqOAotJlcEtMmRAn13xXyFhBKRJsG6N8bglC1y2VPkY8YV0Z6Q9MJuQ2+maO
         BK/Q==
X-Gm-Message-State: APjAAAXAFSToVqnNeUdICJ5u33oFeaZnOAf0w0aOBoLOMe6P5SxY3yY8
        577bSnhwkYeoP8wQO5I9L/pD7+LFPg+bkA==
X-Google-Smtp-Source: APXvYqz4yLVmitgYnJ5F/IiXw5jYtvB70WEMWeVM4SEpfUufsleaWHHGfJiDFK3d5gX9Af1NB273Dg==
X-Received: by 2002:a2e:9888:: with SMTP id b8mr4840075ljj.167.1572418953692;
        Wed, 30 Oct 2019 00:02:33 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id p88sm684246ljp.13.2019.10.30.00.02.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 00:02:31 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id q28so688942lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 00:02:31 -0700 (PDT)
X-Received: by 2002:ac2:5bca:: with SMTP id u10mr5108158lfn.134.1572418950853;
 Wed, 30 Oct 2019 00:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <157225677483.3442.4227193290486305330.stgit@buzz>
 <20191028124222.ld6u3dhhujfqcn7w@box> <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
 <20191028125702.xdfbs7rqhm3wer5t@box> <ac83fee6-9bcd-8c66-3596-2c0fbe6bcf96@yandex-team.ru>
 <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com> <20191030065037.o3q6usc5vo3woif6@box>
In-Reply-To: <20191030065037.o3q6usc5vo3woif6@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Oct 2019 08:02:14 +0100
X-Gmail-Original-Message-ID: <CAHk-=wimHFUTrEiP-m8hKi78NRoaGtwG06=Pqe3TghmsUQL9Xg@mail.gmail.com>
Message-ID: <CAHk-=wimHFUTrEiP-m8hKi78NRoaGtwG06=Pqe3TghmsUQL9Xg@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Steven Whitehouse <swhiteho@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 7:50 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> I don't know much about filesystems, but can't size of file change after
> the open() under network filesystem? Revlidation on read looks like an
> requirement anyway, no?

Requirement? No. But QoS issue, yes.

But note that NFS already does that. Look at nfs_file_read(), and
notice how it's not using generic_file_buffered_read() directly, it's
doing its own thing first with checking for direct-IO, but then doing
that nfs_revalidate_mapping() that checks whether caches should be
re-validated.

It's not just size of the file, the actual cached contents may need
invalidating too etc.

And note how the generic page cache reader doesn't need to care. If
what the generic code does isn't enough, or is the wrong thing, the
filesystem simply shouldn't use it, or, like NFS, do its own thing
first/last.

So I think the "some filesystems may have other rules" is irrelevant.
If they do have other rules, it's _their_ issue, not the issue of the
generic page cache read logic.

             Linus
