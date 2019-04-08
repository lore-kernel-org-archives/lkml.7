Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A34C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B5B217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfDHMrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:47:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39447 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHMrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:47:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so16238653wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 05:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sWgZr2/ASFrFMuFomVVmihUekuNMjX5ykTCS8SSqMD8=;
        b=hR0eg4jmz03xmEQyMGf/xsf3/LTsHmXtibD89UADo0yOM8+Srww9fmIj/uUB45X3St
         VXis5XwuhAlztltrZHOWp6pkc2waDEJyUq0/RiqjJO4/bHOFPR90qHDqedwFJi8nsJIR
         +rg1W01CwXFfmuxVTRKdfxPX25nM6+LiEFJQxLGtJmmXulQ2M4pZItlUOc5riA1OFdMO
         Th6QITXEFYUrc0x0XF043I3LEvECgIg7mbCkwiZQgjzaMXpV6Li6zCcvPVue5ko2+DEG
         oVUIr1s1mocLFFuEzsfCAvIhHo2aVk8GpzPlgXqBxVI2oLmNgOziCFu2mSYcirCSKgxt
         JA7g==
X-Gm-Message-State: APjAAAXJZtdl8v1wy61ytiFLu6NCndHsQNikahoVqe7L1ncl3uEZf5qb
        sAbUIecTtRDwf//9CbgiOMEyMg==
X-Google-Smtp-Source: APXvYqx4FlCoS9VnzUYh/RO7JDGqI2nBLwF5DSG7bu+IGG9iIh80RzfkVdZRay4m92bU8nfPC+Bevw==
X-Received: by 2002:adf:efc1:: with SMTP id i1mr18390089wrp.199.1554727655576;
        Mon, 08 Apr 2019 05:47:35 -0700 (PDT)
Received: from t460s.bristot.redhat.com ([193.205.81.200])
        by smtp.gmail.com with ESMTPSA id j22sm92297955wrd.91.2019.04.08.05.47.34
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 05:47:34 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] Early task context tracking
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Romulo Silva de Oliveira <romulo.deoliveira@ufsc.br>,
        Clark Williams <williams@redhat.com>, X86 ML <x86@kernel.org>
References: <cover.1554234787.git.bristot@redhat.com>
 <CALCETrXUx7ExeqERxwu7nfps9vhZhQbfNEFG5fD_Kp7RexCEcA@mail.gmail.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <9ba6e0eb-cc4c-49db-40dc-1df4b93b81ef@redhat.com>
Date:   Mon, 8 Apr 2019 14:47:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXUx7ExeqERxwu7nfps9vhZhQbfNEFG5fD_Kp7RexCEcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/19 2:01 AM, Andy Lutomirski wrote:
>> To resolve this problem, the set/unset of the IRQ/NMI context needs to
>> be done before the execution of the first C execution, and after its
>> return. By doing so, and using this method to identify the context in the
>> trace recursion protection, no more events are lost.
> I would much rather do the opposite: completely remove context
> tracking from the asm and, instead, stick it into the C code.  We'd
> need to make sure that the C code is totally immune from tracing,
> kprobes, etc, but it would be a nice cleanup.  And then you could fix
> this bug in C!
> 
> 

Humm... what we could do to have things in C is to set the variable right at the
begin of the C handler, e.g., do_IRQ(), and right before the return.

But by doing this we would have a problem with two things:

1) irq handler itself (e.g., do_IRQ())
2) functions/tracepoints that might run before and after the handler execution
(e.g., preemptirq tracer), but still in the IRQ context.

We can work around the first case by checking if (the function is in the
__irq_entry .text section) in the recursion control.

The second case would still be a problem. For instance, the preemptirq:
tracepoints in the preemptirq tracer would be "dropped" in the case of a
miss-identification of a recursion.

Thinking aloud: should we try to move the preemptirq tracers to the C part?

I will try to come up with a patch with this approach to see if it "works."

Thoughts?

-- Daniel
