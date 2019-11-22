Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099E5C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C945520708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m+N+WXsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfKVUcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:32:20 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43604 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVUcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+Yg2/Hm5cj1++a0Hcu01FV0/uqXnkXadO3bz6Dd3Kiw=; b=m+N+WXshWpx+s7Wc8ziZvesKW
        tEdUpEx+9YOIXbTLZTQ+Y3YEBkxaTGqap4wjjb09MBT4LHGRJi/kv464oRqzU17dHHcLjaqZss/Xs
        hoJqbQiE4Yfpoh5D3s8qPLQp3H9wfJFcHOIGYYhr/wtHsJKwlAN1uJoOJFJHLinY53jQ3nKKDaQKE
        STjwD14ik9HuyPF76d+KL6im0oskgRNVmmeFO0yMsnIZGpXTMTDeO0SG4FtIlkts+ebz0BjsLhAIy
        EgBHpdLh2QPBkesPGS7wpWS1SCaAq/3KgsXCHN+ELZKmJw8FlBcNGELBuxS7Yj6Hc091HnCYq7uAX
        cSM0A4sSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYFbD-0006Gv-82; Fri, 22 Nov 2019 20:32:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 90362300565;
        Fri, 22 Nov 2019 21:31:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BC2F20321DB0; Fri, 22 Nov 2019 21:32:14 +0100 (CET)
Date:   Fri, 22 Nov 2019 21:32:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Andy Lutomirski' <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191122203213.GF2844@hirez.programming.kicks-ass.net>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com>
 <3481175cbe14457a947f934343946d52@AcuMS.aculab.com>
 <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
 <397239502dad4bc3819c49c7d569c70c@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <397239502dad4bc3819c49c7d569c70c@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 09:46:16AM +0000, David Laight wrote:
> From Andy Lutomirski

> > Can we really not just change the lock asm to use 32-bit accesses for
> > set_bit(), etc?  Sure, it will fail if the bit index is greater than
> > 2^32, but that seems nuts.
> 
> For little endian 64bit cpu it is safe(ish) to cast int [] to long [] for the bitops.

But that generates the alignment issues this patch set is concerned
about.
