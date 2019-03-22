Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FCFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D6B2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="gXnr/LKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfCVWOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:14:41 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54380 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbfCVWOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:14:38 -0400
Received: by mail-it1-f193.google.com with SMTP id w18so5879802itj.4;
        Fri, 22 Mar 2019 15:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wm2+IDsr0NmRaIQ9GIimbnBiutoAYhXqklaChAdkC0E=;
        b=gXnr/LKcmO3n/AkDnk5tuJJz0sD52kdAC51zKOFpz9IFbfbYifTLF6ymlYbHKb1Fzf
         5IK9kzfgRjlOjG8rPf/pLCcCoxWGCDHkfS90S+LKj3jcXm5xQYa13eJcPAUZ+hXohZjm
         IBPo+8GJ+Rq8y+Q+kI7lVQj+zb+PR7I30rOlJksrdJy/Wp2dqUTjZA9F3vGG+ezwSQtN
         Rd0g5Hf0LyHnnPkTMRnIAwxLFm25gMxn56/wKPSlCPteP5nwXO0eAhs4klJ0MxT6YP2e
         dxwI2R6VEa8rmJFaL4xGk5paDuSdBggXv21lLkD4qtLHBeTsgNPI61yo109FsRi4r0QQ
         8DwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wm2+IDsr0NmRaIQ9GIimbnBiutoAYhXqklaChAdkC0E=;
        b=ItXnI17q/8HYNVYKAk23Ry8uJ6eJUxTrVV/aCpyymPtrQbysZjJ2onR64HdCj05rnC
         pHKT/vgzaN53WGlWX2vfc3nUmvlm55rPp3a/I93Hmbh7qY1IVdyGEOsx90mKojx+8Xbg
         Dfholtef69cKrK7KzW2JgkrLX6RkEfeCwXXFpwz4/CFwoi/5ZG9MUmhxCjRzjqHawUX5
         dowUiFcTo4Be8IOK1tctByaS3agcaQQrSV+XEG588UG/A35E+ofkgChAnMwIueMEiWwg
         Ly1v/Ib2N3RmGhV+iaxe0pWXPGJ3tVSr+dNyQO7+gshCheeGVeEOJfYJeSiEb25CxfHj
         xbWQ==
X-Gm-Message-State: APjAAAVJ9jdxgwr4XN3HSsNPdunKhHNlhJmmZ68hDRGbYyMpsZyjyPRi
        BHWXW9pzdht1adYOIcgJxI9r0O/+COLSfsr+TEk=
X-Google-Smtp-Source: APXvYqwIoaHTQX3ElVQKOchmDlJSSWqTKG84OsYpQvQY0PG83rmTkoixgVtLY+vkXQxXTMX8UIfgiVFJTO08ZCVWvdY=
X-Received: by 2002:a24:411f:: with SMTP id x31mr3120456ita.169.1553292877426;
 Fri, 22 Mar 2019 15:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190317183438.2057-1-ira.weiny@intel.com> <20190317183438.2057-6-ira.weiny@intel.com>
In-Reply-To: <20190317183438.2057-6-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 22 Mar 2019 15:14:26 -0700
Message-ID: <CAA9_cmdQjMekSFU09gLc87-PVx2iHeeh2jC6KeFY1UeadpPh4A@mail.gmail.com>
Subject: Re: [RESEND 5/7] IB/hfi1: Use the new FOLL_LONGTERM flag to get_user_pages_fast()
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 7:36 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> Use the new FOLL_LONGTERM to get_user_pages_fast() to protect against
> FS DAX pages being mapped.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/user_pages.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hfi1/user_pages.c b/drivers/infiniband/hw/hfi1/user_pages.c
> index 78ccacaf97d0..6a7f9cd5a94e 100644
> --- a/drivers/infiniband/hw/hfi1/user_pages.c
> +++ b/drivers/infiniband/hw/hfi1/user_pages.c
> @@ -104,9 +104,11 @@ int hfi1_acquire_user_pages(struct mm_struct *mm, unsigned long vaddr, size_t np
>                             bool writable, struct page **pages)
>  {
>         int ret;
> +       unsigned int gup_flags = writable ? FOLL_WRITE : 0;

Maybe:

    unsigned int gup_flags = FOLL_LONGTERM | (writable ? FOLL_WRITE : 0);

?

>
> -       ret = get_user_pages_fast(vaddr, npages, writable ? FOLL_WRITE : 0,
> -                                 pages);
> +       gup_flags |= FOLL_LONGTERM;
> +
> +       ret = get_user_pages_fast(vaddr, npages, gup_flags, pages);
>         if (ret < 0)
>                 return ret;
>
> --
> 2.20.1
>
