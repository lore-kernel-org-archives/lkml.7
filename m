Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0277C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20ED22CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfIDH1a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:27:30 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3555 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbfIDH12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:27:28 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 09746421599CFEE9ECB1;
        Wed,  4 Sep 2019 15:27:27 +0800 (CST)
Received: from DGGEML422-HUB.china.huawei.com (10.1.199.39) by
 dggeml406-hub.china.huawei.com (10.3.17.50) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 4 Sep 2019 15:27:26 +0800
Received: from DGGEML512-MBX.china.huawei.com ([169.254.2.60]) by
 dggeml422-hub.china.huawei.com ([10.1.199.39]) with mapi id 14.03.0439.000;
 Wed, 4 Sep 2019 15:27:25 +0800
From:   sunqiuyang <sunqiuyang@huawei.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 1/1] mm/migrate: fix list corruption in migration of
 non-LRU movable pages
Thread-Topic: [PATCH 1/1] mm/migrate: fix list corruption in migration of
 non-LRU movable pages
Thread-Index: AQHVYi7CKRiSaGuZ20KJAhdeZXNZ4qcZaW+AgAFf/lT//8LbAIAAjGWd
Date:   Wed, 4 Sep 2019 07:27:25 +0000
Message-ID: <157FC541501A9C4C862B2F16FFE316DC190C2EBD@dggeml512-mbx.china.huawei.com>
References: <20190903082746.20736-1-sunqiuyang@huawei.com>
 <20190903131737.GB18939@dhcp22.suse.cz>
 <157FC541501A9C4C862B2F16FFE316DC190C1B09@dggeml512-mbx.china.huawei.com>,<20190904063836.GD3838@dhcp22.suse.cz>
In-Reply-To: <20190904063836.GD3838@dhcp22.suse.cz>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.249.127]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

isolate_migratepages_block() from another thread may try to isolate the page again:

for (; low_pfn < end_pfn; low_pfn++) {
  /* ... */
  page = pfn_to_page(low_pfn);
 /* ... */
  if (!PageLRU(page)) {
    if (unlikely(__PageMovable(page)) && !PageIsolated(page)) {
        /* ... */
        if (!isolate_movable_page(page, isolate_mode))
          goto isolate_success;
      /*... */
isolate_success:
     list_add(&page->lru, &cc->migratepages);

And this page will be added to another list.
Or, do you see any reason that the page cannot go through this path?
________________________________________
From: Michal Hocko [mhocko@kernel.org]
Sent: Wednesday, September 04, 2019 14:38
To: sunqiuyang
Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm/migrate: fix list corruption in migration of non-LRU movable pages

On Wed 04-09-19 02:18:38, sunqiuyang wrote:
> The isolate path of non-lru movable pages:
>
> isolate_migratepages_block
>       isolate_movable_page
>               trylock_page
>               // if PageIsolated, goto out_no_isolated
>               a_ops->isolate_page
>               __SetPageIsolated
>               unlock_page
>       list_add(&page->lru, &cc->migratepages)
>
> The migration path:
>
> unmap_and_move
>       __unmap_and_move
>               lock_page
>               move_to_new_page
>                       a_ops->migratepage
>                       __ClearPageIsolated
>               unlock_page
>       /* here, the page could be isolated again by another thread, and added into another cc->migratepages,
>       since PG_Isolated has been cleared, and not protected by page_lock */
>       list_del(&page->lru)

But the page has been migrated already and not freed yet because there
is still a pin on it. So nobody should be touching it at this stage.
Or do I still miss something?
--
Michal Hocko
SUSE Labs
