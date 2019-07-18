Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937D4C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643AD21849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563476705;
	bh=JLV3apyWx90y3S5LriUELmBnKu3l40uTLHsTfgrKxVg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KHnb/yNIBCqm4Filr/xEO2zRVG8n4Ii+VZ5jw4yyc7pssSf4jqcnO/yAPMNiYxM9E
	 eZ0E/QSkSpymWHdAe5lk1BZrMqGrjNYDlbuhGXLQNajI8eYdaidc3UGfWwCf/BHlZ5
	 48CH17nycxOsGri05wAk7H8Ik5rFbS+paRsWllu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391010AbfGRTFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:32780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfGRTFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:05:03 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D55121871
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 19:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563476702;
        bh=JLV3apyWx90y3S5LriUELmBnKu3l40uTLHsTfgrKxVg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bl2twEhm2US7P69bVm3HXVdMmwuJjpJpKdezxRcPxJPh5Aa9brJgyZfbKrxU70Ijf
         qLmuD6/QjMGMU3y6dIpzimq1mxSiGSpCKiRxbrufLNl6ISnfP5buAod9rAQEW18Ikf
         8QABJimF8B2leofR35RQCBn7S3se+I+JumTZIFQo=
Received: by mail-wr1-f49.google.com with SMTP id n4so29885930wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 12:05:02 -0700 (PDT)
X-Gm-Message-State: APjAAAVPgvI1LAJjhJmDGUFYN03sPldtsHvPY/KLgJ/UcezKMxH9HSF/
        YA1MhQ4/RsKGnvQkQUhh4554uSFA2ShmJr0+uXXpzw==
X-Google-Smtp-Source: APXvYqzpG2Zvb9psJjKa4SIULThU7OrPSxB3exTHOhAyWQ2kGovet/+/A/I4/VvFFpIRVeaa4FYu0CrzS9XXLK4+qnE=
X-Received: by 2002:adf:f28a:: with SMTP id k10mr11064718wro.343.1563476700729;
 Thu, 18 Jul 2019 12:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190717071439.14261-1-joro@8bytes.org> <20190717071439.14261-4-joro@8bytes.org>
 <CALCETrXfCbajLhUixKNaMfFw91gzoQzt__faYLwyBqA3eAbQVA@mail.gmail.com> <20190718091745.GG13091@suse.de>
In-Reply-To: <20190718091745.GG13091@suse.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 18 Jul 2019 12:04:49 -0700
X-Gmail-Original-Message-ID: <CALCETrXJYuHN872F74kVTuw4dYOc5saKqoUFbgJ5X0EuGEhXcA@mail.gmail.com>
Message-ID: <CALCETrXJYuHN872F74kVTuw4dYOc5saKqoUFbgJ5X0EuGEhXcA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/vmalloc: Sync unmappings in vunmap_page_range()
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 2:17 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> Hi Andy,
>
> On Wed, Jul 17, 2019 at 02:24:09PM -0700, Andy Lutomirski wrote:
> > On Wed, Jul 17, 2019 at 12:14 AM Joerg Roedel <joro@8bytes.org> wrote:
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 4fa8d84599b0..322b11a374fd 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -132,6 +132,8 @@ static void vunmap_page_range(unsigned long addr, unsigned long end)
> > >                         continue;
> > >                 vunmap_p4d_range(pgd, addr, next);
> > >         } while (pgd++, addr = next, addr != end);
> > > +
> > > +       vmalloc_sync_all();
> > >  }
> >
> > I'm confused.  Shouldn't the code in _vm_unmap_aliases handle this?
> > As it stands, won't your patch hurt performance on x86_64?  If x86_32
> > is a special snowflake here, maybe flush_tlb_kernel_range() should
> > handle this?
>
> Imo this is the logical place to handle this. The code first unmaps the
> area from the init_mm page-table and then syncs that page-table to all
> other page-tables in the system, so one place to update the page-tables.


I find it problematic that there is no meaningful documentation as to
what vmalloc_sync_all() is supposed to do.  The closest I can find is
this comment by following the x86_64 code, which calls
sync_global_pgds(), which says:

/*
 * When memory was added make sure all the processes MM have
 * suitable PGD entries in the local PGD level page.
 */
void sync_global_pgds(unsigned long start, unsigned long end)
{

Which is obviously entirely inapplicable.  If I'm understanding
correctly, the underlying issue here is that the vmalloc fault
mechanism can propagate PGD entry *addition*, but nothing (not even
flush_tlb_kernel_range()) propagates PGD entry *removal*.

I find it suspicious that only x86 has this.  How do other
architectures handle this?

At the very least, I think this series needs a comment in
vmalloc_sync_all() explaining exactly what the function promises to
do.  But maybe a better fix is to add code to flush_tlb_kernel_range()
to sync the vmalloc area if the flushed range overlaps the vmalloc
area.  Or, even better, improve x86_32 the way we did x86_64: adjust
the memory mapping code such that top-level paging entries are never
deleted in the first place.
