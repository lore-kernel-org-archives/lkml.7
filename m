Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8081C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90E120645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="V/DLpIz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403940AbfETRJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:09:11 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35568 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730770AbfETRJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:09:11 -0400
Received: by mail-oi1-f195.google.com with SMTP id a132so10594215oib.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKxKhF1FvSDo9f8sIipTTZjoo77Dif+CkluYVXpcRgw=;
        b=V/DLpIz2Cps7Vz9YsQHlqqdZTYdH0WHSn/FPCx9uvLu6vjEqKny+XWTmXKJJWtLCSx
         qxNK1tixYTMzWbLi1LGbXZmIXn+vfxhi/AXVo82Y7ubuQefRIebHbUukIZV90wr62PoG
         BXCoNyB11kyqHlXrUqFhjimKu+S0xXXtA0+rVhgdzTqeMKKO8t7L8yLNNYtnQYcJLlZd
         bSvLceMtjPm6b6gA3c/1SdhYOlOPjCidwL/o5fRaZberQhryCP7bV729IcjXwCc8xDZF
         g6jotOgS+H+MABwnFrtAE0Rg8L97s4KS8OS1x3HHi5a6qqa9CRACTCNHTe5jtOpYQ8YQ
         e96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKxKhF1FvSDo9f8sIipTTZjoo77Dif+CkluYVXpcRgw=;
        b=mYxhWhm7ym2QzBBzZzI+mbSw9kU09dOduDDlE3I+eurnQWzwSQF27MlfTIZHFgIASp
         fD+59gsJMOPrCCv5OdRR1kuOs1Mv5OqSciGyULY0uw+pxSsWHZYj/Bp7K6H/g0FpgNQm
         bTjvCQC0j8Kve/E0UNTi+7GWelLdGMVgyeNSA+QOwzylqtQ2Hq5BG2v/U+bUfcetgiV1
         BIxgZnz02zcHSvyNNcmyMBjABKXJ+NE4oltRaZxLGgIntfx3YzDgm6KDotTvF/He0R/O
         2pEG4OQRynK/2x5VHsh/ck6g+F14MHrPDKkp+Lc417oAmfYZxXrp0dysbh+DtdIp8uTA
         ecYA==
X-Gm-Message-State: APjAAAVeLuHijZYd8VMEeb3XuYEMbpAByinHDe64poor22wRWOs2pjJV
        sYm/YSy0uj9mJFkJLiu8SdbKn4I76Pl+x1I29LbGNw==
X-Google-Smtp-Source: APXvYqwBtWxgHgdvAiDLmO5TZSGZNCT4wiYmm0OQf+BmHaSAnpJX0G36CIkrI5eKeEcDT4auoPb9k0KbTK9uxTOuoQI=
X-Received: by 2002:aca:b641:: with SMTP id g62mr110703oif.149.1558372150650;
 Mon, 20 May 2019 10:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190516055422.16939-1-vaibhav@linux.ibm.com> <CAPcyv4j6Jhpqg9SqAAmz2A6PDry7UUtnniNVoc_qG=WXwuVOWA@mail.gmail.com>
 <87bm01mylr.fsf@vajain21.in.ibm.com>
In-Reply-To: <87bm01mylr.fsf@vajain21.in.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 20 May 2019 10:08:59 -0700
Message-ID: <CAPcyv4j-OQbN=rYY6MH3XFCF+dPpooCYekYF7PJL+N-tCJey3g@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix last_page check in __bdev_dax_supported()
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chandan Rajendra <chandan@linux.ibm.com>,
        Mike Snitzer <snitzer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 10:37 PM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Wed, May 15, 2019 at 10:55 PM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
> >>
> >> Presently __bdev_dax_supported() checks if first sector of last
> >> page ( last_page ) on the block device is aligned to page
> >> boundary. However the code to compute 'last_page' assumes that there
> >> are 8 sectors/page assuming a 4K page-size.
> >>
> >> This assumption breaks on architectures which use a different page
> >> size specifically PPC64 where page-size == 64K. Hence a warning is
> >> seen while trying to mount a xfs/ext4 file-system with dax enabled:
> >>
> >> $ sudo mount -o dax /dev/pmem0 /mnt/pmem
> >> XFS (pmem0): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
> >> XFS (pmem0): DAX unsupported by block device. Turning off DAX.
> >>
> >> The patch fixes this issue by updating calculation of 'last_var' to
> >> take into account number-of-sectors/page instead of assuming it to be
> >> '8'.
> >
> > Yes, I noticed this too and fixed it up in a wider change that also
> > allows device-mapper to validate each component device. Does this
> > patch work for you?
> >
> > https://lore.kernel.org/lkml/155789172402.748145.11853718580748830476.stgit@dwillia2-desk3.amr.corp.intel.com/
>
> Thanks Dan, I tested your patch and not seeing the issue anymore.

Thanks, I recorded a "Tested-by" for you.
