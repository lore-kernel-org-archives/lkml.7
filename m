Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E91C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D5320828
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfFDRY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:24:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48522 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfFDRYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:24:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 121D380D;
        Tue,  4 Jun 2019 10:24:24 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44D773F5AF;
        Tue,  4 Jun 2019 10:24:23 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: clean up asym packing
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1559571064-28087-1-git-send-email-vincent.guitto@linaro.org>
 <1559571436-29091-1-git-send-email-vincent.guittot@linaro.org>
 <7280a3b0-0727-f365-4453-8b4b01a64559@arm.com>
 <CAKfTPtCU_+YJgMVpk-CKhetqTbOcNWVOmbUOD_xuTJqSD64J=w@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <22ddd35b-a901-0292-9dab-6b5efcd16d93@arm.com>
Date:   Tue, 4 Jun 2019 18:24:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCU_+YJgMVpk-CKhetqTbOcNWVOmbUOD_xuTJqSD64J=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2019 19:32, Vincent Guittot wrote:
> On Mon, 3 Jun 2019 at 20:15, Valentin Schneider
[...]
> My original goal was to add a group type to classify the group but
> this would have broken the current behavior whereas I only want to
> move code
> 
>>
>> Also, why tag this group in update_sd_pick_busiest()? It would make more
>> sense to do so in update_sg_lb_stats() like with the other sg_lb_stats fields:
> 
> With your proposal below, the test is called for every groups'
> statistic update whereas it is only done lastly after checking other
> rules in the current code and I don't want to modify the current
> behavior but only move code to set imbalance in calculate imbalance.
> 

Adding a new group_type would make sense. From a behavioral point of view
your change is fine, but from a logical one it sits halfway between being
a new stat and being a new group_type. I'd rather see a new group_type,
though as you said that's a different topic than cleaning up duplicate
operations.

> A bigger cleanup will come in next steps
> 
[...]
