Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812F2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDE22184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553883643;
	bh=rFITafnfcyqZFy7ndBuiIRJBAhKwNtb9JvZEyqneims=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pyzwQsfPRl8E4v+lm/MtynQqi8Nlj/KFi78ZvcUHTOsGG7DuFw/9bSzcYaGkrS6nc
	 sqHz8J0WCVWFuUEXlTbpSy50L4e4gETsplM6O7stkhm5ILutitehyMc0ctHAD7jnsb
	 eECyx5OcisuV5wuyaU/WhXoJLDbTM+TF3NljpMbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbfC2SUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:20:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33603 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729949AbfC2SUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:20:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id v14so2103641lfi.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e0e8+89c8WqHpS92sAwslvgKe3+T9VMjo4MG/AIaEJ0=;
        b=Bwnj99rswxnG2idbOHUyJZMdAA6/RX9IKmqsbaohnDits4oHDao0NNuz88t9FgVDVK
         HRjuq1haxuwp5ifwqwyiLFG21kWwmC4z+oVljARKqov0I9ykSer92dg1r3W3KuqmbHbb
         yDmOCYVj9u/+sMrAJ7ea8buStjFkLspM1rnco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e0e8+89c8WqHpS92sAwslvgKe3+T9VMjo4MG/AIaEJ0=;
        b=NLRzeiY/FvyAb1u3DqDCzYUO/TeBejhgKPmu8U/bpMjcDomJhriUaTV0eNVH9kFWSD
         4+ceqk623GD9uvmqJOziAD107zN4igGu5CrPgQ40lCO1Ug5co8d6LMQr0ICq3bosQCW3
         JQ1VJAWq8CydUtfa+9f3+/yNk8ToJJ42gDeEEJ2T/RF1cvlr8SrSVBqdQS63gfMsD0+D
         kdCgbwRLjYRVn0H5n1E+pEspWro9Et244ht3w+0y+CNBA5m3kEZSdewTeTmd/eMTV1ps
         48/rfm09QW4+kHC24FLbbzeXr3mVNiVrXCvNHmbm/nv8udtWpqep7sviUQvATn2PIyOf
         wr1w==
X-Gm-Message-State: APjAAAV44fESsOyAn3OUnMEFBOOkYodt/N9M4t5TlcxdwBoyOV0kdH12
        puSO0HDc7v5+1hw2krTk7hQm8k9C7Mg=
X-Google-Smtp-Source: APXvYqyxsNA9y9BamWnYDqekhBHBvWZ5H1GjyfRMcgvyAdgodADt7xllaRQTCFCi1xIkJqCqhIaQnA==
X-Received: by 2002:a19:9107:: with SMTP id t7mr26014894lfd.48.1553883639348;
        Fri, 29 Mar 2019 11:20:39 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id z20sm407675lfh.66.2019.03.29.11.20.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 11:20:39 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id r24so2811664ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 11:20:38 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr11854185ljj.79.1553883154094;
 Fri, 29 Mar 2019 11:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230512.486297455@goodmis.org> <CAHk-=whtDB2HiEgyKcJPN7m8c83GrY=hQ=p-m-um1N6eSqxczg@mail.gmail.com>
 <20190329134045.3fb2e69f@gandalf.local.home>
In-Reply-To: <20190329134045.3fb2e69f@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Mar 2019 11:12:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOQpkGb43zE8+djZ99tiVRefJ7mmWFOUN=v6RFRTBvCQ@mail.gmail.com>
Message-ID: <CAHk-=wjOQpkGb43zE8+djZ99tiVRefJ7mmWFOUN=v6RFRTBvCQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4 v2] sycalls: Remove args i and n from syscall_get_arguments()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Roland McGrath <roland@hack.frob.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 10:40 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I'll keep it around for now, but this should go as a warning to Dmitry,
> to get something using it soon, or they may be dropped.

I don't think _that_ is the argument.

Quite the reverse: nobody has ever used it, why have it around, and
much less try to hurry some new pointless user to use it?

The "get system call arguments" code at least can be used somewhat
generically for things like tracing and strace.

The "set system call arguments" can NOT.

Anybody who sets system call arguments had better intimately know the
details anyway, and any user code has to have any legacy ptrace
interface anyway for all but the newest kernels.

So I will just say "NO". No new stupid interface that doesn't have a
truly immensely convincing reason for it.

And definitely not hurried along by "nobody has ever usefully done
this before and now people are noticing how bad the interfaces are, so
let's cobble some sh*t together quickly".

                     Linus
