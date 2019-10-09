Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83C9C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985D821835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbfJIHlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:41:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730059AbfJIHle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:41:34 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 679C63CBE2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 07:41:34 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id i28so1218969pfq.16
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 00:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yhETDPyjdDu1zKZMAXWTw+RFTVrPTgy3NIktVBvTB1s=;
        b=lhIGYG+qyB5mWQ6z7+4NOUEHNDbw5snSu7WmNWeisoc1aYQbdviB+dEi9x56st0SzQ
         OE5pvF3mfhufYEHs1tZq9w0oUIPovyLJxVwq4lxRcOUZc/2JkMAUxJrFNeUdLmBUhFsu
         5F6sYiPzEcBViOcJC6KPWPeUXxMuoAJGPWgE/NrxCWi92F09Vlt8iRT507+rA06dNK7K
         fHkiu7xAsT/TdcyAfzq99N0Zv/Tkl6VgByKlVpyIWd2FoQkBblW70n68xEWTIrQfe4vD
         PGDYXjaLWB0dr5ypnnRVXZbvpp54wmFErjujSrnnBs8TI6qQviTa+JVSdREszeFRM9Hc
         6jIg==
X-Gm-Message-State: APjAAAXmtt339FtJi+Jxbf5z7Q3qcoxSxOwZlm3NFUzTiCO07Ho7TCqc
        BLZqyNyKs5Iwrbqp+zQyHjrhjgv8Ui4iuQJxjcpUM6jcs8NuHIqSOG9VoBoW7NUkYu+GHXyx1jb
        4AOzLfGh1BnFEnDU16JchXvIU
X-Received: by 2002:a17:90a:aa98:: with SMTP id l24mr2457572pjq.96.1570606893822;
        Wed, 09 Oct 2019 00:41:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyHkBK4xiTE3izO6J9VCbcfdAGwtWs5QRjTXypAY/ib7aR15lQSUQgpvx4dIhx/8cAOR0z2oQ==
X-Received: by 2002:a17:90a:aa98:: with SMTP id l24mr2457553pjq.96.1570606893552;
        Wed, 09 Oct 2019 00:41:33 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 19sm1294409pjd.23.2019.10.09.00.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 00:41:32 -0700 (PDT)
Date:   Wed, 9 Oct 2019 15:41:18 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        hughd@google.com, gokhale2@llnl.gov, jglisse@redhat.com,
        xemul@virtuozzo.com, hannes@cmpxchg.org, cracauer@cons.org,
        mcfadden8@llnl.gov, shli@fb.com, aarcange@redhat.com,
        mike.kravetz@oracle.com, dplotnikov@virtuozzo.com,
        rppt@linux.vnet.ibm.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        mgorman@suse.de, kirill@shutemov.name, dgilbert@redhat.com
Subject: Re: [PATCH v4 05/10] mm: Return faster for non-fatal signals in user
 mode faults
Message-ID: <20191009074118.GC1039@xz-x1>
References: <20190923042523.10027-6-peterx@redhat.com>
 <mhng-2f8b3ac1-9d2a-4c81-9417-62cff5f4190f@palmer-si-x1e>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mhng-2f8b3ac1-9d2a-4c81-9417-62cff5f4190f@palmer-si-x1e>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 03:43:19PM -0700, Palmer Dabbelt wrote:
> > diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> > index deeb820bd855..ea8f301de65b 100644
> > --- a/arch/riscv/mm/fault.c
> > +++ b/arch/riscv/mm/fault.c
> > @@ -111,11 +111,12 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
> >  	fault = handle_mm_fault(vma, addr, flags);
> > 
> >  	/*
> > -	 * If we need to retry but a fatal signal is pending, handle the
> > +	 * If we need to retry but a signal is pending, try to handle the
> >  	 * signal first. We do not need to release the mmap_sem because it
> >  	 * would already be released in __lock_page_or_retry in mm/filemap.c.
> >  	 */
> > -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(tsk))
> > +	if ((fault & VM_FAULT_RETRY) &&
> > +	    fault_should_check_signal(user_mode(regs)))
> >  		return;
> > 
> >  	if (unlikely(fault & VM_FAULT_ERROR)) {
> 
> Acked-by: Palmer Dabbelt <palmer@sifive.com> # RISC-V parts
> 
> I'm assuming this is going in through some other tree.

Hi, Palmer,

Thanks for reviewing!

There's a new version here, please feel free to have a look too:

https://lore.kernel.org/lkml/20190926093904.5090-1-peterx@redhat.com/

Regards,

-- 
Peter Xu
