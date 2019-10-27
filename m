Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C52CA9EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 12:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1804A2070B
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 12:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572177936;
	bh=Hi8x7WYvanIhNlVPVdyH7IsyhSTw409zSyZgXr7DWBM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G18RD2tpTfTjE821c9jdFBpKE0FdHOCkyTZUMoZzhm/Y0f/QQO7r38hVRk0LIvAG9
	 yVpPG8pt962cpDougHTq4uvrXiHfI63+zkr8rk2KD4t4YwR6F6WsS+jVSJLnrSn7WK
	 cG9Wq8MjoMGi01o1DXB6Q+dv108HidxblfNUKzZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfJ0MFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 08:05:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33786 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfJ0MFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 08:05:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id y127so5690911lfc.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 05:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Zr1M0nCXlilSobwLkNmgKE2widPtGkZk30ZqC0Jsp4=;
        b=d3QTzyBq1ltmtg4yGSZr5XtauvY/fALYcdqhiDEtFOl1dE9JCqjexjO52exODJRIVQ
         Eh2Een6o4qvZdUFz/jDS+JnTxGr7PmGqPX7rFmA4YZFRZjrNKL/JZDN1nI+V4NXXs/c+
         Hp/xfBUyMptBO5mKJ7+YknkxBRlijCGcU26uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Zr1M0nCXlilSobwLkNmgKE2widPtGkZk30ZqC0Jsp4=;
        b=Y2zo6zoB1E8uVRVKhmtmvBbudN72HMHnnM4VZDa9EpgqEVg2Lz9C1y1THTavm5lCW4
         Aqi2769GEkW59n1nnPflHRTzf01GwCFBJnyfqjN/5hBcCH9s6P5ir31ciObVoxL6EWDQ
         33oTFWdIPuyr1k+fEujHMpDbYPN6ooOFfdQXqdrIKMu5PF6zhaBBmZjeHO1Q0vv2Uw+4
         EKBYoG5NO/wDzDVeKdjkwcx2lbcLhP7Ham9Rt/WU6fdFt+XdeLf3sHjByEXfjca8QHNl
         staDfZxiWylqKb0+nuPfJe47xyyrxBbvivs8bE88glG7XYRseU3iIb47BLa7+GN9Pqsw
         scRw==
X-Gm-Message-State: APjAAAWj35q0igwGvsyjH6hr38kH7dLh9ADy97fHxYA2nroWheGgfyXK
        MDPPixei0BtdLRT6rJ7oiUFZClB4C1T9kw==
X-Google-Smtp-Source: APXvYqzisaLU4/Co8W8z1aAnLwELyrAMEHdSYlWLIFve3PDTjV6b5uMT1CwKvrxF7KNtjm2ehnlaqA==
X-Received: by 2002:a19:750:: with SMTP id 77mr8019759lfh.81.1572177931931;
        Sun, 27 Oct 2019 05:05:31 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id u26sm3891445lfd.19.2019.10.27.05.05.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 05:05:30 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id y6so5680364lfj.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 05:05:29 -0700 (PDT)
X-Received: by 2002:a19:5504:: with SMTP id n4mr8268196lfe.106.1572177927159;
 Sun, 27 Oct 2019 05:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191026185700.10708-1-cyphar@cyphar.com> <20191026185700.10708-3-cyphar@cyphar.com>
In-Reply-To: <20191026185700.10708-3-cyphar@cyphar.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Oct 2019 08:05:11 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjPPWvm5_eR4uaHJaU1isTUk-4iXQV3Z2Px9A+w6j2nHg@mail.gmail.com>
Message-ID: <CAHk-=wjPPWvm5_eR4uaHJaU1isTUk-4iXQV3Z2Px9A+w6j2nHg@mail.gmail.com>
Subject: Re: [PATCH RESEND v14 2/6] namei: LOOKUP_IN_ROOT: chroot-like path resolution
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
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Sat, Oct 26, 2019 at 2:58 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> +       /* LOOKUP_IN_ROOT treats absolute paths as being relative-to-dirfd. */
> +       if (flags & LOOKUP_IN_ROOT)
> +               while (*s == '/')
> +                       s++;
> +
>         /* Figure out the starting path and root (if needed). */
>         if (*s == '/') {
>                 error = nd_jump_root(nd);

So I'm still hung up on this.

I guess I can't help it, but I look at the above, and it makes me go
"whoever wrote those tests wasn't thinking".

It just annoys me how it tests for '/' completely unnecessarily.

If LOOKUP_IN_ROOT is true, we know the subsequent test for '/' is not
going to match, because we just removed it. So I look at that code and
go "that code is doing stupid things".

That's why I suggested moving the LOOKUP_IN_ROOT check inside the '/' test.

Alternatively, just make the logic be

        if (flags & LOOKUP_IN_ROOT) {
               .. remove '/'s ...
        } else if (*s == '/') {
                .. handl;e root ..

and remove the next "else" clause

    Linus
