Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D79C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB570206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfDCFqB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 01:46:01 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:57614 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfDCFqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 01:46:00 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x335jlHi032156
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 14:45:47 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x335jlLm010089;
        Wed, 3 Apr 2019 14:45:47 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x335jGb1003185;
        Wed, 3 Apr 2019 14:45:47 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.148] [10.38.151.148]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-3939739; Wed, 3 Apr 2019 14:44:36 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC20GP.gisp.nec.co.jp ([10.38.151.148]) with mapi id 14.03.0319.002; Wed, 3
 Apr 2019 14:44:36 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hugetlb: Get rid of NODEMASK_ALLOC
Thread-Topic: [PATCH] mm/hugetlb: Get rid of NODEMASK_ALLOC
Thread-Index: AQHU6VjR5Ud9L/BTCUi9Q0MuQPILkqYpVxOA
Date:   Wed, 3 Apr 2019 05:44:35 +0000
Message-ID: <20190403054436.GA20228@hori.linux.bs1.fc.nec.co.jp>
References: <20190402133415.21983-1-osalvador@suse.de>
In-Reply-To: <20190402133415.21983-1-osalvador@suse.de>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.148]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <5D36004EC50BF549823C713D0A9EDB9A@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 03:34:15PM +0200, Oscar Salvador wrote:
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
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

nice cleanup.

Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
