Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AFBC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D2220870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfDHJsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:48:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39127 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfDHJsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:48:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so13954357wmk.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 02:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UWzgzqojHlzhBQpoBT8JJBX9Ik93dbuiaaHMtSwyoKE=;
        b=Jd8bs0+jQgVitIZYkTCgMlAlK+gU+Jh2pzkU6GS3fQoanaYIjKDq9IqxwA9D5/yjMT
         HyZo9eDtlQUazSEgVbbYEiA0arQ/NKTYgEDZiMl0x3vqCnv39VTPB7F75iOiLfmHGbnQ
         8NmvFKayBwM9xhkF1jEbFg8IUfBklFigFsYwzRVzHnPcyUtsJc7Co1KUtRRAQncArcWJ
         +pl/CnTMt9VXSAo9raGxukevmtX4eVWINqukZuJWMuIDyy7Ow4in1cZCbIwgLmZCAiER
         151pSys02Kt/N2QuMVhkDwwjsSuNoqBFHFWDGfF4fX7vUiHWw7wwwGF16VPQSHxE6dQT
         GdJA==
X-Gm-Message-State: APjAAAVT97rUA3j6K72+ydQQJPjGrKCzPzCE9nLBFUsiaosZfuIYLDGy
        MRZRQj9dGctIMSHhJR4ZE7Q+fw==
X-Google-Smtp-Source: APXvYqzkUKQ9tZlOiETSg7fL/ldhK7fqi71auJkohhvpjCpZCYSpG5wxq8MX5H3OKy313mGJwVkq1g==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr17333713wmb.39.1554716932354;
        Mon, 08 Apr 2019 02:48:52 -0700 (PDT)
Received: from t460s.bristot.redhat.com ([193.205.81.200])
        by smtp.gmail.com with ESMTPSA id 204sm19868344wmc.1.2019.04.08.02.48.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 02:48:51 -0700 (PDT)
Subject: Re: [PATCH V2 1/2] trace,x86: Add external_interrupts to the
 irq_vectors class
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
References: <833f2a192b491649e4d46cec51028d07c96bbf5e.1554142415.git.bristot@redhat.com>
 <alpine.DEB.2.21.1904052314410.1802@nanos.tec.linutronix.de>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <7912cfa4-cd20-c764-2a36-32d3853066be@redhat.com>
Date:   Mon, 8 Apr 2019 11:48:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904052314410.1802@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/19 11:15 PM, Thomas Gleixner wrote:
> On Mon, 1 Apr 2019, Daniel Bristot de Oliveira wrote:
> 
>> Currently, the irq_vectors is showing the entry and exit events for
>> the interrupts of the architecture, but not for external interrupts.
> 
> Those are covered by the irq tracepoints. Is there a really good reason why
> we need both?

The irq_handler_* tracepoints might give the "imprecise" idea that more than one
interrupts were raised when we have shared handlers. For instance:

------------ %< ----------------
f-892   [000] d.h.   790.617251: external_interrupt_entry: vector=37
f-892   [000] d.h.   790.617257: irq_handler_entry: irq=11 name=uhci_hcd:usb3
f-892   [000] d.h.   790.617343: irq_handler_exit: irq=11 ret=handled
f-892   [000] d.h.   790.617343: irq_handler_entry: irq=11 name=uhci_hcd:usb4
f-892   [000] d.h.   790.617349: irq_handler_exit: irq=11 ret=unhandled
f-892   [000] d.h.   790.617350: irq_handler_entry: irq=11 name=qxl
f-892   [000] d.h.   790.617360: irq_handler_exit: irq=11 ret=handled
f-892   [000] d.h.   790.617387: external_interrupt_exit: vector=37
------------ >% ----------------

In this case, a single interrupt occurrence (vector 37) caused two handlers to
handle their interrupt.

From a latency analysis perspective, the external_interrupt_* tracepoints turn
clearer that a single interrupt interfered in the thread execution happened, not
two separated executions of the same vector.

The outer-most tracepoints also help to have a more precise accounting of the
interference:

Using the sum of the irq_handler_* tracepoints we have:
(790.617343−790.617257)+(790.617349−790.617343)+(790.617360−790.617350) = 102 us

While using the irq_vector based one:
 790.617387-790.617251 = 136 us

So, the proposed tracepoints help clarify the logical sequence of the interrupt
handling, while increasing the precision of the measurements.

Thoughts?

-- Daniel
> Thanks,
> 
> 	tglx
> 

