Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA553C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD58921655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PPVXtku5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfJGLXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:23:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbfJGLXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:Subject:Cc:To:From:Date:
        Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=slCb8CRQPjdim+WFHcq25s3MGW+Bv4nQty84Qt8ALTw=; b=PPVXtku5/gES
        ZBZEYSGakApH01C6LO6cN7uXKBD0By0p9tlh3tlPJeokE4L8J9oO2BlDiGQj/q4W4QTlFiNaAvhFc
        2w7i+gyOyur92bKze7cfPnCOYcl6bUBKCjw7v8bDvGiqgn4N62YRP06rjqBuYdodpjp4al5m8TRJR
        +DAJOmgWGngEADQF4A8jVjI4wE8Z0H5+Mv6/Q+Z7H777wleclqiOVbSoQFas7DiSIsMNy3lOF3nUx
        ScV5Q7rkW7suzCY/dZWjxHCth1L7UGvcS6gIKzoEqyvR4e7pvRLmSSU4OsvYuO6tP0opYuxhT08vd
        SXuC390W6PaRKJcuFmxqyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6u-0003G0-OP; Mon, 07 Oct 2019 11:23:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8230030034F;
        Mon,  7 Oct 2019 13:22:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 68C6E202A194E; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007081716.07616230.8@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:17:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [PATCH v3 0/6] Rewrite x86/ftrace to use text_poke()
References: <20191007090225.44108711.6@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ftrace was one of the last W^X violators; these patches move it over to the
generic text_poke() interface and thereby get rid of this oddity.


