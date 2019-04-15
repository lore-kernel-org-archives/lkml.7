Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583C8C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2583920833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oGEqHufw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfDOLvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:51:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60624 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfDOLvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rD+LbkY2ZG+QaPbYeuyF5aWKxM499TvbPvDmi83stiQ=; b=oGEqHufwCEkhgfHyULYE82IQM
        iWTDTyLKI/S6kcLXbUgWmOcl0OsbcSem7ZwZSV+23qSL4Rx25g397alw3yXf87n6uPqo53lUHGG0u
        t65ccjpzFnkC/GkPENYpkSmnT9q6g3ibIXwsKL4oq3Iacx1/X6tW9/D27B7dEADsjSQ5m7Al5L6dt
        +JTjLi80PjLt9vkHGZu5OUe73w+cQyB39AkLBkVL9p2ZSpqq0kvs139PZSDwnD6WyI590U/5+znbj
        ez5UdfgkiMdnSpVrqAjWbFDZfZjvoU/VRczBbErE1cUdsigYtdBdOliKJ57zkzBb155bCNS14GE4T
        urjSyFxFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hG08M-0000Ug-BF; Mon, 15 Apr 2019 11:50:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14C8829AC8448; Mon, 15 Apr 2019 13:50:45 +0200 (CEST)
Date:   Mon, 15 Apr 2019 13:50:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V5 6/7] jump_label: Batch updates if arch supports it
Message-ID: <20190415115045.GL11158@hirez.programming.kicks-ass.net>
References: <cover.1554106794.git.bristot@redhat.com>
 <3fbdeb0d8c19968f4a2e2af17a872a31b9a4adcf.1554106794.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fbdeb0d8c19968f4a2e2af17a872a31b9a4adcf.1554106794.git.bristot@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 10:58:18AM +0200, Daniel Bristot de Oliveira wrote:
> +int fallback_batch __read_mostly;
> +static void __jump_label_update(struct static_key *key,
> +				struct jump_entry *entry,
> +				struct jump_entry *stop,
> +				bool init)
> +{
> +	for_each_label_entry(key, entry, stop) {
> +
> +		if (!jump_label_can_update(entry, init))
> +			continue;
> +
> +		if (unlikely(fallback_batch)) {
> +			arch_jump_label_transform(entry, jump_label_type(entry));
> +			continue;
> +		}
> +
> +		if (!arch_jump_label_transform_queue(entry, jump_label_type(entry)))
> +			continue;

That reads wrong; 'if we cannot queue, continue'

> +
> +		/*
> +		 * Queue's overflow: Apply the current queue, and then try to
> +		 * queue again. If it stills fail to queue, fallback to the
> +		 * non-batch mode!
> +		 */
> +		arch_jump_label_transform_apply();
> +
> +		if (arch_jump_label_transform_queue(entry, jump_label_type(entry))) {
> +			WARN(1, "jump_label: batch mode failure!\n");
> +			fallback_batch = 1;
> +			arch_jump_label_transform(entry, jump_label_type(entry));
> +		}
> +	}
> +	arch_jump_label_transform_apply();
> +}

Hurmph...

	for_each_whatever(entry, stop, key) {
		if (!jump_label_can_update(entry, init))
			continue;

		if (!arch_jump_label_transform_queue(entry)) {
			/* queue full, flush */
			arch_jump_label_transform_apply();
			BUG_ON(!arch_jump_label_transform_queue(entry));
		}
	}
	arch_jump_label_transform_apply();

Also, see next patch.
