Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BE5C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F9F214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfFYNaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:30:00 -0400
Received: from foss.arm.com ([217.140.110.172]:42026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfFYN37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:29:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E1FC2B;
        Tue, 25 Jun 2019 06:29:59 -0700 (PDT)
Received: from [10.1.196.120] (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCCE93F718;
        Tue, 25 Jun 2019 06:29:57 -0700 (PDT)
Subject: Re: [PATCH 3/7] perf: arm64: Use rseq to test userspace access to pmu
 counters
To:     Mark Rutland <mark.rutland@arm.com>, will.deacon@arm.com
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        mathieu.desnoyers@efficios.com
References: <20190611125315.18736-1-raphael.gault@arm.com>
 <20190611125315.18736-4-raphael.gault@arm.com>
 <20190611143346.GB28689@kernel.org>
 <20190611165755.GG29008@lakrids.cambridge.arm.com>
From:   Raphael Gault <raphael.gault@arm.com>
Message-ID: <ff5897eb-ae6c-482f-148b-947a661fde4f@arm.com>
Date:   Tue, 25 Jun 2019 14:29:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190611165755.GG29008@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Hi Will,

Now that we have a better idea what enabling this feature for 
heterogeneous systems would look like (both with or without using 
rseqs), it might be worth discussing if this is in fact a desirable 
thing in term of performance-complexity trade off.

Indeed, while not as scary as first thought, maybe the rseq method would 
still dissuade users from using this feature. It is also worth noting 
that if we only enable this feature on homogeneous system, the `mrs` 
hook/emulation would not be necessary.
If because of the complexity of the setup we need to consider whether we 
want to upstream this and have to maintain it afterward.

Thanks,

-- 
Raphael Gault
