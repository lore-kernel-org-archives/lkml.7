Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43607C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFAB206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WYBo7Fjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfCDUMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:12:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47720 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfCDUMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3SJHnacTOoBW8b8W4vRv0uvz720ObhfHvmTAouUsjm4=; b=WYBo7FjbN/ay5p15+iiU7lNRi
        G1hABjf33ZG3i01s4h+TCMgwFNbBZikIXpApItFCAQN7FVLWrMnWEvsHCHF4YoNj2dkEKbUL21r36
        SFJWS8/OOhHZELLCYSxIa+tSI1u7DLuDnzSUWxOWpfmmmkOK0qoKEdyiycrbmnNSWIqVjHPUPfVou
        x+pRSr3R5uB2oEeZmTnokPdfx1GGwwtkKxcumkNXR/q9Kmllj1QMxQor0wK500nLaN9ns5CbSzfuA
        b3+ccopq3dzEikq8vwWFXAan4Ba5jGqUjLPZFNhTeKIYVRdBK1QD8gC6ny6siEUsoiZHd4i5aQyha
        QaqkskQog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h0twR-0008VC-VR; Mon, 04 Mar 2019 20:12:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C2AA201383D7; Mon,  4 Mar 2019 21:12:01 +0100 (CET)
Date:   Mon, 4 Mar 2019 21:12:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 04/17] x86/split_lock: Align x86_capability to
 unsigned long to avoid split locked access
Message-ID: <20190304201201.GT32494@hirez.programming.kicks-ass.net>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
 <1551494711-213533-5-git-send-email-fenghua.yu@intel.com>
 <b9a7e3a6-d89c-9ce7-8909-e09122c93f96@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a7e3a6-d89c-9ce7-8909-e09122c93f96@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 10:52:19AM -0800, Dave Hansen wrote:
> On 3/1/19 6:44 PM, Fenghua Yu wrote:
> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> > index 33051436c864..eb8ae701ef65 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -93,7 +93,9 @@ struct cpuinfo_x86 {
> >  	__u32			extended_cpuid_level;
> >  	/* Maximum supported CPUID level, -1=no CPUID: */
> >  	int			cpuid_level;
> > -	__u32			x86_capability[NCAPINTS + NBUGINTS];
> > +	/* Unsigned long alignment to avoid split lock in atomic bitmap ops */
> > +	__u32			x86_capability[NCAPINTS + NBUGINTS]
> > +				__aligned(sizeof(unsigned long));
> 
> I think this also warrants a comment in the changelog about the
> alignment of 'struct cpuinfo_x86'.

Nah.

