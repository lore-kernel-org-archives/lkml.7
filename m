Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D956CC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B057B20665
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfGAVC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:02:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58586 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfGAVC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:02:57 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x61L2UBl096940;
        Tue, 2 Jul 2019 06:02:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Tue, 02 Jul 2019 06:02:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x61L2PYV096882
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 2 Jul 2019 06:02:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] staging: android: ion: Bail out upon SIGKILL when
 allocating memory.
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Laura Abbott <labbott@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <000000000000a861f6058b2699e0@google.com>
 <03763360-a7de-de87-eb90-ba7838143930@I-love.SAKURA.ne.jp>
 <d088f188-5f32-d8fc-b9a0-0b404f7501cc@I-love.SAKURA.ne.jp>
 <ceef00e8-819a-c0f0-cbb5-60e60e6631fe@redhat.com>
 <CAO_48GHu+c3_AxeMSpWbgwPZx4j7JOd6x5t9Jto7=jjV1xw9HA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b863d9a0-ac5b-8187-4373-b0532cf60e76@i-love.sakura.ne.jp>
Date:   Tue, 2 Jul 2019 06:02:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAO_48GHu+c3_AxeMSpWbgwPZx4j7JOd6x5t9Jto7=jjV1xw9HA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/07/01 23:02, Sumit Semwal wrote:
>> Acked-by: Laura Abbott <labbott@redhat.com>
> fwiw, Acked-by: Sumit Semwal <sumit.semwal@linaro.org>

Thank you for responding. You can carry this patch via whichever tree you like.

By the way, is "memory allocation from ion_system_heap_allocate() is calling
ion_system_heap_shrink()"
( https://lkml.kernel.org/r/03763360-a7de-de87-eb90-ba7838143930@I-love.SAKURA.ne.jp )
what we want? Such memory allocations might not want to call shrinkers...
