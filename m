Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A924C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAA220652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IPQTzISm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfCETfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:35:12 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42258 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfCETfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:35:10 -0500
Received: by mail-qt1-f193.google.com with SMTP id u7so10191004qtg.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 11:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K+3BPzXujBFtjqPxXDYt4guAQdVBXgcnJWhW+gCBb5M=;
        b=IPQTzISmXsvh9Sjoh2DftlLWyMajWSphYY8IxXcioNpKUZo9XpUKxJ3aZqnG+O8Zrw
         9L6FKwaOdD3CuaBvYp7W+J3yRlSztdNGQ3HzPzQn2qJRC+Yu34mkBhRQZRs/xlyNsPFV
         xkRD/i10lKoGSMaJxaYuOOXKBELhaXJ5xPVtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K+3BPzXujBFtjqPxXDYt4guAQdVBXgcnJWhW+gCBb5M=;
        b=swiyZTTQkqbGVf+Ab+Us0tGfSu7pWWeQGH5E76D/ty8o0V07lVZbhbFkmfroznEV+6
         spbFu3OJfnu9KU9M72H4Z8QYPBOER/RDJfOFt2CTnUFLHkzR0VJXRtBE9vmp2vjtVXDP
         RID9v3X8KZSGMHv76TWV9DLOfBZP4m+7GadtlsHNxkq99i0q6/xqnzEhzHHZ9zndHLh2
         5R6KhitQloZH/ISG0YzVRjmWmZJf+B1Xv5ILfz2e4En2Tk4pVW5So3xb+2Pb//RUw93T
         9Diicj4OztPQU0Yvo8UWQjzPpt9WQDtaTRljYBzLX71ag8Oejvbl/GC3j/dfV4zqhnC6
         /CRw==
X-Gm-Message-State: APjAAAUGqyt6HkqJDt3P0NS8nEdUkcLeRmVkrBwu1VoQvr7owYsjop55
        Xbl4SrtAa9DskxEdigk3Mlsm4w==
X-Google-Smtp-Source: APXvYqwionHeW7OvwfALko4BMywjxRnTqkR5k7dN8/pAfPf/iklWDmh1NhduwQkSOCEvbbTgjfb5aQ==
X-Received: by 2002:aed:3504:: with SMTP id a4mr2786179qte.139.1551814509514;
        Tue, 05 Mar 2019 11:35:09 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id r64sm5454138qkb.60.2019.03.05.11.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 11:35:08 -0800 (PST)
Date:   Tue, 5 Mar 2019 14:35:07 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Todd Kjos <tkjos@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH] binder: fix race between munmap() and direct reclaim
Message-ID: <20190305193507.GA149288@google.com>
References: <20190301230606.8302-1-tkjos@google.com>
 <20190302075720.GA18046@kroah.com>
 <CAHRSSExy=kWt+MDzD10VogfasygJET6FmEtRc9vJuLv4Ov7+uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHRSSExy=kWt+MDzD10VogfasygJET6FmEtRc9vJuLv4Ov7+uA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 08:27:44AM -0800, Todd Kjos wrote:
> On Fri, Mar 1, 2019 at 11:57 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Mar 01, 2019 at 03:06:06PM -0800, Todd Kjos wrote:
> > > An munmap() on a binder device causes binder_vma_close() to be called
> > > which clears the alloc->vma pointer.
> > >
> > > If direct reclaim causes binder_alloc_free_page() to be called, there
> > > is a race where alloc->vma is read into a local vma pointer and then
> > > used later after the mm->mmap_sem is acquired. This can result in
> > > calling zap_page_range() with an invalid vma which manifests as a
> > > use-after-free in zap_page_range().
> > >
> > > The fix is to check alloc->vma after acquiring the mmap_sem (which we
> > > were acquiring anyway) and skip zap_page_range() if it has changed
> > > to NULL.
> > >
> > > Signed-off-by: Todd Kjos <tkjos@google.com>

Awesome patch, 
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks!
 
 - Joel

> > > ---
> >
> > Any specific commit that this fixes?
> 
> No, it's been there a long time.
> 
> > And should it be marked for stable releases?
> 
> It is needed in stable (back to 4.4), but will need to be backported.
> Should I post backported versions targeting the specific releases now?
> I was thinking we'd wait for this one to land. I think we'll need 1
> patch for 4.4/4.9 and a second one for 4.14/4.19 (and some of those
> backported patches will have conflicts when merged down to android-4.X
> -- I think the 4.14/4.19 version will apply to all the android
> branches). Let me know how you want to handle this.
> 
> >
> > thanks,
> >
> > greg k-h
