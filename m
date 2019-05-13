Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B1AC46460
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3C8208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="MeRY+QdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbfEMRww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:52:52 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45916 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730532AbfEMRwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:52:51 -0400
Received: by mail-oi1-f196.google.com with SMTP id w144so4511195oie.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y9X01Pkq0XXte5z0O4rYu6NU6lcDo0STfPmFKCJpwI4=;
        b=MeRY+QdGFjfDKUSuf7dAOysOfrk9IX/j0cXEQeRSHYHXItna9fFtGcb80/8yDKWYkg
         kEPTsia824fjKznGv99pekCCmDAbBmu8zC8ES2wNtrw9iGNZzpMC40Dc0waTtukABlou
         DiMjy3wekDMZv+rEku5zj5N9lua8h+E9NR26CrKLNtsmzHWBp5Dk25a7+ZFTFlXvp5bn
         CKgC360dEZCMTiYCVvVNHBz83ANXriwcLt3Kp71GNpJ+aE+ylpXoUdrY8187QZo8pUjo
         MSFx+LZTKoW3yj60OEeZpgD+/UaXJIXSDimXFG17gPEeJljKEDt4VY/2RYHjnGTmH4Sh
         vvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9X01Pkq0XXte5z0O4rYu6NU6lcDo0STfPmFKCJpwI4=;
        b=iypjkRsntmJU5pfsogV+H355WDDbFt3iU962PFkveIlYCN/G2dntuuIdzCX9kUlmmW
         JIovspyzHic/9JqH+xYMrfbMJJXLmtAGR0p6BujADVUkJ6W8AiJErT+jg0xX4E8CWz3e
         /cUqlA5vCG82//SF7XvRsQSaZZI7jSo/qdhc9ra5FL8UUuc8FimSZ3BSQFa0UWIhfSg7
         9jM1djBZjsrqnqN6EvjB2FvZqaW5/V88VaC4LfvRdD75UDXhrnA5YjTmI7B67pEyJsnU
         AEu/dXeCmKm04k1BU2On24tUzCHI+apga+wrOGUC6EnGTs+fMCwU/B1wKXDHNsX435gL
         c+YA==
X-Gm-Message-State: APjAAAW0+WzW83mLdKEi4GM11XxysSataAqLF+utmNMpDtTVCHffHPHn
        YAHy3sqvyIjlpaAOotPUTNUVTA9EPfp9FbTYwrfp9A==
X-Google-Smtp-Source: APXvYqyHlb4HK4pDjcMSgSQt8NqfXMPz+kR7QQEkSBVnAow9XkYo/o3V5df/EMWF1DvMzRr9ptTlw2tfnEJV3YCdJtY=
X-Received: by 2002:aca:dfc4:: with SMTP id w187mr254128oig.70.1557769970924;
 Mon, 13 May 2019 10:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190510155202.14737-1-pagupta@redhat.com> <20190510155202.14737-4-pagupta@redhat.com>
 <CAPcyv4hbVNRFSyS2CTbmO88uhnbeH4eiukAng2cxgbDzLfizwg@mail.gmail.com>
 <864186878.28040999.1557535549792.JavaMail.zimbra@redhat.com>
 <CAPcyv4gL3ODfOr52Ztgq7BM4gVf1cih6cj0271gcpVvpi9aFSA@mail.gmail.com>
 <2003480558.28042237.1557537797923.JavaMail.zimbra@redhat.com> <116369545.28425569.1557768748009.JavaMail.zimbra@redhat.com>
In-Reply-To: <116369545.28425569.1557768748009.JavaMail.zimbra@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 13 May 2019 10:52:39 -0700
Message-ID: <CAPcyv4genJtCt6dp6N07_6RfPTwC6xXMhLp-dr0GWQy5q52YoA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v8 3/6] libnvdimm: add dax_dev sync flag
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     cohuck@redhat.com, Jan Kara <jack@suse.cz>,
        KVM list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, david <david@fromorbit.com>,
        Qemu Developers <qemu-devel@nongnu.org>,
        virtualization@lists.linux-foundation.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ross Zwisler <zwisler@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>, jstaron@google.com,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        jmoyer <jmoyer@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Rik van Riel <riel@surriel.com>,
        yuval shaia <yuval.shaia@oracle.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        Kevin Wolf <kwolf@redhat.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 10:32 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
>
> Hi Dan,
>
> While testing device mapper with DAX, I faced a bug with the commit:
>
> commit ad428cdb525a97d15c0349fdc80f3d58befb50df
> Author: Dan Williams <dan.j.williams@intel.com>
> Date:   Wed Feb 20 21:12:50 2019 -0800
>
> When I reverted the condition to old code[1] it worked for me. I
> am thinking when we map two different devices (e.g with device mapper), will
> start & end pfn still point to same pgmap? Or there is something else which
> I am missing here.
>
> Note: I tested only EXT4.
>
> [1]
>
> -               if (pgmap && pgmap->type == MEMORY_DEVICE_FS_DAX)
> +               end_pgmap = get_dev_pagemap(pfn_t_to_pfn(end_pfn), NULL);
> +               if (pgmap && pgmap == end_pgmap && pgmap->type == MEMORY_DEVICE_FS_DAX
> +                               && pfn_t_to_page(pfn)->pgmap == pgmap
> +                               && pfn_t_to_page(end_pfn)->pgmap == pgmap
> +                               && pfn_t_to_pfn(pfn) == PHYS_PFN(__pa(kaddr))
> +                               && pfn_t_to_pfn(end_pfn) == PHYS_PFN(__pa(end_kaddr)))

Ugh, yes, device-mapper continues to be an awkward fit for dax (or
vice versa). We would either need a way to have a multi-level pfn to
pagemap lookup for composite devices, or a way to discern that even
though the pagemap is different that the result is still valid / not
an indication that we have leaked into an unassociated address range.
Perhaps a per-daxdev callback for ->dax_supported() so that
device-mapper internals can be used for this validation.

We need to get that fixed up, but I don't see it as a blocker /
pre-requisite for virtio-pmem.
