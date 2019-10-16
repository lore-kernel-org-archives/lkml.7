Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50194C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259262168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZPTotc1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391499AbfJPISm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:18:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfJPISl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BG2KQ51P72J02E057kh/TAC3cIOuCZUJAMTfR0cyCPg=; b=ZPTotc1RZtAVAR1OROy+QWuZc
        OiVlbCAgKrClw75P3/JHi6jhKbMwNaqyi3qKhig3Fo8n0q5CFpSNt/8SHeNtf+w/QZZynSwWxhTTu
        HI4+oh/2KGHvqgu4QWARE0vQ/C29rRaqmmS4xFIS8SZiWlLCCrW3qXkbSJPpXlJuZW/iWxCLKhnxr
        c6WWRObEds3fN5VsqMoT+oaH29jORzWCvOhvYidMuZtFn1poNQV6iCfDgorDftUkHOXDYnKnKDg3R
        k39zfQRKm7yq+TXqQ7sy0748MnSeN1y9GI0qhWf0tDzd1daqD4OvaSgqmYZiWZsE2WXgV3uShpb3m
        kiS2tcdjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKeW0-0005IN-QN; Wed, 16 Oct 2019 08:18:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 664B03032F8;
        Wed, 16 Oct 2019 10:17:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C2C020B972E4; Wed, 16 Oct 2019 10:18:39 +0200 (CEST)
Date:   Wed, 16 Oct 2019 10:18:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 31/34] locking: Use CONFIG_PREEMPTION
Message-ID: <20191016081839.GP2328@hirez.programming.kicks-ass.net>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-32-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015191821.11479-32-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 09:18:18PM +0200, Sebastian Andrzej Siewior wrote:
> CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
> Both PREEMPT and PREEMPT_RT require the same functionality which today
> depends on CONFIG_PREEMPT.
> 
> Switch the Kconfig dependency to use CONFIG_PREEMPTION.
> 
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Assuming this is part of a larger series and you'll get it merged
elsewhere:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
