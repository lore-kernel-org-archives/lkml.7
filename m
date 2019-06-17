Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6107EC31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFBB2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JVXa/qhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfFQOWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:22:34 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46493 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfFQOWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:22:33 -0400
Received: by mail-ua1-f65.google.com with SMTP id o19so3486251uap.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 07:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5j/jTwc8VDaf93BqO7lj+/1q92uGDgZVHM2UqM4CWlY=;
        b=JVXa/qhCRuxxyrm3QYu61qbsldvBE3wQwlEaG4aJ6KmZZDqxSxVBoxL7X+Bfv9s19n
         FqGqP132gRRKgT62AQVOONEtf/SJt2ghJilvkSa4JQHGsqaApo0oov0Mj0vMGUPmt7+t
         yoZlxe0qub725pKU1JvcLpMxnffbI5MgBWlmfiEzk456/K+nmEH3WzGdJQ+Le9MuYxQX
         Iu4qlnCRlsg7mSwQXDV0wqAnqSVcJCSK4d8VXNUNun2+GkmNlu+eLeKha0NgAmZFm4VP
         7nygtt75mRK0j8B3LpWPUPRUJxtHpgPflQN89IGbLkITY35PkAdF36l05THa1gfaEOYA
         iODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5j/jTwc8VDaf93BqO7lj+/1q92uGDgZVHM2UqM4CWlY=;
        b=m2yY+qJ8TTK/Ji+JtPOyfphgBeXug646xFDLrbmkKJ9wIUQZKaG4TkcP2HgkxvG6pX
         V5fmjzWoWTUG8zzeg8Ik3FccG2KR1PT9BSntzUpI5MmOd5nSPwXa1vN7eXBp3ZtK08eL
         2nJZ6hdgOYfgs+tWN8kaTrNR3N1deguIcBEcX8cypeIf235G5m8QAoRFDltnqH8GxdPM
         zUFZ/huCQ1Uf9ZmLqlcPc9Le7XLTf/zlhLRQjxlr/C/fNQriH9lTu+4/Xk0qPAP+cT+w
         rzVev3w7lcc2JAfyAEcp/gyQTEibGbKcXzosyCkEOnBx6iJ2UyoLqTK0ApM/n5kprSWk
         1lxQ==
X-Gm-Message-State: APjAAAV8CN5sc3rt5GT7pwfKm1R5qNZduI5f5vwQqD/mN2Gwvk+sDCLn
        PvzUzUAw8EfTkR4+dacq1+3mvHHiBYFah2P9cD79Yw==
X-Google-Smtp-Source: APXvYqxN42nQzWjNqxAIxqNrhLzMhyco1SgYAX2dsRX7qzXsS6prUagFHZjHtXUnxXqZcSLlFDHKJ4+Nb1MwHkJHkf8=
X-Received: by 2002:ab0:30a3:: with SMTP id b3mr14495305uam.3.1560781351980;
 Mon, 17 Jun 2019 07:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190617131210.2190280-1-arnd@arndb.de>
In-Reply-To: <20190617131210.2190280-1-arnd@arndb.de>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 17 Jun 2019 16:22:19 +0200
Message-ID: <CAG_fn=XigLrxy6Uz+NrnHQocb=ZseR6cPC3PyoLXCLU9gukHXg@mail.gmail.com>
Subject: Re: [PATCH] lib: test_meminit: fix -Wmaybe-uninitialized false positive
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Lameter <cl@linux.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Jann Horn <jannh@google.com>, Marco Elver <elver@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 3:12 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The conditional logic is too complicated for the compiler to
> fully comprehend:
>
> lib/test_meminit.c: In function 'test_meminit_init':
> lib/test_meminit.c:236:5: error: 'buf_copy' may be used uninitialized in =
this function [-Werror=3Dmaybe-uninitialized]
>      kfree(buf_copy);
>      ^~~~~~~~~~~~~~~
> lib/test_meminit.c:201:14: note: 'buf_copy' was declared here
>
> Simplify it by splitting out the non-rcu section.
>
> Fixes: af734ee6ec85 ("lib: introduce test_meminit module")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Alexander Potapenko <glider@google.com>
> ---
>  lib/test_meminit.c | 50 ++++++++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
>
> diff --git a/lib/test_meminit.c b/lib/test_meminit.c
> index ed7efec1387b..7ae2183ff1f4 100644
> --- a/lib/test_meminit.c
> +++ b/lib/test_meminit.c
> @@ -208,35 +208,37 @@ static int __init do_kmem_cache_size(size_t size, b=
ool want_ctor,
>                 /* Check that buf is zeroed, if it must be. */
>                 fail =3D check_buf(buf, size, want_ctor, want_rcu, want_z=
ero);
>                 fill_with_garbage_skip(buf, size, want_ctor ? CTOR_BYTES =
: 0);
> +
> +               if (!want_rcu) {
> +                       kmem_cache_free(c, buf);
> +                       continue;
> +               }
> +
>                 /*
>                  * If this is an RCU cache, use a critical section to ens=
ure we
>                  * can touch objects after they're freed.
>                  */
> -               if (want_rcu) {
> -                       rcu_read_lock();
> -                       /*
> -                        * Copy the buffer to check that it's not wiped o=
n
> -                        * free().
> -                        */
> -                       buf_copy =3D kmalloc(size, GFP_KERNEL);
> -                       if (buf_copy)
> -                               memcpy(buf_copy, buf, size);
> -               }
> -               kmem_cache_free(c, buf);
> -               if (want_rcu) {
> -                       /*
> -                        * Check that |buf| is intact after kmem_cache_fr=
ee().
> -                        * |want_zero| is false, because we wrote garbage=
 to
> -                        * the buffer already.
> -                        */
> -                       fail |=3D check_buf(buf, size, want_ctor, want_rc=
u,
> -                                         false);
> -                       if (buf_copy) {
> -                               fail |=3D (bool)memcmp(buf, buf_copy, siz=
e);
> -                               kfree(buf_copy);
> -                       }
> -                       rcu_read_unlock();
> +               rcu_read_lock();
> +               /*
> +                * Copy the buffer to check that it's not wiped on
> +                * free().
> +                */
> +               buf_copy =3D kmalloc(size, GFP_KERNEL);
> +               if (buf_copy)
> +                       memcpy(buf_copy, buf, size);
> +
> +               /*
> +                * Check that |buf| is intact after kmem_cache_free().
> +                * |want_zero| is false, because we wrote garbage to
> +                * the buffer already.
> +                */
> +               fail |=3D check_buf(buf, size, want_ctor, want_rcu,
> +                                 false);
> +               if (buf_copy) {
> +                       fail |=3D (bool)memcmp(buf, buf_copy, size);
> +                       kfree(buf_copy);
>                 }
> +               rcu_read_unlock();
>         }
>         kmem_cache_destroy(c);
>
> --
> 2.20.0
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
