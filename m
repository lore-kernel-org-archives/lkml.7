Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCC7C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E58924249
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="c/vG+WSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfLENKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:10:47 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34288 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfLENKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:10:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id h13so1255138plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 05:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=1shdlwho7hLS2xdM5LPSjSImPuutbJXwb9rmf439njs=;
        b=c/vG+WSN5e13KT0FhfKYEO9V2+SoAlvMYYBXfly2hPl+4hcYpbQZyv05fhQYtADcFO
         NJyEzNgzEakfx3VX18fAMLW8NR5wtr2UfnW6dus3lULbfYarpMlQkwCYhsshxi9J7PYo
         oDgA/iBpVxG+67lKdv0W4LAbcZBEUvZxqeOlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1shdlwho7hLS2xdM5LPSjSImPuutbJXwb9rmf439njs=;
        b=l+OKgDo5zhInzOP+U8EBcvseIzDEzh9R0fYEupeF5qUBNlszmgd1mU6OkhAJAOQgz3
         hU37qya8Nk8sxtzvTHqPQSoU4Hkl3cHug6c+07ALwYX91F1uaSC8ljgpBVkvA5fyjJLS
         brUR+Aulf2X3EwP+8PV/qEDJxKXgSxbTFfpyBPgqjYtRmwwFq5lacPTAxFL9hikzSa9p
         5tLeauPex7mYORq14iNKJG0JZv1SifxMXGFNGxKfqpf8vG0Ng1hpyzIYtVb/c/tMA7Z/
         PUQsEW5YTROjLBtuwjrakZA+DKn9RowsXVVc93r+ZWxcckh/ZomHnKApXOgy4Kecl4Dt
         Y5bg==
X-Gm-Message-State: APjAAAUJuQw075vIDvinpcf2Sex9Qss6CvZ/lz6rYVK3vfi5n2a6lAnA
        lV0TYzwMFzA3RJA8sO5dNDD+iA==
X-Google-Smtp-Source: APXvYqwRDra4k4ov5MNV7qiUx6oO4ScXyz9ByMUKsA2MBOhf6Udf0X4gD8qn9Cuag3ZzEEdUhLrh5Q==
X-Received: by 2002:a17:90a:7784:: with SMTP id v4mr9361713pjk.74.1575551446465;
        Thu, 05 Dec 2019 05:10:46 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-7daa-d2ea-7edb-cfe8.static.ipv6.internode.on.net. [2001:44b8:1113:6700:7daa:d2ea:7edb:cfe8])
        by smtp.gmail.com with ESMTPSA id z64sm12695976pfz.23.2019.12.05.05.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 05:10:45 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+82e323920b78d54aaed5@syzkaller.appspotmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yonghong Song <yhs@fb.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: BUG: unable to handle kernel paging request in pcpu_alloc
In-Reply-To: <20191205125900.GB29780@localhost.localdomain>
References: <000000000000314c120598dc69bd@google.com> <CACT4Y+ZTXKP0MAT3ivr5HO-skZOjSVdz7RbDoyc522_Nbk8nKQ@mail.gmail.com> <877e3be6eu.fsf@dja-thinkpad.axtens.net> <20191205125900.GB29780@localhost.localdomain>
Date:   Fri, 06 Dec 2019 00:10:41 +1100
Message-ID: <871rtiex4e.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On Thu, Dec 05, 2019 at 03:35:21PM +1100, Daniel Axtens wrote:
>> >> HEAD commit:    1ab75b2e Add linux-next specific files for 20191203
>> >> git tree:       linux-next
>> >> console output: https://syzkaller.appspot.com/x/log.txt?x=10edf2eae00000
>> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=de1505c727f0ec20
>> >> dashboard link: https://syzkaller.appspot.com/bug?extid=82e323920b78d54aaed5
>> >> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156ef061e00000
>> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11641edae00000
>> >>
>> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> >> Reported-by: syzbot+82e323920b78d54aaed5@syzkaller.appspotmail.com
>> >
>> > +Daniel, is it the same as:
>> > https://syzkaller.appspot.com/bug?id=f6450554481c55c131cc23d581fbd8ea42e63e18
>> > If so, is it possible to make KASAN detect this consistently with the
>> > same crash type so that syzbot does not report duplicates?
>> 
>> It looks like both of these occur immediately after failure injection. I
>> think my assumption that I could ignore the chance of failures in the
>> per-cpu allocation path will have to be revisited. That's annoying.
>> 
>> I'll try to spin something today but Andrey feel free to pip me at the
>> post again :)
>> 
>> I'm not 100% confident to call them dups just yet, but I'm about 80%
>> confident that they are.
>
> Ok. Double checked BPF side yesterday night, but looks sane to me and the
> fault also hints into pcpu_alloc() rather than BPF code. Daniel, from your
> above reply, I read that you are aware of how the bisected commit would
> have caused the fault?

Yes, this one is on me - I did not take into account the brutal
efficiency of the fault injector when implementing my KASAN support for
vmalloc areas. I have a fix, I'm just doing final tests now.

Regards,
Daniel

>
> Thanks,
> Daniel
>
> -- 
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20191205125900.GB29780%40localhost.localdomain.
