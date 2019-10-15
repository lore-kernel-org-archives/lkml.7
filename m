Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D0CECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFC720854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571170082;
	bh=uc2GHtvslcSS/T/XLupbQ1Q94+ILqCSst1CSsKISRlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q3nqjHYFk1sa3VqL2tHp9BJh5S4Rt/ZY+UT6uBNUTJnMwQOftWWBXxWfisaxGMP0b
	 XTXGh66wICqABJo4KSyH9yFyfgqY6aQDxnylKFEHd3+g1hZWgF0bvpAZgVlsSgAXaf
	 TaKl/Ml3xdPxtIPYtz7vMI6ppgBibGNvu5YnILIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbfJOUIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfJOUIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:08:01 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A10F2083B;
        Tue, 15 Oct 2019 20:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571170081;
        bh=uc2GHtvslcSS/T/XLupbQ1Q94+ILqCSst1CSsKISRlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mnqJpeIhIh78vXOjgm2TBqTqBGBA4pdda0fJslVV6xmMOppJmdQ88FqFYmn/BGCrz
         gi62rThwZuwuweL/DT4Xq48ByuV7Ojc8GyWmV5Ke2wysC3GbTc+oZxhrzSzIGiHpAA
         S1C18iP3nJ9CJWkaATgvnQcGzOrNi8LTf9X4kfck=
Date:   Tue, 15 Oct 2019 21:07:55 +0100
From:   Will Deacon <will@kernel.org>
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v2] arm64: entry.S: Do not preempt from IRQ before all
 cpufeatures are enabled
Message-ID: <20191015200755.aavtyhq56lewazah@willie-the-truck>
References: <20191015172544.186627-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015172544.186627-1-james.morse@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Patch looks good apart from one thing...

On Tue, Oct 15, 2019 at 06:25:44PM +0100, James Morse wrote:
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 2c2e56bd8913..67a1d86981a9 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -223,6 +223,7 @@ extern long schedule_timeout_uninterruptible(long timeout);
>  extern long schedule_timeout_idle(long timeout);
>  asmlinkage void schedule(void);
>  extern void schedule_preempt_disabled(void);
> +asmlinkage void preempt_schedule_irq(void);

I don't understand the need for this hunk, since we're only calling the
function from C now. Please could you explain?

Will
