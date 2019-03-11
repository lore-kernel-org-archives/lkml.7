Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F303C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28330214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gZKWQc2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfCKXXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:23:30 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50566 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfCKXX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:23:29 -0400
Received: by mail-it1-f196.google.com with SMTP id m137so1485291ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 16:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Iy+HRoKGbvYIX/HJ/Oa3YNfE4vvNj0SEEupfHgAt7I=;
        b=gZKWQc2KYwGAX3WowtGwdPrVrqqb8O6bfCdDhL1oyXMRPps7k/Zwmb6pXoM+qjET4y
         ip+aHfBkpp8BwRnBmV+PyaqmdFa+7T1XGd8BqUKvbh5hD9u0P3rz93oaPt9Eq6HsGs34
         jgRj/Whff2r8sgBtjJ6NkZFimIloBJzAodGLYhC9pLsH5dCg26QMKYR9Vzm+6Vf5e0YZ
         8cyq1PVFJILFTXtWlv/sVYeRRSjHGjMpPsYhXYXbjYX/tar0JYGUR63GNmlD8XOTUxMR
         +Dx6uSX090lfloxgp8KMYGqDlUaUNZm6h/JcRcxE1Sjm2keTgiwUwkSFiBhmWg7CVxi7
         BSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Iy+HRoKGbvYIX/HJ/Oa3YNfE4vvNj0SEEupfHgAt7I=;
        b=qwoY5pQSmscCOSWYk1+Nump+Jil0cz0hT5/9/xXYGsQyZxgZb/cotU6wKuIjPvocRY
         BMWfPW1zpXDpdLeARSb2SOhavpS+f+H5qvbKuUjW3cykiM+KRhQAHRUqzQB0KCpbVv8B
         cn1WNckectltsZpWqYa3WZotgtVMVoxOrsnAVOOy8uZJ6RImGTDx6cLHiLQ1507nyjZl
         6ohptOl5KDmH6BAAasE7U1KDx7ytkKa4HTuftPmshSxo2DBRkHPuSTZEoc8n75FGBJzr
         LbXusBLGAVBU1pQKRiEJZiOcSbJZ8UAEWHMpnE8qOK1OBe6WSGXUyC53TNc/2PjO3aHj
         4YYw==
X-Gm-Message-State: APjAAAXUvTlZQ5WkQp3JQVeC6ts7Q7jjHTcutjcY/bJtykgYSqgFCa3v
        Wjyf0qF5mtOOHvY+AafYxkDcyA==
X-Google-Smtp-Source: APXvYqyPGkSJFsx3J+ev890Ozq1EHLT5IDQIVnuh3g3snXm234Vr+JhVinPiWYKVphuheOwwdBLDpg==
X-Received: by 2002:a24:c4c5:: with SMTP id v188mr448374itf.27.1552346608185;
        Mon, 11 Mar 2019 16:23:28 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id w127sm443830itc.4.2019.03.11.16.23.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Mar 2019 16:23:27 -0700 (PDT)
Date:   Mon, 11 Mar 2019 17:23:23 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/3] arm64: mm: use appropriate ctors for page tables
Message-ID: <20190311232323.GC207964@google.com>
References: <20190218231319.178224-1-yuzhao@google.com>
 <20190310011906.254635-1-yuzhao@google.com>
 <b0ae4f65-aa0f-148a-eced-0d9831a7bf01@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0ae4f65-aa0f-148a-eced-0d9831a7bf01@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 01:15:55PM +0530, Anshuman Khandual wrote:
> Hello Yu,
> 
> We had some disagreements over this series last time around after which I had
> posted the following series [1] which tried to enable ARCH_ENABLE_SPLIT_PMD_PTLOCK
> after doing some pgtable accounting changes. After some thoughts and deliberations
> I figure that its better not to do pgtable alloc changes on arm64 creating a brand
> new semantics which ideally should be first debated and agreed upon in generic MM.
> 
> Though I still see value in a changed generic pgtable page allocation semantics
> for user and kernel space that should not stop us from enabling more granular
> PMD level locks through ARCH_ENABLE_SPLIT_PMD_PTLOCK right now.
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg709917.html
> 
> Having said that this series attempts to enable ARCH_ENABLE_SPLIT_PMD_PTLOCK with
> some minimal changes to existing kernel pgtable page allocation code. Hence just
> trying to re-evaluate the series in that isolation.
> 
> On 03/10/2019 06:49 AM, Yu Zhao wrote:
> 
> > For pte page, use pgtable_page_ctor(); for pmd page, use
> > pgtable_pmd_page_ctor(); and for the rest (pud, p4d and pgd),
> > don't use any.
> 
> This is semantics change. Hence the question is why ? Should not we wait until a
> generic MM agreement in place in this regard ? Can we avoid this ? Is the change
> really required to enable ARCH_ENABLE_SPLIT_PMD_PTLOCK for user space THP which
> this series originally intended to achieve ?
> 
> > 
> > For now, we don't select ARCH_ENABLE_SPLIT_PMD_PTLOCK and
> > pgtable_pmd_page_ctor() is a nop. When we do in patch 3, we
> > make sure pmd is not folded so we won't mistakenly call
> > pgtable_pmd_page_ctor() on pud or p4d.
> 
> This makes sense from code perspective but I still dont understand the need to
> change kernel pgtable page allocation semantics without any real benefit or fix at
> the moment. Cant we keep kernel page table page allocation unchanged for now and
> just enable ARCH_ENABLE_SPLIT_PMD_PTLOCK for user space THP benefits ? Do you see
> any concern with that.

This is not for kernel page tables (i.e. init_mm). This is to
accommodate pre-allocated efi_mm page tables because it uses
apply_to_page_range() which then calls pte_alloc_map_lock().
