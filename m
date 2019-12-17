Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDFAC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EF92082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U7G1uuUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfLQLf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:35:26 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:45211 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfLQLf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:35:26 -0500
Received: by mail-qv1-f65.google.com with SMTP id l14so3421407qvu.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 03:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZdgUh+3fq9U6L3+p94OehUQ70Eb7XI14xqgdmXCu0g=;
        b=U7G1uuURLEW0k1zpqBNbqSokpnyhi+5QnETsayOUPDLxY45TSRhyUK/3m2l+fT2gz/
         ut1wULFzlavyxyt+rF3yubDjAuv3AUzL1LMSHqYJncH+EC9i6lDHWg44xMlloRV5AyY3
         DtgmJf9z6QHB95Feo7mn2QGJSnjoSyFu778Zx+GloOyQK5AtseTF4MuM795qK3Jjmkgd
         QuTfb5jABlLLSheeLpfhFikVlRXy8Hk2b1MePaXcuZJhHAHBQ5x6Zqa9WMaq19kA7/6a
         MEYxilrylXJIL5ZIAXLuoX0mUFBW/mEvIaUbJdSZjWWzz87QLUplyFrp93J2IY/tPXYD
         jeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZdgUh+3fq9U6L3+p94OehUQ70Eb7XI14xqgdmXCu0g=;
        b=oj2ACwHpr20IIHxQaOWaKYcxJ07v0Aql88zRPz7XA6gKSincx7gz4vxB+qINWHqn8T
         lRv/ltWRXYYw9P0fCUNsjRxpOkXpxOcDcWZ93hJewVmE8I/vh6ASk1nS8AFh3Cnccto2
         PPWN3uh+hQE4iRSOlo0Xz0iAZYiHqddJ/kkwAjgkfB43SBGUiqg+XPfaSdH7BEIcfO7t
         1eJf+7QlwpiwiqC/6q0wEWDghiKXuw49H419sBxcfUqkiAhc5S+pLgpxZF5OxbjvXW0U
         ktcnz5X6VKLsg4JtZN7pZ0uTrrEg/hLJnHpzaOrVv6EifYBe7gl7JojkHaK1w04asaIm
         vxKA==
X-Gm-Message-State: APjAAAUnhNlXBlSHjSAb45ZkKZ9GVycGwIx2aFXy6jZ3ltBAtrcRhb1G
        vjLasRv1ucwaQ/m6VdiWWsc+bnN6Hrz75xUXbxNlXg==
X-Google-Smtp-Source: APXvYqz4Oc/yoEJ/14nt/DX7bhsOQyEb5x7FbrSFmpJ7UILMAmG24P9U1jbidVmgS2x9fi9bXJQhdgdz6YgqoKVJYlI=
X-Received: by 2002:ad4:4c84:: with SMTP id bs4mr4130682qvb.34.1576582524752;
 Tue, 17 Dec 2019 03:35:24 -0800 (PST)
MIME-Version: 1.0
References: <95e7a12ac909e7de584133772efc7ef982a16bbb.1576170740.git.andreyknvl@google.com>
 <Pine.LNX.4.44L0.1912121313030.1352-100000@iolanthe.rowland.org>
 <CAAeHK+yOBcNz_iopRs6PEu=1-rZn6Gkm+Urq+iVBFQeSjSXqNA@mail.gmail.com>
 <CACT4Y+aN20NXxXhe9qv_WRLntAHbL98Shj8NAvg0WafDw8C=jA@mail.gmail.com> <CAAeHK+xyVh6QkbUp6z+fLrv5f9sODkgFuvmBU1jB8borQ9M65g@mail.gmail.com>
In-Reply-To: <CAAeHK+xyVh6QkbUp6z+fLrv5f9sODkgFuvmBU1jB8borQ9M65g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 17 Dec 2019 12:35:13 +0100
Message-ID: <CACT4Y+a+8u=OoUeC247he4EM1x=CJEeMvix=XViQVfkiU_Kk2Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] kcov: collect coverage from interrupts
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 12:16 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > > On Thu, Dec 12, 2019 at 7:15 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > > On Thu, 12 Dec 2019, Andrey Konovalov wrote:
> > > >
> > > > > This change extends kcov remote coverage support to allow collecting
> > > > > coverage from interrupts in addition to kernel background threads.
> > > > >
> > > > > To collect coverage from code that is executed in interrupt context, a
> > > > > part of that code has to be annotated with kcov_remote_start/stop() in a
> > > > > similar way as how it is done for global kernel background threads. Then
> > > > > the handle used for the annotations has to be passed to the
> > > > > KCOV_REMOTE_ENABLE ioctl.
> > > > >
> > > > > Internally this patch adjusts the __sanitizer_cov_trace_pc() compiler
> > > > > inserted callback to not bail out when called from interrupt context.
> > > > > kcov_remote_start/stop() are updated to save/restore the current per
> > > > > task kcov state in a per-cpu area (in case the interrupt came when the
> > > > > kernel was already collecting coverage in task context). Coverage from
> > > > > interrupts is collected into pre-allocated per-cpu areas, whose size is
> > > > > controlled by the new CONFIG_KCOV_IRQ_AREA_SIZE.
> > > > >
> > > > > This patch also cleans up some of kcov debug messages.
> > > > >
> > > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > > ---
> > > >
> > > > > diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
> > > > > index 4c9d1e49d5ed..faf84ada71a5 100644
> > > > > --- a/drivers/usb/gadget/udc/dummy_hcd.c
> > > > > +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> > > > > @@ -38,6 +38,7 @@
> > > > >  #include <linux/usb/gadget.h>
> > > > >  #include <linux/usb/hcd.h>
> > > > >  #include <linux/scatterlist.h>
> > > > > +#include <linux/kcov.h>
> > > > >
> > > > >  #include <asm/byteorder.h>
> > > > >  #include <linux/io.h>
> > > >
> > > > That's the only change to this driver.  As such, it doesn't appear to
> > > > be needed, judging by the patch description.
> > >
> > > Right, will fix in the next version, thanks!
> >
> > Please also post a github or gerrit link. These small scraps of
> > changes without context and better visualisation are extremely hard to
> > review meaningfully.
>
> The link is in the cover letter:
>
> https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2224/1

Sorry, missed. Now I can read it!
