Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C5FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC222083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PU8b+ihN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfDKSkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:40:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59362 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfDKSkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:40:16 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3BISllO090762;
        Thu, 11 Apr 2019 18:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Fo8SXwQkbF6q15nxNsaxghCGyZTgOADH7D7wGrqPxA0=;
 b=PU8b+ihNIENwF1cmv34uW7m7ADooxaxXJF+NSXixIdJYnEkN0yV/23qI6kZ+s5VOeaNE
 YdhOiuMVD3wVv1Zib4lvITcmnjIhw/ThoQPvtMWBuOFuj2/TPlNMvMXwOcO3p6ufEstO
 cQZmnQ4vNZRA8JQiRwOHHDDxOsQEuC5O7ynOrTSkaN4bWsmW9GBuKL6iIuYFn/UdoC6v
 Mc1Zk0PhacjctAiQAdU4K5QDaPTBr7Y77GB5DENWXgOKGX8+Kjv0lxYZQUqSoyfPKMrT
 92A6yqVN/xDXoXvPD5dUHSkby9s0gWkQwJIEANCvoNL9hGkzM3E1BSqZbTdWXWyuDkt0 wQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2rphmettm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 18:35:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3BIX24b009114;
        Thu, 11 Apr 2019 18:33:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2rpytcx6u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 18:33:02 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3BIWt1x010202;
        Thu, 11 Apr 2019 18:32:57 GMT
Received: from [192.168.1.222] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Apr 2019 11:32:55 -0700
Subject: Re: [PATCH v2 2/2] hugetlb: use same fault hash key for shared and
 private mappings
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20190328234704.27083-1-mike.kravetz@oracle.com>
 <20190328234704.27083-3-mike.kravetz@oracle.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0b1d1faf-ff72-a51f-b48a-175c9c5cab53@oracle.com>
Date:   Thu, 11 Apr 2019 11:32:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328234704.27083-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904110123
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904110123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 4:47 PM, Mike Kravetz wrote:
> hugetlb uses a fault mutex hash table to prevent page faults of the
> same pages concurrently.  The key for shared and private mappings is
> different.  Shared keys off address_space and file index.  Private
> keys off mm and virtual address.  Consider a private mappings of a
> populated hugetlbfs file.  A write fault will first map the page from
> the file and then do a COW to map a writable page.

Davidlohr suggested adding the stack trace to the commit log.  When I
originally 'discovered' this issue I was debugging something else.  The
routine remove_inode_hugepages() contains the following:

			 * ...
			 * This race can only happen in the hole punch case.
			 * Getting here in a truncate operation is a bug.
			 */
			if (unlikely(page_mapped(page))) {
				BUG_ON(truncate_op);

				i_mmap_lock_write(mapping);
				hugetlb_vmdelete_list(&mapping->i_mmap,
					index * pages_per_huge_page(h),
					(index + 1) * pages_per_huge_page(h));
				i_mmap_unlock_write(mapping);
			}

			lock_page(page);
			/*
			 * We must free the huge page and remove from page
			 * ...
			 */
			VM_BUG_ON(PagePrivate(page));
			remove_huge_page(page);
			freed++;

I observed that the page could be mapped (again) before the call to lock_page
if we raced with a private write fault.  However, for COW faults the faulting
code is holding the page lock until it unmaps the file page.  Hence, we will
not call remove_huge_page() with the page mapped.  That is good.  However, for
simple read faults the page remains mapped after releasing the page lock and
we can call remove_huge_page with a mapped page and BUG.

Sorry, the original commit message was not completely accurate in describing
the issue.  I was basing the change on behavior experienced during debug of
a another issue.  Actually, it is MUCH easier to BUG by making private read
faults race with hole punch.  As a result, I now think this should go to
stable.

Andrew, below is an updated commit message.  No changes to code.  Would you
like me to send an updated patch?  Also, need to add stable.

hugetlb uses a fault mutex hash table to prevent page faults of the
same pages concurrently.  The key for shared and private mappings is
different.  Shared keys off address_space and file index.  Private
keys off mm and virtual address.  Consider a private mappings of a
populated hugetlbfs file.  A fault will map the page from the file
and if needed do a COW to map a writable page.

Hugetlbfs hole punch uses the fault mutex to prevent mappings of file
pages.  It uses the address_space file index key.  However, private
mappings will use a different key and could race with this code to map
the file page.  This causes problems (BUG) for the page cache remove
code as it expects the page to be unmapped.  A sample stack is:

page dumped because: VM_BUG_ON_PAGE(page_mapped(page))
kernel BUG at mm/filemap.c:169!
...
RIP: 0010:unaccount_page_cache_page+0x1b8/0x200
...
Call Trace:
__delete_from_page_cache+0x39/0x220
delete_from_page_cache+0x45/0x70
remove_inode_hugepages+0x13c/0x380
? __add_to_page_cache_locked+0x162/0x380
hugetlbfs_fallocate+0x403/0x540
? _cond_resched+0x15/0x30
? __inode_security_revalidate+0x5d/0x70
? selinux_file_permission+0x100/0x130
vfs_fallocate+0x13f/0x270
ksys_fallocate+0x3c/0x80
__x64_sys_fallocate+0x1a/0x20
do_syscall_64+0x5b/0x180
entry_SYSCALL_64_after_hwframe+0x44/0xa9

There seems to be another potential COW issue/race with this approach
of different private and shared keys as noted in commit 8382d914ebf7
("mm, hugetlb: improve page-fault scalability").

Since every hugetlb mapping (even anon and private) is actually a file
mapping, just use the address_space index key for all mappings.  This
results in potentially more hash collisions.  However, this should not
be the common case.

Fixes: b5cec28d36f5 ("hugetlbfs: truncate_hugepages() takes a range of pages")
Cc: <stable@vger.kernel.org>

-- 
Mike Kravetz
