Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C74CC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3848621473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfDHMy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:54:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44500 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHMy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:54:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so653076wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 05:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IcmElKgZzP/E+nnV4t5MPl9ZdFT0jiBnp8i8whHXBQg=;
        b=Hco5upz5VB5d5fuWgB09GFYjEgrKIugLdEy/CpARcS61mO4FPuV7rKy+LI/UAvQ5Hd
         iyyXgNMpgt4ZuaB5vh1kNM+7MKrOsLgaloykAEQaDFLxH40ie2D8PhtbmwsJLhJmhG8V
         qwlYMk3oqHKsJO13w+UCE2a1jx0bD51Q/0TK7JSS7X5x8h0LtkG+7KZePINp39APzhvr
         qdiNoadzy4+b8oaBbeVTcaJLLTF6210jawguGWPo6CFDVx4EKVLQ91cfUsE9g/z8FC7U
         eEKvcNz3ZVcaf2QcuHTX5h213B+ojAKFdgRb/d2cgdnEUfbMzf14HDTrxLyq6OAKQCTy
         cgjQ==
X-Gm-Message-State: APjAAAX321eH5NiTIxdfqQ2AmveyzyyIG52VpmOtjZwP8ayhLB+cT2HC
        YlmeKJVkEauquNDzGS8lR5At9Q==
X-Google-Smtp-Source: APXvYqxeHw8Y6txWsC0t0ITJPKGOXu73YNW2pzOPwdD14BiofN5druKHGgcOPsmFLRYieLcd9oY05Q==
X-Received: by 2002:a5d:4843:: with SMTP id n3mr13130446wrs.256.1554728096892;
        Mon, 08 Apr 2019 05:54:56 -0700 (PDT)
Received: from t460s.bristot.redhat.com ([193.205.81.200])
        by smtp.gmail.com with ESMTPSA id 7sm102539928wrc.81.2019.04.08.05.54.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 05:54:56 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] Early task context tracking
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Romulo Silva de Oliveira <romulo.deoliveira@ufsc.br>,
        paulmck@linux.vnet.ibm.com, Clark Williams <williams@redhat.com>,
        x86@kernel.org
References: <cover.1554234787.git.bristot@redhat.com>
 <20190404174037.GA183378@google.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <09416831-0c99-16ea-9ff0-128dd75f1b1f@redhat.com>
Date:   Mon, 8 Apr 2019 14:54:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190404174037.GA183378@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/19 7:40 PM, Joel Fernandes wrote:
>> Currently, recursion control uses the preempt_counter to
>> identify the current context. The NMI/HARD/SOFT IRQ counters
>> are set in the preempt_counter in the irq_enter/exit functions.
> Just started looking.
> 
> Thinking out loud... can we not just update the preempt_count as early on
> entry and as late on exit, as possible, and fix it that way? (Haven't fully
> yet looked into what could break if we did that.)
> 
> I also feel the context tracking should be unified, right now we already have
> two methods AFAIK - preempt_count and lockdep. Now this is yet another third.
> Granted lockdep cannot be enabled in production, but still. It will be nice
> to unify these tracking methods and if there is a single point of all such
> context tracking that works well, and even better if we can just fix
> preempt_count and use that for non-debugging usecases.
> 
> Also I feel in_interrupt() etc should be updated to rely on such tracking
> methods if something other than preempt_count is used..

Hi Joel,

I agree with you that it is important to have a single method to identify the
context.

I did the RFC using a specific percpu variable to make things simpler. Also
because I tried to move set/unset of the preempt_counter and my dev VM stopped
booting. So it looked, somehow, risky to move the preempt_counter.

Still, if people believe it is better to use the preempt_counter... I am not
against...

-- Daniel


> thanks,
> 
>  - Joel
> 
> 

