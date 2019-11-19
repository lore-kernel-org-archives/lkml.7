Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E0EC33C9D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D36321783
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574151525;
	bh=hfhRKExvnL3vbvgXdPBSs3TbubqDXJUegOtNtbbnM5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RN/st/DlxT1pTFgT0wDYkPvVQkxdxYT4d3GcWyZqr1RO9Adz6u5CzDIA/EkmOgo8h
	 DFr3NLTwEw/DlYezXNBBsgSO8a0C7xXfuOYNBugiTPlXJXjqCYH/y9b84eJUhLDHyn
	 DcN8bJ+QE6xIoBWiUEx8KiN15O1NVfAEJXduq+D0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfKSISo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 03:18:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47071 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfKSIRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 03:17:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id b3so22643274wrs.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 00:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jdp3g9QdNAKIEGud8cTvlCowpSkciSKLnJ1eo5qlpIk=;
        b=XtT/XpUBpjULz+i8+i7Hgw05xUPV0cJOEcfl+sg8RVjHEc3DVjICU8EZCrZoBKKp8S
         ITnTBVAs1Mf2JCTm3xHVoqqYnS6SwuCMHPNbyOO0y/ljwyvcO/aukdIq7rrTCpH9t2i4
         4elxHE/sPZBMRQmoW4pqDEPnKTDF3QUM0xuQPmZAypFKBc0r7aU50RZvnqdGYenf1irG
         GD4tiPHYHc/GoX2UeoaSLky4YR/q0WQKA5Ib1dOicPPgJhvUutrmVInw6/xtbOnaEWkA
         UOaSDvQmSnvT3rbhJNB9Dj0aS0Qj9V/7PDqIKz4UTxLxOXSMtoMM3o0s+UhuYU6MWEM4
         weBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jdp3g9QdNAKIEGud8cTvlCowpSkciSKLnJ1eo5qlpIk=;
        b=fh3xTY9X7KXw9N5AleEm6VrKQrPhZKiUycVTg53P3Tz8FlD4JymEdpY/OA2/hOoFwy
         sCMz4eEPXTdtfHjp4c60EPhFacfcUybCO2tZp+lvW5QLOsEf4n7CqJFGmyitMH65gSx/
         ZI2mTBWBJAQ/gbyrLH1PSau3KKy7oGt1CImHQ0G4RKrf5R4Vtn3vnq7nb/0hti5HY+Ph
         sIMEJlxDTg9Y56C7mVncV7cKfpAdJgK2W9TEJByMPByya9u071zzPYkxs9XV4Slc2JZn
         b+h/YSleuYK7Fx7DHNCbZb3Os7gdjwWjTxuoomeQG0yZWmbWocppHjFygVGaL8DzaoT7
         E3yg==
X-Gm-Message-State: APjAAAWT0oXRoSBb97/W7vW3RD0VlB0kBG9K223jjG3qstgtSepadbjq
        XfLABrkj2zkjWdEgQKEfMI4=
X-Google-Smtp-Source: APXvYqwz/1MBn9VUTjlBhIbUUyQ8M9HhjHO9UNm3xwzbJ18VcujILK1Ue2dpOxznadZiH2PJbk5BVg==
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr523852wrn.377.1574151428396;
        Tue, 19 Nov 2019 00:17:08 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 11sm2226125wmi.8.2019.11.19.00.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 00:17:07 -0800 (PST)
Date:   Tue, 19 Nov 2019 09:17:05 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     tglx@linutronix.de, peterz@infradead.org, bp@alien8.de,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 4/4] x86/mm, pat:  Rename pat_rbtree.c to pat_interval.c
Message-ID: <20191119081705.GA62028@gmail.com>
References: <20191021231924.25373-1-dave@stgolabs.net>
 <20191021231924.25373-5-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021231924.25373-5-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Davidlohr Bueso <dave@stgolabs.net> wrote:

> Considering the previous changes, this is a more proper name.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  arch/x86/mm/{pat_rbtree.c => pat_interval.c} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename arch/x86/mm/{pat_rbtree.c => pat_interval.c} (100%)
> 
> diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_interval.c
> similarity index 100%
> rename from arch/x86/mm/pat_rbtree.c
> rename to arch/x86/mm/pat_interval.c

For some reason this patch was missing the kbuild adjustment for the 
rename of the .c file:

--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -23,7 +23,7 @@ CFLAGS_mem_encrypt_identity.o	:= $(nostackp)
 
 CFLAGS_fault.o := -I $(srctree)/$(src)/../include/asm/trace
 
-obj-$(CONFIG_X86_PAT)		+= pat_rbtree.o
+obj-$(CONFIG_X86_PAT)		+= pat_interval.o
 
 obj-$(CONFIG_X86_32)		+= pgtable_32.o iomap_32.o
 

Thanks,

	Ingo
