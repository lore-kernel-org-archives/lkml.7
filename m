Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476F1CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE70214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390686AbfJ1Rya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 13:54:30 -0400
Received: from foss.arm.com ([217.140.110.172]:43628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731497AbfJ1Rya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 13:54:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC3681F1;
        Mon, 28 Oct 2019 10:54:29 -0700 (PDT)
Received: from [10.188.222.161] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC1E23F71F;
        Mon, 28 Oct 2019 10:54:27 -0700 (PDT)
Subject: Re: [QUESTION] Hung task warning while running syzkaller test
To:     Zhihao Cheng <chengzhihao1@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, peterz@infradead.org,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        patrick.bellasi@arm.com, tglx@linutronix.de
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <0d7aa66d-d2b9-775c-56b3-543d132fdb84@huawei.com>
 <1693d19e-56c7-9d6f-8e80-10fe82101cff@arm.com>
 <aa5d0f35-e707-f5e3-251e-f940c0b0232b@huawei.com>
 <4ca01869-7997-cfce-edce-e75337d3a6fa@arm.com>
 <abba880d-cfa6-3485-7831-9998db290396@huawei.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d7e9f62e-d7a6-50ec-6fb5-76ad136506df@arm.com>
Date:   Mon, 28 Oct 2019 18:54:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <abba880d-cfa6-3485-7831-9998db290396@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2019 03:48, Zhihao Cheng wrote:> 3. You can convert the repro file into a C program by 'syzprog' tool(see syzprog.c). Using compiled syzprog.c directly for testing did not show hung task, which confused me.
> 

Good to know that you can get a readable program out of this, but that diff
in behaviour isn't reassuring.

Also, I don't see anything in there that would try to play with cgroups - I
was mostly curious about the use of the freezer, but don't see any in the
C code. Out of curiosity I ran a similar kernel that I tried before (without
the right configs), and it doesn't complain about missing cgroup options...
