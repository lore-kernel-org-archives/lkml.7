Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94027C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617BB218AF
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567875526;
	bh=B009PTRLUBN8wurk7CoBAwKLSysKQ4xtBud+BIdBHwM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EZOX88N/qaB6DDnR0nsiuZLYGC6PpkMMKxK2/Q158OpI8H2/vf0R/ZzCrw5WrfsTg
	 hfMcPZYoVozMXAqF7c0qxKtl9oIQqP0ehBNJ8Wtda2lMnCQU8hheDVpKYhOsLcPdgo
	 g44eMKlmCdEETy+NErXMDp9KebKKsHGgHVOledyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395051AbfIGQ6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 12:58:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40928 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392087AbfIGQ6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 12:58:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id u29so7426042lfk.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 09:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VaxRwZcXIqBCeM77ijL8A1h5NduVbQyHYByckmz1gJk=;
        b=Ldlyq4Px8HcWw652TFUFBz92WQlbW6hSwxMlCjQQ7ArJ4KZCkRlTmS1rpYbWoVnDTP
         m2fPZeqordNjkxzXe2jf1KmkqKcGf1nJr407YEJX5jdvDfinEa81A2+g7kiafJJQtJkb
         2rcL8ecVWF8zjmoPoJgLSziuzeA0NFXkftsDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VaxRwZcXIqBCeM77ijL8A1h5NduVbQyHYByckmz1gJk=;
        b=kJ56XFnkosrSSITq/DyDgqOrRxIcRfNZVz9EoYQIftY19KaX7lbt2vFL6omKnbXdWx
         7BzP9GKWWlYDQClm5QK0kFmuxmm+zqmk91EHLm3myJ48BJ8HuE7V36KQrxYSQOkqvCeR
         Lhg++QDE9t3acMC69IZUmT63UjcIu2mjbuCa0OY4aBizQC4JVEw+eUG3yvHmLGpY90Ex
         pK7NKqPocQNk5P0t7xRgBNHrIrZXvOtU14SQMhOAh4GZod2vvdsxV34FnhSf6YRzFh9K
         lNT5BwGFTLUA4ZG9BSWRVdHbpdQJW20S/VPTkM3mt2fHguLaGqw9VwIKz9i20YcSX9Gz
         YP3w==
X-Gm-Message-State: APjAAAX/MTKLv0gfiB1HZm4E3ixMVAVzKK4QRtUarGG6KsV3rIwV9KSP
        x1RqADkgIBPM/yBBrg87qaylaZXVuvg=
X-Google-Smtp-Source: APXvYqzY/j9Oyy35tIIqOeuxtHwggE0fx0sXZQiwLW8qgscyWJJPF73lAIvtcaKMXFKMgDKJgPSapQ==
X-Received: by 2002:ac2:414b:: with SMTP id c11mr10127868lfi.159.1567875522546;
        Sat, 07 Sep 2019 09:58:42 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id u1sm1786531lfi.83.2019.09.07.09.58.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2019 09:58:42 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id x80so7451871lff.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 09:58:40 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr5583225lfh.29.1567875518853;
 Sat, 07 Sep 2019 09:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190904201933.10736-1-cyphar@cyphar.com> <20190904201933.10736-12-cyphar@cyphar.com>
 <7236f382d72130f2afbbe8940e72cc67e5c6dce0.camel@kernel.org>
In-Reply-To: <7236f382d72130f2afbbe8940e72cc67e5c6dce0.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Sep 2019 09:58:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZx97Nm-gUK0ppofj2RA2LLz2vmaDUTKSSV-+yYB9q_Q@mail.gmail.com>
Message-ID: <CAHk-=whZx97Nm-gUK0ppofj2RA2LLz2vmaDUTKSSV-+yYB9q_Q@mail.gmail.com>
Subject: Re: [PATCH v12 11/12] open: openat2(2) syscall
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
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

On Sat, Sep 7, 2019 at 5:40 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> After thinking about this a bit, I wonder if we might be better served
> with a new set of OA2_* flags instead of repurposing the O_* flags?

I'd hate to have yet _another_ set of translation functions, and
another chance of people just getting it wrong either in user space or
the kernel.

So no. Let's not make another set of flags that has no sane way to
have type-safety to avoid more confusion.

The new flags that _only_ work with openat2() might be named with a
prefix/suffix to mark that, but I'm not sure it's a huge deal.

                 Linus
