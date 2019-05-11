Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A2AC04A6B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 03:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0BC21479
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 03:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b3zRDdaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfEKDPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 23:15:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42460 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfEKDPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 23:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BB8bWqByrWckvwFlv3dy1LnPzMox9xwaOak7yJC9rFE=; b=b3zRDdaYXok4kXsSSLj7uTfedH
        K4qJO1qngd38Xl+wTexvNFTFMNobSZcrIyiqhRrfIdprQynvr50JOHD/irT7XLLf0moAzw8EcqkiR
        UtUXT8hK86ZyEwvY7Fb3ycKu3gE5vxI0X1pJqLxeUdhmykERZeCv3MF23R0O6OfyETicu4WA0tB84
        unxXedovHye0wpeoTkRr0/BjMqAkZQdqQJuHvxh5l0N0Ziq3Y2Vdf3/2M73Q5xJ5YDAUqEPMVakSu
        inlwG2xijb6AS9LVezJ2c4Qo8X2Pn9aVJipy3YZF8zonsZboAdZ38haLPSvnQLzI2Xn0XjqDwK5jF
        jPzFkA9w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hPITZ-0001jM-8e; Sat, 11 May 2019 03:15:05 +0000
Subject: Re: [RFC] x86: Speculative execution warnings
To:     Nadav Amit <namit@vmware.com>, x86@kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Andy Lutomirsky <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>
References: <20190510192514.19301-1-namit@vmware.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d204035e-6cf7-e7cb-85d2-cebf42d75852@infradead.org>
Date:   Fri, 10 May 2019 20:15:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510192514.19301-1-namit@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/19 12:25 PM, Nadav Amit wrote:
> It may be useful to check in runtime whether certain assertions are
> violated even during speculative execution. This can allow to avoid
> adding unnecessary memory fences and at the same time check that no data
> leak channels exist.
> 
> For example, adding such checks can show that allocating zeroed pages
> can return speculatively non-zeroed pages (the first qword is not
> zero).  [This might be a problem when the page-fault handler performs
> software page-walk, for example.]
> 
> Introduce SPEC_WARN_ON(), which checks in runtime whether a certain
> condition is violated during speculative execution. The condition should
> be computed without branches, e.g., using bitwise operators. The check
> will wait for the condition to be realized (i.e., not speculated), and
> if the assertion is violated, a warning will be thrown.
> 
> Warnings can be provided in one of two modes: precise and imprecise.
> Both mode are not perfect. The precise mode does not always make it easy
> to understand which assertion was broken, but instead points to a point
> in the execution somewhere around the point in which the assertion was
> violated.  In addition, it prints a warning for each violation (unlike
> WARN_ONCE() like behavior).
> 
> The imprecise mode, on the other hand, can sometimes throw the wrong
> indication, specifically if the control flow has changed between the
> speculative execution and the actual one. Note that it is not a
> false-positive, it just means that the output would mislead the user to
> think the wrong assertion was broken.
> 
> There are some more limitations. Since the mechanism requires an
> indirect branch, it should not be used in production systems that are
> susceptible for Spectre v2. The mechanism requires TSX and performance
> counters that are only available in skylake+. There is a hidden
> assumption that TSX is not used in the kernel for anything else, other
> than this mechanism.
> 
> The basic idea behind the implementation is to use a performance counter
> that updates also during speculative execution as an indication for
> assertion failure. By using conditional-mov, which is not predicted,
> to affect the control flow, the condition is realized before the event
> that affects the PMU is triggered.
> 
> Enable this feature by setting "spec_warn=on" or "spec_warn=precise"
> kernel parameter. I did not run performance numbers but I guess the
> overhead should not be too high.

Hi,
If this progresses, please document spec_warn={on|precise} in
Documentation/admin-guide/kernel-parameters.txt.

> I did not run too many tests, but brief experiments suggest that it does
> work. Let me know if I missed anything and whether you think this can be
> useful. To be frank, the exact use cases are not super clear, and there
> are various possible extensions (e.g., ensuring the speculation window
> is long enough by adding data dependencies). I would appreciate your
> inputs.
> 
> Cc: Andy Lutomirsky <luto@kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/Kconfig                     |   4 +
>  arch/x86/include/asm/nospec-branch.h |  30 +++++
>  arch/x86/kernel/Makefile             |   1 +
>  arch/x86/kernel/nospec.c             | 185 +++++++++++++++++++++++++++
>  4 files changed, 220 insertions(+)
>  create mode 100644 arch/x86/kernel/nospec.c

thanks.
-- 
~Randy
