Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D26C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A8820708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kD0jCrxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfKVUXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:23:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44666 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVUXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b8B+GByzGciEAQqjrUTAkbEpsryHD7CBv8tBnhLGMqc=; b=kD0jCrxubG3PD+ZkmYrsktw4h
        GAWC4pi692pSyYH7m743qVeRkACNun5WJxnzCqGy/jA0XbKgSvSHHw8SvxZ/bPy/YEe7npgyJjg8x
        RRevsZye991yu5xYsGKYEx7XW9W2jKQlgSOCdWekUiAz5ondiPjo+Qf8qqW7OMSLhv03F2bXSEWjk
        ydX7IJk4up8tvKnifslhcfsDO+0S0qpaFyKXUnLwVHifSG87hCG/O7EgYbyQyi/gGr0P3CjkJLyiu
        IfxvWo2Eg7zW7jjZQdENZRpxnxRw+aiRjRb7M1G8I8Y2uq7fkEy7MgtrW5uVwBzYPZupAweeX6T7D
        dnkczs4Kw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYFSU-0003ze-RW; Fri, 22 Nov 2019 20:23:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 568FD30068E;
        Fri, 22 Nov 2019 21:22:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C167B20321DB0; Fri, 22 Nov 2019 21:23:12 +0100 (CET)
Date:   Fri, 22 Nov 2019 21:23:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191122202312.GB2844@hirez.programming.kicks-ass.net>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com>
 <20191121173444.GA5581@agluck-desk2.amr.corp.intel.com>
 <20191122105141.GY4114@hirez.programming.kicks-ass.net>
 <20191122152715.GA1909@hirez.programming.kicks-ass.net>
 <20191122172246.GA15557@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122172246.GA15557@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 09:22:46AM -0800, Luck, Tony wrote:
> On Fri, Nov 22, 2019 at 04:27:15PM +0100, Peter Zijlstra wrote:
> > +void handle_user_split_lock(struct pt_regs *regs, long error_code)
> > +{
> > +	if (sld_state == sld_fatal)
> > +		return false;
> > +
> > +	pr_alert("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
> > +		 current->comm, current->pid, regs->ip);
> > +
> > +	__sld_set_msr(false);
> > +	set_tsk_thread_flag(current, TIF_CLD);
> > +	return true;
> > +}
> 
> I think you need an extra check in here. While a #AC in the kernel
> is an indication of a split lock. A user might have enabled alignment
> checking and so this #AC might not be from a split lock.
> 
> I think the extra code if just to change that first test to:
> 
> 	if ((regs->eflags & X86_EFLAGS_AC) || sld_fatal)

Indeed.
