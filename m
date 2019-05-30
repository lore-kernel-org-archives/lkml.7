Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DBBC28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41283257F9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="nFa3Aq2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfE3LOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 07:14:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40163 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3LOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 07:14:20 -0400
Received: by mail-ed1-f65.google.com with SMTP id r18so7565675edo.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 04:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XNn/kmlHnCSr6ANgnhJMJQoNGplaEoHdHhfpn+42U/U=;
        b=nFa3Aq2QY1/b/SmZh7j75KjetoNNh4Q4nF7KjkG89Hf33Lzx/kDlxz2Qaxm9vSqVu+
         dWKMTXTdpkAf3SlD2sCfX+PWajqNbRsWssTuwLzhMoG+a8MWU/cofO8M+Yq3ZHu7GKiS
         4d5eIV53uGfKWdX96tH/kb4YscGd5+m/aiSiYfsOUwTgppVfpXv4x1O3tJM5jNTNArAJ
         +30E1PCsoPxEbPJnRjT8frtFj5kSYKUlF56xcNYLEju/YnD9uf4z5j+Ybjo9vNYG22fM
         3pL263zsGHS7FD+H4sq1/q5Qj1Iy0BbIgmFYjVMUYwkcyvwUksMi4/tpF0Anq+27MwDI
         WmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XNn/kmlHnCSr6ANgnhJMJQoNGplaEoHdHhfpn+42U/U=;
        b=im5rI2krWuA9dicVIwwQ8KEjZhpELaKxqEeXWG4F3IfwVhh9s3grbetbRlBEmXQPQK
         iCDywCWLsBzkOV0Us1glO3lskUEXpQVeqOztACA2BlYzF6cx7aGA5h4OMOgAt8yHrhwY
         KN66zjNVJiECr7AUOSFVAdfVpySu0ZHp/LY48mjyP6edCbgpxgMGfFmkslc/IKx3kH6f
         xsx+eP9kYPOGtA4oMPXT5KhYxugm3OM5BOWUlKkAKz4xNyXGOXt08FXQcQzJcjxANcxK
         y8PTTgUUrZThzPSZS3lbX9ws0eTSI0m5ybiAwctqo4kwjRVCfUPNH7cfKIZjpJONFbY4
         63/g==
X-Gm-Message-State: APjAAAXdH4zfEb1y96UBb9WYNrfisHoUVcmS2+tLuW6Lq6nn71zxXi7/
        gp/jwofQbIWu+rELoTpnHtNrXg==
X-Google-Smtp-Source: APXvYqzkMPjNWxInx+lzce0w2B8z+OegERN/BaKqbY7ZAOBHZ4GjYaNpaklTSY6DfeQu2yRFAGAiFA==
X-Received: by 2002:a17:906:6993:: with SMTP id i19mr2872115ejr.119.1559214858205;
        Thu, 30 May 2019 04:14:18 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v22sm383992eji.13.2019.05.30.04.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 04:14:17 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4B18C1041ED; Thu, 30 May 2019 14:14:16 +0300 (+03)
Date:   Thu, 30 May 2019 14:14:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, namit@vmware.com,
        peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org,
        mhiramat@kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, chad.mynhier@oracle.com,
        mike.kravetz@oracle.com
Subject: Re: [PATCH uprobe, thp 1/4] mm, thp: allow preallocate pgtable for
 split_huge_pmd_address()
Message-ID: <20190530111416.ph6xqd4anjlm54i6@box>
References: <20190529212049.2413886-1-songliubraving@fb.com>
 <20190529212049.2413886-2-songliubraving@fb.com>
 <20190530111015.bz2om5aelsmwphwa@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530111015.bz2om5aelsmwphwa@box>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 02:10:15PM +0300, Kirill A. Shutemov wrote:
> On Wed, May 29, 2019 at 02:20:46PM -0700, Song Liu wrote:
> > @@ -2133,10 +2133,15 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> >  	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
> >  	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd)
> >  				&& !pmd_devmap(*pmd));
> > +	/* only file backed vma need preallocate pgtable*/
> > +	VM_BUG_ON(vma_is_anonymous(vma) && prealloc_pgtable);
> >  
> >  	count_vm_event(THP_SPLIT_PMD);
> >  
> > -	if (!vma_is_anonymous(vma)) {
> > +	if (prealloc_pgtable) {
> > +		pgtable_trans_huge_deposit(mm, pmd, prealloc_pgtable);
> > +		mm_inc_nr_pmds(mm);
> > +	} else if (!vma_is_anonymous(vma)) {
> >  		_pmd = pmdp_huge_clear_flush_notify(vma, haddr, pmd);
> >  		/*
> >  		 * We are going to unmap this huge page. So
> 
> Nope. This going to leak a page table for architectures where
> arch_needs_pgtable_deposit() is true.

And I don't there's correct handling of dirty bit.

And what about DAX? Will it blow up? I think so.

-- 
 Kirill A. Shutemov
