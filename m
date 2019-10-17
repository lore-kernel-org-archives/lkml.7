Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364CDFA3728
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 00:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E01207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 00:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iWx1RJok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437781AbfJQAu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 20:50:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48336 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437557AbfJQAu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 20:50:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9H0nutG052563;
        Thu, 17 Oct 2019 00:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=By4QC8NvkiZQGCVliZZ/nz8FB4DfbtEFgjcJVI43lG8=;
 b=iWx1RJok3PcIWBpLh5TcAWNcwZCDeBPQflcfbOiRXQ4q0pyouDBg82QbRHAKfA0Zw2wg
 qYEJ8dmNuFSTrI6uEGuqJQ64VZ6w0rBwae+e+r+OLwyODkFoVLlymYnYAfcSjxb+7CX3
 Jm5mz+lNAyXM09KmD9NBmq2eP+1zsYsIHO8wNbsvvW/y/Fx0QH3DZm75AMVmfOnmxBaF
 i5KFKZdUnpNHsp94/+ptRK3s/9Kzl8bU+tsjlNiJSgeRE5nzaAKqK8iDhHgh5fj14Ca9
 yZBG2X/QksyRVcSEjOUgz3168j4vFt8fmb+AuuuVk2pBDONw5NIgrwUwr+ahklAUiqHv Ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vk6sqtr7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 00:50:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9H0mf1v010573;
        Thu, 17 Oct 2019 00:50:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vp70nw0sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 00:50:20 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9H0oBDq022601;
        Thu, 17 Oct 2019 00:50:11 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 00:50:11 +0000
Subject: Re: [PATCH V2] mm/page_alloc: Add alloc_contig_pages()
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
References: <1571223765-10662-1-git-send-email-anshuman.khandual@arm.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0ce85182-e00c-8748-32f7-89c30b3be35b@oracle.com>
Date:   Wed, 16 Oct 2019 17:50:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1571223765-10662-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/19 4:02 AM, Anshuman Khandual wrote:
> HugeTLB helper alloc_gigantic_page() implements fairly generic allocation
> method where it scans over various zones looking for a large contiguous pfn
> range before trying to allocate it with alloc_contig_range(). Other than
> deriving the requested order from 'struct hstate', there is nothing HugeTLB
> specific in there. This can be made available for general use to allocate
> contiguous memory which could not have been allocated through the buddy
> allocator.
> 
> alloc_gigantic_page() has been split carving out actual allocation method
> which is then made available via new alloc_contig_pages() helper wrapped
> under CONFIG_CONTIG_ALLOC. All references to 'gigantic' have been replaced
> with more generic term 'contig'. Allocated pages here should be freed with
> free_contig_range() or by calling __free_page() on each allocated page.

I had a 'test harness' used when previously working on such an interface.
It simply provides a user interface to call the allocator with random
values for nr_pages.  Several tasks are then started doing random allocations
in parallel.  The new interface is pretty straight forward, but the idea
was to stress the underlying code.  In fact, it did identify issues with
isolation which were corrected.

I exercised this new interface in the same way and am happy to report that
no issues were detected.
-- 
Mike Kravetz
