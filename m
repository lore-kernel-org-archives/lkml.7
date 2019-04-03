Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C03DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544CE20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfDCFac convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 01:30:32 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:54458 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfDCFab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 01:30:31 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x335UEEq020015
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 14:30:14 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x335UEsJ013917;
        Wed, 3 Apr 2019 14:30:14 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x335SdMJ023670;
        Wed, 3 Apr 2019 14:30:14 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-3938585; Wed, 3 Apr 2019 14:29:14 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0319.002; Wed, 3
 Apr 2019 14:29:13 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/2] A couple hugetlbfs fixes
Thread-Topic: [PATCH v2 0/2] A couple hugetlbfs fixes
Thread-Index: AQHU6d4rcfOiD6QCGkOryDRCw26i8w==
Date:   Wed, 3 Apr 2019 05:29:12 +0000
Message-ID: <20190403052913.GA10888@hori.linux.bs1.fc.nec.co.jp>
References: <20190328234704.27083-1-mike.kravetz@oracle.com>
In-Reply-To: <20190328234704.27083-1-mike.kravetz@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.148]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <77345DB63E7D154B902FE1C4B1357009@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 04:47:02PM -0700, Mike Kravetz wrote:
> I stumbled on these two hugetlbfs issues while looking at other things:
> - The 'restore reserve' functionality at page free time should not
>   be adjusting subpool counts.
> - A BUG can be triggered (not easily) due to temporarily mapping a
>   page before doing a COW.
> 
> Both are described in detail in the commit message of the patches.
> I would appreciate comments from Davidlohr Bueso as one patch is
> directly related to code he added in commit 8382d914ebf7.
> 
> I did not cc stable as the first problem has been around since reserves
> were added to hugetlbfs and nobody has noticed.  The second is very hard
> to hit/reproduce.
> 
> v2 - Update definition and all callers of hugetlb_fault_mutex_hash as
>      the arguments mm and vma are no longer used or necessary.
> 
> Mike Kravetz (2):
>   huegtlbfs: on restore reserve error path retain subpool reservation
>   hugetlb: use same fault hash key for shared and private mappings
> 
>  fs/hugetlbfs/inode.c    |  7 ++-----
>  include/linux/hugetlb.h |  4 +---
>  mm/hugetlb.c            | 43 +++++++++++++++++++++--------------------
>  mm/userfaultfd.c        |  3 +--
>  4 files changed, 26 insertions(+), 31 deletions(-)

Both fixes look fine to me.

Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
