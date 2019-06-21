Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012D6C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD962075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBEX22lM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfFUP03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:26:29 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37485 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUP03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:26:29 -0400
Received: by mail-ua1-f66.google.com with SMTP id z13so3131294uaa.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 08:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m9xPXeXawroVT7KKEHMkuhFnWVtfnUIIo75zbYHefO4=;
        b=YBEX22lMJJKj2bmHZv1K3QQAcVuuhP05htHRnyHmGf/+YvfbPemLwthJCwddhDJMez
         P0alncQzTaYxrvqvoqEiTdRZTCxyv8TSzXI7vv8JpY/XYStJ1o20ZsSy1UkoV/UnZ5Qw
         Golh+FkaB/+O99INvf1UMbJE0OBe13BM7mOGNWFaJOxHkQzbl4FOBUug8dLehdHZs8e3
         X+wBW/u+uooc4Ft3o/XUSOyDXXTsijrolJemXu0TSQgkOMDQtKZljZ7u097Yph5jf2LI
         4pC0VmggjJUbtf/Di21odO5SJ+gIpVmdW3sEdq5kXJ/do9bCAVldj7bptTWcL6JUkWtE
         aT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m9xPXeXawroVT7KKEHMkuhFnWVtfnUIIo75zbYHefO4=;
        b=MbPY9TANAmGFLyjzAgsXMBGvF4MCes8lmC7Cz2ZXoaIetsbSgZ+iUcqg9agm5Hj33h
         RBl7SdNpPxA6+nIEU6198Lk9xOZXtaADZeTUHaicsywFUeHCcHFAuiyH7o3pmZKA7jOM
         JZRb4Ki3aRDaNpTrf78ENdg256iDn/HAOmbIQykOVeaMbxWNQMy0NeTOz6IKN4GVuvJm
         sl5sSWTHyx/rk67oEmxoMWN4MPVkWlCnNohH+AGy6b7R0T6kNlmeG1DQEeoW26/4wZOT
         l9wbqE33cEJd3hX8iKKyIYWThJUEltMxoVjEXh50K17XUzJ/W+ewDMOBPtHyxkjLL5AO
         7fRQ==
X-Gm-Message-State: APjAAAX4p9jpinD7sUFbGhDxw/m+D59nr+d/fE6L+3ygXW89r4N4uMq+
        UzZnk/jK+qEaX/0v4aCSKfgn86ECidiHtJrS6cNAYA==
X-Google-Smtp-Source: APXvYqwU46O0o2fxlmglOdVQi4samVl5zWnKIA9+EYAQ4iWnFaAAISJNikzzcSR24FhYl6xOESBzerPu9dVJbUwKQPA=
X-Received: by 2002:ab0:3d2:: with SMTP id 76mr1131532uau.12.1561130788062;
 Fri, 21 Jun 2019 08:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <1561063566-16335-1-git-send-email-cai@lca.pw> <201906201801.9CFC9225@keescook>
 <CAG_fn=VRehbrhvNRg0igZ==YvONug_nAYMqyrOXh3kO2+JaszQ@mail.gmail.com>
 <1561119983.5154.33.camel@lca.pw> <CAG_fn=WGdFZNrUCeMtbx4wbHhxWqM2s7Vq_GvnMC-9WJZ_mioQ@mail.gmail.com>
 <1561128967.5154.45.camel@lca.pw>
In-Reply-To: <1561128967.5154.45.camel@lca.pw>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 21 Jun 2019 17:26:16 +0200
Message-ID: <CAG_fn=VCF+sXQE3VxvBRa_a97rX8tVGSTXQsk9uiOH=q6Rg9Pw@mail.gmail.com>
Subject: Re: [PATCH -next v2] mm/page_alloc: fix a false memory corruption
To:     Qian Cai <cai@lca.pw>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 4:56 PM Qian Cai <cai@lca.pw> wrote:
>
> On Fri, 2019-06-21 at 16:37 +0200, Alexander Potapenko wrote:
> > On Fri, Jun 21, 2019 at 2:26 PM Qian Cai <cai@lca.pw> wrote:
> > >
> > > On Fri, 2019-06-21 at 12:39 +0200, Alexander Potapenko wrote:
> > > > On Fri, Jun 21, 2019 at 3:01 AM Kees Cook <keescook@chromium.org> w=
rote:
> > > > >
> > > > > On Thu, Jun 20, 2019 at 04:46:06PM -0400, Qian Cai wrote:
> > > > > > The linux-next commit "mm: security: introduce init_on_alloc=3D=
1 and
> > > > > > init_on_free=3D1 boot options" [1] introduced a false positive =
when
> > > > > > init_on_free=3D1 and page_poison=3Don, due to the page_poison e=
xpects the
> > > > > > pattern 0xaa when allocating pages which were overwritten by
> > > > > > init_on_free=3D1 with 0.
> > > > > >
> > > > > > Fix it by switching the order between kernel_init_free_pages() =
and
> > > > > > kernel_poison_pages() in free_pages_prepare().
> > > > >
> > > > > Cool; this seems like the right approach. Alexander, what do you =
think?
> > > >
> > > > Can using init_on_free together with page_poison bring any value at=
 all?
> > > > Isn't it better to decide at boot time which of the two features we=
're
> > > > going to enable?
> > >
> > > I think the typical use case is people are using init_on_free=3D1, an=
d then
> > > decide
> > > to debug something by enabling page_poison=3Don. Definitely, don't wa=
nt
> > > init_on_free=3D1 to disable page_poison as the later has additional c=
hecking
> > > in
> > > the allocation time to make sure that poison pattern set in the free =
time is
> > > still there.
> >
> > In addition to information lifetime reduction the idea of init_on_free
> > is to ensure the newly allocated objects have predictable contents.
> > Therefore it's handy (although not strictly necessary) to keep them
> > zero-initialized regardless of other boot-time flags.
> > Right now free_pages_prezeroed() relies on that, though this can be cha=
nged.
> >
> > On the other hand, since page_poison already initializes freed memory,
> > we can probably make want_init_on_free() return false in that case to
> > avoid extra initialization.
> >
> > Side note: if we make it possible to switch betwen 0x00 and 0xAA in
> > init_on_free mode, we can merge it with page_poison, performing the
> > initialization depending on a boot-time flag and doing heavyweight
> > checks under a separate config.
>
> Yes, that would be great which will reduce code duplication.
I suggest we disable init_on_alloc/init_on_free under
CONFIG_PAGE_POISONING now then and work towards deduplicating this
code in further patch series.


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
