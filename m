Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76560C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3581320857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCnNVlNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfCBQ16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 11:27:58 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34849 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfCBQ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 11:27:57 -0500
Received: by mail-qt1-f193.google.com with SMTP id p48so870335qtk.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 08:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjnv6iMNlS9yYKpROQTYmdIC2eoSfYKiCH6UrKQ3rL8=;
        b=eCnNVlNKniNcbkoE2rsLuu5RWHbtNsdr+HRW4X/rNXAr6ZS1EgK7wxRIiGYz1ft44W
         YfezRfv7dY9pA+9DVFhmrERELuHJDpRRaiNRLmGCQj1fAyE/mS2mXB9N5gQNXpemUcUI
         MIABQiPqNAkSJ/Jega0i43AOJqfECgA37Ji2yQr382ddw5qLP7MVwL8ZMkJ7YzWqgukB
         aSzoQWt+FZ1azCB9jT0sV071iKaI6lUVpWIMYuhHRqvOEFOmablR0PrWSbUiJVOdthNo
         L+OfW1CMH2axGgOby7fpe2yGTn+1J0RBhvFgMkEp4bRGI8BwiWEsu8DGuGoOPpCEbA/G
         i6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjnv6iMNlS9yYKpROQTYmdIC2eoSfYKiCH6UrKQ3rL8=;
        b=lhMWTfPZI0gQ+vmSUTFKCSWMpo4CxM5Okxh3knbdQyNAeJeFaqOL4aJ8I4Ioo4USC4
         kPahAhbNJd1rR/LrHqF3NhMEko4WanfDNCnh6qLPbDuye32eEaSRjSepXR+PmM9x3VTV
         WkYumOd/tKANYASr8x5zm9JYlXnIKHUTSyDL062MxW5ncNouoLAeRQLpA/16f59gWEER
         REkLf4UylDqHDSmq11vz55Rpay0VUFqNuxHOvFBO+/O7IHQsU42jjGR3QFJ1nvTywuZY
         FBd4pziJfehmE/6oSm6lAA9vf3XxuXFLn6HOxSq1If3+QYin24XxHlvp/u6127wDtgVe
         tWKQ==
X-Gm-Message-State: APjAAAWs6zX25gtjV3Ed7GjQ7gI/eKKm9IaLM8d6y49jM83Fej2IB8VB
        dX46xbVjNazYA0NkSnErrYBNvjWHBjdkSswvyO7xaQ==
X-Google-Smtp-Source: APXvYqzAhKOT/k+jSXG2gKPep4lG2XzriqjdfKLtA7QN2okom3KtAa/0F/8KOacQWxLZlokFUOi09jW91+rxliPuld8=
X-Received: by 2002:ac8:28e4:: with SMTP id j33mr8723829qtj.349.1551544076375;
 Sat, 02 Mar 2019 08:27:56 -0800 (PST)
MIME-Version: 1.0
References: <20190301230606.8302-1-tkjos@google.com> <20190302075720.GA18046@kroah.com>
In-Reply-To: <20190302075720.GA18046@kroah.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Sat, 2 Mar 2019 08:27:44 -0800
Message-ID: <CAHRSSExy=kWt+MDzD10VogfasygJET6FmEtRc9vJuLv4Ov7+uA@mail.gmail.com>
Subject: Re: [PATCH] binder: fix race between munmap() and direct reclaim
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Todd Kjos <tkjos@android.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 11:57 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 01, 2019 at 03:06:06PM -0800, Todd Kjos wrote:
> > An munmap() on a binder device causes binder_vma_close() to be called
> > which clears the alloc->vma pointer.
> >
> > If direct reclaim causes binder_alloc_free_page() to be called, there
> > is a race where alloc->vma is read into a local vma pointer and then
> > used later after the mm->mmap_sem is acquired. This can result in
> > calling zap_page_range() with an invalid vma which manifests as a
> > use-after-free in zap_page_range().
> >
> > The fix is to check alloc->vma after acquiring the mmap_sem (which we
> > were acquiring anyway) and skip zap_page_range() if it has changed
> > to NULL.
> >
> > Signed-off-by: Todd Kjos <tkjos@google.com>
> > ---
>
> Any specific commit that this fixes?

No, it's been there a long time.

> And should it be marked for stable releases?

It is needed in stable (back to 4.4), but will need to be backported.
Should I post backported versions targeting the specific releases now?
I was thinking we'd wait for this one to land. I think we'll need 1
patch for 4.4/4.9 and a second one for 4.14/4.19 (and some of those
backported patches will have conflicts when merged down to android-4.X
-- I think the 4.14/4.19 version will apply to all the android
branches). Let me know how you want to handle this.

>
> thanks,
>
> greg k-h
