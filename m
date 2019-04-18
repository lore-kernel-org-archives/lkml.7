Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27097C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED53F2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfDREQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 00:16:08 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:35622 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbfDREQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 00:16:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TPc2a8C_1555560943;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TPc2a8C_1555560943)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Apr 2019 12:15:58 +0800
To:     Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     YangShi <yang.shi@linux.alibaba.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Subject: [QUESTIONS] THP allocation in NUMA fault migration path
Message-ID: <aa34f38e-5e55-bdb2-133c-016b91245533@linux.alibaba.com>
Date:   Wed, 17 Apr 2019 21:15:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


I noticed that there might be new THP allocation in NUMA fault migration 
path (migrate_misplaced_transhuge_page()) even when THP is disabled (set 
to "never"). When THP is set to "never", there should be not any new THP 
allocation, but the migration path is kind of special. So I'm not quite 
sure if this is the expected behavior or not?


And, it looks this allocation disregards defrag setting too, is this 
expected behavior too?


Thanks,

Yang

