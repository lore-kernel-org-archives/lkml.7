Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39248C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1554021773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbfDQNoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:44:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbfDQNoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:44:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C1B220872;
        Wed, 17 Apr 2019 13:44:32 +0000 (UTC)
Date:   Wed, 17 Apr 2019 09:44:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v7 02/10] vsprintf: Consistent %pK handling for
 kptr_restrict == 0
Message-ID: <20190417094430.6a490eee@gandalf.local.home>
In-Reply-To: <20190417115350.20479-3-pmladek@suse.com>
References: <20190417115350.20479-1-pmladek@suse.com>
        <20190417115350.20479-3-pmladek@suse.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 13:53:42 +0200
Petr Mladek <pmladek@suse.com> wrote:

> restricted_pointer() pretends that it prints the address when kptr_restrict
> is set to zero. But it is never called in this situation. Instead,
> pointer() falls back to ptr_to_id() and hashes the pointer.
> 
> This patch removes the potential confusion. klp_restrict is checked only
> in restricted_pointer().
> 
> It actually fixes a small race when the address might get printed unhashed:
> 
> CPU0                            CPU1
> 
> pointer()
>   if (!kptr_restrict)
>      /* for example set to 2 */
>   restricted_pointer()
> 				/* echo 0 >/proc/sys/kernel/kptr_restrict */
> 				proc_dointvec_minmax_sysadmin()
> 				  klpr_restrict = 0;
>     switch(kptr_restrict)
>       case 0:
> 	break:
> 
>     number()
> 
> Fixes: commit ef0010a30935de4e0211 ("vsprintf: don't use 'restricted_pointer()' when not restricting")
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Tobin Harding <me@tobin.cc>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  lib/vsprintf.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index eb7b4a06e1f0..2af48948a973 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -725,8 +725,8 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
>  {
>  	switch (kptr_restrict) {
>  	case 0:
> -		/* Always print %pK values */
> -		break;
> +		/* Handle as %p, hash and do _not_ leak addresses. */
> +		return ptr_to_id(buf, end, ptr, spec);
>  	case 1: {
>  		const struct cred *cred;
>  
> @@ -2041,8 +2041,6 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  			return buf;
>  		}
>  	case 'K':
> -		if (!kptr_restrict)
> -			break;
>  		return restricted_pointer(buf, end, ptr, spec);
>  	case 'N':
>  		return netdev_bits(buf, end, ptr, spec, fmt);

