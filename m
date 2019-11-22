Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A0EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EE320715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gt/m5z4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfKVJqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:46:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfKVJqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4bMCSmie4xBahDbJdinovuabFdb6Cy8S8dTGqzWuLR4=; b=Gt/m5z4eElJMbtAzlkbsivme/p
        NNr7pn/ZSfiG76Nm9qhvebnfTv5LORjN3eJnB3bVavVQCX/92ySfbqprcXoxw6389Jjs4RQNafj/v
        LYyxUSuUanL2v1d8w7C7BK4abFwW4rsXvy+xRYox8sgg6M4WOh4pSh6qEM8ghzR2O/S15Sebtd35T
        51/ZJljch/mX67diz+L9Ev/OnAhJ3wHs9YsUFC4phFCI+NmLoKoHMjdPLm2EvClM3K3TWdlMeTr/N
        xG2e2w2vGpSXvem8Qxr/DmqIXxaDLVyfZbrjdDUngBaQ+Ft122nSGGTJeTomWgMKfY2cAEwKcEuwg
        H98/X7ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iY5WQ-0001gv-Lb; Fri, 22 Nov 2019 09:46:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8693630705E;
        Fri, 22 Nov 2019 10:45:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF3EF2021C977; Fri, 22 Nov 2019 10:46:35 +0100 (CET)
Date:   Fri, 22 Nov 2019 10:46:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 4/6] x86/split_lock: Enumerate split lock detection
 if the IA32_CORE_CAPABILITIES MSR is not supported
Message-ID: <20191122094635.GC4097@hirez.programming.kicks-ass.net>
References: <20191122003754.GF199273@romley-ivt3.sc.intel.com>
 <5A85615E-EFFF-4DF3-A1A5-DB8532451A42@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5A85615E-EFFF-4DF3-A1A5-DB8532451A42@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 06:13:18PM -0800, Andy Lutomirski wrote:

> You seem to be assuming that certain model CPUs have this feature even
> if not enumerated. You need to make sure you don’t try to use it in a
> VM without the hypervisor giving you an indication that it’s available
> and permitted. My suggestion is to disable model-based enumeration if
> HYPERVISOR is set.  You should also consider probing the MSR to double
> check even if you don’t think you have a hypervisor.

Yep, in patch 6 this results in an unconditinoal WRMSR, which, when ran
under a HV, will explode most mighty.

He doesn't double check, doesn't use wrmsrl_safe()...
