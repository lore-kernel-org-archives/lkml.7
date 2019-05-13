Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DDEC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD67208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="REx4synB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfEMPPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:15:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfEMPPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sYk1qF0Vg/KIRkZli5M/2CG/IiUILwRXwJH2skE3G4Y=; b=REx4synBpzyocaSPNSMhz/dBh
        x399vWJqF7p4npVM5QsVPsG55ErkZ5fQHzNE7SvhPaxAGuPAcMoqAhGfsgpUJo8i76muR4yWQQUtU
        tQxC2t4SmATs64p35q/UrMh+zG44Emo+gkoUbGpHChXki9LtyftxRMvXAnAt+8772zDazDPvmcrYZ
        IO6mWpHJHrpQ7Wh+tT7dtK938iXOpR30ImB4A7clcoQAjzmeyAiFIpojNXFvexY4vkFKlAG8lL58r
        +Sogz+Ndue92+0bFtoSM4dJkpK9Nw4F2bT0AXmKHBTkW2UkLKappwxdwuffjpqkmFrgkz4tA9Fal8
        /7i9i1OVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQCfO-0005lL-4u; Mon, 13 May 2019 15:15:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57CEA2029F877; Mon, 13 May 2019 17:15:00 +0200 (CEST)
Date:   Mon, 13 May 2019 17:15:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, kvm@vger.kernel.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        liran.alon@oracle.com, jwadams@google.com
Subject: Re: [RFC KVM 24/27] kvm/isolation: KVM page fault handler
Message-ID: <20190513151500.GY2589@hirez.programming.kicks-ass.net>
References: <1557758315-12667-1-git-send-email-alexandre.chartre@oracle.com>
 <1557758315-12667-25-git-send-email-alexandre.chartre@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557758315-12667-25-git-send-email-alexandre.chartre@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 04:38:32PM +0200, Alexandre Chartre wrote:
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 46df4c6..317e105 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -33,6 +33,10 @@
>  #define CREATE_TRACE_POINTS
>  #include <asm/trace/exceptions.h>
>  
> +bool (*kvm_page_fault_handler)(struct pt_regs *regs, unsigned long error_code,
> +			       unsigned long address);
> +EXPORT_SYMBOL(kvm_page_fault_handler);

NAK NAK NAK NAK

This is one of the biggest anti-patterns around.
