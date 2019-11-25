Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004D8C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3BC20823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="pOGsDGS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfKYJgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:36:05 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39694 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfKYJgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:36:05 -0500
Received: by mail-lj1-f195.google.com with SMTP id e10so5827217ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 01:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lltk+ABKwMzN4Q3qE+TFYH7hNAzWoOTyrBpQNHINGWg=;
        b=pOGsDGS1zDV3Ji0L/1c0M+QXhoBqekXbOPlVWITZTZtMhTIefNFnDfdvq1VmiXPfbf
         teEowcVmzNnApS8P56bu43c43VqftJ+caG5ytLqALGFHSUZCOIRlV1A8/+RVEIBwuAEI
         cu/kBnw3wE2btTRTTWCz9VSZjeRAOeuskHgL4D1BbzdpssJDQyIeRK3FaZEIlFgoGOIm
         nzKJABybFIShwvGdy9JUFpJioZ0tQ5huegi1TvIpCsQUuX2J5pKSTnZHluPLlqg2Rs8j
         EL12ZUlwcre5plySoqzI3zcopFpHXNFi1WncaBkmxw0V9KkOWTGLJ/yCYwkp7e/3wyJ0
         w27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lltk+ABKwMzN4Q3qE+TFYH7hNAzWoOTyrBpQNHINGWg=;
        b=ml6SJW77wGMi81tYf6Jqlxs6zZSYHCPN6WUfgl06vAPoLqoot0mBPfuVf4kQOF6Iq/
         oQnXI6KZc71O/QGLYSR5/sz1vsEMdHFzO+HDfocZIqhfXqhtziI6xlMfniXPxcj5xtPv
         QN1g1Za/YLSj9Kn6diODZmAWlaO2bYFVclHd/CRspVaunGIcJwJXLeHG7c5Fc2yQ493+
         QcIY/JneqxMGnuJf8m5f/SJxFK57sF+ExvvXc0SGOAEWVNM6EbBhz8jRTwZXA8LoBGp0
         wIFhjQAYPPPgg4yq19n5c8TsHtLAcDr+odRKx9yZG1ylsAZyc/yeTsBs/02yns6z38Le
         swMQ==
X-Gm-Message-State: APjAAAWvkcUz3hECstuFT/uAjZf7zRyen0r3Pi1irgUX/cn7vtgbW2qO
        PYCgSR8eBDDE/uLNJEkSz/J2Uw==
X-Google-Smtp-Source: APXvYqxvw9ut+oWe1WULJjWqDhYOkJfFZmIR+tYdPozGStrfGODy3Zu4B71kR/bcLVYFsAgb14RoKA==
X-Received: by 2002:a2e:84d0:: with SMTP id q16mr10206471ljh.48.1574674563554;
        Mon, 25 Nov 2019 01:36:03 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u67sm3581116lja.78.2019.11.25.01.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 01:36:02 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id BBB581032C4; Mon, 25 Nov 2019 12:36:11 +0300 (+03)
Date:   Mon, 25 Nov 2019 12:36:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hughd@google.com, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: shmem: allow split THP when truncating THP
 partially
Message-ID: <20191125093611.hlamtyo4hvefwibi@box>
References: <1574471132-55639-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574471132-55639-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 09:05:32AM +0800, Yang Shi wrote:
> Currently when truncating shmem file, if the range is partial of THP
> (start or end is in the middle of THP), the pages actually will just get
> cleared rather than being freed unless the range cover the whole THP.
> Even though all the subpages are truncated (randomly or sequentially),
> the THP may still be kept in page cache.  This might be fine for some
> usecases which prefer preserving THP.
> 
> But, when doing balloon inflation in QEMU, QEMU actually does hole punch
> or MADV_DONTNEED in base page size granulairty if hugetlbfs is not used.
> So, when using shmem THP as memory backend QEMU inflation actually doesn't
> work as expected since it doesn't free memory.  But, the inflation
> usecase really needs get the memory freed.  Anonymous THP will not get
> freed right away too but it will be freed eventually when all subpages are
> unmapped, but shmem THP would still stay in page cache.
> 
> To protect the usecases which may prefer preserving THP, introduce a
> new fallocate mode: FALLOC_FL_SPLIT_HPAGE, which means spltting THP is
> preferred behavior if truncating partial THP.  This mode just makes
> sense to tmpfs for the time being.

We need to clarify interaction with khugepaged. This implementation
doesn't do anything to prevent khugepaged from collapsing the range back
to THP just after the split.

> @@ -976,8 +1022,31 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>  			}
>  			unlock_page(page);
>  		}
> +rescan_split:
>  		pagevec_remove_exceptionals(&pvec);
>  		pagevec_release(&pvec);
> +
> +		if (split && PageTransCompound(page)) {
> +			/* The THP may get freed under us */
> +			if (!get_page_unless_zero(compound_head(page)))
> +				goto rescan_out;
> +
> +			lock_page(page);
> +
> +			/*
> +			 * The extra pins from page cache lookup have been
> +			 * released by pagevec_release().
> +			 */
> +			if (!split_huge_page(page)) {
> +				unlock_page(page);
> +				put_page(page);
> +				/* Re-look up page cache from current index */
> +				goto again;
> +			}
> +			unlock_page(page);
> +			put_page(page);
> +		}
> +rescan_out:
>  		index++;
>  	}

Doing get_page_unless_zero() just after you've dropped the pin for the
page looks very suboptimal.

-- 
 Kirill A. Shutemov
