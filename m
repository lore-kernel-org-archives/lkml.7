Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E861C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD04208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561134717;
	bh=UcfMc1ASXqklmAnizKrMCBrZWJYP/6BAOOe+TG0bhw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MZ/sDLXv/YBiE3CyrNJ2mAdQK3gYeCOxwKpnMyMRTpLORPiERU/IxhwEk3A36Mf2H
	 jgGsn6VeetwXG7yf0Q0SyIpzo/IyKHRH8AYjJglD8h+TVDLxpJhNWfQ7Dmq1I8d6K1
	 g7N0RVhh+9CXIN5OG+bT/7MsYqq3RXiCOEoDbVvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfFUQby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfFUQbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:31:53 -0400
Received: from linux-8ccs (ip5f5adbc0.dynamic.kabel-deutschland.de [95.90.219.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3874620673;
        Fri, 21 Jun 2019 16:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561134712;
        bh=UcfMc1ASXqklmAnizKrMCBrZWJYP/6BAOOe+TG0bhw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1apq8T89fxZZBpaF4gUEZnjgdRJBnuMF9uzm5yssy3csi3d7C2kVFecBOXZhe814
         ATVGIVhR1TWYc0fxr6FehNFsGqL/LLXLLVYfpqqvcydjYN6XKNjUzJafFSpiRdDsH/
         mwWUIA1zZzBEPGRS3ScUA1m811gq4zGarY56MZAo=
Date:   Fri, 21 Jun 2019 18:31:46 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [RFC][PATCH] module: Propagate MODULE_STATE_COMING notifier
 errors
Message-ID: <20190621163146.GB24038@linux-8ccs>
References: <20190617090335.GX3436@hirez.programming.kicks-ass.net>
 <alpine.LSU.2.21.1906191251380.23337@pobox.suse.cz>
 <20190619112350.GN3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190619112350.GN3419@hirez.programming.kicks-ass.net>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Peter Zijlstra [19/06/19 13:23 +0200]:
>On Wed, Jun 19, 2019 at 01:12:12PM +0200, Miroslav Benes wrote:
>> > @@ -3780,7 +3781,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>> >
>> >  	err = prepare_coming_module(mod);
>> >  	if (err)
>> > -		goto bug_cleanup;
>> > +		goto coming_cleanup;
>>
>> Not good. klp_module_going() is not prepared to be called without
>> klp_module_coming() succeeding. "Funny" things might happen.
>
>Bah, I did look at that but failed to spot it :/
>
>> So it calls for more fine-grained error handling.
>
>Another approach that I considered was trying to re-iterate the notifier
>list up until the point we got, but that was fairly non-trivial and
>needed changes to the notifier crud itself.
>
>I'll try again.

Hm.. I would prefer if we didn't complicate the error handling too
much, especially since you mention it seems non-trivial, and it
doesn't look too nice. You also checked that calling the GOING without
the COMING notifiers should be safe, so I think we can keep things
simple. I tried to look at how other places in the kernel handle
blocking_notifier_call_chain() errors and the places that do look at
the error code (most invocations of blocking_notifier_call_chain()
seem to just ignore the return value) just call the opposing notifiers
(module "going" in our case) to cleanup. I also would not mind
breaking up prepare_coming_module() to refine the error handling, as I
mentioned in my other mail.

Thanks,

Jessica
