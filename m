Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1569C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6562070B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="go6ZaoYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfJDLXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 07:23:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36022 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbfJDLXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 07:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ClUb0N8ehM4dBInFwJ4FzL/4e07/ILuXpFO5ux0hbh4=; b=go6ZaoYO7equ6MnpHuPKuUDxU
        FEI2eEkkzCgiub1il9Y2L+DejhICJJwrN1BMhBVwLo4IIfZTFEuNfo4W5okzptrdQhJ0fQKWOjCn1
        v2/yMcfN2e7H7EGGefFeuWq394rZ7wMbBakTjTEf0kFJ+tVal/aPZ5VlrcQgGH7fdiWr4N7yk/vXO
        EC1L0NbYdgTIIJgjQKnLye3JRR35Cen5TvMdXAcQzU0Fu2Ns2F6qsHClt3BD3p7vewbD71oiN64x9
        6d8cACK3WIyqW/YEden+IFTt5F0iwUi7ImslRY4VvSQ2BgIgg+MMYDLwic9SDwM0MLEVLNR/iscAF
        WhCRdQlkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGLfV-0005lo-BW; Fri, 04 Oct 2019 11:22:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EC033013A4;
        Fri,  4 Oct 2019 13:21:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7F84203E50D2; Fri,  4 Oct 2019 13:22:37 +0200 (CEST)
Date:   Fri, 4 Oct 2019 13:22:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191004112237.GA19463@hirez.programming.kicks-ass.net>
References: <20190827180622.159326993@infradead.org>
 <20190827181147.166658077@infradead.org>
 <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
 <20191002182106.GC4643@worktop.programming.kicks-ass.net>
 <20191003181045.7fb1a5b3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003181045.7fb1a5b3@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 06:10:45PM -0400, Steven Rostedt wrote:
> But still, we are going from 120 to 660 IPIs for every CPU. Not saying
> it's a problem, but something that we should note. Someone (those that
> don't like kernel interference) may complain.

It is machine wide function tracing, interference is going to happen..
:-)

Anyway, we can grow the batch size if sufficient benefit can be shown to
exist.
