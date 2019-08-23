Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAB5C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 22:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B761F21019
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 22:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566600296;
	bh=fFvje1qpo1eY2QTU8IwCjfW86qCM3kOhRzG6iXlRJvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iG6bISef3qNmk3pskvWlF1mbpuUOcuS9wWU9UKCtmYb/ALM7uMd2x2BJ2ujQzNWX8
	 cDxo79kOjRIp5/zW+iskIouryMBmyl+ZEIrGXNaACDMXWR8HSSy77Rw0i7TVbeC2h+
	 3KN/9Fz/OmvTBtp7PqfqU2W3Ya5vDUzZaldqH2pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfHWWoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 18:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfHWWoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 18:44:08 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CB1A21019;
        Fri, 23 Aug 2019 22:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566600247;
        bh=fFvje1qpo1eY2QTU8IwCjfW86qCM3kOhRzG6iXlRJvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HvKA8x9/Jh1X1J3OgdWjZPZjkGfnuxKDsbyurtFWMHjibm6ytbhZL5VfGA+dJgPWS
         1NX+tRja2MLnl/k65RaRiAhzNPjf/RgSdJlGNqhhhCoet3q4R8GiFc3Ui0r3JfeVsr
         alYAD8EUtBzzHq4K9D9IRAcmHiHe0cRKptYWvbxg=
Date:   Sat, 24 Aug 2019 00:44:05 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 26/38] posix-cpu-timers: Make expiry checks array based
Message-ID: <20190823224404.GG18880@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192921.695481430@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192921.695481430@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:13PM +0200, Thomas Gleixner wrote:
> The expiry cache is an array indexed by clock ids. The new sample functions
> allow to retrieve a corresponding array of samples.
> 
> Convert the fastpath expiry checks to make use of the new sample functions
> and do the comparisons on the sample and the expiry array.
> 
> Make the check for the expiry array being zero array based as well.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Just a few boring neats:

>  /**
> - * task_cputime_expired - Compare two task_cputime entities.
> + * task_cputimers_expired - Compare two task_cputime entities.

s/task_cputime/clock arrays ?

>   *
> - * @sample:	The task_cputime structure to be checked for expiration.
> - * @expires:	Expiration times, against which @sample will be checked.
> + * @samples:	Array of current samples for the CPUCLOCK clocks
> + * @expiries:	Array of expiry values for the CPUCLOCK clocks
>   *
> - * Checks @sample against @expires to see if any field of @sample has expired.
> - * Returns true if any field of the former is greater than the corresponding
> - * field of the latter if the latter field is set.  Otherwise returns false.
> + * Returns true if any mmember of @samples is greater than the corresponding

s/mmember/member

> + * member of @expiries if that member is non zero. False otherwise
>   */
> -static inline int task_cputime_expired(const struct task_cputime *sample,
> -					const struct task_cputime *expires)
> +static inline bool task_cputimers_expired(const u64 *sample, const u64 *expiries)

s/sample/samples to agree with above documented parameters.

Thanks.
