Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35373C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCF1206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfDZHti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:49:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:38150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbfDZHti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:49:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C2552AEFF;
        Fri, 26 Apr 2019 07:49:36 +0000 (UTC)
Date:   Fri, 26 Apr 2019 09:49:34 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v4] panic: add an option to replay all the printk message
 in buffer
Message-ID: <20190426074934.seje2tn5p6fsuwaq@pathway.suse.cz>
References: <1556199137-14163-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556199137-14163-1-git-send-email-feng.tang@intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-04-25 21:32:17, Feng Tang wrote:
> Currently on panic, kernel will lower the loglevel and print out
> pending printk msg only with console_flush_on_panic().
> 
> Add an option for users to configure the "panic_print" to replay
> all dmesg in buffer, some of which they may have never seen due
> to the loglevel setting, which will help panic debugging .
> 
> @@ -2539,6 +2540,11 @@ void console_flush_on_panic(void)
>  	 */
>  	console_trylock();
>  	console_may_schedule = 0;
> +
> +	if (mode == CONSOLE_REPLAY_ALL) {
> +		console_seq = log_first_seq;
> +		console_idx = log_first_idx;

Ah, log_first_seq and log_first_idx are synchronized by
logbuf_log.

console_flush_on_panic(CONSOLE_REPLAY_ALL) is called
when only one CPU is running but it is not guaranteed.

Therefore we should use:

	if (mode == CONSOLE_REPLAY_ALL) {
		unsigned long flags;

		logbuf_lock_irqsave(flags);
		console_seq = log_first_seq;
		console_idx = log_first_idx;
		logbuf_unlock_irqrestore(flags);
	}

I am really sorry that I have missed it yesterday.

Anyway, with the above locking, feel free to add:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
