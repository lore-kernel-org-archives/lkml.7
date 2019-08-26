Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0935C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6776921872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566856642;
	bh=D9K92IFV4XsqcixfHYhV/oX9lfC7OT+SzS4AAi8rcJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oU/Nd17xa/uepnNov/yWhd7rwz6w+I12CF9JrtCJ2Oyrdw58ZNTvm4zLqT2iw1Qv+
	 1VRVztaSh4Dyj8S2Hqv+GGqz7jh8ftY/yqAYfjM/yJAA1zDYORxIojih+1YUbKNN1U
	 o+M5ytxAVhTzDydgqT9OlH5bAF5MYF7TGMNmHQPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfHZV5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 17:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfHZV5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 17:57:21 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2276920850;
        Mon, 26 Aug 2019 21:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566856640;
        bh=D9K92IFV4XsqcixfHYhV/oX9lfC7OT+SzS4AAi8rcJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLff1dIe8jDmY1CzJ6Vpbq9DDlJ+/QGJNLEciCOenlUYJMWcXAMLXls/mGMKhz43M
         8f8TEcR1bnZK3xWCcWNe/wxqReIAOHQ96zz3xNXw0yJgzW1mU9sDvR5IBxOiR/ncFk
         Tcb9dTv9UejSJPeCXFeI4ZwbWeurQ1DZZwphbHLk=
Date:   Mon, 26 Aug 2019 23:57:18 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 32/38] posix-cpu-timers: Get rid of zero checks
Message-ID: <20190826215717.GG14309@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192922.275086128@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192922.275086128@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:19PM +0200, Thomas Gleixner wrote:
> Deactivation of the expiry cache is done by setting all clock caches to
> 0. That requires to have a check for zero in all places which update the
> expiry cache:
> 
> 	if (cache == 0 || new < cache)
> 		cache = new;
> 
> Use U64_MAX as the deactivated value, which allows to remove the zero
> checks when updating the cache and reduces it to the obvious check:
> 
> 	if (new < cache)
> 		cache = new;
> 
> This also removes the weird workaround in do_prlimit() which was required
> to convert a RLIMIT_CPU value of 0 (immediate expiry) to 1 because handing
> in 0 to the posix CPU timer code would have effectively disarmed it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
