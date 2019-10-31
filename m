Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E5ECA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 04:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052FD208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 04:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572496311;
	bh=/vZVdjfx1+eTSFpDQ3YOtaUgovcc9xcDfUIxOh8R22I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MQhcy85EG0Zy/+V51zbwB6CYYmHNv9PUFH4P6Gk3+NhA/UYf0BhS0tk+fFdLktr3K
	 E3cLJGetPUNXlpWYlm/g7H00aHamDj/VrmzBCztEp7SCMooyL6VoQGWH6TCHxp/NAh
	 EE7e+v7/btl5IhZfIPneyziy4+kofWXX5dZGK1bY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfJaEbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 00:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfJaEbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 00:31:46 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75D5420862;
        Thu, 31 Oct 2019 04:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572496305;
        bh=/vZVdjfx1+eTSFpDQ3YOtaUgovcc9xcDfUIxOh8R22I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ngIQBfRVYieR754lwPCFY+0f48qLBs7EhpJ8sl+stFK9/SW4b/hfY8/JlpNlmncLH
         b86c5OrxpOlpZHy4qOuqc5SqoVTCJdu3biDQv29Bp3CmBCezR+wr0ARKym1rSDnrTh
         i76l2zZ5lxqJcM8J2tI9aUOG+M3J8kv44C7tUmNU=
Date:   Wed, 30 Oct 2019 21:31:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     lixinhai.lxh@gmail.com, vbabka@suse.cz, mhocko@suse.com,
        mgorman@techsingularity.net, stable@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Li Xinhai" <lixinhai.lxh@gmail.com>
Subject: Re: [PATCH] mm: mempolicy: fix the wrong return value and potential
 pages leak of mbind
Message-Id: <20191030213144.dd7cd8084d4171e29abba875@linux-foundation.org>
In-Reply-To: <12ac5b41-27a6-5a5b-0d07-7e9cb847829d@linux.alibaba.com>
References: <1572454731-3925-1-git-send-email-yang.shi@linux.alibaba.com>
        <12ac5b41-27a6-5a5b-0d07-7e9cb847829d@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019 11:14:58 -0700 Yang Shi <yang.shi@linux.alibaba.com> wrote:

> On 10/30/19 9:58 AM, Yang Shi wrote:
> > The commit d883544515aa ("mm: mempolicy: make the behavior consistent
> > when MPOL_MF_MOVE* and MPOL_MF_STRICT were specified") fixed the return
> > value of mbind() for a couple of corner cases.  But, it altered the
> > errno for some other cases, for example, mbind() should return -EFAULT
> > when part or all of the memory range specified by nodemask and maxnode
> > points  outside your accessible address space, or there was an unmapped
> > hole in the specified memory range specified by addr and len.
> >
> > Fixed this by preserving the errno returned by queue_pages_range().
> > And, the pagelist may be not empty even though queue_pages_range()
> > returns error, put the pages back to LRU since mbind_range() is not called
> > to really apply the policy so those pages should not be migrated, this
> > is also the old behavior before the problematic commit.
> Forgot fixes tag.
> 
> Fixes: d883544515aa ("mm: mempolicy: make the behavior consistent when 
> MPOL_MF_MOVE* and MPOL_MF_STRICT were specified")

What's the relationship between this patch and
http://lkml.kernel.org/r/201910291756045288126@gmail.com?

