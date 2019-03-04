Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD77C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE78206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sg+XsU1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfCDHjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:39:02 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43770 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfCDHjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 02:39:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id l11so2451985pgq.10;
        Sun, 03 Mar 2019 23:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ImeATGrc/HA5GiNT/68WVUj+Vhz5vM8oxHAmuWTiKWE=;
        b=sg+XsU1e0BP/Rdj+C5onxPQm93nzcRrL8r1AxSExaoXMosx8IMQEe7uGk6BqwDX4AV
         8HLVyhW3hc44uBz7XpVut8lb0kxLW4dZyWHNdMZ5mE591DhMBYgaBCdtf0pCdYXoWVhf
         0T/r4bY9nNvCvVf0ZFR1XwzUVDxmUNWQkvCbYoSlWb5aRulimH9WZlYE1OX9sstl//Lj
         JPlDjtxDC57edOfikj9mrwq+3gDHNRO0rnWF/IqydFwwLTSXOPc8TER99mCanxNeJkTs
         N4nj86jUgrRZ4cYL0UmU2cBZfq3asCemhqoSpya9/mDJ74xeUCB6yLcEOMpGs1h6O4ag
         LkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ImeATGrc/HA5GiNT/68WVUj+Vhz5vM8oxHAmuWTiKWE=;
        b=ibxFk5Xla/3boS2n4QElbQCLMeCyYm6pGRvT1ntKQXUUIki0Bjk2gkG+nVuqRFv41X
         N5C0pgablvwP4cuTRZr/CsSDcsJpsCrj9xk1bfZ4krtmuSJ+w0DbqaEDozLKrBVkDJaq
         lt17HgZ4Dsf5B1RvevrcW6hse/ARQfJOCQM4w6jBlDtIzLKPnVxu4jemJl8Mw2dEVKp6
         rnNZmoKJE1B39LiZZq+DFeYld04v9dROh1RY3hzZOeJZPkp1jAnK5hlW47jqolC8aExg
         V71m0ffQX5dAXhs9onHZSxUVhr8NMaZ+p6G+kfA+gozcLtXCblaRBaClyRObOvz0k40p
         a2GQ==
X-Gm-Message-State: APjAAAX0tUvD8Cgqx3CK2QeK6Qmlg7+3x7G2Mi4h+uzNeulR4KAcgoNs
        JWAHwAFesbKJPxTn7w/sXG898nEw
X-Google-Smtp-Source: APXvYqyYuglzqWWG0gwB5LHo9qWpvLsUKRtpwx6aNJEaOMmDKQa8iwXiz2IWtZVd1v0RgTzAiAasKw==
X-Received: by 2002:a65:4384:: with SMTP id m4mr17161079pgp.375.1551685140931;
        Sun, 03 Mar 2019 23:39:00 -0800 (PST)
Received: from localhost ([175.223.38.45])
        by smtp.gmail.com with ESMTPSA id t4sm2953574pfh.117.2019.03.03.23.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 23:38:59 -0800 (PST)
Date:   Mon, 4 Mar 2019 16:38:56 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Message-ID: <20190304073856.GA552@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-9-john.ogness@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/12/19 15:29), John Ogness wrote:
[..]
> +	/* the printk kthread never exits */
> +	for (;;) {
> +		ret = prb_iter_wait_next(&iter, buf,
> +					 PRINTK_RECORD_MAX, &master_seq);
> +		if (ret == -ERESTARTSYS) {
> +			continue;
> +		} else if (ret < 0) {
> +			/* iterator invalid, start over */
> +			prb_iter_init(&iter, &printk_rb, NULL);
> +			continue;
> +		}
> +
> +		msg = (struct printk_log *)buf;
> +		format_text(msg, master_seq, ext_text, &ext_len, text,
> +			    &len, printk_time);
> +
> +		console_lock();
> +		if (len > 0 || ext_len > 0) {
> +			call_console_drivers(ext_text, ext_len, text, len);
> +			boot_delay_msec(msg->level);
> +			printk_delay();
> +		}
> +		console_unlock();
> +	}

This, theoretically, creates a whole new world of possibilities for
console drivers. Now they can do GFP_KERNEL allocations and stall
printk_kthread during OOM; or they can explicitly reschedule from
->write() callback (via console_conditional_schedule()) because
console_lock() sets console_may_schedule.

It's one thing to do cond_resched() (or to let preemption to take over)
after call_console_drivers() (when we are done printing a message to all
console drivers) and another thing to let preemption to take over while
we are printing a messages to the consoles. It probably would make sense
to disable preemption around call_console_drivers().

	-ss
