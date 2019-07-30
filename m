Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919DDC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6861A20679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfG3AQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 20:16:40 -0400
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:51011 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728195AbfG3AQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 20:16:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 25656100E86C2;
        Tue, 30 Jul 2019 00:16:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: duck20_742442808ff0f
X-Filterd-Recvd-Size: 2479
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue, 30 Jul 2019 00:16:37 +0000 (UTC)
Message-ID: <5dee05d6cb8498b3e636f5e8a62da673334cb5a9.camel@perches.com>
Subject: Re: [PATCH 08/12] printk: Replace strncmp with str_has_prefix
From:   Joe Perches <joe@perches.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Date:   Mon, 29 Jul 2019 17:16:35 -0700
In-Reply-To: <20190729151505.9660-1-hslester96@gmail.com>
References: <20190729151505.9660-1-hslester96@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-29 at 23:15 +0800, Chuhong Yuan wrote:
> strncmp(str, const, len) is error-prone.
> We had better use newly introduced
> str_has_prefix() instead of it.
[]
> diff --git a/kernel/printk/braille.c b/kernel/printk/braille.c
[]
> @@ -11,10 +11,10 @@
>  
>  int _braille_console_setup(char **str, char **brl_options)
>  {
> -	if (!strncmp(*str, "brl,", 4)) {
> +	if (str_has_prefix(*str, "brl,")) {
>  		*brl_options = "";
>  		*str += 4;
> -	} else if (!strncmp(*str, "brl=", 4)) {
> +	} else if (str_has_prefix(*str, "brl=")) {
>  		*brl_options = *str + 4;

Better to get rid of the += 4 uses too by storing the result
of str_has_prefix and using that as the addend.

Perhaps
	size_t len;

	if ((len = str_has_prefix(*str, "brl,"))) {
		*brl_options = "";
		*str += len;
	} else if ((len = str_has_prefix(*str, "brl="))) {
		etc...

>  		*str = strchr(*brl_options, ',');
>  		if (!*str) {
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
[]
> @@ -121,13 +121,13 @@ static int __control_devkmsg(char *str)
>  	if (!str)
>  		return -EINVAL;
>  
> -	if (!strncmp(str, "on", 2)) {
> +	if (str_has_prefix(str, "on")) {
>  		devkmsg_log = DEVKMSG_LOG_MASK_ON;
>  		return 2;
> -	} else if (!strncmp(str, "off", 3)) {
> +	} else if (str_has_prefix(str, "off")) {
>  		devkmsg_log = DEVKMSG_LOG_MASK_OFF;
>  		return 3;
> -	} else if (!strncmp(str, "ratelimit", 9)) {
> +	} else if (str_has_prefix(str, "ratelimit")) {
>  		devkmsg_log = DEVKMSG_LOG_MASK_DEFAULT;
>  		return 9;
>  	}

here too.


