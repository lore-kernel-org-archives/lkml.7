Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2055EC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E7E20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZI/rNFGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfDILDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:03:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39778 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfDILDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Sa9IPnO7XJIY1BdPSTotZfMB3FWwmm613L8mJrYOXKc=; b=ZI/rNFGAwWJMfm/w/cIIP3W9C
        cHUJT7At+g+kJgyl5U+p5pvzrcks7whmy7fQYFg0RZrNy7veeUyYwAMkCNJdT1e/tge7glmgHi2cb
        74rov+y4h3sknfXdLACPJLMDesI6NXW7nRF6vpB8DEPf/bMUYBa6C/d4Q6hVYOgEdJysh/Dj0/JJO
        N7bkAgHvT7VB0j3b+W2Z4+Yjl+/9mKeo8tlLaDHBA1ykE/l+nNXqaQSdJoK5b8u8EvO8mXJGK2UK/
        i+sWwB5Mqliu4GtMCJ3Ro2Y8nAuiNyIQwQbRHVJ4LqhYmgVBRRk1byx/wHyYuDPzwtT4mgKag/fcV
        yEGv+bK0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDoXW-0002IW-HC; Tue, 09 Apr 2019 11:03:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 313CF201F29A4; Tue,  9 Apr 2019 13:03:40 +0200 (CEST)
Date:   Tue, 9 Apr 2019 13:03:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [RFC PATCH v2 11/14] x86/watchdog/hardlockup: Add an HPET-based
 hardlockup detector
Message-ID: <20190409110340.GS4038@hirez.programming.kicks-ass.net>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-12-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551283518-18922-12-git-send-email-ricardo.neri-calderon@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 08:05:15AM -0800, Ricardo Neri wrote:
> diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
> index 4d559e0c746f..15dc3b576496 100644
> --- a/arch/x86/include/asm/hpet.h
> +++ b/arch/x86/include/asm/hpet.h
> @@ -123,12 +123,24 @@ struct hpet_hld_data {
>  	u32		num;
>  	u32		flags;
>  	u64		ticks_per_second;
> +	u32		handling_cpu;
> +	struct cpumask	cpu_monitored_mask;
> +	struct msi_msg	msi_msg;
>  };

Please don't use struct cpumask unless you absolutely have to.

The above is better written as:


	struct hpet_hld_data {
		...
		unsigned long cpumask[0];
	};

and allocated using:

	struct hpet_hld_data *hhd = kzalloc(sizeof(struct hpet_hld_data) + cpumask_size());

and used as:

	to_cpumask(hhd->cpumask);
