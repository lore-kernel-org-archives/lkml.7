Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA524C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37F320833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfDHN7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:59:02 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35538 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfDHN7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:59:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id h39so6683684qte.2;
        Mon, 08 Apr 2019 06:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYS4YB6xQJBW5Cjgq2FmmiodlQqxQnUu/xaaZZ+5Xjc=;
        b=c98tOlUyKAxfiiAGSqUyy0ZNCQTfvfjcYwKUYRv04KX5t7ZeJXY+QP3Rcmjqe6zei8
         2yv8DJrzrmbCLpLNzTuMX0mYc8vt3vZGVOZfeHav2GFhG4+syygbTQ3VFUtLL31dVn+P
         JQ/WGlSaybHnYybIee2Qw8g0TMzXyp/PkjtiLhBisdBv8LiTtgBqQdMuqdJX3f40aiIY
         Nd2WUby+cwreYgrMlU4lbJutNjBesObxD+YMDvv/1cjBjyIIbbRjbSyKL1IGuurV8GnQ
         Iyyd7uWqPDggk6Et/+NzdPb/bThxU1PNnphNu6qqSEIrgBgrqiLzF0TVqCSuotjYgZxD
         Vl5g==
X-Gm-Message-State: APjAAAUyUA5dmE5owhOi3hE80DrvFe84MnClm6d8cl6SOyyMdBtzP0Yt
        dXvI6GKukgN4n5+v1u0m3akxDm/qCCpD0sS0Dek=
X-Google-Smtp-Source: APXvYqz4/6RA0TtmJoUO3ceRJPcXWmziqc/CWyBiNthFnT0Vt89eOxJ4G4XuugcKUKeWNrFr3aTfmrwO+i3H/TA06Zo=
X-Received: by 2002:ac8:8b9:: with SMTP id v54mr25473996qth.64.1554731941101;
 Mon, 08 Apr 2019 06:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190408124640.GA607@lst.de>
In-Reply-To: <20190408124640.GA607@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Apr 2019 15:58:44 +0200
Message-ID: <CAK8P3a13NVbkJzzoZG_7HrDT9qGPR5ptbRUL=xH1oZ1a+5ksHw@mail.gmail.com>
Subject: Re: CONFIG_* symbols in UAPI headers?
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jie Zhang <jie.zhang@analog.com>,
        Mike Frysinger <vapier@gentoo.org>,
        David Howells <dhowells@redhat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 2:46 PM Christoph Hellwig <hch@lst.de> wrote:
>
> I just stumbled over the MAP_UNINITIALIZED defintion, initially
> added by:
>
> commit ea637639591def87a54cea811cbac796980cb30d
> Author: Jie Zhang <jie.zhang@analog.com>
> Date:   Mon Dec 14 18:00:02 2009 -0800
>
>     nommu: fix malloc performance by adding uninitialized flag
>
> The defintion depends on CONFIG_MMAP_ALLOW_UNINITIALIZED, which
> will never be set by userspace.  How is this supposed to work?
>
> Shoudn't we define the symbol unconditionally and just turn it
> into a no-op in the implementation?

Right, good catch. That should work. It can probably be done
by adding another check before the conditional, like:

       /* clear anonymous mappings that don't ask for uninitialized data */
       if (!vma->vm_file &&
           !(IS_ENABLED(CONFIG_MMAP_ALLOW_UNINITIALIZED) &&
             (flags & MAP_UNINITIALIZED))
               memset((void *)region->vm_start, 0,
                      region->vm_end - region->vm_start);

> There are a few similar issues, like struct elf_prstatus having
> a different layout depending on CONFIG_BINFMT_ELF_FDPIC, or
> MAX_SHARED_LIBS defending on CONFIG_BINFMT_SHARED_FLAT.

I thought we had cleaned them out a long time ago, but it looks
like those have been there since the uapi headers got split out,
and are still wrong.

Why doesn't scripts/headers_check.pl find those?

      Arnd
