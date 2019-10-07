Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD880C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14EB20659
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CE8wQWou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfJGQNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:13:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33310 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfJGQNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aONeFDLbBithO73vHYkhDtop/BmMj25yt4UQnRDlml0=; b=CE8wQWouMnSXLBYJT5/GE4GCO
        /v8P88UHi2eyAO8lqiQwZUp7+NTRxtwHGfxJ3J8+d35Ux1hP5DntKMJGkzgsg4HtNQDmngHesYxhH
        u1zM7MxmpYJrg3pScZZ/zye8f0MOV/m+oJ1WmYaZ7R2r0tnQRA6ScjjjAu8xBpPziRNBUro3IVuzF
        tUby1PtGkGdZ/MKcnX49ThYl/ygaEuTXnda+LZgJrcT3BFf1p//ZW1wBUGzh2c3byp2zLEcZDgK5g
        rWyY8oWbVWdf2WJKP+MPbAQ8CXP6LQLuWiEi5V0PHZLmsp3u4eJaAHwInU4Fwps4s3Xx+kN2lKjv3
        tJJlK8erw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHVdB-0007OM-89; Mon, 07 Oct 2019 16:13:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A87E9802D2; Mon,  7 Oct 2019 18:13:02 +0200 (CEST)
Date:   Mon, 7 Oct 2019 18:13:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        hjl.tools@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [RFC][PATCH 0/9] Variable size jump_label support
Message-ID: <20191007161302.GI4643@worktop.programming.kicks-ass.net>
References: <20191007090225.441087116@infradead.org>
 <20191007084443.793701281@infradead.org>
 <20191007112229.GA3221@gmail.com>
 <20191007112606.GA44864@gmail.com>
 <20191007111742.00d6c50b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007111742.00d6c50b@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 11:17:42AM -0400, Steven Rostedt wrote:
> Actually, even back then I said that it would be best to merge all the
> tools into one (I just didn't have the time to implement it), and then
> we could pull this off. I have one of my developers working to merge
> record-mcount into objtool now (there's been some patches floating
> around).

Right, but while working on this I discovered GCC's -mrecord-mcount (and
the kernel using this), so how much do we really still need the
record-mcount tool?

Do we really only need the tool for the little hole between gcc-4.6
(minimal supported GCC version) and gcc-5 (when -mrecord-mcount was
introduced) ?

