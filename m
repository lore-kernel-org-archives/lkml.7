Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8432C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B742721E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHh1FgYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfGCAc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:32:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39714 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfGCAcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:32:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id m10so305949edv.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 17:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NZtVuNGmIL9iaoOv0S9sHPsevjMvF/JVL4gPcjO5NUI=;
        b=SHh1FgYPa22DIxBnLW3RbawjFoO5Ews8pSLyOZtbQLVFUITDB/8JUBPIyVCQQqif2o
         jh0XBWcmHMPfugvHT4zk9ZjmT/ikZnm/p6VSJjTMfg4cwitT7AT/HiFcTuSR1FBLDQPa
         rBV2OXCkJgC371eYAR/rFiKQQGs535az8ojnru1tfAIBz0Fgoj2YMtZVCdSpmLxem0pq
         IlUoJcxyhGdbJq/Nszm0bvjhzXKF0PXEfoUwkQ6S1AxufB4AinVLqzLZI5XvXwBdawlg
         AaKBWT7X2DMQfSWdzKY7fMrxBY/iWG0flIV3U8h2rXGA2uCmaP3WkWxPLubhXjDjb5Y8
         CkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NZtVuNGmIL9iaoOv0S9sHPsevjMvF/JVL4gPcjO5NUI=;
        b=WvXPZRRLFXl1DVPh/OpJpUpciv92xYeWoPAoWrT4Xojk+JVL+OVsM4LQ6mW+AVVBkX
         RkRybH1orMfJOB4iNnMDi952kHMMX9lHw3f2Yl/dXpma4aJBsfDT+/Fd4YngFrbh9Mf9
         i9QfED+5MNHjWjSUiKvMuGTAPfNKriybfusUjltQG4bwaCVX/q8GiIxmy8oZImBkg9JA
         M02ifSTFJ6Qof6XmjCBjabAr5ma5mcbvpNzeZPWNgJ0PZJYHTjbbSKt6YNtntUpaCg+J
         ZRNVECBxJjKHnJ6vZppDP5PL+Q06TTKCpXf8UCQrl3VkQnd8qfHOskuw0uRBsHuRJ9QI
         fseg==
X-Gm-Message-State: APjAAAUB/bDWmuMjekCKev1QxMdzlLtRODK+r32nqgkvuNQbY2Gl1HOC
        1jDYiC8XgA1ci0Qn8pRcwEKZfXWgKys=
X-Google-Smtp-Source: APXvYqy+5foubNJ06De2DuMgU5AFGqLcI3pTtf/zTzuWwlpy+qCo7LSTAegL5DC5/UAsumZaZbpBRw==
X-Received: by 2002:a50:ec03:: with SMTP id g3mr38512006edr.233.1562109902787;
        Tue, 02 Jul 2019 16:25:02 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id s52sm135306edm.55.2019.07.02.16.25.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 16:25:01 -0700 (PDT)
Date:   Tue, 2 Jul 2019 16:24:59 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] arm64: mm: Fix dead assignment of old_pte
Message-ID: <20190702232459.GA14941@archlinux-epyc>
References: <20190702231302.60727-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702231302.60727-1-nhuck@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 04:13:02PM -0700, 'Nathan Huckleberry' via Clang Built Linux wrote:
> When analyzed with the clang static analyzer the
> following warning occurs
> 
> line 251, column 2
> Value stored to 'old_pte' is never read
> 
> This warning is repeated every time pgtable.h is
> included by another file and produces ~3500
> extra warnings.
> 
> Moving old_pte into preprocessor guard.
> 
> Cc: clang-built-linux@googlegroups.com
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index fca26759081a..42ca4fc67f27 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -238,8 +238,6 @@ extern void __sync_icache_dcache(pte_t pteval);
>  static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>  			      pte_t *ptep, pte_t pte)
>  {
> -	pte_t old_pte;
> -
>  	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
>  		__sync_icache_dcache(pte);
>  
> @@ -248,8 +246,11 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>  	 * hardware updates of the pte (ptep_set_access_flags safely changes
>  	 * valid ptes without going through an invalid entry).
>  	 */
> +	#if IS_ENABLED(CONFIG_DEBUG_VM)
> +	pte_t old_pte;
> +
>  	old_pte = READ_ONCE(*ptep);
> -	if (IS_ENABLED(CONFIG_DEBUG_VM) && pte_valid(old_pte) && pte_valid(pte) &&
> +	if (pte_valid(old_pte) && pte_valid(pte) &&
>  	   (mm == current->active_mm || atomic_read(&mm->mm_users) > 1)) {
>  		VM_WARN_ONCE(!pte_young(pte),
>  			     "%s: racy access flag clearing: 0x%016llx -> 0x%016llx",
> @@ -258,6 +259,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>  			     "%s: racy dirty state clearing: 0x%016llx -> 0x%016llx",
>  			     __func__, pte_val(old_pte), pte_val(pte));
>  	}
> +	#endif
>  
>  	set_pte(ptep, pte);
>  }
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

Hi Nathan,

This does not apply on -next because of https://git.kernel.org/arm64/c/9b604722059039a1a3ff69fb8dfd024264046024.
I would get into the habit of testing -next to see if the warning is
present there first because someone may have independently fixed it
already (I'd be surprised if it wasn't fixed by that commit from a quick
glance).

Additionally, when I do apply this patch to mainline and build, I see
the following warning:

In file included from /home/nathan/cbl/linux/arch/arm64/kernel/asm-offsets.c:10:
In file included from /home/nathan/cbl/linux/include/linux/arm_sdei.h:14:
In file included from /home/nathan/cbl/linux/include/acpi/ghes.h:5:
In file included from /home/nathan/cbl/linux/include/acpi/apei.h:9:
In file included from /home/nathan/cbl/linux/include/linux/acpi.h:34:
In file included from /home/nathan/cbl/linux/include/acpi/acpi_io.h:5:
In file included from /home/nathan/cbl/linux/include/linux/io.h:13:
In file included from /home/nathan/cbl/linux/arch/arm64/include/asm/io.h:18:
/home/nathan/cbl/linux/arch/arm64/include/asm/pgtable.h:250:8: warning: ISO C90 forbids mixing declarations and code [-Wdeclaration-after-statement]
        pte_t old_pte;
              ^
1 warning generated.

Cheers,
Nathan
