Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9322DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF6821D7A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gvDMJyi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394664AbfIVS4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:56:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41526 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394635AbfIVS4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:56:48 -0400
Received: by mail-io1-f68.google.com with SMTP id r26so28122286ioh.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 11:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sAqbwyBTLJzoUSUpLlDoNowzK2mKFjnFSGx3ns38mRA=;
        b=gvDMJyi0VYg2HDyTVTX871MrmgdptlPi80DlT2OFZ/09lG+cgJHqYoQ3pfp4GMxki9
         Q+Mys2JCRTWBll+dWcfNXkhZsNQlrxWYX1XJExoD6GmxfgUvFwJoyV/5OStqxsgOgyyF
         3y57mn0MbPeAD8DB5iq4Fnvx2UQhUocf4p3ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sAqbwyBTLJzoUSUpLlDoNowzK2mKFjnFSGx3ns38mRA=;
        b=nPaIyTlZIIHJqfudLyVcWXVltKL2EOctrFkWRwMOo8myfDugwfTm+0ek7MVsgi+IN5
         TzxIcwC/nM8pdzUuqWdHLu0gmWH8zQ9VG1ag8FQnveufY/eSF0BgH6WaSn+fFgez81uK
         dHTv5IUo6uSMe7J3fEMTb69PrK2riDW8wBWbCFR570X/pP/FvZFSEJZdiHNyJqqRLqXT
         YFZYCFd1J+Tgd3FRY1tOVifp957UVQ0hYiqGgXPxk84fHMzhdnwewXT1DsnVtKWYT9u9
         ro4p+lfNFTtaHH9wqpkmOUc6yOX9/LWovN/sEOUAZrIgSoXxKTZpg6X2oDShA8ErDOT6
         S/4A==
X-Gm-Message-State: APjAAAVzRj+lO9GUQuUEoEMjThOrd+VJGSDrqk9z0vqyTZAX4o8DnqCs
        AhowFqsSjxrpfm1z5GRmRuIbYoBrZpgOedjcCEkPww==
X-Google-Smtp-Source: APXvYqxzkhJ6AasAGq0IVSL9MC0OHG+zVFKC5bbGePpkO+jPZmyxNT5A7a6uwF9+BwM7wd8tFr917EWYOp/RcO8JFcg=
X-Received: by 2002:a6b:5d18:: with SMTP id r24mr31400776iob.285.1569178607349;
 Sun, 22 Sep 2019 11:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190922131936.GE2233839@devbig004.ftw2.facebook.com>
In-Reply-To: <20190922131936.GE2233839@devbig004.ftw2.facebook.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Sun, 22 Sep 2019 20:56:36 +0200
Message-ID: <CAJfpegsO3gepyyQUhY15gE=nqBW5hL1G4wUM+Yj2CvLf83Sw0Q@mail.gmail.com>
Subject: Re: [PATCH] FUSE: fix beyond-end-of-page access in fuse_parse_cache()
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 3:19 PM Tejun Heo <tj@kernel.org> wrote:
>
> With DEBUG_PAGEALLOC on, the following triggers.
>
>   BUG: unable to handle page fault for address: ffff88859367c000
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 3001067 P4D 3001067 PUD 406d3a8067 PMD 406d30c067 PTE 800ffffa6c983060
>   Oops: 0000 [#1] SMP DEBUG_PAGEALLOC
>   CPU: 38 PID: 3110657 Comm: python2.7
>   RIP: 0010:fuse_readdir+0x88f/0xe7a [fuse]
>   Code: 49 8b 4d 08 49 39 4e 60 0f 84 44 04 00 00 48 8b 43 08 43 8d 1c 3c 4d 01 7e 68 49 89 dc 48 03 5c 24 38 49 89 46 60 8b 44 24 30 <8b> 4b 10 44 29 e0 48 89 ca 48 83 c1 1f 48 83 e1 f8 83 f8 17 49 89
>   RSP: 0018:ffffc90035edbde0 EFLAGS: 00010286
>   RAX: 0000000000001000 RBX: ffff88859367bff0 RCX: 0000000000000000
>   RDX: 0000000000000000 RSI: ffff88859367bfed RDI: 0000000000920907
>   RBP: ffffc90035edbe90 R08: 000000000000014b R09: 0000000000000004
>   R10: ffff88859367b000 R11: 0000000000000000 R12: 0000000000000ff0
>   R13: ffffc90035edbee0 R14: ffff889fb8546180 R15: 0000000000000020
>   FS:  00007f80b5f4a740(0000) GS:ffff889fffa00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: ffff88859367c000 CR3: 0000001c170c2001 CR4: 00000000003606e0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>    iterate_dir+0x122/0x180
>    __x64_sys_getdents+0xa6/0x140
>    do_syscall_64+0x42/0x100
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> faddr2line says
>
>   fuse_readdir+0x88f/0x38fc9b:
>   fuse_parse_cache at /builddir/build/BUILD/kernel-5.2.9-1992_g2c63931edbb0/fs/fuse/readdir.c:375
>   (inlined by) fuse_readdir_cached at /builddir/build/BUILD/kernel-5.2.9-1992_g2c63931edbb0/fs/fuse/readdir.c:524
>   (inlined by) fuse_readdir at /builddir/build/BUILD/kernel-5.2.9-1992_g2c63931edbb0/fs/fuse/readdir.c:562
>
> It's in fuse_parse_cache().  %rbx (ffff88859367bff0) is fuse_dirent
> pointer - addr + offset.  FUSE_DIRENT_SIZE() is trying to dereference
> namelen off of it but that derefs into the next page which is disabled
> by pagealloc debug causing a PF.
>
> This is caused by dirent->namelen being accessed before ensuring that
> there's enough bytes in the page for the dirent.  Fix it by pushing
> down reclen calculation.

Thanks, applied.

Miklos
