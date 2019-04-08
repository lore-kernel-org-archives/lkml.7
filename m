Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256E6C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD07320879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554739701;
	bh=RreRBcz4kMbrSb4+TrHcvb5hfroMvi0yEWBvzQZRoQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G2tACP8wMlNVoQFGecZnsJn9RehBQqy5BnZhVzTJbLXAyEk66F13loC59pQJlRFDW
	 15Z5lfw0vXPE1mQHvli7ZH45EQjezRxWHubS34ZgoSk7us+KJizZKSrPH065y9XMLI
	 mw2ZZuyO/Ptj7Xt879ME/V01qqPDKX++EyOBTwhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfDHQIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbfDHQIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:08:17 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2353D2190B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2019 16:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554739696;
        bh=RreRBcz4kMbrSb4+TrHcvb5hfroMvi0yEWBvzQZRoQk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wiEWXzV71pxafzOXr8qKnb2Leb6LfK4aC7yUkT80I2nEfhsQT/oexJmAdNXmr6X7r
         kg2vSl+YLvGu+nTPs1tPyOONBNgrberaRCKMXclYEKmuS66wmjCfJVH9be9zU5Tm5o
         y/gPXokVE8D1Yf8y17volrr3VhYUc4G+5cN/XIdc=
Received: by mail-wr1-f46.google.com with SMTP id j9so17102288wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 09:08:16 -0700 (PDT)
X-Gm-Message-State: APjAAAUMBSm58+0ifZroYGrGibwauOBLFlFj2a0a+B9B7BaCDdseZIYo
        pSQOquE3WnSWdOF7Pl303oBPEbiid+NkqLUScmrTFg==
X-Google-Smtp-Source: APXvYqwMJ8ZKmwlx2ioreJSOW2F+UEgJYjJB5i5lwTserRtjKEerAUxI1g5Y8ZaW1k46+nDx4k5oqaVHZ9M5v3LH9E4=
X-Received: by 2002:adf:c788:: with SMTP id l8mr19019626wrg.143.1554739694561;
 Mon, 08 Apr 2019 09:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554234787.git.bristot@redhat.com> <CALCETrXUx7ExeqERxwu7nfps9vhZhQbfNEFG5fD_Kp7RexCEcA@mail.gmail.com>
 <9ba6e0eb-cc4c-49db-40dc-1df4b93b81ef@redhat.com>
In-Reply-To: <9ba6e0eb-cc4c-49db-40dc-1df4b93b81ef@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 8 Apr 2019 09:08:03 -0700
X-Gmail-Original-Message-ID: <CALCETrXbLMirQSXsgbQYfJg0Wr23g+LFoSz3thtttVM1Ms+6Mg@mail.gmail.com>
Message-ID: <CALCETrXbLMirQSXsgbQYfJg0Wr23g+LFoSz3thtttVM1Ms+6Mg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Early task context tracking
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 5:47 AM Daniel Bristot de Oliveira
<bristot@redhat.com> wrote:
>
> On 4/4/19 2:01 AM, Andy Lutomirski wrote:
> >> To resolve this problem, the set/unset of the IRQ/NMI context needs to
> >> be done before the execution of the first C execution, and after its
> >> return. By doing so, and using this method to identify the context in the
> >> trace recursion protection, no more events are lost.
> > I would much rather do the opposite: completely remove context
> > tracking from the asm and, instead, stick it into the C code.  We'd
> > need to make sure that the C code is totally immune from tracing,
> > kprobes, etc, but it would be a nice cleanup.  And then you could fix
> > this bug in C!
> >
> >
>
> Humm... what we could do to have things in C is to set the variable right at the
> begin of the C handler, e.g., do_IRQ(), and right before the return.
>
> But by doing this we would have a problem with two things:
>
> 1) irq handler itself (e.g., do_IRQ())
> 2) functions/tracepoints that might run before and after the handler execution
> (e.g., preemptirq tracer), but still in the IRQ context.
>
> We can work around the first case by checking if (the function is in the
> __irq_entry .text section) in the recursion control.
>
> The second case would still be a problem. For instance, the preemptirq:
> tracepoints in the preemptirq tracer would be "dropped" in the case of a
> miss-identification of a recursion.
>
> Thinking aloud: should we try to move the preemptirq tracers to the C part?


I think we should try to move as much as possible to the C part.
