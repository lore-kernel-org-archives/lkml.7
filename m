Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32784C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045D02084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbfCZNrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:47:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48373 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfCZNrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:47:48 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8mQX-00068z-QX; Tue, 26 Mar 2019 14:47:41 +0100
Date:   Tue, 26 Mar 2019 14:47:41 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V3 01/23] perf/x86: Support outputting XMM registers
In-Reply-To: <5533614f-3d97-6e50-c63c-bee33c00c93b@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1903261442470.1789@nanos.tec.linutronix.de>
References: <20190322163718.2191-1-kan.liang@linux.intel.com> <20190322163718.2191-2-kan.liang@linux.intel.com> <alpine.DEB.2.21.1903260106210.1789@nanos.tec.linutronix.de> <5533614f-3d97-6e50-c63c-bee33c00c93b@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019, Liang, Kan wrote:
> On 3/25/2019 8:11 PM, Thomas Gleixner wrote:
> 
> -#define REG_RESERVED (~((1ULL << PERF_REG_X86_MAX) - 1ULL))
> +#define REG_RESERVED	0

What's the point of having this around?

>  int perf_reg_validate(u64 mask)
>  {
>  	if (!mask || mask & REG_RESERVED)
>  		return -EINVAL;

 mask & 0 == 0, right? So which bits are you checking here?

Thanks,

	tglx
