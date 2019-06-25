Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203D5C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA572146E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j+KwMRPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbfFYNXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:23:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41984 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfFYNXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Er+C2PKvEl/nJrxXCEOSipOUJk0fmvDq2EsmH4+cGk8=; b=j+KwMRPnq4dUxOOUVuJm3vBLp
        Yr7hRnORtM5T8FZXNeYrnzja8t5wKGncmIO+vAeotY2az3jEqz2tCz07Q/U7C9dI1dL6sWmIWoOc6
        41GmUMQjkrdfNZtjs/v/L1Gh1DhrICTQkiIhL42sZ4w8hBnDsyfdimP/vLvX72Sbx/j0nkveics04
        +QwIFZhyR6j+7iarhWArXGc50cKiAscltQIlBXfJoykuEhGISPZ7Fyn765WPx7VsSHlbywYkRoOzR
        ZZ7NGm3K4nFSfQtE8KvgzrchXvPbbnuokJM10Cn/+HMNe5VmQITEfKzxhw3+yiLLLX8FowxBeSThA
        qn/bzaw0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hflPW-0006D5-Nn; Tue, 25 Jun 2019 13:22:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ABAC5209FCA10; Tue, 25 Jun 2019 15:22:56 +0200 (CEST)
Date:   Tue, 25 Jun 2019 15:22:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, ast@kernel.org,
        daniel@iogearbox.net, akpm@linux-foundation.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Vasily Averin <vvs@virtuozzo.com>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] notifier: Fix broken error handling pattern
Message-ID: <20190625132256.GY3419@hirez.programming.kicks-ass.net>
References: <20190624091843.859714294@infradead.org>
 <20190624092109.745446564@infradead.org>
 <20190624222107.wrmtww6b2be26wwl@treble>
 <20190625073821.GQ3436@hirez.programming.kicks-ass.net>
 <20190625121334.x3dyvhwsuryxevrz@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625121334.x3dyvhwsuryxevrz@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 07:13:34AM -0500, Josh Poimboeuf wrote:
> On Tue, Jun 25, 2019 at 09:38:21AM +0200, Peter Zijlstra wrote:
> > > > @@ -156,43 +169,30 @@ int atomic_notifier_chain_unregister(str
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
> > > >  
> > > > -/**
> > > > - *	__atomic_notifier_call_chain - Call functions in an atomic notifier chain
> > > > - *	@nh: Pointer to head of the atomic notifier chain
> > > > - *	@val: Value passed unmodified to notifier function
> > > > - *	@v: Pointer passed unmodified to notifier function
> > > > - *	@nr_to_call: See the comment for notifier_call_chain.
> > > > - *	@nr_calls: See the comment for notifier_call_chain.
> > > > - *
> > > > - *	Calls each function in a notifier chain in turn.  The functions
> > > > - *	run in an atomic context, so they must not block.
> > > > - *	This routine uses RCU to synchronize with changes to the chain.
> > > > - *
> > > > - *	If the return value of the notifier can be and'ed
> > > > - *	with %NOTIFY_STOP_MASK then atomic_notifier_call_chain()
> > > > - *	will return immediately, with the return value of
> > > > - *	the notifier function which halted execution.
> > > > - *	Otherwise the return value is the return value
> > > > - *	of the last notifier function called.
> > > > - */
> > > 
> > > Why remove the useful comment?
> > 
> > Because I delete the whole function ?
> 
> I viewed it as more of a rename... Regardless would the comment not
> still be useful for the non-double-underscore version of the function?

I never got that far, I just deleted the whole thing without reading it.
But yes, with a few tweaks it should apply to the normal function.
