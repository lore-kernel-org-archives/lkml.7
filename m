Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C58ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33DC20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbfJNNrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:47:02 -0400
Received: from foss.arm.com ([217.140.110.172]:44592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbfJNNrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:47:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94714337;
        Mon, 14 Oct 2019 06:47:00 -0700 (PDT)
Received: from [10.1.194.37] (unknown [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 745613F68E;
        Mon, 14 Oct 2019 06:46:59 -0700 (PDT)
Subject: Re: [PATCH] sched/topology: Disable sched_asym_cpucapacity on domain
 destruction
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@qperret.net>,
        "# v4 . 16+" <stable@vger.kernel.org>
References: <20191014114710.22142-1-valentin.schneider@arm.com>
 <20191014121648.GA53234@google.com>
 <CAKfTPtDoBrE=npY_Ay1pucdXsW1yQr1UiaCGq1DXKa2VmNqcUg@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <fe5977ab-0a70-e705-fcca-246c7dc3d23f@arm.com>
Date:   Mon, 14 Oct 2019 14:46:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDoBrE=npY_Ay1pucdXsW1yQr1UiaCGq1DXKa2VmNqcUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Replying to the reply because for some reason my mail client never got
your reply?!)

On 14/10/2019 14:29, Vincent Guittot wrote:
> On Mon, 14 Oct 2019 at 14:16, Quentin Perret <qperret@google.com> wrote:
>> FWIW we already clear the EAS static key properly (based on the sd
>> pointer, not the static key), so this is really only for the
>> capacity-aware stuff.
>>

Ah, right.

>> So what happens it you have mutiple root domains ? You might skip
>> build_sched_domains() for one of them and end up not setting the static
>> key when you should no ?
>>
>> I suppose an alternative would be to play with static_branch_inc() /
>> static_branch_dec() from build_sched_domains() or something along those
>> lines.
>>

Hmph, so I went with the concept that having the key set should mandate
having a non-NULL sd_asym_cpucapacity domain, which is why I unset it as
soon as one CPU gets attached to a NULL domain.

Sadly as you pointed out, this doesn't work if we have another root domain
that sees asymmetry. It also kinda sounds broken to have SDs of a root
domain that does not see asymmetry (e.g. LITTLEs only) to see that key 
being set. Maybe what we want is to have a key per root domain?

>> Thanks,
>> Quentin
