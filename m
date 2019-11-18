Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BDDC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A2220730
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf9jS8Lv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfKRMdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:33:54 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38348 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfKRMdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 07:33:53 -0500
Received: by mail-io1-f66.google.com with SMTP id i13so18555590ioj.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 04:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vsKkxgYFGaLOW/gYA/fneaG8YkqaAWQiU3Y+2OmRUrA=;
        b=Xf9jS8LvvS+7hP/1GlYhdHz6qyoYj7un7Z7utw+0KWpiPUbNPaNwjB1jmtNlC4G3i1
         H9mYaDNMDvtP/ReGISh4yLCPDGkwhgGwm+WBds9j0ozZlup5UHY57C38LwtANF2KxyZP
         Wf0jTZimx94TNMNmgUDQPXZGqx3Lf+ImaSgnLbFbyvfDe/8MlljE6fAaDqsenUT223TM
         8kr6zqTQ6ojGLEXLS7xzRKWRmHDCKKdJ11oU663iPiGh8Ki2fHeYTLQDX0LPLnW/sjwI
         Jwg/a6reFcsF7+ST+Mc6Wj9RjI4xMSFvYeTqOXeHrhdz+8GZantcfyefT42SQJotg+eA
         ICRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vsKkxgYFGaLOW/gYA/fneaG8YkqaAWQiU3Y+2OmRUrA=;
        b=VIB5JMHfFspekIvKQlg9ygIi9w/YA4PhoSKJn+qONvvcfAzwUTagXpbf7B9UxhylQP
         fjatcTMTDEewDDohsB682zfRjQ9TifJGj9Ntizl1OI0O4Hr5hd+Cc9WyoWSgv7qj1jH1
         6rMnInpS0AosQvTxwBsXYHQRMqmU9hGuWyhUFYocWgeDiWbLNHDOWkv2ZFINtN11/8k1
         zTLl2MCt0lshP+p3NUF7hJcDxJxDg0+tfuqDIEnc0zQxi/Wzstjh9Rx3SA1vVn6USMHa
         i7q+aT8/X33EZM+ck22i51o/TfDIct8PETWTyyqOi1RdAPELx7cF0cIeaZvJ2LmdziW9
         O9nQ==
X-Gm-Message-State: APjAAAXG29luc8LUgVXlw6uRcY824fhnDvUJIKjB5sfdYBIHhmt1g5j2
        zRdBvBJKxAwqLM6yxBFYiKXwyfux0nRA3syAIP6mS2gS
X-Google-Smtp-Source: APXvYqyQCHWuc2VBsLMDFGD7UqlZEUXTY+DkLAKaHCCpflZUSuC2q0i8MtgwsacP931q+0uUKztC0wH10MEOlaC9xfY=
X-Received: by 2002:a6b:7215:: with SMTP id n21mr10466008ioc.281.1574080431064;
 Mon, 18 Nov 2019 04:33:51 -0800 (PST)
MIME-Version: 1.0
From:   Santiago Pastorino <spastorino@gmail.com>
Date:   Mon, 18 Nov 2019 09:33:31 -0300
Message-ID: <CAKecwXB6CYuykBYrfGUDffF_AY31E_M8HpQddOe4xojjx0xZ8w@mail.gmail.com>
Subject: perf trace segfault
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently running Linux kernel 5.3.11-arch1-1 and I'm getting a segfault
when I run `perf trace` after some seconds.
Here I'm pasting the backtrace:

Program terminated with signal SIGSEGV, Segmentation fault.
#0 0x00007fdbb2615a40 in main_arena () from /usr/lib/libc.so.6
(gdb) bt
#0 0x00007fdbb2615a40 in main_arena () from /usr/lib/libc.so.6
#1 0x0000562fc44e22d7 in syscall__scnprintf_val (sc=0x562fc50cc4a0,
val=6, arg=0x7ffd10440870, size=2021, bf=0x562fc52b722b "") at
builtin-trace.c:1649
#2 syscall__scnprintf_args (sc=sc@entry=0x562fc50cc4a0,
bf=0x562fc52b721b "fd: 223, level: ", size=2037,
args=args@entry=0x7fdbb21a118c <error: Cannot access memory at address
0x7fdbb21a118c>, augmented_args=augmented_args@entry=0x0,
augmented_args_size=augmented_args_size@entry=0, trace=0x7ffd10440fa0,
thread=0x562fc51da000) at builtin-trace.c:1716
#3 0x0000562fc44e3e22 in trace__sys_enter (trace=0x7ffd10440fa0,
evsel=<optimized out>, event=<optimized out>, sample=0x7ffd10440990)
at builtin-trace.c:1935
#4 0x0000562fc44e11ac in trace__handle_event (sample=0x7ffd10440990,
event=0x7fdbb21a1140, trace=0x7ffd10440fa0) at builtin-trace.c:2645
#5 __trace__deliver_event (trace=trace@entry=0x7ffd10440fa0,
event=0x7fdbb21a1140) at builtin-trace.c:2899
#6 0x0000562fc44ea7dc in trace__deliver_event (event=<optimized out>,
trace=0x7ffd10440fa0) at builtin-trace.c:2926
#7 trace__run (argv=<optimized out>, argc=<optimized out>,
trace=0x7ffd10440fa0) at builtin-trace.c:3124
#8 cmd_trace (argc=<optimized out>, argv=<optimized out>) at
builtin-trace.c:4060
#9 0x0000562fc4519043 in run_builtin (p=0x562fc4a026c0 <commands+576>,
argc=1, argv=0x7ffd10444560) at perf.c:304
#10 0x0000562fc44952fc in handle_internal_command (argv=<optimized
out>, argc=<optimized out>) at perf.c:356
#11 run_argv (argcp=<optimized out>, argv=<optimized out>) at perf.c:400
#12 main (argc=1, argv=0x7ffd10444560) at perf.c:522
(gdb) quit

# perf --version
perf version 5.3.g4d856f72c10e

Thanks for reading and feel free to cc me in replies since I'm not
subscribed to lkml.
