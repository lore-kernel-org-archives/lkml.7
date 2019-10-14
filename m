Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83DFC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CE720673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YDp68Zyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbfJNM4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 08:56:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38001 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730526AbfJNM4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:56:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so10373776pfe.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 05:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pyS+DrympKyI4FdnI2r2kXlN0WEKP6R4E5v/Ib2pOHo=;
        b=YDp68Zyk2ywgMVsWqmix1nrW5hNei5h6TonrN8JMUKCArSSX9z2yuhp6zSoI4u/aGS
         Xk0HT/EcCVmQUXT3Z+9YEwyX+TYybN5z2TdKIeWK89+vNPpbrhA13RvNNu3xMjvTp4CN
         N2u/L72QjH7otjbNBSQpt0PcNU/fq78yjMo/qGJJBXUWpiO2DkkEopyZxiUYGq5E73NH
         2lhvsHl2DpJmfdY9RpXvZBF/X91ezHas6607xDXtRhie+kQkivFpiQrWBPkhpLhrQnlV
         JjRdZlL/6kpuzoLgRGQ2tKBPfpOGmL2e1u/WXtIImnsi2RCBvaFdc8WNEuQ5qDi32GIP
         pJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pyS+DrympKyI4FdnI2r2kXlN0WEKP6R4E5v/Ib2pOHo=;
        b=pb0s7BjiPrA0cBVGaCpyZuZud6Byk6/Op3RlPH1KMJbVyEArVW2CtbCrgOa+K5HbGj
         mH782+vPhY8tkTVTn2N97Lx74oMbZoKbAjSxghXdyiTVyic9zL1Jyx3ASQYK/ZpHwFYo
         HbRzE3BMewW9KXM44AfetO7K1n5J5uTR/kV1SJG5sIfGPPcjcJ52lm/SiLVgEdJW9w53
         8fFsD78Ez/OJNuRX/QULqTXq78tsnHoSVTiAPOmP72LN/mthZ3pz3bo0byhyYrRr+GYI
         JYEfMnasn3lsY46rLdkWcDQCNYNyX6DSZ4TKRSLtkKEa1JuobnhAZ8cutPB7QCFlNGqz
         G56g==
X-Gm-Message-State: APjAAAU4wCHtqb7JNLCu2dokXlN7eUopxhxQStbQR3X8jLuPmiZRrS8G
        mRkRQ0a0FvswGiJJ+XAH5SLYUlEjtbOzw2DR9aJ6WA==
X-Google-Smtp-Source: APXvYqxE5OPcn3OUgyHT/ky5G2661dzw3FQJAA1da5dBNfVi6+WKL5gqbxEQO874AQKIgeroPf+VvwnmMXE495YiMCM=
X-Received: by 2002:a65:4c03:: with SMTP id u3mr33085293pgq.440.1571057807365;
 Mon, 14 Oct 2019 05:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+zR=S1cyaYfehyUDrpMGMXvxgLEeS8V2ze2HkwYUp6bjg@mail.gmail.com>
 <Pine.LNX.4.44L0.1910111039380.1529-100000@iolanthe.rowland.org> <20191011150646.GA1240544@kroah.com>
In-Reply-To: <20191011150646.GA1240544@kroah.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 14 Oct 2019 14:56:36 +0200
Message-ID: <CAAeHK+yCdTUtTMbH6r_r=hmS+Tk5mk6=nyRVuOFz6yvYSySKPA@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in alauda_check_media
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Jaskaran Singh <jaskaransingh7654321@gmail.com>,
        syzbot <syzbot+e7d46eb426883fb97efd@syzkaller.appspotmail.com>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        usb-storage@lists.one-eyed-alien.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 5:06 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 11, 2019 at 10:53:47AM -0400, Alan Stern wrote:
> > On Fri, 11 Oct 2019, Andrey Konovalov wrote:
> >
> > > On Fri, Oct 11, 2019 at 4:08 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > > > Now yes, it's true that defining status as an array on the stack is
> > > > also a bug, since USB transfer buffers are not allowed to be stack
> > > > variables.
> > >
> > > Hi Alan,
> > >
> > > I'm curious, what is the reason for disallowing that? Should we try to
> > > somehow detect such cases automatically?
> >
> > Transfer buffers are read and written by DMA.  On systems that don't
> > have cache-coherent DMA controllers, it is essential that the CPU does
> > not access any cache line involved in a DMA transfer while the transfer
> > is in progress.  Otherwise the data in the cache would be different
> > from the data in the buffer, leading to corruption.
> >
> > (In theory it would be okay for the CPU to read (not write!) a cache
> > line assigned to a buffer for a DMA write (not read!) transfer.  But
> > even doing that isn't really a good idea.)
> >
> > (Also, this isn't an issue for x86 architectures, because x86 has
> > cache-coherent DMA.  But it is an issue on other architectures.)
> >
> > In practice, this means transfer buffers have to be allocated by
> > something like kmalloc, so that they occupies their own separate set of
> > cache lines.  Buffers on the stack obviously don't satisfy this
> > requirement.
> >
> > At some point there was a discussion about automatically detecting when
> > on-stack (or otherwise invalid) buffers are used for DMA transfers.  I
> > don't recall what the outcome was.
>
> A patchset from Kees was sent, but it needs a bit more work...

Hi Greg,

Could you send a link to the patchset?

Thanks!
