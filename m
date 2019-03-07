Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C14BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEF120675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn5U/PWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfCGHaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 02:30:35 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37319 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfCGHae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 02:30:34 -0500
Received: by mail-pg1-f194.google.com with SMTP id q206so10582881pgq.4;
        Wed, 06 Mar 2019 23:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aRVJRtJSltnICo4XeANkexk67QPVIwISckjKmMuz/Lk=;
        b=nn5U/PWMrbyWSgHceJmL2yDFq0Y69YinzxOMCdyrxYl6jjnEJULLPuLNEtgp7YrDtv
         YLvsfSsSCzL5jmRuc6DQDMgQIQB89WyWrxIfWYh4+od8z4t8e0mxAslD54dKiWMD5Brj
         aUI2JsbyNpl22lcupTlsKoY/ApZlZg99JXbriYjNL3RHF0DFXahI9gE6Rdti+63gVI46
         +oJor5XrEZ4DePXqfkoXDvb/aTE9jY6mgANZZZWnBiDaN7fQ3jeUK+rmFQlYJqtHw8qz
         JgODwqcURVh9QRMRzuNupBRnMqiSOO4DABU/hkpKHaCI3ghHfg8cKpHI7mgHubulpGzY
         bJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aRVJRtJSltnICo4XeANkexk67QPVIwISckjKmMuz/Lk=;
        b=Av7gIIkEPs7Gsr2g4NwvOfFGUKnwjitKMan2366clLp2C7r9IpItQgQ3ejyIYZ9gXo
         eMrfoRpgta+8gOpk9XIlHzRCFOCqROpMZIAK238JES1LUc1OFJ9emO2ad1FS6Ws9Ys7A
         eEMkXw1NvkP9qaEhK+1SMSI93ro9in+oxgv6+v5PpwlYILgXt2nPXZmUCaHASaihZk0f
         /rqvgAwCWZjAUhjLNYjflQQtYORDZwRTnFWlKV8imB0yJFsP+S4WcBrJ7UJFNfvYmc9s
         /xny5Fg0XZz87EMZV6pLf+X6s7Ep5JJOwj5WQf2sDwGhfr0y5OrkVWjTrMVTZuXV7FSr
         4M4g==
X-Gm-Message-State: APjAAAUDu6O34CNWtF3cWluPtJoAIkMDjprR7Z9otDZ0PF07cMzb03WW
        C3DeK/0MFWJPTFbDtKWJLCXGHZ5P
X-Google-Smtp-Source: APXvYqyGDyKAUYq/LpuQ4DNzpXJzfptOYuS/BjnP2erNjH67I/CYVOgYCUY4MIUHQ5NjQLruR0fgiA==
X-Received: by 2002:a17:902:622:: with SMTP id 31mr11524119plg.31.1551943833630;
        Wed, 06 Mar 2019 23:30:33 -0800 (PST)
Received: from localhost ([175.223.39.30])
        by smtp.gmail.com with ESMTPSA id k9sm7439695pfc.57.2019.03.06.23.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 23:30:32 -0800 (PST)
Date:   Thu, 7 Mar 2019 16:30:29 +0900
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
Subject: Re: [RFC PATCH v1 19/25] printk: introduce emergency messages
Message-ID: <20190307073029.GA489@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-20-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-20-john.ogness@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/12/19 15:29), John Ogness wrote:
[..]
> +static bool console_can_emergency(int level)
> +{
> +	struct console *con;
> +
> +	for_each_console(con) {
> +		if (!(con->flags & CON_ENABLED))
> +			continue;
> +		if (con->write_atomic && level < emergency_console_loglevel)
> +			return true;
> +		if (con->write && (con->flags & CON_BOOT))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static void call_emergency_console_drivers(int level, const char *text,
> +					   size_t text_len)
> +{
> +	struct console *con;
> +
> +	for_each_console(con) {
> +		if (!(con->flags & CON_ENABLED))
> +			continue;
> +		if (con->write_atomic && level < emergency_console_loglevel) {
> +			con->write_atomic(con, text, text_len);
> +			continue;
> +		}
> +		if (con->write && (con->flags & CON_BOOT)) {
> +			con->write(con, text, text_len);
> +			continue;
> +		}
> +	}
> +}
> +
> +static void printk_emergency(char *buffer, int level, u64 ts_nsec, u16 cpu,
> +			     char *text, u16 text_len)
> +{
> +	struct printk_log msg;
> +	size_t prefix_len;
> +
> +	if (!console_can_emergency(level))
> +		return;
> +
> +	msg.level = level;
> +	msg.ts_nsec = ts_nsec;
> +	msg.cpu = cpu;
> +	msg.facility = 0;
> +
> +	/* "text" must have PREFIX_MAX preceding bytes available */
> +
> +	prefix_len = print_prefix(&msg,
> +				  console_msg_format & MSG_FORMAT_SYSLOG,
> +				  printk_time, buffer);
> +	/* move the prefix forward to the beginning of the message text */
> +	text -= prefix_len;
> +	memmove(text, buffer, prefix_len);
> +	text_len += prefix_len;
> +
> +	text[text_len++] = '\n';
> +
> +	call_emergency_console_drivers(level, text, text_len);

So this iterates the console list and calls consoles' callbacks, but what
prevents console driver to be rmmod-ed under us?

	CPU0						CPU1

	printk_emergency()				rmmod netcon
	 call_emergency_console_drivers()		
	  con_foo->flags & CON_ENABLED == 1
							unregister_console(con_foo)
							con_foo->flags &= ~CON_ENABLED
							__exit // con_foo gone ?
	  con_foo->write()

We use console_lock()/console_trylock() in order to protect the list and
console drivers; but this brings scheduler to the picture, with all its
locks.

Or am I missing something?

	-ss
