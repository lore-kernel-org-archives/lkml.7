Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6002BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E02208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567633519;
	bh=oKN6y+BD97HuD2RBNoiSMpbHH7QPlm3FLMHKjaadJ48=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gMUrWJYyPlXRyO2BVjZ2a0ADs2fi5YwSivqn2P7N6vOTtx2ZDg3ivyy1OIg2ZOWGP
	 2deeeQJ85ku2PH6osSwKrCRv2qX7dYTmOcyKQ3lVBzLquHjKJno36htBcA8zut3Z2o
	 YlisGfdo5ydn1FP8IBQFVZqeMrbCYtMg9Fsd9nvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfIDVpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:45:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37628 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfIDVpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:45:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id t14so246492lji.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afyKDAGEEGBbAV94gj2UOZt2XiwokGAAZY9fEg48q/g=;
        b=NaaXzsE03/A0aggT0JGsMPgqMPOgw689sbkH2wUyL6Wp3qKaZ1pKjDt9q3nSCqMPah
         2e4dX/SHASPLfri+fuLDS7WlObVzMB0uCQ613gb+lr0h/VEtc5FGRP26lR62YK8De+Ct
         /QjcaW9K7a4FCLT2Siyb/L/tVCZoNkYi2RP38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afyKDAGEEGBbAV94gj2UOZt2XiwokGAAZY9fEg48q/g=;
        b=IMdju0b+UyxLRqxZm9j55H5qUBzYHxXLTZAd8UXF64NAFEqQvnvyow/XYufFqk9i+x
         v37ik4IJg9v7W/vV8sa8kzkHsvV5S+s5aFjUHiZIukxFTR3rWGGREkLn/qPY5wOMDRU2
         4NtfENJbtqcgYgF3XeGi4/Ew9sjtyt8dEqiCQ0YcAxuNn+Oh8hF4XVaeGbX/Kl/bgEq9
         N52m/4nIyedkSCq4zomLFZELn5ATLTn+Ny5vpYFkHR3E1bRxlFuuk2oBGefRTS0X8yjg
         qeU8Of7jU0KmBGKlfpnDJqIuru6+VrnR3yc6TTwbNzu8jkaplzfE2cjR3Eq4UY9sTHUs
         DO6Q==
X-Gm-Message-State: APjAAAUcZ0Pipf6y/8q/4v0ohRYUP2txRc36RXbRAqkf4fRkNB1DCl4o
        +0BrX0KUSzwx13ZXNnSp+Nmrcb5+QDY=
X-Google-Smtp-Source: APXvYqwz92fAW9fe7hVWQI+K9lri8pCuEemgLDG06mgW150jnCxewNNrOEvvyoUoHR4EVfiXrKv0Mg==
X-Received: by 2002:a05:651c:292:: with SMTP id b18mr8210270ljo.131.1567633515907;
        Wed, 04 Sep 2019 14:45:15 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id i21sm17242lfl.44.2019.09.04.14.45.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 14:45:15 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id u13so202255lfm.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 14:45:15 -0700 (PDT)
X-Received: by 2002:a05:6512:512:: with SMTP id o18mr154625lfb.170.1567633024273;
 Wed, 04 Sep 2019 14:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190904201933.10736-1-cyphar@cyphar.com> <20190904201933.10736-11-cyphar@cyphar.com>
 <CAHk-=wiod1rQMU+6Zew=cLE8uX4tUdf42bM5eKngMnNVS2My7g@mail.gmail.com> <CAHk-=wiHRW3Z9xPRiExi9jLjB0cdGhM=3vaW+b80mjuRcbORyw@mail.gmail.com>
In-Reply-To: <CAHk-=wiHRW3Z9xPRiExi9jLjB0cdGhM=3vaW+b80mjuRcbORyw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Sep 2019 14:36:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiExfaVhUTvKj7hR6DG4C2+oy6usz0Sa6QbPr5EgDH28w@mail.gmail.com>
Message-ID: <CAHk-=wiExfaVhUTvKj7hR6DG4C2+oy6usz0Sa6QbPr5EgDH28w@mail.gmail.com>
Subject: Re: [PATCH v12 10/12] namei: aggressively check for nd->root escape
 on ".." resolution
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
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

On Wed, Sep 4, 2019 at 2:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Sep 4, 2019 at 2:09 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So you'd have three stages:
> >
> >  1) ".." always returns -EXDEV
> >
> >  2) ".." returns -EXDEV if there was a concurrent rename/mount
> >
> >  3) ".." returns -EXDEV if there was a concurrent rename/mount and we
> > reset the sequence numbers and check if you escaped.
>
> In fact, I wonder if this should return -EAGAIN instead - to say that
> "retrying may work".

And here "this" was meant to be "case 2" - I was moving the quoted
text around and didn't fix my wording, so now it is ambiguous or
implies #3, which would be crazy.

Sorry for the confusion,

            Linus
