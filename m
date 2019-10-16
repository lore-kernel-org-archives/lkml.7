Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FB5FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBF021835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571241217;
	bh=2aQeCKMudat8SNGBakIrBap6j4bq+bgWrgmVeaKi6zU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h4ZHaCd6ZNc7L7/BqCCtS3HrgWJP0B2xM+KapjFuHGMD06UqMWeVgszkYZK3JkvDV
	 FtjHBYeufxFPi7zntRlL0Zrda4MKug+WwE68WA88I+U/j9BndhQnmNyVstBIYhEcJ/
	 pnot81QNdetCqTMHPVwbI0D8i/01+lcUj9xv5eOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405878AbfJPPxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:53:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfJPPxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:53:35 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D230520650;
        Wed, 16 Oct 2019 15:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571241214;
        bh=2aQeCKMudat8SNGBakIrBap6j4bq+bgWrgmVeaKi6zU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ijByLgSxyop2dsaHlNCdO07lOchloezmmgNbZeNWtA5TyMI9wMhu5SjIpv48XwpXZ
         QSqwS3/7CvktAZWYQq15RRfERk2Lsk7+i3FEysweZiiU8I4gqNqYSO5T0FMPgi4OHr
         ZLw7TsTLcxaowLsHAa5q78Uj7X3+xueNZZW4bpYY=
Date:   Wed, 16 Oct 2019 16:53:29 +0100
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
Message-ID: <20191016155328.exfa25uc6thdpq7b@willie-the-truck>
References: <20191015172544.186627-1-james.morse@arm.com>
 <20191015200755.aavtyhq56lewazah@willie-the-truck>
 <e6d58ed6-2d5e-8c78-c824-d0d5abff8394@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6d58ed6-2d5e-8c78-c824-d0d5abff8394@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Wed, Oct 16, 2019 at 10:35:13AM +0100, James Morse wrote:
> On 15/10/2019 21:07, Will Deacon wrote:
> > Patch looks good apart from one thing...
> > 
> > On Tue, Oct 15, 2019 at 06:25:44PM +0100, James Morse wrote:
> >> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >> index 2c2e56bd8913..67a1d86981a9 100644
> >> --- a/include/linux/sched.h
> >> +++ b/include/linux/sched.h
> >> @@ -223,6 +223,7 @@ extern long schedule_timeout_uninterruptible(long timeout);
> >>  extern long schedule_timeout_idle(long timeout);
> >>  asmlinkage void schedule(void);
> >>  extern void schedule_preempt_disabled(void);
> >> +asmlinkage void preempt_schedule_irq(void);
> > 
> > I don't understand the need for this hunk, since we're only calling the
> > function from C now. Please could you explain?
> 
> (A prototype is needed to make the thing build[0], but)

Got it, thanks. I'm surprised the prototype doesn't exist already, but it
looks like we'll be the first C caller.

I'll queue this as a fix.

Will
