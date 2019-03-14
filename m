Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A17C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0F7217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfCNG3f convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:29:35 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:45064 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfCNG3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:29:35 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x2E6T99R025732
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 14 Mar 2019 15:29:09 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2E6T9W4029992;
        Thu, 14 Mar 2019 15:29:09 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2E6SqEo006613;
        Thu, 14 Mar 2019 15:29:09 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.150] [10.38.151.150]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-3338476; Thu, 14 Mar 2019 15:27:57 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC22GP.gisp.nec.co.jp ([10.38.151.150]) with mapi id 14.03.0319.002; Thu,
 14 Mar 2019 15:27:56 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     zhong jiang <zhongjiang@huawei.com>
CC:     Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Qestion] Hit a WARN_ON_ONCE in try_to_unmap_one when runing
 syzkaller
Thread-Topic: [Qestion] Hit a WARN_ON_ONCE in try_to_unmap_one when runing
 syzkaller
Thread-Index: AQHU2O0je1X84FRQ5UO03r19PzuDFKYKFWaA
Date:   Thu, 14 Mar 2019 06:27:55 +0000
Message-ID: <20190314062757.GA27899@hori.linux.bs1.fc.nec.co.jp>
References: <5C87D848.7030802@huawei.com>
In-Reply-To: <5C87D848.7030802@huawei.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <4B7AEFEF8D2342479BEA063B334FC83A@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 13, 2019 at 12:03:20AM +0800, zhong jiang wrote:
...
> 
> Minchan has changed the conditon check from  BUG_ON  to WARN_ON_ONCE in try_to_unmap_one.
> However,  It is still an abnormal condition when PageSwapBacked is not equal to PageSwapCache.
> 
> But Is there any case it will meet the conditon in the mainline.
> 
> It is assumed that PageSwapBacked(page) is true in the anonymous page,   This is to say,  PageSwapcache
> is false. however,  That is impossible because we will update the pte for hwpoison entry.
> 
> Because page is locked ,  Its page flags should not be changed except for PageSwapBacked

try_to_unmap_one() from hwpoison_user_mappings() could reach the
WARN_ON_ONCE() only if TTU_IGNORE_HWPOISON is set, because PageHWPoison()
is set at the beginning of memory_failure().

Clearing TTU_IGNORE_HWPOISON might happen on the following two paths:

  static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
                                    int flags, struct page **hpagep)
  {
      ...
  
      if (PageSwapCache(p)) {
              pr_err("Memory failure: %#lx: keeping poisoned page in swap cache\n",
                      pfn);
              ttu |= TTU_IGNORE_HWPOISON;
      }
      ...

      mapping = page_mapping(hpage);                                                                           
      if (!(flags & MF_MUST_KILL) && !PageDirty(hpage) && mapping &&                                           
          mapping_cap_writeback_dirty(mapping)) {                                                              
              if (page_mkclean(hpage)) {                                                                       
                      SetPageDirty(hpage);                                                                     
              } else {                                                                                         
                      kill = 0;                                                                                
                      ttu |= TTU_IGNORE_HWPOISON;                                                              
                      pr_info("Memory failure: %#lx: corrupted page was clean: dropped without side effects\n",
                              pfn);                                                                            
              }                                                                                                
      }                                                                                                        
      ...

      unmap_success = try_to_unmap(hpage, ttu);
      ...

So either of the above "ttu |= TTU_IGNORE_HWPOISON" should be executed.
I'm not sure which one, but both paths show printk messages, so if you
could have kernel message log, that might help ...

Thanks,
Naoya Horiguchi
