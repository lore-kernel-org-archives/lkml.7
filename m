Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B1BC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FE3208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561521490;
	bh=avFzZ4O2c+/K29+kDv53q6xh6xHapF0kzXoy3BP0j54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KzVK4T8ENd1YxIEqLdtRGCAI57+X33I3IF3oFHuLnHuPPzreWARXf+/M6i4Ye8Lc2
	 8V7sCuGlWb7AVJnqN/ge/tABad0gM3BqtOTQ/TKMCQaxqiUyILz6hS1XxWgJEvbief
	 agM1jhT+1kJFSwl+jgQS9zVhj2nrLawi8naWFjvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfFZD6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:58:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfFZD6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:58:08 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 017E0208CB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 03:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561521488;
        bh=avFzZ4O2c+/K29+kDv53q6xh6xHapF0kzXoy3BP0j54=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z9RMt+T/gc0ZJyl8ZFG1PJLgqZxyyIgKqs/T3VSzIasR83pgQC5s3OFDqIT2S1dMk
         8iCh8oB+uJK2IXVxjXGBM1rD8tnXhlaF170qAb9ImnvkSRTb0zM1NswqZb+UCD9/m0
         sEe2COBWenM/+LWPhgRBiqS80tW7iPxyNIY6+Cys=
Received: by mail-wm1-f44.google.com with SMTP id g135so531491wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 20:58:07 -0700 (PDT)
X-Gm-Message-State: APjAAAWTGEoZgcCgxWCjoZe7OLXnT5N2Ho4Ufglt5bRejuy6TCVYs0rS
        8kRj73Zn7LY2Lo0l1tqHO36Ctt+zwMu5xRkUEeJxIg==
X-Google-Smtp-Source: APXvYqxW8KyNHGbrsqLX3wAjZrmO6i7qfo2PeSj40E/NfFtWyBAQxsOTIpZkKpXr/3lBP3MynIAMaAzMcSQC90OFjk4=
X-Received: by 2002:a7b:c450:: with SMTP id l16mr879120wmi.0.1561521486613;
 Tue, 25 Jun 2019 20:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190613064813.8102-1-namit@vmware.com> <20190613064813.8102-9-namit@vmware.com>
 <aa90347f-d1da-6bd7-dbf0-786f157eb370@intel.com>
In-Reply-To: <aa90347f-d1da-6bd7-dbf0-786f157eb370@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 25 Jun 2019 20:57:54 -0700
X-Gmail-Original-Message-ID: <CALCETrVM8GafRLTzbE-3CFjRxhorMeB=s2LYWNuH0nZn8YO2Yw@mail.gmail.com>
Message-ID: <CALCETrVM8GafRLTzbE-3CFjRxhorMeB=s2LYWNuH0nZn8YO2Yw@mail.gmail.com>
Subject: Re: [PATCH 8/9] x86/tlb: Privatize cpu_tlbstate
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 2:52 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/12/19 11:48 PM, Nadav Amit wrote:
> > cpu_tlbstate is mostly private and only the variable is_lazy is shared.
> > This causes some false-sharing when TLB flushes are performed.
>
> Presumably, all CPUs doing TLB flushes read 'is_lazy'.  Because of this,
> when we write to it we have to do the cache coherency dance to get rid
> of all the CPUs that might have a read-only copy.
>
> I would have *thought* that we only do writes when we enter or exist
> lazy mode.  That's partially true.  We do write in enter_lazy_tlb(), but
> we also *unconditionally* write in switch_mm_irqs_off().  That seems
> like it might be responsible for a chunk (or even a vast majority) of
> the cacheline bounces.
>
> Is there anything preventing us from turning the switch_mm_irqs_off()
> write into:
>
>         if (was_lazy)
>                 this_cpu_write(cpu_tlbstate.is_lazy, false);
>
> ?
>
> I think this patch is probably still a good general idea, but I just
> wonder if reducing the writes is a better way to reduce bounces.

Good catch!  I'm usually pretty good about this for
test_and_set()-style things, but I totally missed this obvious
unnecessary write when I did this.  I hereby apologize for all the
cycles I wasted :)

--Andy
