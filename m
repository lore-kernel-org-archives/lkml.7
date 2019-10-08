Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C69C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D9B206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dcAWg8QQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbfJHIPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:15:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730549AbfJHIPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sh9ykIEzDZIGiyjLdhPffAiNXbo1ruICQ2cpisEDWQA=; b=dcAWg8QQ4feUcsmnPUK85ucvM
        h1AWM/e2x6RsKCdJWTalQOyQY1735NVykrYFIcX19lU0Zj/wWry+TorFKQ3QN6WiG1bideFKoFJOy
        uPZt6YFVxvU2rKLe2wIlXaS3Wa71fpqcpTeENfnIhNky0na1F4AdgieV3r8ayyNpD2jT/T+ozWupF
        v8yPAVLZ6wuleRI1WE93ae0wOHs5JknRKgp+q+X9UCIyiUHEAHOeF728CI55uW6UR1BqnXLYsE2On
        LgbCHit0tuCY+THwHBQRaD3hfKAKMNe3AiIO7XKlSx+iYBm3bXRFjsN5SnKh+MKzwrSc/6K7lCyR2
        Kxpkpzw/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHkeg-000788-6H; Tue, 08 Oct 2019 08:15:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F62E3008C1;
        Tue,  8 Oct 2019 10:14:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 511AA2022BAB2; Tue,  8 Oct 2019 10:15:35 +0200 (CEST)
Date:   Tue, 8 Oct 2019 10:15:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 4/6] x86/alternatives: Add and use text_gen_insn()
 helper
Message-ID: <20191008081535.GF2311@hirez.programming.kicks-ass.net>
References: <20191007081716.07616230.8@infradead.org>
 <20191007081945.05309765.9@infradead.org>
 <20191008152349.293e77b5315acf42f6e607ec@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008152349.293e77b5315acf42f6e607ec@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 03:23:49PM +0900, Masami Hiramatsu wrote:
> On Mon, 07 Oct 2019 10:17:20 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Provide a simple helper function to create common instruction
> > encodings.
> 
> Thanks for using correct INSN_OPCODE:)
> This looks good to me.
> 

Right, I have it on my todo list to convert all of kprobes over. But
feel tree to beat me to it :-)
