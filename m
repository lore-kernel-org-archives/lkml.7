Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9260BC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575B42070B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YbrRCa3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbfFSLYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:24:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50094 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfFSLYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fylzs5dNL3OKhlXewZ+EVbIKCGZknynksWeV2gQQNEw=; b=YbrRCa3VRK84HVN1OFgwF9tvG
        9aA97HcCpZyg5YKT+awTQmX9xBgsGDXsg4w+fKGw873K6vLAYNC7RdeEQbOd3uFTEv8zaBWsWnnBx
        qZQUaycpSuLqmqSdoDFUmzB3avWgv/MYya7W9M6QrLSrxdosGNVVAJSVCPnXMQKOzZK9c72NUtERw
        o+LGzJBXdXaF9vkl4PU6ZQ2+/HKezwQG4VqSsFH1iadXeRuCzE3xwsFROIiB848TwzNTOTVvLnq5m
        qhSJMlHZTReIPoQMSjCC3Qjk67Y4Cvn21hldwCFydFaHtbreBv/A1JwkY4cak+DtnnUy8Kv8+1Lx6
        c81zZIJWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdYgx-00060Q-P3; Wed, 19 Jun 2019 11:23:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 202D8201F98FC; Wed, 19 Jun 2019 13:23:50 +0200 (CEST)
Date:   Wed, 19 Jun 2019 13:23:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [RFC][PATCH] module: Propagate MODULE_STATE_COMING notifier
 errors
Message-ID: <20190619112350.GN3419@hirez.programming.kicks-ass.net>
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
> > @@ -3780,7 +3781,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
> >  
> >  	err = prepare_coming_module(mod);
> >  	if (err)
> > -		goto bug_cleanup;
> > +		goto coming_cleanup;
> 
> Not good. klp_module_going() is not prepared to be called without 
> klp_module_coming() succeeding. "Funny" things might happen.

Bah, I did look at that but failed to spot it :/

> So it calls for more fine-grained error handling.

Another approach that I considered was trying to re-iterate the notifier
list up until the point we got, but that was fairly non-trivial and
needed changes to the notifier crud itself.

I'll try again.
