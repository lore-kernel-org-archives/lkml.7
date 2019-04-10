Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65F9C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6ED217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfDJXBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:01:03 -0400
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:57931 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726023AbfDJXBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:01:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id D890E18029DB0;
        Wed, 10 Apr 2019 23:00:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: meal65_259f6336bff40
X-Filterd-Recvd-Size: 2400
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Apr 2019 23:00:58 +0000 (UTC)
Message-ID: <c8e4bd0958e7c58465a2535cb10b2ee994334045.camel@perches.com>
Subject: Re: [PATCH] afs: use correct format characters
From:   Joe Perches <joe@perches.com>
To:     Louis Taylor <louis@kragniz.eu>, dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Wed, 10 Apr 2019 16:00:56 -0700
In-Reply-To: <20190410220301.2332-1-louis@kragniz.eu>
References: <20190410220301.2332-1-louis@kragniz.eu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-10 at 23:03 +0100, Louis Taylor wrote:
> When compiling with -Wformat, clang warns:
> 
> fs/afs/flock.c:632:29: warning: format specifies type 'short' but the argument has type
>       'unsigned char' [-Wformat]
>         _leave(" = %d [%hd]", ret, fl->fl_type);

I really think this clang message should be ignored.

It's really unnecessary as every vararg argument smaller
than int size is already promoted to int.

This particular error is pedantic and has no effect
_at all_ on output or runtime.

If there was some actual mismatch between the signedness
of the argument and the format type, it could make sense.

ie:

	signed char foo = (signed char)-1;
	printk("mismatched %%d emitted as %%u: %u\n", foo);

where the output is a somewhat unexpected 4294967295

> fl_type is declared as an unsigned char unconditionally in
> include/linux/fs.h, so use the correct format characters.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Louis Taylor <louis@kragniz.eu>
> ---
>  fs/afs/flock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/afs/flock.c b/fs/afs/flock.c
> index 6a0174258382..be4c3f6a3178 100644
> --- a/fs/afs/flock.c
> +++ b/fs/afs/flock.c
> @@ -629,7 +629,7 @@ static int afs_do_getlk(struct file *file, struct file_lock *fl)
>  
>  	ret = 0;
>  error:
> -	_leave(" = %d [%hd]", ret, fl->fl_type);
> +	_leave(" = %d [%hhu]", ret, fl->fl_type);
>  	return ret;
>  }
>  

