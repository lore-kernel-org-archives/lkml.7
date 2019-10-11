Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285ACC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 22:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD50F2196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 22:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570832197;
	bh=M1UCWtUQBgIjYG4651k6EPCtET4bBtdbxlyASuHK0mo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IEzxDfx74HSqIa/911xfsZkA8id04oqRL/ttr/mmQ+DZmpnrzdF/TsVUpaFP3zJuo
	 L8reIKqIgJWRvKWS9t9G/xb58HtDhNe1GlIUmKZztYvJUI+nE9MDQhN3DRtoHpAoAc
	 +wgg7ZeTcM9Phbutax3qyyq8nZRa6Q/wKYIrZ+b8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfJKWQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 18:16:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729124AbfJKWQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 18:16:35 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A53F9206CD;
        Fri, 11 Oct 2019 22:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570832195;
        bh=M1UCWtUQBgIjYG4651k6EPCtET4bBtdbxlyASuHK0mo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CPXMhtAQCg6yCVsqHqY7yrIWbqdBfmUiop4Rh8U1wiqL+qqTxu2kcQyM0ztXuLOi9
         gcrmh6X3VluuEsKamMJVzIlILQjiX8ukDnY4x1wSAnsZEyKPZZ1vsEXEk4+6/KtU1b
         /cP8xYxgIvk2o3RrgxFPDoJdCmJkJWhCofl1nW9U=
Date:   Fri, 11 Oct 2019 15:16:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v1] drivers/base/memory.c: Don't access uninitialized
 memmaps in soft_offline_page_store()
Message-Id: <20191011151634.0b566c9e32e8d0e11181d025@linux-foundation.org>
In-Reply-To: <20191010141200.8985-1-david@redhat.com>
References: <20191010141200.8985-1-david@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 16:12:00 +0200 David Hildenbrand <david@redhat.com> wrote:

> Uninitialized memmaps contain garbage and in the worst case trigger kernel
> BUGs, especially with CONFIG_PAGE_POISONING. They should not get
> touched.
> 
> Right now, when trying to soft-offline a PFN that resides on a memory
> block that was never onlined, one gets a misleading error with
> CONFIG_PAGE_POISONING:
>   :/# echo 5637144576 > /sys/devices/system/memory/soft_offline_page
>   [   23.097167] soft offline: 0x150000 page already poisoned
> 
> But the actual result depends on the garbage in the memmap.
> 
> soft_offline_page() can only work with online pages, it returns -EIO in
> case of ZONE_DEVICE. Make sure to only forward pages that are online
> (iow, managed by the buddy) and, therefore, have an initialized memmap.
> 
> Add a check against pfn_to_online_page() and similarly return -EIO.
> 
> Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online") # visible after d0dc12e86b319

Should this be cc:stable?

What is the relationship between this and some similar fixes in the
series "mm/memory_hotplug: Shrink zones before removing memory", v6?

Should any of the patches in "mm/memory_hotplug: Shrink zones before
removing memory", v6 be cc:stable?

