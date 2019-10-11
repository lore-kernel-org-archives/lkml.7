Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FDFECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333362084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KsTf+DZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfJKHBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 03:01:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40226 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfJKHBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 03:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BjeZot4fEwwx6gNj+xVZ6oahHmQIIs1To0+8L06kqK0=; b=KsTf+DZxFxL1gpCNRT2SyZmSl
        sBQrx1xu+ruwGBTHODo5HvWK3I9SbFBZutGNCsfO3N1vzT3G3fo5S/eg/6IoooI6lyqU10DusR11Q
        Uu3ZzuqP6jCiE3g9Nq0OW0miViyxIU+Qn89/mRYaAQbknKzRzhI11Rb1Nw51QQGexN96lV0STVwlo
        Rcv8WU2NhZHUSbWbOuvrrURDicJE/WBwmi6yiP+jOhrK4F9OifaoaBusw8eXx7Mq0a3pKzaMHFv0p
        mMj1Pc6aplKtZF6dQTtDFlnLCwISVocMjIDtJfdV4Jv63ufNGw/is5+NQJytbRCGiDIlCYDyuTIGG
        TdvOco/Iw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIovZ-00049f-Il; Fri, 11 Oct 2019 07:01:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0828F3008C1;
        Fri, 11 Oct 2019 09:00:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86E0720C04742; Fri, 11 Oct 2019 09:01:26 +0200 (CEST)
Date:   Fri, 11 Oct 2019 09:01:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191011070126.GU2328@hirez.programming.kicks-ass.net>
References: <20190827180622.159326993@infradead.org>
 <20190827181147.166658077@infradead.org>
 <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
 <20191002182106.GC4643@worktop.programming.kicks-ass.net>
 <20191003181045.7fb1a5b3@gandalf.local.home>
 <7b4196a4-b6e1-7e55-c3e1-a02d97c262c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b4196a4-b6e1-7e55-c3e1-a02d97c262c7@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 10:10:47AM +0200, Daniel Bristot de Oliveira wrote:
> Currently, ftrace_rec entries are ordered inside the group of functions, but
> "groups of function" are not ordered. So, the current int3 handler does a (*):

We can insert a sort() of the vector right before doing
text_poke_bp_batch() of course...
