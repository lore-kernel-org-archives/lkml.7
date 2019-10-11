Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC92BECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56FC2196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrLANnnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfJKJUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:20:03 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37179 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfJKJUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:20:03 -0400
Received: by mail-ua1-f68.google.com with SMTP id w7so2831283uag.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 02:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TFXaZXUVnWUo7FUoeyK+pimFP0T4TRsHMwFzrX99AMw=;
        b=qrLANnnPzdE4J92iqNq5PD6fjNxUOyVwpzFp6BQ5hiBx78tosvQ9MWO+uZ2mjESNV/
         4guvp0g5b5GIxWNCETw0OzGJxu3nigYwbkoaHXJVkm8X8BQWsi1ETz5Hp4ab3h/Y1Pxv
         8FqXstBi5Zgpfo4QSwhnhVFaj+/m9NuDX0vh8paTuTg5mmfRNlBSQmdIqeJlxrXv8Dcb
         zi6cEQhXSnWvu/8W8298JU3aS5Qw5i5NmpINkMf0N5taz58b+IOhMSkrqcvZqGxulcJ7
         xkZFN2+7ek3+shHZUc58s+5P2X66/b785Ifhaav6eOeZftbD/dYtOqT9oi1YiQArBQGB
         mFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TFXaZXUVnWUo7FUoeyK+pimFP0T4TRsHMwFzrX99AMw=;
        b=ItO+y74YVC8hGYJKpg+WbkyoEh+fQKO8vYNA5qBOlCZH1S26KgHlRMYrw3NF9BXW2R
         gpBHb8OdU9uy9k0ROuKJLEjh2sY0+4PRsADJTy8+JW9G/pacMlN8eKsyJPJh5N+pKEQi
         4qJ4hl4CfX/DhYnyjjzIeo8ZMNScdjdgiYmatgTiFMYGdlp/9EQ5Jj24RdT+ag2E0uCj
         aE938UudR+LOLyAA9aqRAKRNTdc1hWark+qmcn/1fE+dGCdxC/dtytXOvaOM5Ri7VI21
         Ld96hd/X22yWJxuNiY6UEcc1fGVoMpaFtOQDsyLjxZ+vEEP7PJBH5UdBBPjz9llif2eN
         30Cw==
X-Gm-Message-State: APjAAAUzLy1nzbov9gogOZMjqg6BZHb9IrRKNxoKkCgxzfDW5c6OYcs0
        Y6bxEzdhQTOk/YvJS0AkYVWeOq8eAUn5XIZxgX9sRHbzaFc=
X-Google-Smtp-Source: APXvYqyQ3FT1Trdnl3pRYnMIjP5Zd82IeXfo65Gui+/IKtSdpKl6Aoqf1C1vdv4yLGqhhiPMy+wDoFtLD80uce34w6Y=
X-Received: by 2002:ab0:d82:: with SMTP id i2mr6008603uak.34.1570785602088;
 Fri, 11 Oct 2019 02:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191010140615.26460-1-oshpigelman@habana.ai> <20191010140950.GA27176@infradead.org>
 <AM6PR0202MB338206146804E2E2BC18C67FB8940@AM6PR0202MB3382.eurprd02.prod.outlook.com>
 <20191011081055.GA9052@infradead.org>
In-Reply-To: <20191011081055.GA9052@infradead.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 11 Oct 2019 12:19:36 +0300
Message-ID: <CAFCwf11hYWYNeROT8zpW+fcALijcTUuGVk-NoWvxzCORvd+dew@mail.gmail.com>
Subject: Re: [PATCH 1/2] habanalabs: support vmalloc memory mapping
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Omer Shpigelman <oshpigelman@habana.ai>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 11:10 AM Christoph Hellwig <hch@infradead.org> wrot=
e:
>
> On Thu, Oct 10, 2019 at 07:54:07PM +0000, Omer Shpigelman wrote:
> > The is_vmalloc_addr checks are for user pointers and for memory which w=
as allocated by the driver with vmalloc_user.
>
> This does not make any sense whatsoever.  vmalloc_user returns a kernel
> address, it just does a GFP_USER instead of GFP_KERNEL allocation, which
> is just accounting differences.
>
> > > > Mapping vmalloc memory is needed for Gaudi ASIC.
> > >
> > > How does that ASIC pass in the vmalloc memory?  I don't fully underst=
and
> > > the code, but it seems like the addresses are fed from ioctl, which m=
eans
> > > they only come from userspace.
> >
> > The user pointers are indeed fed from ioctl for DMA purpose, but as I w=
rote above the vmalloc memory is allocated by the driver with vmalloc_user =
which will be mmapped later on in order to create a shared buffer between t=
he driver and the userspace process.
>
> Again, you can't pass pointers obtained from vmalloc* to userspace.  You
> can map the underlying pages into user pagetables, but is_vmalloc_addr
> won't know that.  I think you guys need to read up on virtual memory 101
> first and then come back and actually explain what you are trying to do.

Hi Christoph,
I think the confusion here is because this is only a pre-requisite
patch, which doesn't show the full code of how we use vmalloc_user.
So I want to describe the full flow here and please tell me if and
what we are doing wrong.

We first allocate, using vmalloc_user, a certain memory block that
will be used by the ASIC and the user (ASIC is producer, user is
consumer).
After we use vmalloc_user, we map the *kernel* pointer we got from the
vmalloc_user() to the ASIC MMU. We reuse our driver's generic code
path to map host memory to ASIC MMU and that's why we need the patch
above. The user does NOT send us the pointer. He doesn't have this
pointer. It is internal to the kernel driver. To do this reuse, we
added a call to the is_vmalloc_addr(), so the function will know if it
is called to work on user pointers, or on vmalloc *kernel* pointers.

What the user does get is an opaque handle. Later he calls mmap() with
our FD and this handle. In the driver, we do remap_vmalloc_range() on
the *kernel* pointer we retrieved using the opaque handle we got from
the user, and return a valid user-space process address that points to
this memory block, so the user can access it.

AFAIK from my GPU days, this is totally valid. The user does NOT see
kernel pointers. There is total separation between kernel and user
pointers. User get pointers only by calling mmap(). We NEVER return a
pointer to a user in an IOCTL. Only through mmap.
Please tell me if you see a problem here. If you need more details,
I'll happy to provide them.

Side note:
The reason the driver allocates the memory block and not the user
itself (like we did so far in all our code), is because this block is
mapped to our ASIC internal MMU using a priviliged ASID. I don't want
to give the user a uapi that will enable him to request to map memory
to the ASIC using a priviliged ASID. Therefore, the kernel driver does
it internally.

Thanks,
Oded
