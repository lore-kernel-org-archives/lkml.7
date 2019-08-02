Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2488AC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED558206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfHBDNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 23:13:10 -0400
Received: from smtprelay0078.hostedemail.com ([216.40.44.78]:47735 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726014AbfHBDNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 23:13:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id B6B4B180295BD;
        Fri,  2 Aug 2019 03:13:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bone24_5581e2d354449
X-Filterd-Recvd-Size: 2113
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri,  2 Aug 2019 03:13:07 +0000 (UTC)
Message-ID: <df75fa45950ab7bb67da52fe4b711209790e52ef.camel@perches.com>
Subject: Re: [PATCH v2 06/10] printk: Replace strncmp with str_has_prefix
From:   Joe Perches <joe@perches.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Aug 2019 20:13:06 -0700
In-Reply-To: <20190802014718.8952-1-hslester96@gmail.com>
References: <20190802014718.8952-1-hslester96@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-02 at 09:47 +0800, Chuhong Yuan wrote:
> strncmp(str, const, len) is error-prone because len
> is easy to have typo.
> The example is the hard-coded len has counting error
> or sizeof(const) forgets - 1.
> So we prefer using newly introduced str_has_prefix
> to substitute such strncmp.
[]
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
[]
> @@ -118,18 +118,20 @@ static unsigned int __read_mostly devkmsg_log = DEVKMSG_LOG_MASK_DEFAULT;
>  
>  static int __control_devkmsg(char *str)
>  {
> +	size_t len;
> +
>  	if (!str)
>  		return -EINVAL;
>  
> -	if (!strncmp(str, "on", 2)) {
> +	if ((len = str_has_prefix(str, "on"))) {
>  		devkmsg_log = DEVKMSG_LOG_MASK_ON;
> -		return 2;
> -	} else if (!strncmp(str, "off", 3)) {
> +		return len;
> +	} else if ((len = str_has_prefix(str, "off"))) {
>  		devkmsg_log = DEVKMSG_LOG_MASK_OFF;
> -		return 3;
> -	} else if (!strncmp(str, "ratelimit", 9)) {
> +		return len;
> +	} else if ((len = str_has_prefix(str, "ratelimit"))) {
>  		devkmsg_log = DEVKMSG_LOG_MASK_DEFAULT;
> -		return 9;
> +		return len;
>  	}
>  	return -EINVAL;
>  }

All of the else uses above could also be removed.

