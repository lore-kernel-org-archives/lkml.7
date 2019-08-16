Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7819C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 15:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBC92173B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 15:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isXsm8F7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfHPPCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 11:02:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33426 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfHPPCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 11:02:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so3093816pgn.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 08:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=80681125HOe1NksgS/XdMjl6WQzpX7RNekCUe4aCq/Y=;
        b=isXsm8F7NqAKGGb6PgZvvznUtwOOxSMgaDX8r1auxQi6T+0wWxvsKu4UQcEV7FvDTt
         /kmf9wFUT593QxhHVbPkM/7ZvZjp8zaFDhuhrjJ+2dg5VecyfRCTm6uVilNB1OMAxGYo
         N1lfcetsW5mFyCCoz5J48KjqJUImLeh/5uo3n9ZQYv3BfWPRiAUE5t5mBjNxh1Yd0VhN
         N8Nd3Prb9PbpWE0nzwWQl+oCkS0chyoW+Snfn4DQJiX813XuRnuAobYBX4dgIpvjjB6S
         Xrpz7AxrAEACdibYFHVh5Ic5UWw9FIRtqz6dQ2UnxYP/8Bl541fTpvkhBdrngiAd7303
         Qp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=80681125HOe1NksgS/XdMjl6WQzpX7RNekCUe4aCq/Y=;
        b=ZiTYdygurh99qROO2cgrE/3kWgmqkdqJ4BgFhvDfkNcOJpiW/EU/iAyDJCQWfcn2MU
         tNMUTDamlNCnzI8QeTXGlv/qmC0R8JvW4tTK2D3N1OOQSD4/Pa/a3ZF2QdaqcfyVbIRc
         4K80pkdzwRWtm+0pN+KO1bMFcQgk7CrBEvLeBhWy2ffYMMTaGQ907kG50gXfmUNkAMqI
         fAYnLO+6IX8j0qrHRQswsNH0qI7xKOGHKPfPUJRbWRqwBMTz9Ye3Xp/TyoUff74MURii
         zonae9hf2qMmswgfb2zrfhRAWW3fVoVD0sP70nsazBNC3Hem9dGGa8P1VxKUCYAMndxW
         MYIA==
X-Gm-Message-State: APjAAAUX7EwJ98tYseSsaE2OWHwdb6j8cGXg0H0nnqlr4x/XH7BFIa3/
        GFWTqP9morL3O8pRgaE/zw==
X-Google-Smtp-Source: APXvYqyYrWsBv+YFWGKWMSvAj/Y6YsQ7WRpo5y7EPvTeuwShnVq5fuYFBDU7SpfgE/kycdeUsjN79w==
X-Received: by 2002:a17:90a:5207:: with SMTP id v7mr7332463pjh.127.1565967755090;
        Fri, 16 Aug 2019 08:02:35 -0700 (PDT)
Received: from mypc ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f12sm5339136pgq.52.2019.08.16.08.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 08:02:33 -0700 (PDT)
Date:   Fri, 16 Aug 2019 23:02:22 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/migrate: see hole as invalid source page
Message-ID: <20190816150222.GA10855@mypc>
References: <1565078411-27082-1-git-send-email-kernelfans@gmail.com>
 <1565078411-27082-2-git-send-email-kernelfans@gmail.com>
 <20190815172222.GD30916@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815172222.GD30916@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 01:22:22PM -0400, Jerome Glisse wrote:
> On Tue, Aug 06, 2019 at 04:00:10PM +0800, Pingfan Liu wrote:
> > MIGRATE_PFN_MIGRATE marks a valid pfn, further more, suitable to migrate.
> > As for hole, there is no valid pfn, not to mention migration.
> > 
> > Before this patch, hole has already relied on the following code to be
> > filtered out. Hence it is more reasonable to see hole as invalid source
> > page.
> > migrate_vma_prepare()
> > {
> > 		struct page *page = migrate_pfn_to_page(migrate->src[i]);
> > 
> > 		if (!page || (migrate->src[i] & MIGRATE_PFN_MIGRATE))
> > 		     \_ this condition
> > }
> 
> NAK you break the API, MIGRATE_PFN_MIGRATE is use for 2 things,
> first it allow the collection code to mark entry that can be
> migrated, then it use by driver to allow driver to skip migration
> for some entry (for whatever reason the driver might have), we
> still need to keep the entry and not clear it so that we can
> cleanup thing (ie remove migration pte entry).
Thanks for your kindly review.

I read the code again. Maybe I miss something. But as my understanding,
for hole, there is no pte.
As the current code migrate_vma_collect_pmd()
{
	if (pmd_none(*pmdp))
		return migrate_vma_collect_hole(start, end, walk);
...
	make_migration_entry()
}

We do not install migration entry for hole, then no need to remove
migration pte entry.

And on the driver side, there is way to migrate a hole. The driver just
skip it by
drivers/gpu/drm/nouveau/nouveau_dmem.c: if (!spage || !(src_pfns[i] & MIGRATE_PFN_MIGRATE))
                                             ^^^^
Finally, in migrate_vma_finalize(), for a hole,
		if (!page) {
			if (newpage) {
				unlock_page(newpage);
				put_page(newpage);
			}
			continue;
		}
And we do not rely on remove_migration_ptes(page, newpage, false); to
restore the orignal pte (and it is impossible).

Thanks,
	Pingfan
