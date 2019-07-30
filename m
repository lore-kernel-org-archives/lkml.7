Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDB0C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3302D20659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564516668;
	bh=AMIbOfaH1AjrFphUogto0ZdKc3oQxfZfBT3qJGxuBng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pIhx0XmBoult8o30IJLvUVaN+yNN3gt9RgSkU7iIikvWmze0lJzrZj5k8ah8hpP3Z
	 0RO50NXwEjt9uLwdEDa0TS9ALLY28AcQYUVHpeInCGUF+V+/LVT5t9C8FHl6a/n4ZB
	 a1Tc4QTRX+2bj7ACpaMkg7Fl5Q+YsinR5VONSR2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfG3T5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:57:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47278 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfG3T5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:57:46 -0400
Received: from X1 (unknown [76.191.170.112])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9EACF3197;
        Tue, 30 Jul 2019 19:57:45 +0000 (UTC)
Date:   Tue, 30 Jul 2019 12:57:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v2] mm: kmemleak: Use mempool allocations for kmemleak
 objects
Message-Id: <20190730125743.113e59a9c449847d7f6ae7c3@linux-foundation.org>
In-Reply-To: <20190727132334.9184-1-catalin.marinas@arm.com>
References: <20190727132334.9184-1-catalin.marinas@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2019 14:23:33 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> Add mempool allocations for struct kmemleak_object and
> kmemleak_scan_area as slightly more resilient than kmem_cache_alloc()
> under memory pressure. Additionally, mask out all the gfp flags passed
> to kmemleak other than GFP_KERNEL|GFP_ATOMIC.
> 
> A boot-time tuning parameter (kmemleak.mempool) is added to allow a
> different minimum pool size (defaulting to NR_CPUS * 4).

Why would anyone ever want to alter this?  Is there some particular
misbehaviour which this will improve?  If so, what is it?

> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2011,6 +2011,12 @@
>  			Built with CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y,
>  			the default is off.
>  
> +	kmemleak.mempool=
> +			[KNL] Boot-time tuning of the minimum kmemleak
> +			metadata pool size.
> +			Format: <int>
> +			Default: NR_CPUS * 4
> +

This is the only documentation we provide people and it doesn't really
explain anything at all.  IOW, can we do a better job of explaining all this
to the target audience?

Why does the min size need to be tunable anyway?

