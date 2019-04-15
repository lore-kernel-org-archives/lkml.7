Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40206C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6B920693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ADBYsgvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfDOJEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:04:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35680 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfDOJEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6Y1sUvSp25DQUSecTY7gB5Ablwg7tJmCYsxXPYXaofY=; b=ADBYsgvkhZHBuKug0QJGHq1ci
        T4phB6d8iXS+K9iwMq0c4QH5FByAtv8lmLBqR1Q7S055rBrdZ9FptfWpLAy7ythGFqk41ryTvAyMR
        +tTBVnE7M9Gvn2vkoFrqv4iknZejfJW/zZOttiYsmzk/yp+4bQMF4IUYVicI+KSP+PBSMLkitrYym
        22i8swNam3A85L9f/PyqzxfnnIbmzdaq70F5xjjeWSJUYjQSHUZ/kj/hxdlqgYvSA1QRk2jvKX+ZF
        sycKqJeyf51iUug0NgOYIM7auyF7kE7khecj9M1QHKyp9vowF7gIOmkURGGNPDVp+akmrOdehUwB4
        Opk8QKURA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hFxX7-00005c-Uk; Mon, 15 Apr 2019 09:04:10 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44B53981E5B; Mon, 15 Apr 2019 11:04:06 +0200 (CEST)
Date:   Mon, 15 Apr 2019 11:04:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tj@kernel.org
Subject: Re: misuse of fget_raw() in perf_event_get()
Message-ID: <20190415090406.GJ2490@worktop.programming.kicks-ass.net>
References: <20190413210242.GP2217@ZenIV.linux.org.uk>
 <20190415044158.5goa2je57j63kwaz@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415044158.5goa2je57j63kwaz@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 09:42:00PM -0700, Alexei Starovoitov wrote:
> On Sat, Apr 13, 2019 at 10:02:42PM +0100, Al Viro wrote:
> > 	What's the point of using fget_raw(), if you do
> > _not_ accept O_PATH descriptors?  That should be fget()...
> 
> I think you're talking about commit e03e7ee34fdd ("perf/bpf: Convert perf_event_array to use struct file")
> I don't really remember why we went with this instead of fget().
> There was a bunch of back and forth back then with Peter.

That was mostly on what refcount to use, you wanted to use the event
refcount, and I suggested using the file refcount.

If you look at:

  lkml.kernel.org/r/20160126161637.GF6357@twins.programming.kicks-ass.net

I too wondered about the fget_raw() at the time, whatever Al wants
though, I never quite remember how that file stuff works :/

