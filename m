Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16AECA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FDC2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="byq6KJZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388800AbfJ1MI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:08:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36232 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbfJ1MI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:08:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so11072543ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 05:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6kDoXt82CZljf+qYADfgJAkcPTlQsFN1MjjiwFG1/RM=;
        b=byq6KJZBAX2DLAVCixgRz0a3foTiHOcfMMRSGNs4kAATIezC3V3fo+VoYYGZyk0SCy
         /+wiTzN6adLGc7qy8PsJuczixruDVfdrJcQt4nYTlRIU9NooFXE3BVZfqTeXO+x7iLoP
         MODzSsRG5P3GseVPZ1gMt9mr8kDY+nZqe2q8N1dchBW1vIkaOWi2set3Pq77bKpLqd7g
         m8vtzdHLILeZun5kvamZXLaG69F65q2i5/OPrVjq7iB4TsGSZMS+BZldDFiqzGio6zw2
         ITl8my0VvV0AhZ4O8ER8IfkKS9kTsqAQGeMpmFoHrpHJFUISIvjd1MYpKB11WzILz4MU
         BxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6kDoXt82CZljf+qYADfgJAkcPTlQsFN1MjjiwFG1/RM=;
        b=MpUF4JMvULXRTGawfDk6NJ/yTBH6JWu2MCJv7XoXmG453ijePTk/zg0Nn+KKYCCicI
         2UZXdtPQDgbOXHlKewARlrImO7E6W644qPfbueh9UacAgsR4ShVHy/ZFZaLGIVu6aMS4
         UKpsXuGmpxMKEnPOqXHBH3rcgNfad8/bwVX5yOEjMc4jl++QnPHVPRXaksh01OjOmUSA
         n9T+22PwvLpj7W71aZDUEvQb8TW0AsQ1Yh5bjl6E/5eO8O6lAK6IFenGTmJiU305whTZ
         QXEtIxxALodP03nGToEE/6Y22a1A+shu8A3Lpaauf/YjYvtRrZzMo5v6i5qIrLB6EQFT
         hhnA==
X-Gm-Message-State: APjAAAUO9KZkS2rR2R+0FRhU1TIa0iHCQPv1diS64lfzstxhcjJKkXp5
        cuzTuHV/YZSdY7DM74Hq4yma5w==
X-Google-Smtp-Source: APXvYqzYukSwZMFq5wv0NTuGkMM95KOM3+uXAMOBIFQx7Db98+LH3OzhK61OsWzwhG6Vw99QXDauAQ==
X-Received: by 2002:a2e:9ad0:: with SMTP id p16mr11568746ljj.179.1572264504500;
        Mon, 28 Oct 2019 05:08:24 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k9sm5245781ljk.91.2019.10.28.05.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 05:08:23 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 78EDB100242; Mon, 28 Oct 2019 15:08:25 +0300 (+03)
Date:   Mon, 28 Oct 2019 15:08:25 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Figo.zhang" <figo1802@gmail.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] mm: Recheck page table entry with page table lock held
Message-ID: <20191028120825.mmlfputxj3p44yxh@box>
References: <20180926031858.9692-1-aneesh.kumar@linux.ibm.com>
 <CAF7GXvqmf_pqrYCoG+9Kna184Yi0JNvGpwN7JcGvnBL3SFrcnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF7GXvqmf_pqrYCoG+9Kna184Yi0JNvGpwN7JcGvnBL3SFrcnQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:13:58AM +0800, Figo.zhang wrote:
> Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> 于2018年9月26日周三 上午11:19写道：
> 
> > We clear the pte temporarily during read/modify/write update of the pte.
> > If we
> > take a page fault while the pte is cleared, the application can get
> > SIGBUS. One
> > such case is with remap_pfn_range without a backing vm_ops->fault callback.
> > do_fault will return SIGBUS in that case.
> >
> what is " remap_pfn_range without a backing vm_ops->fault callback ", would
> you like  elaborate the scenario?
>  is it the case using remap_pfn_range()  in drivers mmap() file operations?
> if in that case, why it will trap into do_fault?

Because there's no page mapped there during the race.

> >
> > cpu 0                                           cpu1
> > mprotect()
> > ptep_modify_prot_start()/pte cleared.
> > .
> > .                                               page fault.
> > .
> > .
> > prep_modify_prot_commit()
> 
> 
>   i am confusing this  scenario, when CPU0 will call
> in change_pte_range()->ptep_modify_prot_start() to clear the pte content,
> and
> on the other thread, in handle_pte_fault(), pte_offset_map() can get the
> pte, and the pte is not invalid, it's pte is valid but just the content is
> all zero, so why it will call into do_fault?
> 
> in  handle_pte_fault():
>     vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
>     if (!vmf->pte) {
>             return do_fault(vmf);
>     }

This case handles the situation when pte is none (clear) or page table is
not allocated at all.

-- 
 Kirill A. Shutemov
