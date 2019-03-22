Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058C0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF8120850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SoIIWRKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfCVQw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:52:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51050 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfCVQw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=43yWoHNsIC8YPsKPjdrRLXkYbp5BCR3I+6h2VPg3G2Q=; b=SoIIWRKqYcgcAypFylzNqem/l
        xYfEClSFsoXMgl/znXpzKM57JoUolr1nk1HfWtKPAIM3vf0GI01kzFmXEa5CQ4wCmVmNKUkxtZ6GT
        l3fIEqpU3AiKeZbhN14cnLqb/iMdvcTN+fg5drySVfie72W5767xQIVrp/ESwBblfgVPaNkurQRCE
        t3ZaYeT4Zkzz2SGa1mKuelVC4GvvZcYfhz8uhxVMnkzd2hlpzhcRjC+Cfk/l3rz2CkQr28B3M2lca
        uCF3viMTK56agTLE88pnUuA+hvbWcauM4Cchpwgy0zAmQ4Zncuoni4mdVTl91rLpCaykTQ0i67tKF
        n9BQOTceA==;
Received: from [31.161.229.66] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7NOz-0003VU-Pq; Fri, 22 Mar 2019 16:52:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE103980317; Fri, 22 Mar 2019 17:52:14 +0100 (CET)
Date:   Fri, 22 Mar 2019 17:52:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Pu Wen <puwen@hygon.cn>, "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/cpu/hygon: Fix phys_proc_id calculation logic
 for multi-die processor
Message-ID: <20190322165214.GI7905@worktop.programming.kicks-ass.net>
References: <1553251380-7015-1-git-send-email-puwen@hygon.cn>
 <20190322155449.GE12472@zn.tnic>
 <639a5bc6-f821-ee9d-1594-d02701321192@hygon.cn>
 <20190322164445.GG12472@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322164445.GG12472@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 05:44:45PM +0100, Borislav Petkov wrote:
> On Sat, Mar 23, 2019 at 12:19:01AM +0800, Pu Wen wrote:
> > That 6 is not a magic number.
> 
> Well, if I see a naked 6, then it is only magic to me. Now if it were a
> proper define with a descriptive name...

Does AMD/Hygon not have a CPUID leaf to read useful things like this
from?
