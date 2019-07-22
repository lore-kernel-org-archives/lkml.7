Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB497C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9878221734
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="g1l7IjGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732339AbfGVTrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:47:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34590 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfGVTrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:47:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id p17so38769951ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 12:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iv+V0Rpx3ExLkuG+eyUVBN1ISBnPgHbLF8tVFwmrwgE=;
        b=g1l7IjGNmlkcm0BXrZBIAhtTbnSs3PRdOJ+9WJcM7UCHDxkR13fyN16xb6xIZZaO3Z
         UubjYZgk7vIf4L85btTbyWg4liFpBjZMOjq90XcNAXU/0szQ5fif4HtZgOJFYv+khmm8
         HrrNbccaH889WwEkvU9wBbF2CUfqCdlQIb9mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iv+V0Rpx3ExLkuG+eyUVBN1ISBnPgHbLF8tVFwmrwgE=;
        b=mgtaPXNSHJU/U0PSOjH+60GmM3ch1+Vay9xK+esT6EoMcp3vOhbrGvRQJyL+jJ13Ev
         N9L/bHxsGMJ02Xch6klKYc7C2zqTGcHqowmQvlhzhJqN40hKEzb+5JbYd3GYILrd/9S5
         yeJVYKACiCapY6dUXehsdxdm15Fr1xsxcAd+UH1DYzZWL/qzCSWTJvrBqN0DS2KSdWkH
         M/CpsiZdUynlzudJYDFsaC2Hvd+prvmhupYlWz4sgr25PsghaEa+HkdHItmNOzP6+MBO
         ToUlT7fClLAX+9ZjXfMRxEu49MoM4ULgu1Wg/qhw11RG5Y6+shnwZWEclvv0z1YCeOEF
         s5rw==
X-Gm-Message-State: APjAAAXDbydsaCrNW3RTGpWux3eqDK202iFxYSFY4F7sAJPg0wj8vA5p
        7EeOJdu2NMU7hx/sOazZlLs=
X-Google-Smtp-Source: APXvYqyHUom8DyoQGzLgOTAWEu2iZdRYYf4dHmvx6P2KXa9eEOOWAZ3Orgkrco18AAC4MenNFY/RUg==
X-Received: by 2002:a2e:3604:: with SMTP id d4mr36900007lja.85.1563824823697;
        Mon, 22 Jul 2019 12:47:03 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id s21sm7722668ljm.28.2019.07.22.12.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 12:47:03 -0700 (PDT)
Subject: Re: [PATCH v3 3/9] x86/mm/tlb: Open-code on_each_cpu_cond_mask() for
 tlb_is_not_lazy()
To:     Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joe Perches <joe@perches.com>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-4-namit@vmware.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <40f86e4b-8426-1a71-2ab5-4c5523dba247@rasmusvillemoes.dk>
Date:   Mon, 22 Jul 2019 21:47:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190719005837.4150-4-namit@vmware.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2019 02.58, Nadav Amit wrote:

>  /*
> @@ -865,7 +893,7 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>  	if (cpumask_test_cpu(cpu, &batch->cpumask)) {
>  		lockdep_assert_irqs_enabled();
>  		local_irq_disable();
> -		flush_tlb_func_local(&full_flush_tlb_info);
> +		flush_tlb_func_local((void *)&full_flush_tlb_info);
>  		local_irq_enable();
>  	}

I think the confusion could be cleared up if you moved this hunk to
patch 2 where it belongs - i.e. where you change the prototype of
flush_tlb_func_local() and hence introduce the warning.

Rasmus
