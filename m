Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92B9C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E2D2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfDZIJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:09:39 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:58371 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbfDZIJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:09:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TQH-UjF_1556266174;
Received: from ali-6c96cfdd1403.local(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0TQH-UjF_1556266174)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Apr 2019 16:09:35 +0800
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
Subject: [Regression][stable] Major hackbench pipes regression due to commit
 'sched/fair: Search a task from the tail of the queue'
To:     urezki@gmail.com
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Message-ID: <f3c31802-3276-fbf4-208f-a72b5d8c9170@linux.alibaba.com>
Date:   Fri, 26 Apr 2019 16:09:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Uladzislau

We found a major regression (more than -40%) of hackbench on 2VCPU 
(skylake) virtual machine, with LTS kernel v4.19.36. Following commit be 
bisect by test 'hackbench --thread --pipe --group 1 --loop 60000'

---

commit 93824900a2e242766f5fe6ae7697e3d7171aa234
Author: Uladzislau Rezki <urezki@gmail.com>
Date:   Wed Sep 13 12:24:30 2017 +0200

     sched/fair: Search a task from the tail of the queue

---

-default: 21.048

-revert: 14.385


It said that the hackbench has slightly better performance with 40 
groups in the commit log, but it seems more performance dropped with 
less groups, such as less than 32 group. I also tried this benchmark 
with newest v5.1-rc6 kernel, same regression was found.

Could you please also have a check?

Thanks!

BRs/Shile



