Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241DAC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5ED32082E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558129068;
	bh=aV+DZYgCxz6TeUuopFM95pRHxHKcPxgDyN99N5XYJko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ICZgZgKC2sAlc0viNP+FrQ1JzB4hpe7UR87CxxUn4aDbwGG+xk6kE/ioOTAHoofe5
	 nnQu1PFuET/wH5H3g1yCGEYDqXDOQSvvYneTXIdTSMVD+GRM9WLxhJAQ6mZsdKtuGE
	 6ZuimxKoNr7qZIduu4c8lySd01XGpETVd4WWIH1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfEQVhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 17:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfEQVhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:37:47 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E79DB20815;
        Fri, 17 May 2019 21:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558129067;
        bh=aV+DZYgCxz6TeUuopFM95pRHxHKcPxgDyN99N5XYJko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zyaA/h6aSWnQbfVIYgqsy2UrDKSlqT0fUgWvQgq/rIbENLvBDNuAhY84I4Cm0CmLD
         cPGqFAtx/nnBYevpcWHQItaMk+wpufHLo0tSppdBJA4ooerLdUqPl1v/gMovZc1ya9
         Y/ZZQIjHjuO4Er8F1QTdG0soYL1cGA93941vJyYY=
Date:   Fri, 17 May 2019 14:37:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitry Vyukov <dvyukov@gmail.com>
Cc:     catalin.marinas@arm.com, Dmitry Vyukov <dvyukov@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmemleak: fix check for softirq context
Message-Id: <20190517143746.2157a759f65b4cbc73321124@linux-foundation.org>
In-Reply-To: <20190517171507.96046-1-dvyukov@gmail.com>
References: <20190517171507.96046-1-dvyukov@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019 19:15:07 +0200 Dmitry Vyukov <dvyukov@gmail.com> wrote:

> From: Dmitry Vyukov <dvyukov@google.com>
> 
> in_softirq() is a wrong predicate to check if we are in a softirq context.
> It also returns true if we have BH disabled, so objects are falsely
> stamped with "softirq" comm. The correct predicate is in_serving_softirq().
>
> ...
> 
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -588,7 +588,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
>  	if (in_irq()) {
>  		object->pid = 0;
>  		strncpy(object->comm, "hardirq", sizeof(object->comm));
> -	} else if (in_softirq()) {
> +	} else if (in_serving_softirq()) {
>  		object->pid = 0;
>  		strncpy(object->comm, "softirq", sizeof(object->comm));
>  	} else {

What are the user-visible runtime effects of this change?
