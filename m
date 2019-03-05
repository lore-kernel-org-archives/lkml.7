Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C288C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156F220842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfCEHwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:52:43 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44739 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfCEHwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:52:43 -0500
Received: by mail-qt1-f193.google.com with SMTP id d2so8045650qti.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 23:52:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPZytMG+Z7k2oqGMYQ9JH1bz0MaTZvZva5KfwVxLgmE=;
        b=fnVCegs44vEtlHIcedIViYvAVIeQTq1TbShfeI93CbLQVu1d7ln9ehA8f+XxkEU6R8
         iz9qxZS8MVEU4BgJzXkbGUTV6sCnIbcmTpu1Yrbt6iid30C6hG2H/REX3twnYN4f86DB
         ppXfjdZxLbPYIn+FeMfD+b+C2ErataCX1SZ3kLqvofuOxdwJXAx5LakLJJubzVGZbmeI
         iFIqmHuwXwpVh5Tk4TSKCBKftd7VMj4NmEvNWXU0UXomZFY4E2RcEIPOvYmuidDCwUoP
         udBCS935fcmiMzqgrVyoI9UhJrm2NPpYZBkkPoJOLjBkUVEYVHdzwt8t5aVOZ+wTbPp4
         RiEA==
X-Gm-Message-State: APjAAAWNbmE7elVEAeqA3+AzPQB9fr8Q/lIkPv2EvR4PaK+Ljl+6rhi5
        jxJqFmEif+PkGmGp2qpmqPRSVz1Dbm+ejTTHVYk=
X-Google-Smtp-Source: APXvYqwNfOml4xkT41UlOfXY5Tr1OgM1lEHwM1lL4INaNrcJWKzx3U1PUfsUa8962dKVxJ3aM+b9CUizBThMbOboHSM=
X-Received: by 2002:ac8:2bcf:: with SMTP id n15mr440727qtn.96.1551772362166;
 Mon, 04 Mar 2019 23:52:42 -0800 (PST)
MIME-Version: 1.0
References: <20190304200748.1418790-1-arnd@arndb.de> <20190304164306.4b76acc1@gandalf.local.home>
In-Reply-To: <20190304164306.4b76acc1@gandalf.local.home>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Mar 2019 08:52:25 +0100
Message-ID: <CAK8P3a3DEA0nUupyNVmxp3fQ90sFj_R=FR3gXsDg_cSwg-BRrw@mail.gmail.com>
Subject: Re: [PATCH] x86/ftrace: avoid an unused-function warning
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 10:43 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon,  4 Mar 2019 21:07:39 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
...
> Also, it's basically identical to ftrace_call_replace(). I'm going to
> combine the two and move the jmp replace and have it do this instead.

Sounds good.

> arch/x86/kernel/ftrace.c:669:23: error: 'ftrace_jmp_replace' defined but not used [-Werror=unused-function]
>
> The ftrace_jmp_replace() function now only has a single user and should be
> simply moved by that user. But looking at the code, it shows that
> ftrace_jmp_replace() is similar to ftrace_call_replace() except that instead
> of using the opcode of 0xe8 it uses 0xe9. It makes more sense to consolidate
> that function into one implementation that both ftrace_jmp_replace() and
> ftrace_call_replace() use by passing in the op code separate.
>
> The structure in ftrace_code_union is also modified to replace the "e8"
> field with the more appropriate name "op".
>
> Cc: stable@vger.kernel.org
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Link: http://lkml.kernel.org/r/20190304200748.1418790-1-arnd@arndb.de
> Fixes: d2a68c4effd8 ("x86/ftrace: Do not call function graph from dynamic trampolines")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
