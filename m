Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE7FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E072077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CGKMLquy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbfDXTyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:54:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35536 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732031AbfDXTyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=99fgFGmI2RlIMaGJ8cuAyYvlGKed2b+6TTuCu4KQIO8=; b=CGKMLquyZfNEhXnFLV4HUFDIy
        o4pkXF6Iw8P6YimY3BEVLUhAEKL4ZIzbpnyl8u1RbN/ThMe8/FchPrek38xUzOvQoEJoI9NaBLviR
        X5Xd0P3skHP4RE7wrWpSOBGNPYQMYvipotbsZp9jcUARHZofJIBNULi4dLyGEU42UrE0UPcZHOBsz
        A0IzsvVfxa1t94jYvGQRqfvNvyYniHsp80j1Mjs2D8fFzs8UVhLXbGgiO32Nx5MS+0stEI/MLJgHR
        6ofN81Qzl0wEg+Bhw9gpRd9/KwXPLnOB+X+wa+OZXX5eUOEeMDgFZd2vmdusQ5qlUZOXoyyMsfbOD
        7tuovjo3g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJNya-0007x4-FC; Wed, 24 Apr 2019 19:54:40 +0000
Subject: Re: linux-next: Tree for Apr 17 (objtool)
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190417173117.196b5ac6@canb.auug.org.au>
 <7114e2f5-0c1f-c5e4-177c-2a5c61d12d58@infradead.org>
 <20190424160357.6olyocstevbz7wnw@treble>
 <20190424162209.GQ11158@hirez.programming.kicks-ass.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f430f7a9-ba11-5545-cfb6-59deb1ff8693@infradead.org>
Date:   Wed, 24 Apr 2019 12:54:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424162209.GQ11158@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 9:22 AM, Peter Zijlstra wrote:
> On Wed, Apr 24, 2019 at 11:03:57AM -0500, Josh Poimboeuf wrote:
>> On Wed, Apr 17, 2019 at 08:41:34AM -0700, Randy Dunlap wrote:
> 
>>> on x86_64:
>>>
>>>   CC      drivers/gpu/drm/i915/i915_gem_execbuffer.o
>>> drivers/gpu/drm/i915/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x18: redundant UACCESS disable
> 
>> I haven't looked at this, do you know if this is the same issue as the
>> other note from Randy, or something else?
> 
> That smells like the below commit went missing... But I cannot reproduce
> when building next/master myself.
> 

This patch is already in linux-next of today & of the reported "problem."

> ---
> commit 8f4faed01e3015955801c8ef066ec7fd7a8b3902
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Thu Feb 28 13:52:31 2019 +0100
> 
>     i915, uaccess: Fix redundant CLAC
>     
>     New tooling noticed this:
>     
>      drivers/gpu/drm/i915/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x3c: redundant UACCESS disable
>      drivers/gpu/drm/i915/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x66: redundant UACCESS disable
>     
>     You don't need user_access_end() if user_access_begin() fails.
>     
>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Cc: Borislav Petkov <bp@alien8.de>
>     Cc: Chris Wilson <chris@chris-wilson.co.uk>
>     Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>     Cc: Linus Torvalds <torvalds@linux-foundation.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Thomas Gleixner <tglx@linutronix.de>
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> diff --git a/drivers/gpu/drm/i915/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
> index 02adcaf6ebea..16f80a448820 100644
> --- a/drivers/gpu/drm/i915/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
> @@ -1667,6 +1667,7 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
>  					     len)) {
>  end_user:
>  				user_access_end();
> +end:
>  				kvfree(relocs);
>  				err = -EFAULT;
>  				goto err;
> @@ -1686,7 +1687,7 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
>  		 * relocations were valid.
>  		 */
>  		if (!user_access_begin(urelocs, size))
> -			goto end_user;
> +			goto end;
>  
>  		for (copied = 0; copied < nreloc; copied++)
>  			unsafe_put_user(-1,
> @@ -2695,7 +2696,7 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
>  		 * when we did the "copy_from_user()" above.
>  		 */
>  		if (!user_access_begin(user_exec_list, count * sizeof(*user_exec_list)))
> -			goto end_user;
> +			goto end;
>  
>  		for (i = 0; i < args->buffer_count; i++) {
>  			if (!(exec2_list[i].offset & UPDATE))
> @@ -2709,6 +2710,7 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
>  		}
>  end_user:
>  		user_access_end();
> +end:;
>  	}
>  
>  	args->flags &= ~__I915_EXEC_UNKNOWN_FLAGS;
> 


-- 
~Randy
