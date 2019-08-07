Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAF3C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B6E218CA
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCFuvFNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfHGF3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 01:29:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37724 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfHGF3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 01:29:10 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so38930942plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 22:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1vTjKKjPXcwvezFpuQlHk79++RRKGCelf1VGueOrrEQ=;
        b=nCFuvFNjI+cgrH3oDF1fIJi/Gq7hJFsokBsK8Uk0siw2EVuKNJSVN0AMOq6AEhD4Dx
         E6gEWGICMUy//3HQJjqquj7/B4tN4HRsxaKuilwqEnslFkay5kXcE4m4Z+7pnIfDNX4z
         J2MmaMZx/wIlbGaJqxZafWOrIgP0h2OmTm+nFq+KC5BQjgYoFj4YY61UuWYfPrzIK1NE
         OeM5sPFCAxPN4PUucNSQx0XuJcGZW5qJ7jDu+Ylt3wKlLwGa3tGfCcU6uunEtQEA6FsO
         GrtjjJOB+u2Fqwe4751ta6gDwDK1jAz6djR9iimXtoy14zH+CavZcZL7RtJ9tlZ9aCbF
         f4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1vTjKKjPXcwvezFpuQlHk79++RRKGCelf1VGueOrrEQ=;
        b=lHzlayfFxfjXjrBGu0VF1XeNmPtn77BFFBuZODudJNxkefBWNL+Awgr1IAhWk1ZxgW
         p4Fmlz13+lbLeRuFJ8ZnQ2Eteki/H0cAFYBSQL+XvfOecqa9lgGCC+BfNgPbjTxKx1TP
         30j3DimUo2WE+HNfaKsqHKaClckPcwAwxib+XvtWZs4IWmK9GNxTFLC/LF9XpfWAeHd6
         3AT6npENfEy5V31B0uz+ZwxePHtHkJ+a0/k5osGPnI+b2k0ITDZHeW7bVq3aE3UOhv/k
         JiDWC3KfENH93ktAEstAMcyz1iKi8biHPsEKG0zcXYkQqCpHsaRAeZtwCgTEvlmpI975
         1AlQ==
X-Gm-Message-State: APjAAAUWq9CWI9LcPlGQX+wJIc5A3EtNzQgvQi9edbO1ngQZ2eqnWYyS
        mujbRxQ6jUqeXyxSPfNOHQ==
X-Google-Smtp-Source: APXvYqy8DYamhO+Xxeu70pQ++qwQXuBclAgixKYv4wKka+YwFq7p/cQW6qI5JZSet/yTl8yH7Gy/lg==
X-Received: by 2002:a17:90a:30cf:: with SMTP id h73mr6810509pjb.42.1565155748748;
        Tue, 06 Aug 2019 22:29:08 -0700 (PDT)
Received: from mypc ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v63sm91853525pfv.174.2019.08.06.22.29.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 22:29:08 -0700 (PDT)
Date:   Wed, 7 Aug 2019 13:28:58 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/migrate: clean up useless code in
 migrate_vma_collect_pmd()
Message-ID: <20190807052858.GA9749@mypc>
References: <1565078411-27082-1-git-send-email-kernelfans@gmail.com>
 <20190806133503.GC30179@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806133503.GC30179@bombadil.infradead.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 06:35:03AM -0700, Matthew Wilcox wrote:
> 
> This needs something beyond the subject line.  Maybe ...
> 
> After these assignments, we either restart the loop with a fresh variable,
> or we assign to the variable again without using the value we've assigned.
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> >  			goto next;
> >  		}
> > -		pfn = page_to_pfn(page);
> 
> After you've done all this, as far as I can tell, the 'pfn' variable is
> only used in one arm of the conditions, so it can be moved there.
> 
> ie something like:
> 
> -               unsigned long mpfn, pfn;
> +               unsigned long mpfn;
> ...
> -               pfn = pte_pfn(pte);
> ...
> +                       unsigned long pfn = pte_pfn(pte);
> +
> 
This makes code better. Thank you for the suggestion. Will send v2 for
this patch.

Regards,
	Pingfan
