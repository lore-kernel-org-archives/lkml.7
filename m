Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55314C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEB42173B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HRYyyvVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfKFJ6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:58:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34012 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfKFJ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pEOi60hxj9rUlpmt3AQ2uyxpDVk2yVdnMhMixbzTFeI=; b=HRYyyvVQsAS6nAl+fCluFegk1
        jeYNquWSMkN9TaXSNwh6k8vUGgVyIpMek9be5kmVO4ugopk1YFD/5gHHx7mnrmnmHewqbMlrsloJa
        WcwXroIxDJYrHs4dfHjc4Z7dBq1Yv/YT3gpCNQL7VGpZV4N8T6VzYL+i3WXk/+BXC9DXvR24lyAXL
        L/wbBjPI/zGJrWhOrNVumMj5YTFL/t+Y8hkAVY1668Afwkn9D0GmZiBLeQwZJ3UvR3THH5540hPrV
        cRtHfpjY9TE/VLcpAYt+yxNk8sTSQGNeZvxbOsDgvOBRCBa+MP06lFzaekAEi+G0aXc27Y3r1rHHH
        Aqgx/lpvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSI4q-0003dA-BR; Wed, 06 Nov 2019 09:58:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6FB11301A79;
        Wed,  6 Nov 2019 10:57:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7142529ABB5FD; Wed,  6 Nov 2019 10:58:10 +0100 (CET)
Date:   Wed, 6 Nov 2019 10:58:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
Subject: Re: [PATCH 1/2] perf/core: Adding capability to disable PMUs event
 multiplexing
Message-ID: <20191106095810.GK5671@hirez.programming.kicks-ass.net>
References: <1573002091-9744-1-git-send-email-gkulkarni@marvell.com>
 <1573002091-9744-2-git-send-email-gkulkarni@marvell.com>
 <20191106094032.GV4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106094032.GV4131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 10:40:32AM +0100, Peter Zijlstra wrote:
> On Wed, Nov 06, 2019 at 01:01:40AM +0000, Ganapatrao Prabhakerrao Kulkarni wrote:
> > When PMUs are registered, perf core enables event multiplexing
> > support by default. There is no provision for PMUs to disable
> > event multiplexing, if PMUs want to disable due to unavoidable
> > circumstances like hardware errata etc.
> > 
> > Adding PMU capability flag PERF_PMU_CAP_NO_MUX_EVENTS and support
> > to allow PMUs to explicitly disable event multiplexing.
> 
> This doesn't make sense, multiplexing relies on nothing that normal
> event scheduling doesn't also rely on.
> 
> Either you can schedule different sets of events, or you cannot.

More specifically, how is a reschedule due to rotation any different
than a reschedule due to context switch?

Both cases we do a full reprogram of the PMU.
