Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A68ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 02:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D74E222C6
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 02:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571450734;
	bh=8nWcylZqHzMVIk7uB0sGYSXsSv+KJhSMGMXr6+VKXUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HYCblyzPNAi2WfvZLSWREr+08M7v3oFZ3uvMg1/QzJBahKHyCRHC4iyoDpYEhkBKc
	 k6fH6p/Y/NRWmpsOXc0pUrwJqJvvhKlvTU9k99cjoSR6Vx2ffgeIPrZa9eGRZiaVbN
	 vi09jS3C1b8p8hsJw4tdXyfZge1WFqY43vN5z3Ig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfJSCFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 22:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbfJSCFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 22:05:32 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0DB3222C5;
        Sat, 19 Oct 2019 02:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571450731;
        bh=8nWcylZqHzMVIk7uB0sGYSXsSv+KJhSMGMXr6+VKXUs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gXGHd6V2r2kqj8KD8t2ZwllUYgynkGbAtBTFJlcJx37APcKsa7K2PPhpLUNTUdEMO
         3T35YRTiEbpPqCNtPSZ2njwBHxg2xZ27d5WA1vMWuXVfQfi3hDA+RO5kT/Ri/EIrce
         BUbTmyhIrWG7ofHc0GVI0VTSsY2d1MCRV43+vknw=
Date:   Fri, 18 Oct 2019 19:05:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 2/2] mm/memory-failure.c: Don't access uninitialized
 memmaps in memory_failure()
Message-Id: <20191018190531.975b70fabdce5f7e5d6b27df@linux-foundation.org>
In-Reply-To: <134d4f03-a40a-fe62-fb93-53d209a91d2e@redhat.com>
References: <20191009142435.3975-1-david@redhat.com>
        <20191009142435.3975-3-david@redhat.com>
        <20191010002619.GB3585@hori.linux.bs1.fc.nec.co.jp>
        <134d4f03-a40a-fe62-fb93-53d209a91d2e@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 09:17:42 +0200 David Hildenbrand <david@redhat.com> wrote:

> >> -	pgmap = get_dev_pagemap(pfn, NULL);
> >> -	if (pgmap)
> >> -		return memory_failure_dev_pagemap(pfn, flags, pgmap);
> >> -
> >> -	p = pfn_to_page(pfn);
> > 
> > This change seems to assume that memory_failure_dev_pagemap() is never
> > called for online pages. Is it an intended behavior?
> > Or the concept "online pages" is not applicable to zone device pages?
> 
> Yes, that's the real culprit. ZONE_DEVICE/devmem pages are never online
> (SECTION_IS_ONLINE). The terminology "online" only applies to pages that
> were given to the buddy. And as we support sup-section hotadd for
> devmem, we cannot easily make use of the section flag it. I already
> proposed somewhere to convert SECTION_IS_ONLINE to a subsection bitmap
> and call it something like pfn_active().
> 
> pfn_online() would then be "pfn_active() && zone != ZONE_DEVICE". And we
> could use pfn_active() everywhere to test for initialized memmaps (well,
> besides some special cases like device reserved memory that does not
> span full sub-sections). Until now, nobody volunteered and I have other
> things to do.

Is it worth a code comment or two to make this clearer?
