Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA32C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C1D20874
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QfHg/jEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406099AbfFKR1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:27:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57638 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405718AbfFKR1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Dar/WM9H13xu/Hyi4BKbNrb4KMNdAL61gb8NhO+H5E8=; b=QfHg/jEZCM3KPVt89hxZScmxp0
        i5wupjPy58t3ZNKCLb8DxCIRmec0fEnUZiWZ3TXn/Nt5zVCDh3qYQblmdXCSnFXIObGe8aII0S7Lc
        oPkt8cCIumc7tFdvZtoK5IMBo9t3sV1zrFLEaqVIVj7yqiSXUL/mlVTmuZJA/UfG+naZVJ7AgLuph
        iVa2eDr0c+VqzDBYWOWA4xKXKIpHpuHXLrXy+WlGiFMUaQf8Ct0iuGwciShDGdYb8mwu4MEXN3xjz
        6doexOaudPHV29i+WeAhg0xVSgw9bsFUrdrLOJ3pJI3pWs8VKVAnFLdamKRkoweBnOt52vTaru5cS
        NeVgQ4cQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hakYK-0006EZ-SR; Tue, 11 Jun 2019 17:27:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BEB712025A826; Tue, 11 Jun 2019 19:27:17 +0200 (CEST)
Date:   Tue, 11 Jun 2019 19:27:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v4 3/5] x86/umwait: Add sysfs interface to control umwait
 C0.2 state
Message-ID: <20190611172717.GC3436@hirez.programming.kicks-ass.net>
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
 <1559944837-149589-4-git-send-email-fenghua.yu@intel.com>
 <20190611085410.GT3436@hirez.programming.kicks-ass.net>
 <0D67CEAC-9710-4ECB-9248-75B48542FF82@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0D67CEAC-9710-4ECB-9248-75B48542FF82@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


(can you, perchance, look at a MUA that isn't 'broken' ?)

On Tue, Jun 11, 2019 at 09:04:30AM -0700, Andy Lutomirski wrote:
> 
> 
> > On Jun 11, 2019, at 1:54 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> >> On Fri, Jun 07, 2019 at 03:00:35PM -0700, Fenghua Yu wrote:
> >> C0.2 state in umwait and tpause instructions can be enabled or disabled
> >> on a processor through IA32_UMWAIT_CONTROL MSR register.
> >> 
> >> By default, C0.2 is enabled and the user wait instructions result in
> >> lower power consumption with slower wakeup time.
> >> 
> >> But in real time systems which require faster wakeup time although power
> >> savings could be smaller, the administrator needs to disable C0.2 and all
> >> C0.2 requests from user applications revert to C0.1.
> >> 
> >> A sysfs interface "/sys/devices/system/cpu/umwait_control/enable_c02" is
> >> created to allow the administrator to control C0.2 state during run time.
> > 
> > We already have an interface for applications to convey their latency
> > requirements (pm-qos). We do not need another magic sys variable.
> 
> I’m not sure I agree.  This isn’t an overall latency request, and
> setting an absurdly low pm_qos will badly hurt idle power and turbo
> performance.  Also, pm_qos isn’t exactly beautiful.
> 
> (I speak from some experience. I may be literally the only person to
> write a driver that listens to dev_pm_qos latency requests. And, in my
> production box, I directly disable c states instead of messing with
> pm_qos.)
> 
> I do wonder whether anyone will ever use this particular control, though.

I agree that pm-qos is pretty terrible; but that doesn't mean we should
just add random control files all over the place.
