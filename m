Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971E9C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE8821841
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="INhcJGIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfGXQxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:53:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36944 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfGXQxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RQ7VaSAzvcmxPLciLsbioYDmZXRLn9Opl2kFM/lOf8s=; b=INhcJGIrrafQFgG1n+wzJ+ETh
        CVht9cgoNTyHPoepMSFxPV1tflMz66uqrGUV1uR0JfS8GxPDmD8Tggs3qfuRIP4VZf0Tk8NMuXI+p
        WPIrG1FNQabv6USYtcj7XFsVKZgOkxCro5twe4yhBzQDEfADlcvugKxqgUjk6isNz0ZDzBW9LIH1s
        825YtCzDNKL2Hv3TTCnpRxyrbkKtHmdTIRMywUQFM72sKCTXHWSY4wcSPMGBqMteAAx/DGyySR8SL
        GnK20iRtWZ3g3R5QzzC9dMyGYJnm8PvDYaa9nU5cv/fQzitapYiwc0GL5esOqu932hUKpqxFqCGS7
        PgPAo8obA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqKVW-00066L-Ko; Wed, 24 Jul 2019 16:52:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3BCB20288388; Wed, 24 Jul 2019 18:52:48 +0200 (CEST)
Date:   Wed, 24 Jul 2019 18:52:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        chris@chris-wilson.co.uk
Subject: Re: x86 - clang / objtool status
Message-ID: <20190724165248.GD31381@hirez.programming.kicks-ass.net>
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
 <20190724023946.yxsz5im22fz4zxrn@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724023946.yxsz5im22fz4zxrn@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 09:43:24PM -0500, Josh Poimboeuf wrote:
> On Thu, Jul 18, 2019 at 10:40:09PM +0200, Thomas Gleixner wrote:
> 
> >   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x86: redundant UACCESS disable
> 
> Looking at this one, I think I agree with objtool.
> 
> PeterZ, Linus, I know y'all discussed this code a few months ago.
> 
> __copy_from_user() already does a CLAC in its error path.  So isn't the
> user_access_end() redundant for the __copy_from_user() error path?
> 
> Untested fix:

Run this past i915 people, but with the objtool patch I just posted it
reproduces with GCC and this patch makes it go away.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> index 5fae0e50aad0..41dab9ea33cd 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -1628,6 +1628,7 @@ static int check_relocations(const struct drm_i915_gem_exec_object2 *entry)
>  
>  static int eb_copy_relocations(const struct i915_execbuffer *eb)
>  {
> +	struct drm_i915_gem_relocation_entry *relocs;
>  	const unsigned int count = eb->buffer_count;
>  	unsigned int i;
>  	int err;
> @@ -1635,7 +1636,6 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
>  	for (i = 0; i < count; i++) {
>  		const unsigned int nreloc = eb->exec[i].relocation_count;
>  		struct drm_i915_gem_relocation_entry __user *urelocs;
> -		struct drm_i915_gem_relocation_entry *relocs;
>  		unsigned long size;
>  		unsigned long copied;
>  
> @@ -1663,14 +1663,8 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
>  
>  			if (__copy_from_user((char *)relocs + copied,
>  					     (char __user *)urelocs + copied,
> -					     len)) {
> -end_user:
> -				user_access_end();
> -end:
> -				kvfree(relocs);
> -				err = -EFAULT;
> -				goto err;
> -			}
> +					     len))
> +				goto end;
>  
>  			copied += len;
>  		} while (copied < size);
> @@ -1699,10 +1693,14 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
>  
>  	return 0;
>  
> +end_user:
> +	user_access_end();
> +end:
> +	kvfree(relocs);
> +	err = -EFAULT;
>  err:
>  	while (i--) {
> -		struct drm_i915_gem_relocation_entry *relocs =
> -			u64_to_ptr(typeof(*relocs), eb->exec[i].relocs_ptr);
> +		relocs = u64_to_ptr(typeof(*relocs), eb->exec[i].relocs_ptr);
>  		if (eb->exec[i].relocation_count)
>  			kvfree(relocs);
>  	}
