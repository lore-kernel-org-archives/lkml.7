Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2184C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F4B206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555474767;
	bh=bspQzlGo9EynIWDSkYCI8MXcWsaNVw/Z8IDPpae7Bq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zdXczyF9bVN/Vb0SXl0PDArcI6rAStJ5gT0zh1W8DGXSuIM9jgC0uiCQ5tR9WWZD7
	 U5ODoQMqbzMO3KrDnBiVvho6bT53s8Cdea7v6VyKyJ4JjufkSAp20AB/5a/Q0s0vBI
	 qaT6g8LtpUthW61doo7s3GPJIyz0nqkHZYXbzQWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfDQET0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 00:19:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfDQET0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 00:19:26 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 95213D81;
        Wed, 17 Apr 2019 04:19:24 +0000 (UTC)
Date:   Tue, 16 Apr 2019 21:19:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2] panic: add an option to replay all the printk
 message in buffer
Message-Id: <20190416211922.d3c9c6987f0b992da343be52@linux-foundation.org>
In-Reply-To: <20190410153718.22905-1-feng.tang@intel.com>
References: <20190410153718.22905-1-feng.tang@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 23:37:18 +0800 Feng Tang <feng.tang@intel.com> wrote:

> Currently on panic, kernel will lower the loglevel and print out
> new printk msg only with console_flush_on_panic().
> 
> Add an option for users to configure the "panic_print" to see
> all dmesg in buffer, some of which they may have never seen due
> to the loglevel setting, which will help debugging too.
> 
> Thanks to Petr Mladek as somes codes come directly from the sample
> code in his review comments.

CONFIG_PRINTK=n:

kernel/printk/printk.c: In function console_unlock:
kernel/printk/printk.c:2419:11: warning: __builtin_memcpy writing 27 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
    len += sprintf(text + len,
           ^~~~~~~~~~~~~~~~~~~
            "Replaying the entire log:\n");
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

because LOG_LINE_MAX=0 and PREFIX_MAX=0.


Which is interesting.  The pre-existing

			len = sprintf(text,
				      "** %llu printk messages dropped **\n",
				      log_first_seq - console_seq);

in console_unlock() has the same issue, but the compiler doesn't seem
to want to warn.

(Also, using sprintf() is a bit lame for the new message - could use
strlcpy()).

I'll drop the patch for now - we don't want that warning to come out. 
console_unlock() needs some fixing for the CONFIG_PRINTK=n case.

