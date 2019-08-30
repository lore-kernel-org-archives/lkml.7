Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A5DC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F2423431
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfH3Vxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:53:30 -0400
Received: from smtprelay0060.hostedemail.com ([216.40.44.60]:41443 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728111AbfH3Vxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:53:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B5135181D341A;
        Fri, 30 Aug 2019 21:53:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mouth94_111052b6051b
X-Filterd-Recvd-Size: 1865
Received: from XPS-9350.home (unknown [47.151.137.30])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Aug 2019 21:53:27 +0000 (UTC)
Message-ID: <64a000cc3b0fcd7c99b5cd41b0db7f1b5e9e6db7.camel@perches.com>
Subject: Re: [PATCH] printf: add support for printing symbolic error codes
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Date:   Fri, 30 Aug 2019 14:53:25 -0700
In-Reply-To: <20190830214655.6625-1-linux@rasmusvillemoes.dk>
References: <20190830214655.6625-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-30 at 23:46 +0200, Rasmus Villemoes wrote:
> It has been suggested several times to extend vsnprintf() to be able
> to convert the numeric value of ENOSPC to print "ENOSPC". This is yet
> another attempt. Rather than adding another %p extension, simply teach
> plain %p to convert ERR_PTRs. While the primary use case is

Thanks, this all this seems reasonable except for

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
[]
> @@ -2178,8 +2204,6 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  		return flags_string(buf, end, ptr, spec, fmt);
>  	case 'O':
>  		return kobject_string(buf, end, ptr, spec, fmt);
> -	case 'x':
> -		return pointer_string(buf, end, ptr, spec);
>  	}
>  
>  	/* default is to _not_ leak addresses, hash before printing */

why remove this?

