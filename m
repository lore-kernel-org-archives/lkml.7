Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D81C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45ADC218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MbW34w26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfCOLG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:06:28 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53019 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfCOLG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:06:28 -0400
Received: by mail-it1-f193.google.com with SMTP id g17so9545940ita.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 04:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5vwE1mK2LrSVRCDcCWmkPt3eZILJfwhggvzcUc68doY=;
        b=MbW34w26diimFJ2anjGBESlXtxkzKuUyyUAxk7NuBAtLSl6TRNnGaFQdTzp+IKX87K
         Z5B2DPw6w5GiS8HJcpCiZp4PhDpV0GXnLXxnyKoBPJweTY3fTgrv4y3msu4dENWlO/gT
         sisYwayO+IIXWyZByRiC8m5D8OqIoJ2N9TIFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5vwE1mK2LrSVRCDcCWmkPt3eZILJfwhggvzcUc68doY=;
        b=eDfSFu3ZZZ0FX7mBWzLNdCWIRgkmnd5YL0wKpscj0JoOjcYxG/ZK8ZAT6OKyv5nd5d
         FyeYIPoEmwEgUQk4ctP1myNWZZ3MwOo0RQTtBb2aOsWjzvq49ylXTX6OYG9gUz+3BXBR
         1Bo8TBkdd0pWPUbOc3LqUz4QqUFIaoWJscYINf3ILGfA1BA4TP3h3B+8+/iiQFTrRX2V
         uPSBIet13BiePuMAzRSFGBTeD3vZ3aHVcpR/jcHssQN0ArSk5VM+OFZB2CpvroaLN/Tq
         glRx0l6AcmPvqEcdKFE+L6QBI+/XQGjZJyuD4dPIxRqFlmxQi9f7a8GSUma//0wzMM2o
         mMiA==
X-Gm-Message-State: APjAAAVhe0lQCL0txqEHrMqCU2Fy5LK4X7jHCRxcgGLutNIonvAbiaT2
        aOS+LRj0RZIgCsFvLN3X5f+8LDmv7ZzYfTaFlAP2HA==
X-Google-Smtp-Source: APXvYqwb8NxABys/a2md1iOdfU7HO7OM9n+ReWGg6aYypHSeWQggt/QVlg1bsiT/lryGqMxAjQcZHnBKOO/vJHaF8E0=
X-Received: by 2002:a02:1ac3:: with SMTP id 186mr2042087jai.96.1552647987268;
 Fri, 15 Mar 2019 04:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190227035448.117169-1-fengc@google.com> <CAO_48GG0sW3AJNVJnydjuWUQHcmWe5aQrB=X0Wo7uBtDnPtoYg@mail.gmail.com>
In-Reply-To: <CAO_48GG0sW3AJNVJnydjuWUQHcmWe5aQrB=X0Wo7uBtDnPtoYg@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 15 Mar 2019 12:06:15 +0100
Message-ID: <CAKMK7uFMj7wQQ7hVubXgbP61gmAE3zGcNQyDW5gexZO75z4sDw@mail.gmail.com>
Subject: Re: [RFC dma-buf 0/3] Improve the dma-buf tracking
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     Chenbo Feng <fengc@google.com>, erickreyes@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 6:49 PM Sumit Semwal <sumit.semwal@linaro.org> wrot=
e:
>
> Hello Chenbo,Thank you for your RFC series.
>
> On Wed, 27 Feb 2019 at 09:24, Chenbo Feng <fengc@google.com> wrote:
> >
> > Currently, all dma-bufs share the same anonymous inode. While we can co=
unt
> > how many dma-buf fds or mappings a process has, we can't get the size o=
f
> > the backing buffers or tell if two entries point to the same dma-buf. A=
nd
> > in debugfs, we can get a per-buffer breakdown of size and reference cou=
nt,
> > but can't tell which processes are actually holding the references to e=
ach
> > buffer.
> >
> > To resolve the issue above and provide better method for userspace to t=
rack
> > the dma-buf usage across different processes, the following changes are
> > proposed in dma-buf kernel side. First of all, replace the singleton in=
ode
> > inside the dma-buf subsystem with a mini-filesystem, and assign each
> > dma-buf a unique inode out of this filesystem.  With this change, calli=
ng
> > stat(2) on each entry gives the caller a unique ID (st_ino), the buffer=
's
> > size (st_size), and even the number of pages assigned to each dma-buffe=
r.
> > Secoundly, add the inode information to /sys/kernel/debug/dma_buf/bufin=
fo
> > so in the case where a buffer is mmap()ed into a process=E2=80=99s addr=
ess space
> > but all remaining fds have been closed, we can still get the dma-buf
> > information and try to accociate it with the process by searching the
> > proc/pid/maps and looking for the corresponding inode number exposed in
> > dma-buf debug fs. Thirdly, created an ioctl to assign names to dma-bufs
> > which lets userspace assign short names (e.g., "CAMERA") to buffers. Th=
is
> > information can be extremely helpful for tracking and accounting shared
> > buffers based on their usage and original purpose. Last but not least, =
add
> > dma-buf information to /proc/pid/fdinfo by adding a show_fdinfo() handl=
er
> > to dma_buf_file_operations. The handler will print the file_count and n=
ame
> > of each buffer.
>
> In general, I think I like the idea as it contributes to a much more
> relevant usage analysis of dma-buf backed buffers.
> I will get to doing a more detailed review soon, but immediately, we
> might want to think a bit about the get/set_name IOCTLS - do we need
> to think of disallowing multiple renaming of buffers once they start
> getting used? It could otherwise make the whole metrics a lot
> confused?
>
> >
> > Greg Hackmann (3):
> >   dma-buf: give each buffer a full-fledged inode
> >   dma-buf: add DMA_BUF_{GET,SET}_NAME ioctls
> >   dma-buf: add show_fdinfo handler

I'm not seeing the patches, so just quick comment here: Some drivers
(at least vc4) already have the concept of buffer names. Would be neat
to integrate this between dma-buf and drm_gem in prime.

Aside from that sounds like a good idea overall, but I can't see any detail=
s.
-Daniel

> >
> >  drivers/dma-buf/dma-buf.c    | 121 ++++++++++++++++++++++++++++++++---
> >  include/linux/dma-buf.h      |   5 +-
> >  include/uapi/linux/dma-buf.h |   4 ++
> >  include/uapi/linux/magic.h   |   1 +
> >  4 files changed, 122 insertions(+), 9 deletions(-)
> >
> > --
> > 2.21.0.rc2.261.ga7da99ff1b-goog
> >
>
> Best,
> Sumit.
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
