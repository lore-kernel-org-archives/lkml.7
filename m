Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19116C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC952084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="posuELPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfDZMzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:55:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33124 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZMzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:55:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id k19so1620362pgh.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SQzOrGUY48gjPjM3GavzO8lbkXfGYL5/14d5K1icr/M=;
        b=posuELPNjRXQRiKZ2XEmtu+3EA4l+VjZApPz+gsPz77lQ0LIa/5Byvw6eVrTpxfdTx
         Oyjb/7HnYwaLmrDAB3U+Y424KEgHk31nGcPQLTyqk/QAWwkuqdaGeMWeDoMfY16IREWH
         3draDt+v5ADJryWCHBKd9ZqtX4i1SpMeaYGEZ3s1xYlwwNL14YvAzu4siy7f2kr0My3K
         lver0M+EUq2Sz3wPDtwoz8sOiZjeWqQ2ihuZTXDMw1cAcvf+wTEQyCUlfqkqJlCAkkth
         5PBmpq12s6jYL7auYniroEam2DLHt6t7kAndT8tTzaOpzet62ElFwRPBDOyZc9mHoWwE
         imYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SQzOrGUY48gjPjM3GavzO8lbkXfGYL5/14d5K1icr/M=;
        b=Uzfniynleg1kYSPtg88cxOwnpbEhCWtnw8u0UqK/BbUa3xGNPl3gpXJEwbSwusFrvb
         zy+i+Fa/6QXQMDH6hJg6QvkMldFJy56R8ZrrD54nrUXPmheB0UVfWCwd42SCXyixzevc
         tJj+kVhaqTbo48Z+2zqhrUEMHjzNUcQoisriSgtFw05Gb1EPqvT2XIjvFAOM+N0GtTzD
         RQqtc70RUU6Pr5HeyFsSvUyzysoInTM5DrjuaxDV27uuZiSTR96Y86V/BTgdwsepihTs
         FGOI3EWFX3Ach6wjFMd1QUTmLBHMRcIWYopsf94Lja4dRe2C0P80ADC+/QlIoDqcvonY
         yfpg==
X-Gm-Message-State: APjAAAX2J9CjDU+BmrTHXYleJ74sUtyg4MFhb4Ik88isGbklYdJympm6
        UcSFzfM8TLZD6Kejd7HXvFM=
X-Google-Smtp-Source: APXvYqzOTP+S0iVOIanHXRaRlF/zrldRvy1tIJocqz1aHVkLw1zv9jhpJRORoWGdD0pz2z+HA16RSg==
X-Received: by 2002:aa7:9a9a:: with SMTP id w26mr9558179pfi.116.1556283315887;
        Fri, 26 Apr 2019 05:55:15 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id z8sm11793875pgr.10.2019.04.26.05.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 05:55:14 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 26 Apr 2019 22:53:16 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v4] panic: add an option to replay all the printk message
 in buffer
Message-ID: <20190426135316.GA505@tigerII.localdomain>
References: <1556199137-14163-1-git-send-email-feng.tang@intel.com>
 <20190426074934.seje2tn5p6fsuwaq@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426074934.seje2tn5p6fsuwaq@pathway.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/26/19 09:49), Petr Mladek wrote:
> On Thu 2019-04-25 21:32:17, Feng Tang wrote:
> > Currently on panic, kernel will lower the loglevel and print out
> > pending printk msg only with console_flush_on_panic().
> > 
> > Add an option for users to configure the "panic_print" to replay
> > all dmesg in buffer, some of which they may have never seen due
> > to the loglevel setting, which will help panic debugging .
> > 
> > @@ -2539,6 +2540,11 @@ void console_flush_on_panic(void)
> >  	 */
> >  	console_trylock();
> >  	console_may_schedule = 0;
> > +
> > +	if (mode == CONSOLE_REPLAY_ALL) {
> > +		console_seq = log_first_seq;
> > +		console_idx = log_first_idx;
> 
> Ah, log_first_seq and log_first_idx are synchronized by
> logbuf_log.
> 
> console_flush_on_panic(CONSOLE_REPLAY_ALL) is called
> when only one CPU is running but it is not guaranteed.
> 
> Therefore we should use:
> 
> 	if (mode == CONSOLE_REPLAY_ALL) {
> 		unsigned long flags;
> 
> 		logbuf_lock_irqsave(flags);
> 		console_seq = log_first_seq;
> 		console_idx = log_first_idx;
> 		logbuf_unlock_irqrestore(flags);
> 	}

I thought about it, and I don't think I see how we can race with
anything here.

Suppose we have panic on CPUA and cactive CPUB in console_unlock():

- if it's not in atomic context, then the moment it does

	call_console_drivers();
	printk_safe_exit_irqrestore(flags);  << IPI

  IPI will take it down.

- If IPI doesn't take it down, then NMI will.

- But, more importantly, if that CPUB is in atomic context, then panic
  CPUA will spin, waiting for that CPUB to handoff printing, before
  panic CPU will even try to stop all CPUs.

	pr_emerg("Kernel panic - not syncing: %s\n", buf)

  is the point of 'synchronization' - panic CPU will wait for
  current console owner.

  Hmm, we might have a bit of a problem here, maybe.

	-ss
