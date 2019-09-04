Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD48C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C632168B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567622903;
	bh=y/U9awkp5NHEKyToOdNfhASID49ak7lJitv2XnwM8ig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LznO9wVQEWvLy3kIGh/nxAsL1oSV+eSatMClo/CW//RWrEncUtrLtRKsk4aGg9lYN
	 Lhk7mndWKAEtcMwFRw86RQwY11skxeciWGu0aPUS62k9g8CR9YVwnhkMMUvLTDJ6ux
	 XWFqpvFkHDBxS4R0nbJaeQ8VT6iYNocM1brrXDE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbfIDSsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:48:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730410AbfIDSsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:48:21 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03D9C2077B;
        Wed,  4 Sep 2019 18:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567622901;
        bh=y/U9awkp5NHEKyToOdNfhASID49ak7lJitv2XnwM8ig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l48eplRtfDQ9dCB0z0/vjJSBpp4+nu72sQ5JB/xFiwEi+5YkL02O902322DNOoXq0
         2o6b81X9JJkXjkuTU3+Rlwzma+WoPy3wed9pWDdYoHBGHF78R5LfS/3ZeheTMIWMgh
         bKmluPnWE7bN+EqOrCD1L/bEcjgC3ET+et+hF2Yw=
Date:   Wed, 4 Sep 2019 11:48:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     zhong jiang <zhongjiang@huawei.com>, mhocko@kernel.org,
        anshuman.khandual@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: Unsigned 'nr_pages' always larger than zero
Message-Id: <20190904114820.42d9c4daf445ded3d0da52ab@linux-foundation.org>
In-Reply-To: <5505fa16-117e-8890-0f48-38555a61a036@suse.cz>
References: <1567592763-25282-1-git-send-email-zhongjiang@huawei.com>
        <5505fa16-117e-8890-0f48-38555a61a036@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019 13:24:58 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 9/4/19 12:26 PM, zhong jiang wrote:
> > With the help of unsigned_lesser_than_zero.cocci. Unsigned 'nr_pages"'
> > compare with zero. And __get_user_pages_locked will return an long value.
> > Hence, Convert the long to compare with zero is feasible.
> 
> It would be nicer if the parameter nr_pages was long again instead of unsigned
> long (note there are two variants of the function, so both should be changed).

nr_pages should be unsigned - it's a count of pages!

The bug is that __get_user_pages_locked() returns a signed long which
can be a -ve errno.

I think it's best if __get_user_pages_locked() is to get itself a new
local with the same type as its return value.  Something like:

--- a/mm/gup.c~a
+++ a/mm/gup.c
@@ -1450,6 +1450,7 @@ static long check_and_migrate_cma_pages(
 	bool drain_allow = true;
 	bool migrate_allow = true;
 	LIST_HEAD(cma_page_list);
+	long ret;
 
 check_again:
 	for (i = 0; i < nr_pages;) {
@@ -1511,17 +1512,18 @@ check_again:
 		 * again migrating any new CMA pages which we failed to isolate
 		 * earlier.
 		 */
-		nr_pages = __get_user_pages_locked(tsk, mm, start, nr_pages,
+		ret = __get_user_pages_locked(tsk, mm, start, nr_pages,
 						   pages, vmas, NULL,
 						   gup_flags);
 
-		if ((nr_pages > 0) && migrate_allow) {
+		nr_pages = ret;
+		if (ret > 0 && migrate_allow) {
 			drain_allow = true;
 			goto check_again;
 		}
 	}
 
-	return nr_pages;
+	return ret;
 }
 #else
 static long check_and_migrate_cma_pages(struct task_struct *tsk,


