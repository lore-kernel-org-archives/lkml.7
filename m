Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F65C07542
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF98D21721
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="YbZYex+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfE2Hzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:55:50 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51286 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfE2Hzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:55:50 -0400
Received: by mail-it1-f194.google.com with SMTP id m3so2192671itl.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 00:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=op4791qBHMjDCQdV9txK9mbzIX+WhgzeovFSwUXqaFQ=;
        b=YbZYex+MkYR9h819JTNbMfn9OoTfQc0WfMl0pIniSUlyhGceEB4vQ8StrtFyuiAy4w
         V/rdXa8qsaNoWL4xwbh2GBDzhIEKxgBZMsNRyZjGgmPoBJPWEYu2f0YjJis9SSPtC26W
         UD998MyvHLyBc5OYtLE92jxNIzzt5APPCEtC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=op4791qBHMjDCQdV9txK9mbzIX+WhgzeovFSwUXqaFQ=;
        b=lZU9DWDT2yDX9By2aVaFKYCAx1OOF91/M3Wx3Ti6nXb6PRGjY0if8ogqztu1SUa0I0
         nMpIFCrqT3nses/X0xx2MB6MmasCOdSGIDaoSnWxxLjB7l+N1tfZhfpu/fAxG2mHCtme
         UXAyPF2y5tRCkxKoZaKU9XdhIU/865c+F6LeXxkXrk1ceTNs4y1pF1GR887mzYhU41fR
         ov30K+tCoJF6r8mHm9Q+i0HcVjKh21PENINvT4iDjlcbWc7kH12IRxxFPE+GyY68s0hr
         m7qzDBW2AC9h8KndVHdChWsxw7Ge3q1sK86yG7pP7zgcAC99eF3cqmUjjGa1Yko7P6O1
         GOcQ==
X-Gm-Message-State: APjAAAUgNpNzLgCKqbddcE+Uj3IZHWRcmQ3KPm3Pxa5wInQwuTDN/Sb4
        NHhY1oywkIIfcgHgheL7Wfs5k6aWUJLlyhMFO8x8cg==
X-Google-Smtp-Source: APXvYqy/whcusTY4hHDoC4X+OnP9aaNKf6KjmFpD6uW6iIEpnRrUQmEJ77wekoH11aNFI99khObtXhKqxO04kVXVSD0=
X-Received: by 2002:a24:4dd4:: with SMTP id l203mr6105131itb.118.1559116549227;
 Wed, 29 May 2019 00:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <155905621951.1304.5956310120238620025.stgit@warthog.procyon.org.uk>
 <155905622921.1304.8775688192987027250.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905622921.1304.8775688192987027250.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 29 May 2019 09:55:38 +0200
Message-ID: <CAJfpeguPTQ00zVjpwVQ4R8mEqE3aijCzNMAz6Wvr56xE-jfJag@mail.gmail.com>
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able ring
 buffer [ver #13]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 5:10 PM David Howells <dhowells@redhat.com> wrote:
>
> Implement a misc device that implements a general notification queue as a
> ring buffer that can be mmap()'d from userspace.
>
> The way this is done is:
>
>  (1) An application opens the device and indicates the size of the ring
>      buffer that it wants to reserve in pages (this can only be set once):
>
>         fd = open("/dev/watch_queue", O_RDWR);
>         ioctl(fd, IOC_WATCH_QUEUE_NR_PAGES, nr_of_pages);
>
>  (2) The application should then map the pages that the device has
>      reserved.  Each instance of the device created by open() allocates
>      separate pages so that maps of different fds don't interfere with one
>      another.  Multiple mmap() calls on the same fd, however, will all work
>      together.
>
>         page_size = sysconf(_SC_PAGESIZE);
>         mapping_size = nr_of_pages * page_size;
>         char *buf = mmap(NULL, mapping_size, PROT_READ|PROT_WRITE,
>                          MAP_SHARED, fd, 0);

Would it make sense to use relayfs for the implementation of the
mapped ring buffer?

Thanks,
Miklos
