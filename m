Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620C3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EAE20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551667102;
	bh=scsFAmvxg5YiYqEyqd+IlgGunvcOusKcMPrUtzNXUaM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0sbBhwVX2/bf3cjHJJP7aZ/vczhx4JzufwpOyWfIGMtfjVv3Zs+J9ETKGAk/lG3GA
	 K6MiBJmqgpq8uxsQ4NG2MUJSSLao3Z1fvULcwst3sSd55TpmgI01c+mICKFEDJpiiS
	 i3hV8gR+fPuR+QQdUvvPG0H3l1j/I549DyO/nDHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfCDCiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 21:38:20 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44057 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfCDCiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 21:38:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id q128so2921870ljb.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 18:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4JrruaKr/DC29lA6rXyh+567cPmWV36kSmiJipTZUsY=;
        b=XAJuR9aG9KY9lQh2pBmcElx3sE+8A5ktEUPGY4prQ7XEQkzfH03a+OOJdNPjZQ3ekl
         NPLMVaRx5AciOTI2z/LCFPhukCjBMxKeY/3ca6SV1ztzHF2weHLJSe0lpIaUoWDLwoDy
         fZ7m8cp985IF3IoFKXA+WZDGYJHxez2F/71xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4JrruaKr/DC29lA6rXyh+567cPmWV36kSmiJipTZUsY=;
        b=o6VFsrbWRQjDNqyZGMsJurkYIhEwGDWs8yv6V7Cul6qplNYLN4p84T2eU8kbodwuli
         lqm9WDtSt8IT7K7Ohm3L9aD292Wi+HCH5H6z8O9WOby1PoK99e0HjRR3MtBCSXCaXSzf
         vYYuzM8sKZqmD03DHzjVQdhvMgtyDzhT8GBHdnEZmlJKVyRNwCtwoCEGXzWjTq0ddxDP
         dUzL4r+W+zoMQjmVBDmdIT214VSWdgYTrwpxIDXbT3U8LjUyWLls3vSu/P036SY3aifG
         cVT6ykGNEKMYYPDoU8CYcBXLa1RqQi6JetkLQPSnZRpgnA7PegiLONeX/GdUhA1wGbtZ
         Kdcw==
X-Gm-Message-State: APjAAAVZG7Z/wdOhrB2GzUYBMNcObj6YRgzZcX0WBdcUudpbpjQQNnrS
        gTNjv6DT4x9Xw4NXqGdLRiigEOBmsG8=
X-Google-Smtp-Source: APXvYqxo8pNQm6H1xrQ7t3bNONuwcTEOfVHtC52cgX+MViGbh42o1iOyj9ozKbN7TG6xDe6qrZ1PHQ==
X-Received: by 2002:a2e:9b15:: with SMTP id u21mr9337526lji.82.1551667096619;
        Sun, 03 Mar 2019 18:38:16 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id y30sm1251196ljd.12.2019.03.03.18.38.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 18:38:16 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id d26so2378987lfa.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 18:38:15 -0800 (PST)
X-Received: by 2002:a19:c744:: with SMTP id x65mr8983080lff.148.1551667094892;
 Sun, 03 Mar 2019 18:38:14 -0800 (PST)
MIME-Version: 1.0
References: <155136980507.2968.15165201054223875356.stgit@devbox>
 <20190303173954.kliegojbuigqi5tn@inn2.lkp.intel.com> <CAHk-=wij8VLupHh1U-fFhFBjin9Fch3mG2_2=aL9h1L+WBvm2g@mail.gmail.com>
 <20190304101434.8429ffffb17813c0e7930130@kernel.org>
In-Reply-To: <20190304101434.8429ffffb17813c0e7930130@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Mar 2019 18:37:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=whYMvevgF4yh7uhQug=Wt1A1Eg7abyM=RCi=bQiqiMBvQ@mail.gmail.com>
Message-ID: <CAHk-=whYMvevgF4yh7uhQug=Wt1A1Eg7abyM=RCi=bQiqiMBvQ@mail.gmail.com>
Subject: Re: [uaccess] 780464aed0: WARNING:at_arch/x86/include/asm/uaccess.h:#strnlen_user/0x
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com, lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 3, 2019 at 5:14 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> I think it comes from WARN_ON_ONCE(!segment_eq(get_fs(), USER_DS)) in
> user_access_ok(). The call trace shows that strndup_user might be called
> from kernel daemon context.

Ahh, yes.

We've had this before. We've gotten rid of the actual "use system
calls", but we still have some of the init sequence in particular just
calling the wrappers instead.

And yes, ksys_mount() takes __user pointers.

It would be a lot better to use "do_mount()", which is the interface
that takes actual "char *" pointers.

                    Linus
