Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A4DECE58D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2AD207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571042358;
	bh=/iRUtYW2DqEiFpeYYYWspGOKICVFzaiC9FJCCvg2pvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=enY/TWykKcyJfY+U6WBALJE5e4XbmO6W8LLOUtwRSOwJNt50Hv3EzKg+I6T0SK4Gf
	 BLAQ6EeqBBfZILkC4hBGA6GCUA9kmrqMMgrtlxOwTI33xVVhGJZ1pzHzEGeNwbnvFZ
	 ZFbH+q+XHe24nhDltaGFdVNApW9tMhq43ZPd6IGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfJNIjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:39:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:38758 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729234AbfJNIjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:39:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A2DABB885;
        Mon, 14 Oct 2019 08:39:15 +0000 (UTC)
Date:   Mon, 14 Oct 2019 10:39:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: memory offline infinite loop after soft offline
Message-ID: <20191014083914.GA317@dhcp22.suse.cz>
References: <1570829564.5937.36.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1570829564.5937.36.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11-10-19 17:32:44, Qian Cai wrote:
> # /opt/ltp/runtest/bin/move_pages12
> move_pages12.c:263: INFO: Free RAM 258988928 kB
> move_pages12.c:281: INFO: Increasing 2048kB hugepages pool on node 0 to 4
> move_pages12.c:291: INFO: Increasing 2048kB hugepages pool on node 8 to 4
> move_pages12.c:207: INFO: Allocating and freeing 4 hugepages on node 0
> move_pages12.c:207: INFO: Allocating and freeing 4 hugepages on node 8
> move_pages12.c:197: PASS: Bug not reproduced
> move_pages12.c:197: PASS: Bug not reproduced
> 
> for mem in $(ls -d /sys/devices/system/memory/memory*); do
>         echo offline > $mem/state
>         echo online > $mem/state
> done
> 
> That LTP move_pages12 test will first madvise(MADV_SOFT_OFFLINE) for a range.
> Then, one of "echo offline" will trigger an infinite loop in __offline_pages()
> here,
> 
> 		/* check again */
> 		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
> 					    NULL, check_pages_isolated_cb);
> 	} while (ret);
> 
> because check_pages_isolated_cb() always return -EBUSY from
> test_pages_isolated(),
> 
> 
> 	pfn = __test_page_isolated_in_pageblock(start_pfn, end_pfn,
> 						skip_hwpoisoned_pages);
>         ...
>         return pfn < end_pfn ? -EBUSY : 0;
> 
> The root cause is in __test_page_isolated_in_pageblock() where "pfn" is always
> less than "end_pfn" because the associated page is not a PageBuddy.
> 
> 	while (pfn < end_pfn) {
> 	...
> 		else
> 			break;
> 
> 	return pfn;

Hmm, this is interesting. I would expect that this would hit the
previous branch
	if (skip_hwpoisoned_pages && PageHWPoison(page))
and skip over hwpoisoned page. But I cannot seem to find that we would
mark all tail pages HWPoison as well and so any tail page seem to
confuse __test_page_isolated_in_pageblock.

Oscar is rewriting the hwpoison implementation but I am not sure
how/whether he is handling this case differently. Naoya, shouldn't we do
the following at least?
---
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 89c19c0feadb..5fb3fee16fde 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -274,7 +274,7 @@ __test_page_isolated_in_pageblock(unsigned long pfn, unsigned long end_pfn,
 			 * simple way to verify that as VM_BUG_ON(), though.
 			 */
 			pfn += 1 << page_order(page);
-		else if (skip_hwpoisoned_pages && PageHWPoison(page))
+		else if (skip_hwpoisoned_pages && PageHWPoison(compound_head(page)))
 			/* A HWPoisoned page cannot be also PageBuddy */
 			pfn++;
 		else
-- 
Michal Hocko
SUSE Labs
