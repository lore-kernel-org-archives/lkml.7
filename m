Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61167C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBC7217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UTEKW/lQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390605AbfGROaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:30:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45349 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGROaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:30:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id s22so20605903qkj.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 07:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jjmJCNJRGOhllI8UevhEezWy1jhS3nYRGQxeSWHjEqQ=;
        b=UTEKW/lQw1+YfnPZ90S0KbWWY8Wf+Rufpf+WlEgKiDHOHtf7HrKB83Bjoy8ag66hfO
         6MEeXVjU8MnY7PYY4RwzoAQ3hb3OZLC5SmYHPlDFCJ9/XcnZV0V5s1UC+pDevIW9Du7u
         WmxuQm1ZgMKRAio5Ii5xne72QhjVM+oE+ZM646Z6YLs2vTQ5P/95rMA/07sWtgyUOw2h
         1rm2g3x7RY3qk7h1uYXaihYrKv2/nw+UG8zP5AHcSOx8zX6gGJ1IkOVYET8QR92ep1B0
         oxQFc2EAkLrtehUI7WEnsZikIYEQNhggfHRYPQjfmT12HvL9xJN/58xty7YWcw3RsBbB
         m7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjmJCNJRGOhllI8UevhEezWy1jhS3nYRGQxeSWHjEqQ=;
        b=W/sgjGc5SXPCH8sFh+gFQDfYpP4S4kyPj0pSLzX0JLjE2TLAWrll6vWyfGVGWY6lXS
         2A2RRl4yOHEWcIvjkyF1fzJPiups36dyjZ++3fABKZF1JJMaDu65FU4Reya/cL2RmtpU
         sTdY45w9WtK0S8EItnRoG0eNm08yejOd+tZs1M2g/3xvxdvsGVCshLzvRd1Hf7FIQHYI
         22FjBzwzQcXJoS+WopQH/fQbrhX+wzOe9kuZ51NM7QEHZqTFR1oeFyu1cfWjtEpwGbjS
         /ZAApRGwQz6HI6G31hygo5v9lld8wpUufm5iWLT0XfmhWeyhrtsBLCLw2Pey/YbmVh/E
         S5sw==
X-Gm-Message-State: APjAAAURTKHmMZZ0Ywi0EKPEMK0YBHhHsGnXb10V9gl91/JNugrTKaB+
        JGpd3pw0epn420HS1jvSyT+vGYSN+wja3elVvYlx3A==
X-Google-Smtp-Source: APXvYqyH3Tq2IZ4Y34U+Coq0W2cVWZFn0bZvr00HyTwOSwv4wauHuS/tecT7SIuKu7ysKawZSqDgTIAA4/cnpxUome4=
X-Received: by 2002:a37:a742:: with SMTP id q63mr29771140qke.421.1563460215307;
 Thu, 18 Jul 2019 07:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190515192715.18000-1-vgoyal@redhat.com> <20190515192715.18000-19-vgoyal@redhat.com>
 <20190717192725.25c3d146.pasic@linux.ibm.com> <20190718131532.GA13883@redhat.com>
In-Reply-To: <20190718131532.GA13883@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 18 Jul 2019 07:30:03 -0700
Message-ID: <CAPcyv4i+2nKJYqkbrdm3hWcjaMYkCKUxqLBq96HOZe6xOZzGGg@mail.gmail.com>
Subject: Re: [PATCH v2 18/30] virtio_fs, dax: Set up virtio_fs dax_device
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Collin Walling <walling@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        KVM list <kvm@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Steven Whitehouse <swhiteho@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 6:15 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Jul 17, 2019 at 07:27:25PM +0200, Halil Pasic wrote:
> > On Wed, 15 May 2019 15:27:03 -0400
> > Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > >
> > > Setup a dax device.
> > >
> > > Use the shm capability to find the cache entry and map it.
> > >
> > > The DAX window is accessed by the fs/dax.c infrastructure and must have
> > > struct pages (at least on x86).  Use devm_memremap_pages() to map the
> > > DAX window PCI BAR and allocate struct page.
> > >
> >
> > Sorry for being this late. I don't see any more recent version so I will
> > comment here.
> >
> > I'm trying to figure out how is this supposed to work on s390. My concern
> > is, that on s390 PCI memory needs to be accessed by special
> > instructions. This is taken care of by the stuff defined in
> > arch/s390/include/asm/io.h. E.g. we 'override' __raw_writew so it uses
> > the appropriate s390 instruction. However if the code does not use the
> > linux abstractions for accessing PCI memory, but assumes it can be
> > accessed like RAM, we have a problem.
> >
> > Looking at this patch, it seems to me, that we might end up with exactly
> > the case described. For example AFAICT copy_to_iter() (3) resolves to
> > the function in lib/iov_iter.c which does not seem to cater for s390
> > oddities.
> >
> > I didn't have the time to investigate this properly, and since virtio-fs
> > is virtual, we may be able to get around what is otherwise a
> > limitation on s390. My understanding of these areas is admittedly
> > shallow, and since I'm not sure I'll have much more time to
> > invest in the near future I decided to raise concern.
> >
> > Any opinions?
>
> Hi Halil,
>
> I don't understand s390 and how PCI works there as well. Is there any
> other transport we can use there to map IO memory directly and access
> using DAX?
>
> BTW, is DAX supported for s390.
>
> I am also hoping somebody who knows better can chip in. Till that time,
> we could still use virtio-fs on s390 without DAX.

s390 has so-called "limited" dax support, see CONFIG_FS_DAX_LIMITED.
In practice that means that support for PTE_DEVMAP is missing which
means no get_user_pages() support for dax mappings. Effectively it's
only useful for execute-in-place as operations like fork() and ptrace
of dax mappings will fail.
