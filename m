Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EBFC04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 03:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814C8217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 03:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559099948;
	bh=jE0bNLaY53Z8nSUY6OlnLjAN+ljsrbXhvZ38e1WAjwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jys4Jb1S9qBuPpiTBZTlmKrjnD4ix7fd1F6ORh0ievwgvTpsUTkvI2Srbw3aql9+i
	 XlOMLWHJblkcYypvUW5Nx3u0JGuxvunzV49GE1asyZ3SwcKEYh24ERav826vTB0N5Y
	 3tPRnL9ivXseeWOnkNEoBf91qjKW6A9wgf0OQjm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfE2DTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 23:19:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfE2DTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 23:19:07 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 927352173B;
        Wed, 29 May 2019 03:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559099946;
        bh=jE0bNLaY53Z8nSUY6OlnLjAN+ljsrbXhvZ38e1WAjwE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KI/PZTV86LTUcP5/Gx7wEH90yj01lgOrWLmjQH2twd7jBSscERnYIsZuLRYM+RbFC
         h75NCqTgFnpWugEO9dOCFCHNTF1m76GxQnfmljvLHmW8UhBaQAOkbDY5AlmiYu8klV
         SRi1tJQPFBMutzkdRGAkIc4eCwHXtRucqHbbETok=
Date:   Tue, 28 May 2019 20:19:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpumask: Remove error message and backtrace on
 out-of-memory condition
Message-Id: <20190528201906.c0a5fb647b070c462bd7de1e@linux-foundation.org>
In-Reply-To: <20190527122958.6667-1-geert+renesas@glider.be>
References: <20190527122958.6667-1-geert+renesas@glider.be>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2019 14:29:58 +0200 Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> There is no need to print an error message and backtrace if
> kmalloc_node() fails, as the memory allocation core already takes care
> of that.
> 
> ...
>
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -114,13 +114,6 @@ bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node)
>  {
>  	*mask = kmalloc_node(cpumask_size(), flags, node);
>  
> -#ifdef CONFIG_DEBUG_PER_CPU_MAPS
> -	if (!*mask) {
> -		printk(KERN_ERR "=> alloc_cpumask_var: failed!\n");
> -		dump_stack();
> -	}
> -#endif
> -
>  	return *mask != NULL;
>  }
>  EXPORT_SYMBOL(alloc_cpumask_var_node);

Well, not really - as it stands CONFIG_DEBUG_PER_CPU_MAPS=y can override a
caller's __GFP_NOWARN.

I wonder if anyone ever sets CONFIG_DEBUG_PER_CPU_MAPS any more...
