Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634B2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307C42087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfCHPof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:44:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:57842 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbfCHPoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:44:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 72583AFCE;
        Fri,  8 Mar 2019 15:44:32 +0000 (UTC)
Date:   Fri, 8 Mar 2019 16:44:31 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Calvin Owens <calvinowens@fb.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/4] printk: Add ability to set loglevel via "console="
 cmdline
Message-ID: <20190308154431.vutfqckuv3t57znd@pathway.suse.cz>
References: <cover.1551486732.git.calvinowens@fb.com>
 <e1311e98d6803f678cdcaa2be1cfb58d667fe3fd.1551486732.git.calvinowens@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1311e98d6803f678cdcaa2be1cfb58d667fe3fd.1551486732.git.calvinowens@fb.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-03-01 16:48:18, Calvin Owens wrote:
> This extends the "console=" interface to allow setting the per-console
> loglevel by adding "/N" to the string, where N is the desired loglevel
> expressed as a base 10 integer. Invalid values are silently ignored.
> 
> Signed-off-by: Calvin Owens <calvinowens@fb.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  6 ++--
>  kernel/printk/console_cmdline.h               |  1 +
>  kernel/printk/printk.c                        | 30 +++++++++++++++----
>  3 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 858b6c0b9a15..afada61dcbce 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -612,10 +612,10 @@
>  		ttyS<n>[,options]
>  		ttyUSB0[,options]
>  			Use the specified serial port.  The options are of
> -			the form "bbbbpnf", where "bbbb" is the baud rate,
> +			the form "bbbbpnf/l", where "bbbb" is the baud rate,
>  			"p" is parity ("n", "o", or "e"), "n" is number of
> -			bits, and "f" is flow control ("r" for RTS or
> -			omit it).  Default is "9600n8".
> +			bits, "f" is flow control ("r" for RTS or omit it),
> +			and "l" is the loglevel on [0,7]. Default is "9600n8".

We should a more detailed explanation about the loglevel semantic. It
is either minimal loglevel. Or that it overrides the global
console_loglevel if you accept my proposal.

>  
>  			See Documentation/admin-guide/serial-console.rst for more
>  			information.  See
> diff --git a/kernel/printk/console_cmdline.h b/kernel/printk/console_cmdline.h
> index 11f19c466af5..fbf9b539366e 100644
> --- a/kernel/printk/console_cmdline.h
> +++ b/kernel/printk/console_cmdline.h
> @@ -6,6 +6,7 @@ struct console_cmdline
>  {
>  	char	name[16];			/* Name of the driver	    */
>  	int	index;				/* Minor dev. to use	    */
> +	int	loglevel;			/* Loglevel to use */

The comment will be true only with the new proposal.

>  	char	*options;			/* Options for the driver   */
>  #ifdef CONFIG_A11Y_BRAILLE_CONSOLE
>  	char	*brl_options;			/* Options for braille driver */
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 6ead14f8c2bc..2e0eb89f046c 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2104,8 +2105,8 @@ __setup("console_msg_format=", console_msg_format_setup);
>  static int __init console_setup(char *str)
>  {
>  	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
> -	char *s, *options, *brl_options = NULL;
> -	int idx;
> +	char *s, *options, *llevel, *brl_options = NULL;
> +	int idx, loglevel = LOGLEVEL_EMERG;
>  
>  	if (_braille_console_setup(&str, &brl_options))
>  		return 1;
> @@ -2123,6 +2124,14 @@ static int __init console_setup(char *str)
>  	options = strchr(str, ',');
>  	if (options)
>  		*(options++) = 0;
> +
> +	llevel = strchr(str, '/');

This should be:

      if (options)
		llevel = strchr(options, '/');

> +	if (llevel) {
> +		*(llevel++) = 0;
> +		if (kstrtoint(llevel, 10, &loglevel))
> +			loglevel = LOGLEVEL_EMERG;
> +	}
> +
>  #ifdef __sparc__
>  	if (!strcmp(str, "ttya"))
>  		strcpy(buf, "ttyS0");

Best Regards,
Petr
