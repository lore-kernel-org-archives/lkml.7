Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D62FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12E92082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554235320;
	bh=Rt1LiUa8Y4kfG7R4e5KXDWvzs10Tt1JHkg2U6/p/E/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qNm0TA2IcJwsg9CLQRfQPsNdniuyujBsF3W4mOswrz8w/X/W2xcAFiUy6oSTY4ahZ
	 JTfJEwJc+UE9gsxuWOSo47zxf0rbUgTlhE9wDy3Jjn8rIS31qPQT8o0gdDVJHUOZr5
	 cqPfvTpCfWLNQeKB7jTptHW+Hc9DDBdzx8ipBodU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfDBUB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:01:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43206 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfDBUB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:01:56 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DC995EA8;
        Tue,  2 Apr 2019 20:01:55 +0000 (UTC)
Date:   Tue, 2 Apr 2019 13:01:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     mike.kravetz@oracle.com, n-horiguchi@ah.jp.nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: Get rid of NODEMASK_ALLOC
Message-Id: <20190402130153.338e59c6cfda1ed3ec882517@linux-foundation.org>
In-Reply-To: <20190402133415.21983-1-osalvador@suse.de>
References: <20190402133415.21983-1-osalvador@suse.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Apr 2019 15:34:15 +0200 Oscar Salvador <osalvador@suse.de> wrote:

> NODEMASK_ALLOC is used to allocate a nodemask bitmap, ant it does it by
> first determining whether it should be allocated in the stack or dinamically
> depending on NODES_SHIFT.
> Right now, it goes the dynamic path whenever the nodemask_t is above 32
> bytes.
> 
> Although we could bump it to a reasonable value, the largest a nodemask_t
> can get is 128 bytes, so since __nr_hugepages_store_common is called from
> a rather shore stack we can just get rid of the NODEMASK_ALLOC call here.
> 
> This reduces some code churn and complexity.

It took a bit of sleuthing to figure out that this patch applies to
Mike's "hugetlbfs: fix potential over/underflow setting node specific
nr_hugepages".  Should they be folded together?  I'm thinking not.

(Also, should "hugetlbfs: fix potential over/underflow setting node
specific nr_hugepages" have been -stableified?  I also think not, but I
bet it happens anyway).

