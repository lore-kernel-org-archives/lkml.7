Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3352AC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029B626F34
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559337304;
	bh=gKgYNLBpeOOMUpEUJl708y2vi02Rzrqk2Rf+7SqGFoQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MGz7+LcYQmzvtgSppwWMKcPmmaLHLfHR7XuVTfRpczQY1BxYxv8tglDGI1LzZPgdo
	 XrNVOb2rGdnxNiynil5uXAPqkWxGyEGN/NwMlERuv4VFHDM7u2bBchPO50ELAJohea
	 ZodpaVand5jxrgCy1oDHR1AfPfeCZth48yjXq2Nw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfEaVPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 17:15:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbfEaVPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 17:15:02 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C092D26F3A
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 21:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559337302;
        bh=gKgYNLBpeOOMUpEUJl708y2vi02Rzrqk2Rf+7SqGFoQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W9h3QmtxYVFfKyGjxKV1kw7bQbisE5CwjZlEyxDo29IaBbYLLEUapXI/8I4VE/BbX
         rDO5MuObKn3SLMgQghdhuq6N3Fdjs/xtVteJnJL64uWlkOVwQ/mT2rez3marqg4WR9
         Patymlv2TB0sF5Jbj4IY3c20acNrlTdqppRb0N7A=
Received: by mail-wr1-f50.google.com with SMTP id h1so7360736wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 14:15:01 -0700 (PDT)
X-Gm-Message-State: APjAAAXq5gogHDp9E/mVKGOsDv45vRdZ8xgo556XyOPFrSJT6X0eKTbA
        nTXVtqPZXCN8X2TGO33NHpAa3nKx1bEAeqPZteGDhQ==
X-Google-Smtp-Source: APXvYqwXwuWopX6mQo+6kLuUg/7ghxmPwAoAls8+UMozk4xNmr28ndE2vp7IeSCLGjgzv+PEEwUB7NaFrwcDe4AEu5E=
X-Received: by 2002:adf:e9ca:: with SMTP id l10mr7529012wrn.47.1559337300326;
 Fri, 31 May 2019 14:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190531063645.4697-1-namit@vmware.com> <20190531063645.4697-12-namit@vmware.com>
In-Reply-To: <20190531063645.4697-12-namit@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 31 May 2019 14:14:49 -0700
X-Gmail-Original-Message-ID: <CALCETrU0=BpGy5OQezQ7or33n-EFgBVDNe5g8prSUjL2SoRAwA@mail.gmail.com>
Message-ID: <CALCETrU0=BpGy5OQezQ7or33n-EFgBVDNe5g8prSUjL2SoRAwA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages
 for flushing
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 11:37 PM Nadav Amit <namit@vmware.com> wrote:
>
> When we flush userspace mappings, we can defer the TLB flushes, as long
> the following conditions are met:
>
> 1. No tables are freed, since otherwise speculative page walks might
>    cause machine-checks.
>
> 2. No one would access userspace before flush takes place. Specifically,
>    NMI handlers and kprobes would avoid accessing userspace.
>

I think I need to ask the big picture question.  When someone calls
flush_tlb_mm_range() (or the other entry points), if no page tables
were freed, they want the guarantee that future accesses (initiated
observably after the flush returns) will not use paging entries that
were replaced by stores ordered before flush_tlb_mm_range().  We also
need the guarantee that any effects from any memory access using the
old paging entries will become globally visible before
flush_tlb_mm_range().

I'm wondering if receipt of an IPI is enough to guarantee any of this.
If CPU 1 sets a dirty bit and CPU 2 writes to the APIC to send an IPI
to CPU 1, at what point is CPU 2 guaranteed to be able to observe the
dirty bit?  An interrupt entry today is fully serializing by the time
it finishes, but interrupt entries are epicly slow, and I don't know
if the APIC waits long enough.  Heck, what if IRQs are off on the
remote CPU?  There are a handful of places where we touch user memory
with IRQs off, and it's (sadly) possible for user code to turn off
IRQs with iopl().

I *think* that Intel has stated recently that SMT siblings are
guaranteed to stop speculating when you write to the APIC ICR to poke
them, but SMT is very special.

My general conclusion is that I think the code needs to document what
is guaranteed and why.

--Andy
