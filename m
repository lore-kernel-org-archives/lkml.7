Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD7DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A12F22CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567018814;
	bh=2gaPnx7Vc1n0CsL2HRqSHouFoy8gfq91M+JgCP9XbyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ua+x1tWvoJQGsogktKmHUZcnEvGM9X6D2tffVd0ycWdppaORHQekCm7fLVwFvZKAV
	 5Jo+QnXYQsEDQmc9q1e3E/kuAGmvkO5UOsyi0lkYfS31uPOOLXd5U/GfkVGgK9jDGG
	 jB2NJw3xzbwjtbfZi/ksCCQgcedXpIepWvTnZs6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfH1TAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 15:00:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34098 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfH1TAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:00:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18so908060wrn.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XdmZGtARKaGVNuVdqzkRt4PkpnK4Z78+t/Gev6u8314=;
        b=vMDIknOd3KU31BE32YSHpbz9+A5hrcOZVyHfTqAiKzu9/UyfQce91Z5AZoxMqqBpTD
         TKbvW77HDp3a99FsSHf/tRz8FAus0pIyEopJDg65kjIctNoNiTT37jBbsllN1wDjJCwU
         VAwZWpd7F/1X9KFxvgoji0Gkk9ExGqrZAGsn4nnTP/aVl7QM036yMSfJ6i0dJRvjR5xg
         qdGinJXrlDZTn/33e4BYvTC2nQMqvHNYMk9DFhh59fhHDkM+djpElM0zluj9XxXXMgBB
         k3FbdqL6KL0TOOx4ekhcSoLLjT9KOeIhimArzrfqKL4E00mo4XY0itvBdRy+rPdfUzvF
         iPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XdmZGtARKaGVNuVdqzkRt4PkpnK4Z78+t/Gev6u8314=;
        b=q5v+SSMyAXYp+nv2MoL8+RvjnC9UQJatY7F/LfMZTWwRCOZ2Zahj5hnZ3IU7lweIFk
         gEb0oeVHqXs+E6S6lwfppKUSflXbfwoN8zznuZDDmpCahCV3iuGy6c9/UxcSEFZMz89m
         bTB4NGHdssWvGeuma7Jz+WtWkUmWQuvziN2twLhAAoEb8uW3+opC9JaAxLHGlmVFLlUs
         4HqxinsstI2A/Y+0ZRkKh9Ba9gb5j9ILnudBIhsFwRGcLIqOM7q11E+mQQobhf53sy1n
         9TPaneji9CHunH+KSMplw0D4QtPhbjvRL0KA9y+Z+aDtw4dIC38ti5ZC1CL5ebao76ao
         v2Dg==
X-Gm-Message-State: APjAAAU7MK3o31lZag9m5wpD/4gSP9Xf64mrG1eL95B5Pt13l1veX0Fx
        9M/NZ6yvOk4s9FjlXaF5zmY=
X-Google-Smtp-Source: APXvYqyVt8hqw++WTmfEZHoM0Bx8fBhH/FE9QsCAYG6BjU15bKUGjs6+5jx/kmHZ/DNjizJMwpK0ew==
X-Received: by 2002:a5d:45cb:: with SMTP id b11mr6851468wrs.117.1567018810735;
        Wed, 28 Aug 2019 12:00:10 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id k9sm25658wrq.15.2019.08.28.12.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 12:00:08 -0700 (PDT)
Date:   Wed, 28 Aug 2019 21:00:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Song Liu <songliubraving@fb.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [patch 2/2] x86/mm/pti: Do not invoke PTI functions when PTI is
 disabled
Message-ID: <20190828190006.GB77809@gmail.com>
References: <20190828142445.454151604@linutronix.de>
 <20190828143124.063353972@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828143124.063353972@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> When PTI is disabled at boot time either because the CPU is not affected or
> PTI has been disabled on the command line, the boot code still calls into
> pti_finalize() which then unconditionally invokes:
> 
>      pti_clone_entry_text()
>      pti_clone_kernel_text()
> 
> pti_clone_kernel_text() was called unconditionally before the 32bit support
> was added and 32bit added the call to pti_clone_entry_text().
> 
> The call has no side effects as cloning the page tables into the available
> second one, which was allocated for PTI does not create damage. But it does
> not make sense either and in case that this functionality would be extended
> later this might actually lead to hard to diagnose issue.

s/issue/issues

> Neither function should be called when PTI is runtime disabled. Make the
> invocation conditional.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/mm/pti.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -668,6 +668,8 @@ void __init pti_init(void)
>   */
>  void pti_finalize(void)
>  {
> +	if (!boot_cpu_has(X86_FEATURE_PTI))
> +		return;
>  	/*
>  	 * We need to clone everything (again) that maps parts of the
>  	 * kernel image.

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
