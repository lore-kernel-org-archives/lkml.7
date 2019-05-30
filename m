Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4F8C28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B756C2568D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="WwpXvpKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfE3MOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 08:14:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44861 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfE3MOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:14:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id b8so8788215edm.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 05:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p1918MnxARtKvEc6ceYsEUd3Epplrq3Dno0QWUAOQIc=;
        b=WwpXvpKM9wyVqaBDvR0ygQVcZ42ff9V7UdQHrCrSBwcUIEVEmjuTKBZ/IcXWH9eb5r
         LM2dQI9+J0VXq6CKq0RCQVNNfFNFV7wXEVX6NmISCJthmIw0bOFXuveRJjd3kAcqEdmH
         2kXefMuUqNOvxd8cf4G/K8smJTb967IvuR2zQJyzvKmuTmEJjeY909hYgmoeDTt9dJqw
         tIy9hLMgZ4lmN0z3tHsNhdeexSGkNFDu0lIElK/3gavacIosueW6YA0nyyn5+T38ggfF
         TqQMY95IlMlKA9y5AfiRxQGvPAHj/giAOKuetihepllUU1tcrz57Yur9DY5wjCsZV4WJ
         Zr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p1918MnxARtKvEc6ceYsEUd3Epplrq3Dno0QWUAOQIc=;
        b=sMQDd/Y7CVLYUjsiMI7pG6F/xU1qbDz1XEHQEiLSEzYrIRfmfZipSnR4euu+GPH3Vb
         HT2DO42vcBd0TMBx79jN3Ruzch1IGGbG9Dsb6icIqlBe6twmfg7WumtrltKZTWbogl5S
         Hzzvs+TVV+Gfi11iF3Jx8pTiKsMdCz1b5CSuM0mZT2jXlIPoKO3xJVuo6zTgyfw4nOld
         VB6107fOC7aCvRTPc8ZIOUaQuDRwaDBcpQxJzrzQZi9nxIijFwII97y/axd3vr5gf9H5
         bf7aktu0UdLSX2TigOrH+qNhEJWRG1uHnasiuyUTni9Hnd/+IcAn4Lpm49Y2BMvVrsdG
         8PQw==
X-Gm-Message-State: APjAAAXaDlD4nSMlPk61sGETrpEY1dQaHd7FjXIwvibx3wjU8aPAmSGp
        yYG2zTEGAMmdFamNXfhxUzB5Qw==
X-Google-Smtp-Source: APXvYqyeQ7RjD8auQNHx3XF4JeRe83d9ggJZiR6/yHiQKW8mGxbq1bQy7fyk84Y985CtTEYnjKtW9g==
X-Received: by 2002:a17:906:a302:: with SMTP id j2mr3149843ejz.155.1559218443491;
        Thu, 30 May 2019 05:14:03 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g18sm684004edh.13.2019.05.30.05.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 05:14:02 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C43031041ED; Thu, 30 May 2019 15:14:00 +0300 (+03)
Date:   Thu, 30 May 2019 15:14:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, namit@vmware.com,
        peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org,
        mhiramat@kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, chad.mynhier@oracle.com,
        mike.kravetz@oracle.com
Subject: Re: [PATCH uprobe, thp 3/4] uprobe: support huge page by only
 splitting the pmd
Message-ID: <20190530121400.amti2s5ilrba2wvb@box>
References: <20190529212049.2413886-1-songliubraving@fb.com>
 <20190529212049.2413886-4-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529212049.2413886-4-songliubraving@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 02:20:48PM -0700, Song Liu wrote:
> Instead of splitting the compound page with FOLL_SPLIT, this patch allows
> uprobe to only split pmd for huge pages.
> 
> A helper function mm_address_trans_huge(mm, address) was introduced to
> test whether the address in mm is pointing to THP.

Maybe it would be cleaner to have FOLL_SPLIT_PMD which would strip
trans_huge PMD if any and then set pte using get_locked_pte()?

This way you'll not need any changes in split_huge_pmd() path. Clearing
PMD will be fine.

-- 
 Kirill A. Shutemov
