Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB05DC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8163E206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdP6kqdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbfHAL2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:28:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37886 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHAL2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:28:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so62832770wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 04:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xqlL4i3gNjqYtXtO6TQlV20Xxo/VOCfNj1pkiBeVGDw=;
        b=AdP6kqdBNqVzqPbTjcZqUCSeEuNZAZ0N2Hl7V0yyDQ97NwaxFQ3YPSdyfa5WscChBf
         eQGOSebUDGwTIsy3ec9wtj4XhJSdNy2Nm7UQuj6m19HzgAcIqfK5QtKXngKhsE1bAzeh
         Z8MDxuC/JtqX8MJIT/X74Qs9abmRPhqfAm5cJtPevPH0QqRG7ypBFY4LyQVHKu3J+qaA
         Az3nbeoW6l241nTdt1fleedlEYCSx4Y7Xs61bGbsIt2U6eBnBODlCX0nRzxsXY2YSfmG
         kNL4/CyfOJAdHhqkx81K3DomreRUeEF9m8TieokhBXNpFzz1ocBDIayWwDPw/PqD2BSX
         2s0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xqlL4i3gNjqYtXtO6TQlV20Xxo/VOCfNj1pkiBeVGDw=;
        b=VBTqbAMG/YUusZxDGGXVRjRZgnbIidfGQfV4w/jzrdHU2aKHfYbnMEH0WbPZFaYsFM
         ITr912r30RI7MBQOBkZh5nDnRwJUDvI9akap+vQX1PnnH4sWlCFD7N1yHiATcvozqD0r
         t/iAHFgTO7yA+3JQu5gEiAPrKL67IsMeFSZazecQbds1d39GcIBaVY2KCQrqLg1aLNwX
         KQG8b5rsbsZIx/2HsQ+7kk1eW5zkMgL14Hz0+P1fTL5rGuIaVCsTTOnXZLpNcb/JkALK
         HShCGnoZ+KHXhpOvvLCzUzu3Gyhbg0dgPyrMSV/DQcDGbeGCM7JCkA595ilJKbkjpeZ6
         x43A==
X-Gm-Message-State: APjAAAVFiKCPUuXiO687wcHwrMCI2khnChiw3DYRc7GqVW1LAT4heqs5
        RwWe3qM5QmfamM9B3FtA/9OWhVR51SBW8iaeQOEFvg==
X-Google-Smtp-Source: APXvYqwGETwdoashndHC330DdqucKEGLjf3h8H2eI2Z/vsG8Q0EpDPaNd2yf/onQdcky1xXqUBZxaQrJFZevg/rqT08=
X-Received: by 2002:a1c:770d:: with SMTP id t13mr42679017wmi.79.1564658923216;
 Thu, 01 Aug 2019 04:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAG_fn=VBGE=YvkZX0C45qu29zqfvLMP10w_owj4vfFxPcK5iow@mail.gmail.com>
 <20190731193240.29477-1-labbott@redhat.com> <20190731193509.GG4700@bombadil.infradead.org>
 <201907311304.2AAF454F5C@keescook>
In-Reply-To: <201907311304.2AAF454F5C@keescook>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 1 Aug 2019 13:28:31 +0200
Message-ID: <CAG_fn=VJm7M0wzMTti5RoegW56CY2YpikjEZryt8gMN5nOiyqw@mail.gmail.com>
Subject: Re: [PATCH] mm: slub: Fix slab walking for init_on_free
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Laura Abbott <labbott@redhat.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 10:05 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Jul 31, 2019 at 12:35:09PM -0700, Matthew Wilcox wrote:
> > On Wed, Jul 31, 2019 at 03:32:40PM -0400, Laura Abbott wrote:
> > > Fix this by ensuring the value we set with set_freepointer is either =
NULL
> > > or another value in the chain.
> > >
> > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > Signed-off-by: Laura Abbott <labbott@redhat.com>
> >
> > Fixes: 6471384af2a6 ("mm: security: introduce init_on_alloc=3D1 and ini=
t_on_free=3D1 boot options")
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Alexander Potapenko <glider@google.com>
>
> --
> Kees Cook



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
