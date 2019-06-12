Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27553C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0267E20883
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="HXRALFEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436472AbfFLBqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 21:46:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38111 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfFLBqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:46:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id g13so23020524edu.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 18:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LXj97QV1xj0YMzJTfwO7V63Jo2GxebtIwJp0QMGiowU=;
        b=HXRALFEYuiiWfCAMv5ihCzb+blJRwM2p40Q+4CrmWGOBIgEkIDSwBrEmzJYKQ+tQQG
         z2zhnfgt9xZBNdaJnC4IYxdve974bp8GqdRK0VoTR77WKjzD+KD0JIztls5JApZ5hV+F
         OZ26YVVQJtbKfc4dhoGKHLxGltQMUFpy31s8E4bdelVuXnJSkCJzxdSGyZILsBzUq80t
         f2c+1jkR/tn+MjiDAWne64fh2CCM+Ju3910qo87nTjZEZJjXCiYH7ZeVy12toNmoHyaz
         IxnqUNMjynTbSnz5WxKPBzjlGaW/AxuUfXPeCSCnkTypuYPRZ93+e0sfsOSBZY616mof
         zdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LXj97QV1xj0YMzJTfwO7V63Jo2GxebtIwJp0QMGiowU=;
        b=roGIY97NgS3ePYJYZkRA8BTYqMqVVPHP1dGWtDYlK8nfJ6pKE7HCw5vrl3DBQoir5u
         swN7yMXe8dHzvy1BNlEG5PznGwerIXsMvZ3fZLnG6tJWRjPSq48xQuCP8UkEARUG2iwE
         8jhkrYVjQmJ3QEEfufbzmBWTl7v4jA1xxkVOTEss/shTlo4UFxr4xjCPmRqB2jmtPRi0
         RVxfs5a/kcIFIRMHIZ7ZwNDjRrYcNvf3vQ5dqiQQivaASX3jthgj8pIi4p7ZSEhebaNA
         ZtGce7QX4pXJ6f8SQHRBmt/4qgqIixVw4NlECbzPAruY90ZJCZsHiyMvt36EcJFid4cs
         1LNA==
X-Gm-Message-State: APjAAAVmtU7bPkHSPG9NstreFYU8KD/zjly14EuWSCN3FVXJz6ntnpqP
        PTQqQVk045bKL2xStJ+qrldEaw==
X-Google-Smtp-Source: APXvYqwI5Qv0C/a0lrl6mzuoFXDCntFWruXenrhqcLo08+2SpUh6wATX727OIc7E2oRZg6ayc5q2AQ==
X-Received: by 2002:a50:ad01:: with SMTP id y1mr62139325edc.180.1560303994960;
        Tue, 11 Jun 2019 18:46:34 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a53sm1063966eda.56.2019.06.11.18.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 18:46:34 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0011A10081B; Wed, 12 Jun 2019 04:46:34 +0300 (+03)
Date:   Wed, 12 Jun 2019 04:46:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        Jan Kara <jack@suse.cz>, Song Liu <liu.song.a23@gmail.com>
Subject: Re: [PATCH v4] page cache: Store only head pages in i_pages
Message-ID: <20190612014634.f23fjumw666jj52s@box>
References: <20190307153051.18815-1-willy@infradead.org>
 <155951205528.18214.706102020945306720@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155951205528.18214.706102020945306720@skylake-alporthouse-com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2019 at 10:47:35PM +0100, Chris Wilson wrote:
> Quoting Matthew Wilcox (2019-03-07 15:30:51)
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 404acdcd0455..aaf88f85d492 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2456,6 +2456,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> >                         if (IS_ENABLED(CONFIG_SHMEM) && PageSwapBacked(head))
> >                                 shmem_uncharge(head->mapping->host, 1);
> >                         put_page(head + i);
> > +               } else if (!PageAnon(page)) {
> > +                       __xa_store(&head->mapping->i_pages, head[i].index,
> > +                                       head + i, 0);
> 
> Forgiving the ignorant copy'n'paste, this is required:
> 
> +               } else if (PageSwapCache(page)) {
> +                       swp_entry_t entry = { .val = page_private(head + i) };
> +                       __xa_store(&swap_address_space(entry)->i_pages,
> +                                  swp_offset(entry),
> +                                  head + i, 0);
>                 }
>         }
>  
> The locking is definitely wrong.

Does it help with the problem, or it's just a possible lead?

-- 
 Kirill A. Shutemov
