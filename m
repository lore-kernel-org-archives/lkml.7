Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614BAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425CF217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfJOM5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 08:57:55 -0400
Received: from foss.arm.com ([217.140.110.172]:38306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfJOM5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 08:57:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 234401000;
        Tue, 15 Oct 2019 05:57:54 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C0643F718;
        Tue, 15 Oct 2019 05:57:53 -0700 (PDT)
Subject: Re: [PATCH v2] sched/topology: Allow sched_asym_cpucapacity to be
 disabled
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        stable@vger.kernel.org
References: <20191015102956.20133-1-valentin.schneider@arm.com>
 <20191015104010.GA242992@google.com>
 <a3a1a3d9-5d3a-3ab3-0eaf-e63e0c401c99@arm.com>
 <d1dac9d1-3ac6-1a1b-f1c9-48b136833686@arm.com>
 <20191015115632.GC242992@google.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <ce8cfbad-6f2d-fceb-b045-a1d9c682f788@arm.com>
Date:   Tue, 15 Oct 2019 13:57:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015115632.GC242992@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2019 12:56, Quentin Perret wrote:
> Hmm, a problem here is that static_branch*() can block (it uses a
> mutex) while you're in the rcu section, I think.
> 
> I suppose you could just move this above rcu_read_lock() and use
> rcu_access_pointer() instead ?
> 

Right, I got confused again, the only problem is with the rcu_read_lock(),
so the increment is fine but the decrement isn't.

Let me try this again with more coffee.

> Thanks,
> Quentin
> 
