Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E04AC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDE12080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfFTJo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:44:26 -0400
Received: from foss.arm.com ([217.140.110.172]:56642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfFTJoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:44:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F4104360;
        Thu, 20 Jun 2019 02:44:24 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F063E3F246;
        Thu, 20 Jun 2019 02:44:23 -0700 (PDT)
Subject: Re: [PATCH] genirq: Remove warning on preemptible in
 prepare_percpu_nmi()
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        YJ Chiang <yj.chiang@mediatek.com>
References: <20190620091233.22731-1-lecopzer.chen@mediatek.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <6b1dfe9b-90b4-2782-9444-b6afd2b8791b@arm.com>
Date:   Thu, 20 Jun 2019 10:44:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190620091233.22731-1-lecopzer.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lecopzer,

On 20/06/2019 10:12, Lecopzer Chen wrote:
> prepare_percpu_nmi() acquires lock first by irq_get_desc_lock(),
> no matter whether preempt enabled or not, acquiring lock forces preempt off.
> 
> This simplifies the usage of prepare_percpu_nmi() and we don't need to
> acquire extra lock or explicitly call preempt_[disable,enable]().
> 

This allows wrong usage of prepare_percpu_nmi(). If you are not calling
it from a preemptible context, you could start the call on a CPU, get
preempted and setup the NMI on a completely different CPU than the one
you started on.

This check is for sanity checking, and if you end up calling
prepare_percpu_nmi() from non-preemptible context then your intentions
are unclear, unless you are fine with the possibility of "preparing an
NMI on a random CPU". Also you would have no way to know that that CPU
(since you could run on a random CPU) doesn't already have that IRQ line
set for NMI delivery.

So, I don't think removing those simplifies much, it just silences calls
to it that could go wrong.

Cheers,

-- 
Julien Thierry
