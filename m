Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD16C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 19:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FEA20989
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 19:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mONh6IYP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JPDs4ghL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbfC3Tfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 15:35:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730542AbfC3Tfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 15:35:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9187160907; Sat, 30 Mar 2019 19:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553974540;
        bh=p4AR5hXP47ztUsFViQu0vH0Il83mBoYgsSHmwZpUHxE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mONh6IYPBj9Soenom0p/3gJ9zgJlOSZNVT11qrGUTwgXR2E1KBOI6mDjPoo2wUUMv
         b+QgW90PIvX7OmBcNpuywpXKJWVtTyRn7KOheBbhfdxQriNskh/U4S1kphJvoKuTFz
         nujEL3wuk7LdWRJ/Z8g9DYIyoqxQp0+HpHtfXPcY=
Received: from [10.79.169.97] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 51D02602FC;
        Sat, 30 Mar 2019 19:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553974539;
        bh=p4AR5hXP47ztUsFViQu0vH0Il83mBoYgsSHmwZpUHxE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JPDs4ghLLTy+E2QN/9k2LLi5yvWHaJv7UJjGkDqej4ZadX+sbdyrH0+IeIiypsJif
         oDy1iIMjZvbt9+j/tDflFhierlij4w6CSCTznQxFX1cSLqzMh6rR+AtI90myKIvO/7
         c/oPG7xoOYSmFAyjyKLMaZiVOqojO7heSTbkCS5I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51D02602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] [V2] x86/asm: add __user on copy_user_handle_tail()
 pointers
To:     Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, mingo@redhat.co, bp@alien8.de, hpa@zytor.com,
        torvalds@linux-foundation.org, tglx@linutronix.de
References: <20190330115624.4000-1-ben.dooks@codethink.co.uk>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <65f52f59-3513-bf53-cb73-36bad40fad2d@codeaurora.org>
Date:   Sun, 31 Mar 2019 01:05:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190330115624.4000-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/30/2019 5:26 PM, Ben Dooks wrote:
> The copy_user_handle_tail() clearly uses both from and to as pointers
> to user-space memory. This triggers sparse warning on using the calls
> to get and put to user-space. This can be fixed easily by changing the
> call to take __user annotated pointer.s
>
> arch/x86/lib/usercopy_64.c:68:21: warning: incorrect type in argument 1 (different address spaces)
> arch/x86/lib/usercopy_64.c:68:21:    expected void const volatile [noderef] <asn:1>*<noident>
> arch/x86/lib/usercopy_64.c:68:21:    got char *
> arch/x86/lib/usercopy_64.c:70:21: warning: incorrect type in argument 1 (different address spaces)
> arch/x86/lib/usercopy_64.c:70:21:    expected void const volatile [noderef] <asn:1>*<noident>
> arch/x86/lib/usercopy_64.c:70:21:    got char *to
>
>  From Linus Torvalds:
>
> On Thu, Mar 28, 2019 at 12:24 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Well, but copy_user_generic() (which ends up calling the
> copy_user_handle_tail() eventually) casts those __user pointers to
> (__force void *). Converting them back to __user looks strange to me.
>
> Linus?
>
> Well, it does that because the x86 version of copy_user_generic() can
> work in either direction, so it works when either the source or
> destination (or both) are user pointers, but they don't _have_ to be.
>
> So the "userness" of a pointer in that context is a bit ambiguous, and
> so we've picked the pointers to be just plain "void *".
>
> That said, arguably we should have gone the other way and just made
> them both "__user" pointers, and do the cast the other way around.
>
> But there's no absolutely right answer here, and nobody should ever
> use copy_user_generic() directly (ie it is very much meant to be only
> used as a internal helper for the cases that get the pointer
> annotations right).
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh


> ---
>   arch/x86/include/asm/uaccess_64.h | 2 +-
>   arch/x86/lib/usercopy_64.c        | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
> index a9d637bc301d..cbca2cb28939 100644
> --- a/arch/x86/include/asm/uaccess_64.h
> +++ b/arch/x86/include/asm/uaccess_64.h
> @@ -208,7 +208,7 @@ __copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
>   }
>   
>   unsigned long
> -copy_user_handle_tail(char *to, char *from, unsigned len);
> +copy_user_handle_tail(char __user *to, char __user *from, unsigned len);
>   
>   unsigned long
>   mcsafe_handle_tail(char *to, char *from, unsigned len);
> diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
> index ee42bb0cbeb3..aa180424e77a 100644
> --- a/arch/x86/lib/usercopy_64.c
> +++ b/arch/x86/lib/usercopy_64.c
> @@ -60,7 +60,7 @@ EXPORT_SYMBOL(clear_user);
>    * it is not necessary to optimize tail handling.
>    */
>   __visible unsigned long
> -copy_user_handle_tail(char *to, char *from, unsigned len)
> +copy_user_handle_tail(char __user *to, char __user *from, unsigned len)
>   {
>   	for (; len; --len, to++) {
>   		char c;
