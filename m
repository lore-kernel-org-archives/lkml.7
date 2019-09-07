Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2BEC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FB320578
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567878357;
	bh=msHmPyEJDzQFsZmLPdWi5gjJmS+VqKjbTg7O/MhE5Lo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2NAjvQPEhkg2gxOePng3c6Rb30Oz2pQqnzk/bbUzY3WTPRax7ybhSBGcTzI2weGY4
	 4P96I3hpaXC8lInH6Kmb9Md3rS4aexE4DRZA1FXFkIL1kIbfBY4NZQHaaVNFcF/bVT
	 X9e0cfEGXvr3uih3KHMJdRqGbUI5ltLbMLfGI1mM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392825AbfIGRp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 13:45:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43644 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfIGRp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 13:45:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id q27so7470216lfo.10
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JJRFoANDdA7LVjR/dXOt13NCYJCwAkkvMBjFRYL2CJk=;
        b=O0k0d7lqzfAmPEYFzDlOGgQsR12LVtrvxo5oTKj/qTWwdx05EQgXW+UipRXAFcHY7l
         NJSN5sB8Bd0GzZnsutsLrlnHa03N+sVzppgC400AeuuF3leAik8ua94YYTL1N/jeDSEY
         p0NLqzIjW/MddvLJPDdxPws4zfzc5nCUgJ+sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJRFoANDdA7LVjR/dXOt13NCYJCwAkkvMBjFRYL2CJk=;
        b=jlFoH77ChZsxxILHou9LH2joFVpkUjZZlxwhZAP5yvUEAaDNubvNL09hVzzIbmCC36
         6fFgZodt/KlZ2N0FwbDAuvnk1Dov5Ew0VfY6g19MtNq8EczUqVL8SEoMVEQk++JKwU6J
         d1iG0HoQRJoniUogltFxRlWdSAWCMhmeDEAjk7lWEoru/53bCf0W4qcGIg4cp6My7nFQ
         1jd4wx2lp0UrzLzsIRsMIKQJPvqZ0/iKA/YEMEHZ5nr1lsu39pong73ifY3iJqUpQ9G5
         pQ3aY2X8XmI7qKScljeQZCzaXz+aZWIumYkWjdN/9S0MozBCAM3bCTESFa7PkpOd1se3
         MK7Q==
X-Gm-Message-State: APjAAAWZ+UD/JCU1MEQRBoP9ZKZmPsOxgqRj4QhY3VNqO5wr4IQ+Pu2r
        XHYAebo5AART6b0mrOyNvDJU7MN20Do=
X-Google-Smtp-Source: APXvYqyEbNx6/EyRozWuL1nehgWWvsj31eEMKHNgdsi3sB6j/ySeygyGpUvHdKrTkLZehiehFbH1yA==
X-Received: by 2002:a19:7609:: with SMTP id c9mr10188686lff.91.1567878353645;
        Sat, 07 Sep 2019 10:45:53 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id f22sm1824470lfk.56.2019.09.07.10.45.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2019 10:45:52 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id e17so8856107ljf.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 10:45:51 -0700 (PDT)
X-Received: by 2002:a2e:8645:: with SMTP id i5mr9691835ljj.165.1567878349245;
 Sat, 07 Sep 2019 10:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190904201933.10736-1-cyphar@cyphar.com> <20190904201933.10736-12-cyphar@cyphar.com>
 <7236f382d72130f2afbbe8940e72cc67e5c6dce0.camel@kernel.org>
 <CAHk-=whZx97Nm-gUK0ppofj2RA2LLz2vmaDUTKSSV-+yYB9q_Q@mail.gmail.com> <C81D6D29-F6BF-48E6-A15E-3ABCB2C992E5@amacapital.net>
In-Reply-To: <C81D6D29-F6BF-48E6-A15E-3ABCB2C992E5@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Sep 2019 10:45:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whe90Ec_RRrMRLE0=bJOHNS9YmVwcytVxmrfK3oCuZF6A@mail.gmail.com>
Message-ID: <CAHk-=whe90Ec_RRrMRLE0=bJOHNS9YmVwcytVxmrfK3oCuZF6A@mail.gmail.com>
Subject: Re: [PATCH v12 11/12] open: openat2(2) syscall
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Jeff Layton <jlayton@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 10:42 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
> Linus, you rejected resolveat() because you wanted a *nice* API

No. I rejected resoveat() because it was a completely broken garbage
API that couldn't do even basic stuff right (like O_CREAT).

We have a ton of flag space in the new openat2() model, we might as
well leave the old flags alone that people are (a) used to and (b) we
have code to support _anyway_.

Making up a new flag namespace is only going to cause us - and users -
more work, and more confusion. For no actual advantage. It's not going
to be "cleaner". It's just going to be worse.

                 Linus
