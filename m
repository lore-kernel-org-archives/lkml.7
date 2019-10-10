Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF55AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8950720B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570727686;
	bh=rVBQfiP/YB1yYBxqZtiGACMzxcOAKtX1Jx40mSLBOVM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dOH4fAgYd3LTadRjCGmRjt6+MPdctl+balPd4dQmkIa33MrOrfnlSyYthXuV0Gih4
	 PLFnh38jnMj8YyhGBRsnp5O7EKqLuKAaWM8BARdXqpAHrMd685Uxc2Fq/Hgp1Bavru
	 oGpQkpwpc54vmMn0hQEd33Z/kRvlrTM9Ra/iLhG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfJJROp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 13:14:45 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43950 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfJJROo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:14:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id u3so4963030lfl.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 10:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqvz+afB1Rg3ieCrlwoBKML7ipcOdiXJ/q/XXxTUovI=;
        b=Xol/3a0t0AtCulvKJeuAKS1uo5PWCjeyeDeHYLSA1FXKSnOkgSTF276gwVNHa4nPiN
         l58RJ3zV8SDjz5HcQUbk/k9PwAg2ytkBSxmhuzf7L/EFmiieyqeQcJuKFBVQbWUjfXE1
         U4t1RhqK0BT10C1Atodrl5m0eWGZPM7fTB2Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqvz+afB1Rg3ieCrlwoBKML7ipcOdiXJ/q/XXxTUovI=;
        b=glodWuALEM8cYbt/zcs/CojeJ1zS2ukvV26k4/OJpiCo+7eHNXvn2iQEqw0cnr5NUr
         IjjZAFQNGMw1fP013bbzZzEXCPVUBHhSaP7yLolpXB3UEp0ZXRnlrxTTj2ZjjEhiD+gW
         IbJtzE/UpomgpP2psuQHlV6hg8HEmCbZVJQa8H7pyUalee+n4yT72dexFwa/0Jbq7vL+
         zfdWKDCLNiiqQQiOqG5UdffngQVlUNXZyXumYXYS3IRdK4NB7TNYgkqgpzzPyVH3JZJV
         a43nP0CA9AVgShVuYPesU87LQ4g/QckFjvq92o/I+5ePEuBrDNAvx9dn5W4bVLYORcMg
         /LBw==
X-Gm-Message-State: APjAAAUbxynaiBWYbMl91nZtUMV48NnuyqI/4heUfIuXgQI+HS5YqGir
        7Mt0vQWp32Vq4uT0klyRKWJpc4Rhb2s=
X-Google-Smtp-Source: APXvYqykfUZ1KXLt2GIhlAPtjVj1f587ifOmLFLSItB+wHz601eqS0WjLtgDeYwB920fZOwuMcCDtQ==
X-Received: by 2002:ac2:4946:: with SMTP id o6mr6313540lfi.86.1570727681525;
        Thu, 10 Oct 2019 10:14:41 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id q14sm1381586ljc.7.2019.10.10.10.14.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 10:14:41 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id w6so4987921lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 10:14:41 -0700 (PDT)
X-Received: by 2002:a19:f709:: with SMTP id z9mr6611392lfe.170.1570727268603;
 Thu, 10 Oct 2019 10:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191010054140.8483-1-cyphar@cyphar.com> <20191010054140.8483-3-cyphar@cyphar.com>
In-Reply-To: <20191010054140.8483-3-cyphar@cyphar.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Oct 2019 10:07:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8L50f31vW8BwRUXhLiq3eoCQ3tg8ER4Yp2dzuU1w5rQ@mail.gmail.com>
Message-ID: <CAHk-=wh8L50f31vW8BwRUXhLiq3eoCQ3tg8ER4Yp2dzuU1w5rQ@mail.gmail.com>
Subject: Re: [PATCH v14 2/6] namei: LOOKUP_IN_ROOT: chroot-like path resolution
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

On Wed, Oct 9, 2019 at 10:42 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2277,6 +2277,11 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
>
>         nd->m_seq = read_seqbegin(&mount_lock);
>
> +       /* LOOKUP_IN_ROOT treats absolute paths as being relative-to-dirfd. */
> +       if (flags & LOOKUP_IN_ROOT)
> +               while (*s == '/')
> +                       s++;
> +
>         /* Figure out the starting path and root (if needed). */
>         if (*s == '/') {
>                 error = nd_jump_root(nd);

Hmm. Wouldn't this make more sense all inside the if (*s =- '/') test?
That way if would be where we check for "should we start at the root",
which seems to make more sense conceptually.

That test for '/' currently has a "} else if (..)", but that's
pointless since it ends with a "return" anyway. So the "else" logic is
just noise.

And if you get rid of the unnecessary else, moving the LOOKUP_IN_ROOT
inside the if-statement works fine.

So this could be something like

    --- a/fs/namei.c
    +++ b/fs/namei.c
    @@ -2194,11 +2196,19 @@ static const char *path_init(struct
nameidata *nd, unsigned flags)

        nd->m_seq = read_seqbegin(&mount_lock);
        if (*s == '/') {
    -           set_root(nd);
    -           if (likely(!nd_jump_root(nd)))
    -                   return s;
    -           return ERR_PTR(-ECHILD);
    -   } else if (nd->dfd == AT_FDCWD) {
    +           /* LOOKUP_IN_ROOT treats absolute paths as being
relative-to-dirfd. */
    +           if (!(flags & LOOKUP_IN_ROOT)) {
    +                   set_root(nd);
    +                   if (likely(!nd_jump_root(nd)))
    +                           return s;
    +                   return ERR_PTR(-ECHILD);
    +           }
    +
    +           /* Skip initial '/' for LOOKUP_IN_ROOT */
    +           do { s++; } while (*s == '/');
    +   }
    +
    +   if (nd->dfd == AT_FDCWD) {
                if (flags & LOOKUP_RCU) {
                        struct fs_struct *fs = current->fs;
                        unsigned seq;

instead. The patch ends up slightly bigger (due to the re-indentation)
but now it handles all the "start at root" in the same place. Doesn't
that make sense?

             Linus
