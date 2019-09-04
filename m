Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D758C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3266D22CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbfIDMTS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:19:18 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:37294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727929AbfIDMTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:19:18 -0400
Received: from DGGEML401-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 409C5B175537DB1266F5;
        Wed,  4 Sep 2019 20:19:16 +0800 (CST)
Received: from DGGEML512-MBX.china.huawei.com ([169.254.2.60]) by
 DGGEML401-HUB.china.huawei.com ([fe80::89ed:853e:30a9:2a79%31]) with mapi id
 14.03.0439.000; Wed, 4 Sep 2019 20:19:11 +0800
From:   sunqiuyang <sunqiuyang@huawei.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 1/1] mm/migrate: fix list corruption in migration of
 non-LRU movable pages
Thread-Topic: [PATCH 1/1] mm/migrate: fix list corruption in migration of
 non-LRU movable pages
Thread-Index: AQHVYi7CKRiSaGuZ20KJAhdeZXNZ4qcZaW+AgAFf/lT//8LbAIAAjGWd//+OTACAAMgqDg==
Date:   Wed, 4 Sep 2019 12:19:11 +0000
Message-ID: <157FC541501A9C4C862B2F16FFE316DC190C3402@dggeml512-mbx.china.huawei.com>
References: <20190903082746.20736-1-sunqiuyang@huawei.com>
 <20190903131737.GB18939@dhcp22.suse.cz>
 <157FC541501A9C4C862B2F16FFE316DC190C1B09@dggeml512-mbx.china.huawei.com>
 <20190904063836.GD3838@dhcp22.suse.cz>
 <157FC541501A9C4C862B2F16FFE316DC190C2EBD@dggeml512-mbx.china.huawei.com>,<20190904081408.GF3838@dhcp22.suse.cz>
In-Reply-To: <20190904081408.GF3838@dhcp22.suse.cz>
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


________________________________________
From: Michal Hocko [mhocko@kernel.org]
Sent: Wednesday, September 04, 2019 16:14
To: sunqiuyang
Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm/migrate: fix list corruption in migration of non-LRU movable pages

Do not top post please

On Wed 04-09-19 07:27:25, sunqiuyang wrote:
> isolate_migratepages_block() from another thread may try to isolate the page again:
>
> for (; low_pfn < end_pfn; low_pfn++) {
>   /* ... */
>   page = pfn_to_page(low_pfn);
>  /* ... */
>   if (!PageLRU(page)) {
>     if (unlikely(__PageMovable(page)) && !PageIsolated(page)) {
>         /* ... */
>         if (!isolate_movable_page(page, isolate_mode))
>           goto isolate_success;
>       /*... */
> isolate_success:
>      list_add(&page->lru, &cc->migratepages);
>
> And this page will be added to another list.
> Or, do you see any reason that the page cannot go through this path?

The page shouldn't be __PageMovable after the migration is done. All the
state should have been transfered to the new page IIUC.

----
I don't see where page->mapping is modified after the migration is done. 

Actually, the last comment in move_to_new_page() says,
"Anonymous and movable page->mapping will be cleard by
free_pages_prepare so don't reset it here for keeping
the type to work PageAnon, for example. "

Or did I miss something? Thanks,

--
Michal Hocko
SUSE Labs
