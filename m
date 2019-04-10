Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB04C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C898217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554881507;
	bh=jSiTYgdpPVF7YN1DVaDPZf4115qOPvk1rCMJI5B+Y8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i+ieg6kPUpu/d0GUo686mtU0RsEXVmcs4SUdGeCJoooIqTtAdv6tX7LVnDLgq+D3u
	 qONUEq6vfcpTsa6sZpwI0/F/fE9obI7xqIr8aKgQ3PGJESsYgMkHZgf0IxJ0pSz7cM
	 OOyu2LvKYws41t60H/Ls6jecQranrjM5jfUSJ45g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfDJHbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:31:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33718 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDJHbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:31:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so1655508wrp.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 00:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lkxUsR042gDEBBDHQwVljAED8SAFsJwRj7BhGYD8oFY=;
        b=bCQDNkFTcxnBkzqv7mVRRSSIeEx0rhHSaQiQ2ka/5WwUlKeyusuCAOnRjmZ7Ccvv10
         kT/Ku8NHq7DsPXSsp2/uGDRZAL0i14PT8fIep973IsVYAOLWKoM+w8cvuH0NKacVKHNw
         sQA10GOPKgeTYmisPfPz4QfebOG5L4nMIzrQx1hoNNJRavyl9xI/0twbOaYx27+Tvq7P
         rhTx84RZMLhD3B+0zpI9UswHuXatpeiLfGY9UKrfPpNEfNRqfpZGcQAzHuXzQNK5w+q6
         62WIXfBQgdL6PrUej2qgiTH5pxMbMqNPl9/xRatPdlJ1xXSDQAtrJKJxkfRqCjn4GzOo
         CDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lkxUsR042gDEBBDHQwVljAED8SAFsJwRj7BhGYD8oFY=;
        b=TKMwgHturbp8/aP2eJTbQFPXib1+S6GXQmvV2igxgebkEl81nQ+ulgl/aBwFcPKJZn
         GY3nOCKUjJ4MkAMCY/8yhUpGVL22zSIODni20n7z+FHCIKvTOQWmL5srK9+qE4bUaajO
         mg6G9fpVi7pm861yRLPfdg2Yhao9qfbhPwAZuITLXbUHsGfCYCQUPhCvGO9rlGDBu5Z0
         auqynzO/TSVNKLAroNVjOG3QqmuyVQ5SXmfvrefu0IlHMxoRnZZJQRIMeWiGJsY7iilA
         +w2wyAffbB6l7jVii+5+iOm9CGpveGkRX2bk1PH/qMSTb5RUWRcqdCKpBFJ3JQ/vB6Gd
         69pg==
X-Gm-Message-State: APjAAAVYr0qUlfWJcnHdcsJYgePyrs4fqJ2jWcF609BlUB5ejApWIlvk
        dHegqV5c1ZdHRjMCra8/eHM=
X-Google-Smtp-Source: APXvYqwlxmNalLrzOzZGGYTTw3hjAB7jWWodfDNC3lWDkPNY6QaeLunqISSV9pnK5Kq1S8yC73di/A==
X-Received: by 2002:a5d:4843:: with SMTP id n3mr20867606wrs.256.1554881503821;
        Wed, 10 Apr 2019 00:31:43 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 7sm120341732wrc.81.2019.04.10.00.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 00:31:43 -0700 (PDT)
Date:   Wed, 10 Apr 2019 09:31:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 08/10] x86-64: select DYNAMIC_DEBUG_RELATIVE_POINTERS
Message-ID: <20190410073140.GA30370@gmail.com>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
 <20190409212517.7321-9-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409212517.7321-9-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> This reduces the size of struct _ddebug from 56 to 40 bytes. There's
> one such struct for each pr_debug(), netdev_debug() etc. in a
> CONFIG_DYNAMIC_DEBUG kernel. An Ubuntu 4.15 kernel has about 2550
> entries in the __verbose section of vmlinux, amounting to ~40K
> saved. (Modules also become smaller, but it's harder to quantify how
> much that yields at runtime.)
> 
> For comparison, the __bug_table section of that Ubuntu kernel is 75576
> bytes, i.e. 6298 12-byte bug_entrys, so GENERIC_BUG_RELATIVE_POINTERS
> saves ~50K.
> 
> Due to the build-time sanity checks in asm-generic/dynamic_debug.h, we
> need to add another #undef to vclock_gettime.c.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  arch/x86/Kconfig                            | 1 +
>  arch/x86/entry/vdso/vdso32/vclock_gettime.c | 1 +
>  arch/x86/include/asm/Kbuild                 | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5ad92419be19..eb5488b4577d 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -30,6 +30,7 @@ config X86_64
>  	select SWIOTLB
>  	select X86_DEV_DMA_OPS
>  	select ARCH_HAS_SYSCALL_WRAPPER
> +	select DYNAMIC_DEBUG_RELATIVE_POINTERS

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
