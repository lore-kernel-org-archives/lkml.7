Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B156ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5B12168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732431AbfJPI26 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:28:58 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:60618 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbfJPI25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:28:57 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9G8Sewh006533
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 16 Oct 2019 17:28:40 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9G8Seei024790;
        Wed, 16 Oct 2019 17:28:40 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9G8S49m019488;
        Wed, 16 Oct 2019 17:28:40 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-9545169; Wed, 16 Oct 2019 17:27:38 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0439.000; Wed,
 16 Oct 2019 17:27:37 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm, soft-offline: convert parameter to pfn
Thread-Topic: [PATCH] mm, soft-offline: convert parameter to pfn
Thread-Index: AQHVg/CjSPbKnBteSU6QJtzEs3jIHKdcT6KAgAAIvQA=
Date:   Wed, 16 Oct 2019 08:27:36 +0000
Message-ID: <20191016082735.GB13770@hori.linux.bs1.fc.nec.co.jp>
References: <20191016070924.GA10178@hori.linux.bs1.fc.nec.co.jp>
 <e931b14b-da27-2720-5344-b5c0b08b38ad@redhat.com>
In-Reply-To: <e931b14b-da27-2720-5344-b5c0b08b38ad@redhat.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <D19E38659F43DE43834A1C8A7974B60F@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 09:56:19AM +0200, David Hildenbrand wrote:
> On 16.10.19 09:09, Naoya Horiguchi wrote:
> > Hi,
> > 
> > I wrote a simple cleanup for parameter of soft_offline_page(),
> > based on thread https://lkml.org/lkml/2019/10/11/57.
> > 
> > I know that we need more cleanup on hwpoison-inject, but I think
> > that will be mentioned in re-write patchset Oscar is preparing now.
> > So let me shared only this part as a separate one now.
...
> 
> I think you should rebase that patch on linux-next (where the
> pfn_to_online_page() check is in place). I assume you'll want to move the
> pfn_to_online_page() check into soft_offline_page() then as well?

I rebased to next-20191016. And yes, we will move pfn_to_online_page()
into soft offline code.  It seems that we can also move pfn_valid(),
but is simply moving like below good enough for you?

  @@ -1877,11 +1877,17 @@ static int soft_offline_free_page(struct page *page)
    * This is not a 100% solution for all memory, but tries to be
    * ``good enough'' for the majority of memory.
    */
  -int soft_offline_page(struct page *page, int flags)
  +int soft_offline_page(unsigned long pfn, int flags)
   {
   	int ret;
  -	unsigned long pfn = page_to_pfn(page);
  +	struct page *page;
   
  +	if (!pfn_valid(pfn))
  +		return -ENXIO;
  +	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
  +	if (!pfn_to_online_page(pfn))
  +		return -EIO;
  +	page = pfn_to_page(pfn);
   	if (is_zone_device_page(page)) {
   		pr_debug_ratelimited("soft_offline: %#lx page is device page\n",
   				pfn);
  -- 

Or we might have an option to do as memory_failure() does like below:

  int memory_failure(unsigned long pfn, int flags)
  {
          ....
          p = pfn_to_online_page(pfn);
          if (!p) {
                  if (pfn_valid(pfn)) {
                          pgmap = get_dev_pagemap(pfn, NULL);
                          if (pgmap)
                                  return memory_failure_dev_pagemap(pfn, flags,
                                                                    pgmap);
                  }
                  pr_err("Memory failure: %#lx: memory outside kernel control\n",
                          pfn);
                  return -ENXIO;
          }

Thanks,
Naoya Horiguchi
