Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC13C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FB92084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfDZRCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbfDZRCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:02:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 876DF206E0;
        Fri, 26 Apr 2019 17:02:06 +0000 (UTC)
Date:   Fri, 26 Apr 2019 13:02:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <geert+renesas@glider.be>,
        <me@tobin.cc>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -next] lib/vsprintf: Make function pointer_string static
Message-ID: <20190426130204.23a5a05c@gandalf.local.home>
In-Reply-To: <20190426164630.22104-1-yuehaibing@huawei.com>
References: <20190426164630.22104-1-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Apr 2019 00:46:30 +0800
Yue Haibing <yuehaibing@huawei.com> wrote:

> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warning:
> 
> lib/vsprintf.c:673:6: warning:
>  symbol 'pointer_string' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  lib/vsprintf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 1f367f3..7b0a614 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -670,8 +670,9 @@ char *string(char *buf, char *end, const char *s,
>  	return string_nocheck(buf, end, s, spec);
>  }
>  
> -char *pointer_string(char *buf, char *end, const void *ptr,
> -		     struct printf_spec spec)
> +static char *pointer_string(char *buf, char *end,

Looks like commit "vsprintf: Do not check address of well-known
strings" removed the: "static noinline_for_stack"

Does pointer_string() need that still?

Petr?

-- Steve


> +			    const void *ptr,
> +			    struct printf_spec spec)
>  {
>  	spec.base = 16;
>  	spec.flags |= SMALL;

