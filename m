Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B852C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D45721670
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VirwsMNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfHXGJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:09:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36072 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfHXGJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:09:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id w2so8054357pfi.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eF/Jt9OwmgoasE2fXQZChkJqVcCkz2wUqMFj73gYDxk=;
        b=VirwsMNQw2LQ2avP5NOanwM1le++Xd7QEImgtEhSIpoHlsR2MZmNBVw9yM6X9leHY8
         zefgu1XLrYH2mP5/Uuh5VQ49U4nIAKtqXxNTZZhrt1f29gZ7ybarP5kxJM5xY1l5jwS7
         nJ1HIiPbtNl+zBO6a4slR2v/9mjh3PgfFIPem035FBNPYF3cA8xy1XTgp2hWBGp0rfDP
         K/jZAW10QzKe+6A+ts8KNvs+2Vr2y6LaJd/AssYp84FUEqxcRlGW9nxVNHm3sSnVLXTC
         H+G2EVjFNZRXQVPeNuSiL0xYjiBoDboN7lrKeyavugfK+U9Q5Vt3hnMT9Hqmvu4mMYxv
         Hl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eF/Jt9OwmgoasE2fXQZChkJqVcCkz2wUqMFj73gYDxk=;
        b=JAs3NdFOXNZ2ZH+2UXDUKeoFSk08OsjR29E53g4dSrBWfyDgxTGWwhPcxjOs+oZf5H
         H3IRurBuAXKhpoTA9MsPn/XAXwpjnSDVdcLqLLSSz+T7Q9ZI4Lu48Su/Cbv+RSOsGy26
         NPZCnT6nllJTvfkdWm4LbHeSjz42TTQM1sJXgyG+wTD1kAkOXSzqerJPXP1mZz2ABxDu
         rZFWT7QpwXNaWJnu5NEzrppfuHHbg2mRHoVef8sa45eRIWCsHUmitDeRc3s5HPE7jJXT
         TqUcNkd6xm9BFowlU7/Jgkrgr6/fRphBQJmSiLvNBfvXrId9OBf/HlS7XO8BgLq/sOdj
         H3Mg==
X-Gm-Message-State: APjAAAVgw10TI5pRZ2HOTOqfDnUPqqaKplJun3LVbYohy5NGa2YS6vAV
        AvaaGX+E4CS/xZejtwxS5Oc=
X-Google-Smtp-Source: APXvYqw49VNRLEQ73Gyb26PHCsB0JTGsAzfkzgoPkqtPycTUmqoLDMEDM1F+rr9TTU3fjynEQLRIXA==
X-Received: by 2002:a17:90a:b290:: with SMTP id c16mr8822508pjr.34.1566626968562;
        Fri, 23 Aug 2019 23:09:28 -0700 (PDT)
Received: from [10.2.189.129] ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id z14sm3693893pjr.23.2019.08.23.23.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 23:09:27 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH 0/3] x86/mm/tlb: Defer TLB flushes with PTI
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20190823224635.15387-1-namit@vmware.com>
Date:   Fri, 23 Aug 2019 23:09:26 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Content-Transfer-Encoding: 7bit
Message-Id: <1E9E8042-5FF8-4C06-9BE1-E0A7440E35AA@gmail.com>
References: <20190823224635.15387-1-namit@vmware.com>
To:     Nadav Amit <namit@vmware.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I made a mistake and included the wrong patches. I will send
RFC v2 in few minutes.


> On Aug 23, 2019, at 3:46 PM, Nadav Amit <namit@vmware.com> wrote:
> 
> INVPCID is considerably slower than INVLPG of a single PTE, but it is
> currently used to flush PTEs in the user page-table when PTI is used.
> 
> Instead, it is possible to defer TLB flushes until after the user
> page-tables are loaded. Preventing speculation over the TLB flushes
> should keep the whole thing safe. In some cases, deferring TLB flushes
> in such a way can result in more full TLB flushes, but arguably this
> behavior is oftentimes beneficial.
> 
> These patches are based and evaluated on top of the concurrent
> TLB-flushes v4 patch-set.
> 
> I will provide more results later, but it might be easier to look at the
> time an isolated TLB flush takes. These numbers are from skylake,
> showing the number of cycles that running madvise(DONTNEED) which
> results in local TLB flushes takes:
> 
> n_pages		concurrent	+deferred-pti		change
> -------		----------	-------------		------
> 1		2119		1986 			-6.7%
> 10		6791		5417 			 -20%
> 
> Please let me know if I missed something that affects security or
> performance.
> 
> [ Yes, I know there is another pending RFC for async TLB flushes, but I
>  think it might be easier to merge this one first ]
> 
> Nadav Amit (3):
>  x86/mm/tlb: Defer PTI flushes
>  x86/mm/tlb: Avoid deferring PTI flushes on shootdown
>  x86/mm/tlb: Use lockdep irq assertions
> 
> arch/x86/entry/calling.h        | 52 +++++++++++++++++++--
> arch/x86/include/asm/tlbflush.h | 31 ++++++++++--
> arch/x86/kernel/asm-offsets.c   |  3 ++
> arch/x86/mm/tlb.c               | 83 +++++++++++++++++++++++++++++++--
> 4 files changed, 158 insertions(+), 11 deletions(-)
> 
> -- 
> 2.17.1


