Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED04FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A47E214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438795AbfJQIMF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:12:05 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:47381 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438692AbfJQIME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:12:04 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9H8BkkZ031574
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 17 Oct 2019 17:11:46 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9H8BkFX012836;
        Thu, 17 Oct 2019 17:11:46 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9H8BEYu017939;
        Thu, 17 Oct 2019 17:11:46 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-9600387; Thu, 17 Oct 2019 17:07:22 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0439.000; Thu,
 17 Oct 2019 17:07:21 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Michal Hocko" <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm, soft-offline: convert parameter to pfn
Thread-Topic: [PATCH] mm, soft-offline: convert parameter to pfn
Thread-Index: AQHVhLrXcCLS8WnGfEC5psVxf+kROqdd3rQAgAADpYCAAAEegA==
Date:   Thu, 17 Oct 2019 08:07:21 +0000
Message-ID: <20191017080720.GB15898@hori.linux.bs1.fc.nec.co.jp>
References: <20191016070924.GA10178@hori.linux.bs1.fc.nec.co.jp>
 <e931b14b-da27-2720-5344-b5c0b08b38ad@redhat.com>
 <20191016082735.GB13770@hori.linux.bs1.fc.nec.co.jp>
 <c78962ba-ffa1-90e2-0116-6c94d082de2f@redhat.com>
 <20191016085359.GD13770@hori.linux.bs1.fc.nec.co.jp>
 <997b5b51-db71-3e27-1f84-cbaa24fa66c7@redhat.com>
 <20191016234706.GA5493@www9186uo.sakura.ne.jp>
 <ac4c1ab9-1df6-6a30-30ed-a015622ef591@redhat.com>
 <20191017075018.GA10225@hori.linux.bs1.fc.nec.co.jp>
 <20191017080315.GA31827@linux>
In-Reply-To: <20191017080315.GA31827@linux>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <1333D4BE3CA755459C62D6761242E0E6@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 10:03:21AM +0200, Oscar Salvador wrote:
> On Thu, Oct 17, 2019 at 07:50:18AM +0000, Naoya Horiguchi wrote:
> > Actually I guess that !pfn_valid() never happens when called from
> > madvise_inject_error(), because madvise_inject_error() gets pfn via
> > get_user_pages_fast() which only returns valid page for valid pfn.
> > 
> > And we plan to remove MF_COUNT_INCREASED by Oscar's re-design work,
> > so I start feeling that this patch should come on top of his tree.
> 
> Hi Naoya,
> 
> I am pretty much done with my testing.
> If you feel like, I can take the patch and add it on top of [1]
> , then I will do some more testing and, if nothing pops up, I will
> send it upstream.

Hi Oscar,
Yes, please take it, thank you for speaking up.

> 
> [1] https://github.com/leberus/linux/tree/hwpoison-v2
