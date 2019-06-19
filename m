Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ED1C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4A72070B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1jbBrbcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbfFSL0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:26:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58588 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731483AbfFSL0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v6YivmBrw5L1i+bfL46EzgafKRjz06uka2Dpxe2XHM8=; b=1jbBrbcVaoBCQONn9ugrpQKwH
        ASd6uzmQQCIx+nJ64oCqdwXTFA0mnZM6GnbgAaeEWuZC9kx4Ii6mEXFtiHa9/w5Opf9YzQN6tKFTc
        aTMy8h90kXE/5m1UGzTM0jRB6nqjQminh5jFI1dkDKsnYi/EfiVQoWoBhQ64yj8jOk5ojtNdiDYFl
        ibqEFLSXOC1w2MRWRLdKmriGzZ9XcNmDvC3Itpt0fG+ksdSD1roBmNNCKjFI6PAZJYYh+I1iG+xWW
        9iYdUjyxkK8fvyQfas+ESRjl08Rh8f98OvXfvILqM+NwlNvu0FXFxP3VVdt1GGyJ+ZIXCRH6l6iMh
        bVH0skLyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdYiZ-0006fG-0G; Wed, 19 Jun 2019 11:25:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 846BD20796503; Wed, 19 Jun 2019 13:25:29 +0200 (CEST)
Date:   Wed, 19 Jun 2019 13:25:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [RFC][PATCH] module: Propagate MODULE_STATE_COMING notifier
 errors
Message-ID: <20190619112529.GO3419@hirez.programming.kicks-ass.net>
References: <20190617090335.GX3436@hirez.programming.kicks-ass.net>
 <alpine.LSU.2.21.1906191251380.23337@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1906191251380.23337@pobox.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 01:12:12PM +0200, Miroslav Benes wrote:
> On Mon, 17 Jun 2019, Peter Zijlstra wrote:
> 
> > 
> > Some module notifiers; such as jump_label_module_notifier(),
> > tracepoint_module_notify(); can fail the MODULE_STATE_COMING callback
> > (due to -ENOMEM for example). However module.c:prepare_coming_module()
> > ignores all such errors, even though this function can already fail due
> > to klp_module_coming().
> 
> It does, but there is no change from the pre-prepare_coming_module() 
> times. Coming notifiers were called in complete_formation(), their return 
> values happily ignored and going notifiers not called to clean up even 
> before.

Sure; but I didn't care to look before :-) The fact that it can
currently fail means most/all the unwinding is already there and we only
need to consider the additional cases.
