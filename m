Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3677C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA1D2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbfJIMDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:03:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbfJIMDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:03:20 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7AC22A09B1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 12:03:19 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id i2so1031828wrv.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 05:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=faApr5o7VeVVH94hLoZndjX4D5gG2Iyd9XySkn5mWQM=;
        b=pUbkNLx5A4DPjDvPYXIX9z/pmpvdgKXaEOqkbTZhMBqqLBrhwCsc955S1PvjA/6iPV
         AV5NXpinbDDI43VhOrJWB4x9GjzAfCgzbocq6IxKxPOO16ton6/PxGZFi9akJJQtiItA
         j3SET8iy5AyOWzTvgmzZsZB4R7O/NdEs3jNvB+eZ1lvo7mvREL2hVATZ1Sq+mpfhx0AJ
         4opCmSdl42W/3Ci694Nilears3C872yvNNXhulsxgog+ax8/3cUR4bCkw/Z5R4FQDxhp
         KKS4NOkgy6reSaDAficMF1SyXY+UdVK8+kGN2SkBj4cq20ItdwXHXK4YDP7fv/WfLAPh
         uY+A==
X-Gm-Message-State: APjAAAU8XnjJz00Myx5bn3safsI0mDnmOwfDMJMZe9PYx013Fqx541kU
        xIm4ACz5JScaSaiHuAXUVjfhafWt8KGl6kMNhJqbfrsQZ/FzZhIIS2QYNk4BatIeputEp0pPV5q
        zF0D1q+aWqthc7z6rEc11vm8V
X-Received: by 2002:a1c:2d4d:: with SMTP id t74mr2255372wmt.108.1570622598497;
        Wed, 09 Oct 2019 05:03:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzpD+KXBlMzrLUx7bTlhV+/NWvhjcHEQS6Lk1peqLrrN2Qv1UDRLjiFY5XWVe6ucs7YHkoTXQ==
X-Received: by 2002:a1c:2d4d:: with SMTP id t74mr2255347wmt.108.1570622598229;
        Wed, 09 Oct 2019 05:03:18 -0700 (PDT)
Received: from t460s.bristot.redhat.com (nat-cataldo.sssup.it. [193.205.81.5])
        by smtp.gmail.com with ESMTPSA id j11sm2172777wrw.86.2019.10.09.05.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 05:03:17 -0700 (PDT)
Subject: Re: [PATCH v3 1/6] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
References: <20191007081716.07616230.8@infradead.org>
 <20191007081944.88332264.2@infradead.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <b72b9c83-154e-010d-d8c2-3e163073426d@redhat.com>
Date:   Wed, 9 Oct 2019 14:03:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191007081944.88332264.2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2019 10:17, Peter Zijlstra wrote:
> In preparation for static_call and variable size jump_label support,
> teach text_poke_bp() to emulate instructions, namely:
> 
>   JMP32, JMP8, CALL, NOP2, NOP_ATOMIC5, INT3
> 
> The current text_poke_bp() takes a @handler argument which is used as
> a jump target when the temporary INT3 is hit by a different CPU.
> 
> When patching CALL instructions, this doesn't work because we'd miss
> the PUSH of the return address. Instead, teach poke_int3_handler() to
> emulate an instruction, typically the instruction we're patching in.
> 
> This fits almost all text_poke_bp() users, except
> arch_unoptimize_kprobe() which restores random text, and for that site
> we have to build an explicit emulate instruction.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel
