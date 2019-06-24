Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2409C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC2C213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="jtU1r3t/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfFXO1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:27:44 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37304 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfFXO1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:27:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so22111339eds.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 07:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nMad3CaCSZkzI4gyvFvbmTY8mwA5a8Sp7vTVJg617is=;
        b=jtU1r3t/2UsWRHp4cHYwBYGPpiZUxz1/KLoBCTrKS4GUbo9DYoiKDE4ko+tPLCvBZu
         kVU2KDKQj4bZshQa9gZS8SkpWHRzIIr1zMHVlq+h71f92Sb1sMdH5cnBrexMB088xYoj
         lsqFXhocWNoaRaULy95jAMLyLmMA7bfqik/wFGsDEb1zokXQv1eavf7pI0rdaS0SuOiE
         7dXJYQcgVtIul74lHRgtWv1FCERbkHxuQATQxfehC89AGfJA6TAGFluhj8wPparDYqeP
         dx75xVh4boioNOkMS5RMHsVzHq+Fqmr9V3rUsM9KoOJQYU4Kgjhf0MyUkXvlsYHXp7+O
         n7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nMad3CaCSZkzI4gyvFvbmTY8mwA5a8Sp7vTVJg617is=;
        b=daweTlfImIBw2UN330Lh9xQiw1BoMCtIkoYBRO7pNeB1IBKozYA5kVZIqV0ViQtcQr
         cjJV3NlyN+6TBC1DwYdn1aDnCT7jKDreZ3j8YrKrZ6ENFuJSSoWvPXRVzP85kIc6JUE9
         i3JEDqSRBzq7jlHPzyPVyfY6rBMOfSJFuwZSH0DUcgf7UG2ykjdmzfvMWZuM25cPghKw
         jFRyCLMPtFdpRA8YTjdoc+MYlHkzaOiuwvszafCNaIbr1h6deAGAm3u9ozhg4xj4VbvT
         HkjelJVQDneM7ccS/eqe4vNUWz8a0c4ki7anBIpM6ydw4SNUw0Pp4a1U/g9l/JlohpIi
         uYUA==
X-Gm-Message-State: APjAAAWUKgDdPPGyklLApAGmRykKM11CWLOiZiAIcfj9fi5YqXb/a1Ut
        0hIvvkLEEpdOYdlkT8vqpLcPxQ==
X-Google-Smtp-Source: APXvYqwqid3EK2KULR3HvJOfTxPaV9NVV4GB+bO31X1U4vpGtxWUZczZsb76evJVJFcgmV4mVSqaMg==
X-Received: by 2002:a17:906:3c1:: with SMTP id c1mr34162609eja.221.1561386462321;
        Mon, 24 Jun 2019 07:27:42 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a8sm3743134edt.56.2019.06.24.07.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 07:27:41 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0F1161043B3; Mon, 24 Jun 2019 17:27:47 +0300 (+03)
Date:   Mon, 24 Jun 2019 17:27:47 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hdanton@sina.com" <hdanton@sina.com>
Subject: Re: [PATCH v7 5/6] mm,thp: add read-only THP support for (non-shmem)
 FS
Message-ID: <20190624142747.chy5s3nendxktm3l@box>
References: <20190623054749.4016638-1-songliubraving@fb.com>
 <20190623054749.4016638-6-songliubraving@fb.com>
 <20190624124746.7evd2hmbn3qg3tfs@box>
 <52BDA50B-7CBF-4333-9D15-0C17FD04F6ED@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52BDA50B-7CBF-4333-9D15-0C17FD04F6ED@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 02:01:05PM +0000, Song Liu wrote:
> >> @@ -1392,6 +1403,23 @@ static void collapse_file(struct mm_struct *mm,
> >> 				result = SCAN_FAIL;
> >> 				goto xa_unlocked;
> >> 			}
> >> +		} else if (!page || xa_is_value(page)) {
> >> +			xas_unlock_irq(&xas);
> >> +			page_cache_sync_readahead(mapping, &file->f_ra, file,
> >> +						  index, PAGE_SIZE);
> >> +			lru_add_drain();
> > 
> > Why?
> 
> isolate_lru_page() is likely to fail if we don't drain the pagevecs. 

Please add a comment.

> >> +			page = find_lock_page(mapping, index);
> >> +			if (unlikely(page == NULL)) {
> >> +				result = SCAN_FAIL;
> >> +				goto xa_unlocked;
> >> +			}
> >> +		} else if (!PageUptodate(page)) {
> > 
> > Maybe we should try wait_on_page_locked() here before give up?
> 
> Are you referring to the "if (!PageUptodate(page))" case? 

Yes.

-- 
 Kirill A. Shutemov
