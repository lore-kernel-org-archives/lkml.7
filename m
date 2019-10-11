Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F502C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DF121A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fT3cHyRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfJKHhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 03:37:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53393 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726679AbfJKHhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 03:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570779437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mnqVOKtqUNUgCWPe0XIF5Rlh7Gf3htYkoyKJklLcWqI=;
        b=fT3cHyRHjT4+A7Qw+6KGIn+JkfRmhb8V/+/4rhSH3pSifaMtWXRId4m1ovycAV4wNNhbMq
        pEdFkWna0FoNrDsrYhq6KzSk3bT/WPbozoieBEtjK+JRubSUy7LT28XRgdwBPzQX6NJliN
        SdBgILVtdxMuQve/sA3tghKi7okhYDM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-zA50sfe8NXel0Dy9PixMng-1; Fri, 11 Oct 2019 03:37:13 -0400
Received: by mail-wr1-f69.google.com with SMTP id k4so3963759wru.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 00:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MkrE9QEq1m7PqcHZU7meN7X8RfGO/KWn15Ti2Duw+14=;
        b=hsmM50lUx4msDiWqF22JmeIvMhVWxHDr4VfA9NUMdXtnvfNeBEn4bhlmeKSoNVhvlW
         ROhtqoCu4tLznWBKNC8BRWFVeP8Y9YYVYNNNwEhsj/bPFmCm2S/CK1yf/nTr4ZJeSrWf
         jkWb+BwbB2zOrk5U9HcExFpRjGU/fPz32EPQi74gMH47EE84vYrH0JyxRJldMzFiAqAQ
         V0SkkxuZQSbife7sK+dEaztpiwxlUl3CMJkUqi5/DcDRhHQKUM3mSfWHjEimlz7sxFAw
         CXGJzzD2wIataGjcLIc9NxgppR+Xdi6o0UAoX0JFDn4pnA44b7RAY5pZq8/eFAfrrNms
         veDw==
X-Gm-Message-State: APjAAAXPi2FFqTG83iWdf/8R1VXO2aMCOH2RPRQYjYQgwjsPXx15u0X2
        5Ql2isC3YGSy+UL+Dn2e+x0TJwl3QS/P5cFdPOyaxVyHU8yB1yEG/31tAowryXSQ0pbw5jUH0zQ
        TIxQjKIIHV0zRSJlV7IqZqRCV
X-Received: by 2002:adf:bd93:: with SMTP id l19mr11621710wrh.1.1570779432114;
        Fri, 11 Oct 2019 00:37:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyi1wTVbNizm1fHTc//Xnt2Tl3Bl0+bESHuDpiUXBXsrn4VuRARJTdyiQzGgmnwgcyn7b/A6Q==
X-Received: by 2002:adf:bd93:: with SMTP id l19mr11621686wrh.1.1570779431781;
        Fri, 11 Oct 2019 00:37:11 -0700 (PDT)
Received: from t460s.bristot.redhat.com (nat-cataldo.sssup.it. [193.205.81.5])
        by smtp.gmail.com with ESMTPSA id q22sm7520466wmj.31.2019.10.11.00.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 00:37:10 -0700 (PDT)
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20190827180622.159326993@infradead.org>
 <20190827181147.166658077@infradead.org>
 <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
 <20191002182106.GC4643@worktop.programming.kicks-ass.net>
 <20191003181045.7fb1a5b3@gandalf.local.home>
 <7b4196a4-b6e1-7e55-c3e1-a02d97c262c7@redhat.com>
 <20191011070126.GU2328@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <c482a958-e1f5-d39a-21e2-ade5cd41798e@redhat.com>
Date:   Fri, 11 Oct 2019 09:37:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011070126.GU2328@hirez.programming.kicks-ass.net>
Content-Language: en-US
X-MC-Unique: zA50sfe8NXel0Dy9PixMng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2019 09:01, Peter Zijlstra wrote:
> On Fri, Oct 04, 2019 at 10:10:47AM +0200, Daniel Bristot de Oliveira wrot=
e:
>> Currently, ftrace_rec entries are ordered inside the group of functions,=
 but
>> "groups of function" are not ordered. So, the current int3 handler does =
a (*):
> We can insert a sort() of the vector right before doing
> text_poke_bp_batch() of course...

I agree!

What I tried to do earlier this week was to order the ftrace_pages in the
insertion [1], and so, while sequentially reading the pages with
do_for_each_ftrace_rec() we would already see the "ip"s in order.

As ftrace_pages are inserted only at boot and during a load of a module, th=
is
would push the ordering for a very very slow path.

It works! But under the assumption that the address of functions in a modul=
e
does not intersect with the address of other modules/kernel, e.g.:

kernel:          module A:      module B:
[ 1, 2, 3, 4 ]   [ 7, 8, 9 ]    [ 15, 16, 19 ]

But this does not happen in practice, as I saw things like:

kernel:          module A:      module B:
[ 1, 2, 3, 4 ]   [ 7, 8, 18 ]   [ 15, 16, 19 ]
                         ^^ <--- greater than the first of the next

Is this expected?

At this point, I stopped working on it to give a time for my brain o think =
about
a better solution, also because Steve is reworking ftrace_pages to save som=
e
space. So, it was better to wait.

But, yes, we will need [ as an optimization ] to sort the address right bef=
ore
inserting them in the batch. Still, having the ftrace_pages ordered seems t=
o be
a good thing, as in many cases, the ftrace_pages are disjoint sets.

[1] see ftrace_pages_insert() and ftrace_pages_start.

-- Daniel

