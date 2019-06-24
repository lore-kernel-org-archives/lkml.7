Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82454C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5598020663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfFXTpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:45:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfFXTpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:45:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98DDF2F8BEE;
        Mon, 24 Jun 2019 19:45:09 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A19196085B;
        Mon, 24 Jun 2019 19:45:05 +0000 (UTC)
Subject: Re: [locking/rwsem] 4f23dbc1e6: reaim.jobs_per_min -37.0% regression
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, tipbuild@zytor.com,
        lkp@01.org
References: <20190624054511.GA7221@shao2-debian>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <f0381605-e266-4816-653a-91c6e17ca3a5@redhat.com>
Date:   Mon, 24 Jun 2019 15:45:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624054511.GA7221@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 24 Jun 2019 19:45:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/19 1:45 AM, kernel test robot wrote:
> Greeting,
>
> FYI, we noticed a -37.0% regression of reaim.jobs_per_min due to commit:
>
>
> commit: 4f23dbc1e657951e5d94c60369bc1db065961fb3 ("locking/rwsem: Implement lock handoff to prevent lock starvation")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git locking/core
>
> in testcase: reaim
> on test machine: 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 64G memory
> with following parameters:
>
> 	runtime: 300s
> 	nr_task: 7000t
> 	test: shared_memory
> 	cpufreq_governor: performance
> 	ucode: 0x42e
>
> test-description: REAIM is an updated and improved version of AIM 7 benchmark.
> test-url: https://sourceforge.net/projects/re-aim-7/

With 7000 users, there will be extreme contention on the rwsems. The
lock handoff patch is known to reduce throughput with such level of lock
contention. This is a tradeoff between throughput and fairness. I don't
think this is a problem unless some real world workloads also have
significant regression in performance. I will try to reproduce the
regression and see if we can do something to reduce the performance
regression.

Cheers,
Longman


