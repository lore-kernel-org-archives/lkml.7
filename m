Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511F5C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DE22087E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0L2NJu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfKGVA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:00:26 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36457 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfKGVA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:00:26 -0500
Received: by mail-io1-f67.google.com with SMTP id s3so3898536ioe.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 13:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N1kmrdQXG5vssjwCd67eTK4dWVDhQf2oRjU5ZbEWya4=;
        b=d0L2NJu3gPoGrUeZiF8fvX69O8lD9EF9IDygPpfopNtglqZUGyJ1oom8QPjw8flAg+
         XNVxK87p3Ti5+74nIUhY6IhruUapE1XKdqkQSOKaaBtGVqyjSDe/N92cA/6jiDgXW3YO
         +FuexexIJ/EWzlCC+k7pZE1sRwB+OQiF9TROWcZ9L4Jn6WvMTV/2IhCjcY+o/RupSMPT
         wH9G0EvaN7+okWhtfkXWip0lXr37mvB04AceBMaer98vIjrDDD4vzgVGiiZJyghqdfTL
         lxKaeAKWMZVexLbr6yrOQcrEYXGyxk0GrBWtWhnJYU5xIFf5g6DxOdsI68uT9zGXevaT
         FdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N1kmrdQXG5vssjwCd67eTK4dWVDhQf2oRjU5ZbEWya4=;
        b=b40wxm7bFipRDA3dBPPa978/HJAlQis5avAC62Mz/4JZ4ALO6fySGzfndTamzRHkp+
         ceRS2MXzCYeyM8RaOqbe2p9W+tGWZDNN6YmlwerHQskT43HmD9sne2itR2BM8uyVhLHd
         EYwfZGqiEa5aB/eWyGjMfeZvsggc4/zSOFH+zFaDb9pYuVeXJ1/4l2Wlf2XODlJTLEt3
         Yt/IKM2PFVGWrWGXD/yRilKKduc2eUPVvZb5qEW+NPKpfnGC/aR2jGWK6u8jhYh0+pl1
         oBlfux7+Haucc9EYHg4TlCk2/f6B09B9g3PXzEZN+ksqsa87jWfPEkOxd9oMsu+Q9Nq3
         LlHw==
X-Gm-Message-State: APjAAAUggnUR9omYBwuyUugdwI679twnJfKsUmQXkAL3L9CiSKjUXfqR
        MhPxuHpR6AtlrYSf+TVOb4hpRANBJohndU29lnWMzlVwzg==
X-Google-Smtp-Source: APXvYqyXRBCUvK4O92YsEnNdlF6ZhgIfYKHOjIbyvZHjvmGcNqJJJCW15yULCpVho0gfHCcV5QJiRc6oLrKDBk0lU4k=
X-Received: by 2002:a5d:8450:: with SMTP id w16mr5459728ior.11.1573160425402;
 Thu, 07 Nov 2019 13:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20191106193459.581614484@linutronix.de> <20191106202806.241007755@linutronix.de>
 <CAMzpN2juuUyLuQ-tiV7hKZvG4agsHKP=rRAt_V4sZhpZW7cv9g@mail.gmail.com> <CAHk-=wiGO=+mmEb-sfCsD5mxmL5++gdwkFj_aXcfz1R41MJnEg@mail.gmail.com>
In-Reply-To: <CAHk-=wiGO=+mmEb-sfCsD5mxmL5++gdwkFj_aXcfz1R41MJnEg@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 7 Nov 2019 16:00:13 -0500
Message-ID: <CAMzpN2gt4qM41=96GpNHL-kbgBsjD-zphq+5oK0BXqoCFN4F4Q@mail.gmail.com>
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage further
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 2:54 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Nov 7, 2019 at 11:24 AM Brian Gerst <brgerst@gmail.com> wrote:
> >
> > Here is a different idea:  We already map the TSS virtually in
> > cpu_entry_area.  Why not page-align the IO bitmap and remap it to the
> > task's bitmap on task switch?  That would avoid all copying on task
> > switch.
>
> We map the tss _once_, statically, percpu, without ever changing it,
> and then we just (potentially) change a couple of fields in it on
> process switch.
>
> Your idea isn't horrible, but it would involve a TLB flush for the
> page when the io bitmap changes. Which is almost certainly more
> expensive than just copying the bitmap intelligently.
>
> Particularly since I do think that the copy can basically be done
> effectively never, assuming there really aren't multiple concurrent
> users of ioperm() (and iopl).

There wouldn't have to be a flush on every task switch.  If we make it
so that tasks that don't use a bitmap just unmap the pages in the
cpu_entry_area and set tss.io_bitmap_base to outside the segment
limit, we would only have to flush when switching from a task using
the bitmap (because the next task uses a different bitmap or we are
unmapping it).  If the previous task doesn't have a bitmap the pages
in cpu_entry_area were unmapped and can't be in the TLB, so no flush
is needed.

Going a step further, we could track which task is mapped to the
current cpu like proposed above, and only flush when a different task
needs the IO bitmap, or when the bitmap is being freed on task exit.

--
Brian Gerst
