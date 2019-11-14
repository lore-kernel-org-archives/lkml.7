Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCDCC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8545206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573756882;
	bh=RQW5rUzFlJU85fLG+L2c/qlP96bFwFiQvsuJmFHOLgk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G3bTXXHU2KZfwMfTQ/ZE/nS8tgthf45oYv4d+UQIZf/9PL12xHSnSZhuoZiuZKogU
	 qPmSApUCiABqYdssqvRpQrZJdBCGoCPomgXrGETb3//N1U29AtNKxSXYYLs7NQrfpM
	 N2ukcGoZDDOZHQMvoAGGbDCtvQGuuO4uS53YgJC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKNSlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:41:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:44806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbfKNSlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:41:21 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1143720733
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 18:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573756880;
        bh=RQW5rUzFlJU85fLG+L2c/qlP96bFwFiQvsuJmFHOLgk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Aov+8BbSGewYlafIbnpIZoZr/PFLCYvP5rLP7q/np4kUIwkUS9v/GLueoJU6Z4LPs
         SEqKw+f0fY2O/QdXQi9vwbi+5TDYlPaSy+6jD0DfNXDTP14i9PjoRtS5joZ/3oKMG5
         xJyEfe/UycEE3xzwh01k4SkN66AdU349XyUwl6nY=
Received: by mail-wr1-f49.google.com with SMTP id w9so7739624wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 10:41:19 -0800 (PST)
X-Gm-Message-State: APjAAAVqR6FVRUAZpY9mC8fhaz/vS3xrik0q3UNg1YyLHVS7jKlwbxt/
        0/CBA1UiMoL3ijpMnID0TwnSVL6bfzH7fUlv8zzH+A==
X-Google-Smtp-Source: APXvYqwkX3l/Mfx8fxL+ND4r+MxhlCTgT+cMpoxH0unVvMbH4/5tbOLrcdbzt/dZWqKFjAPwQ+QAWyOqR+qNm/uR6YM=
X-Received: by 2002:a5d:640b:: with SMTP id z11mr9414430wru.195.1573756877389;
 Thu, 14 Nov 2019 10:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20191112211002.128278-1-jannh@google.com> <20191112211002.128278-2-jannh@google.com>
 <20191114174630.GF24045@linux.intel.com> <CALCETrVmaN4BgvUdsuTJ8vdkaN1JrAfBzs+W7aS2cxxDYkqn_Q@mail.gmail.com>
 <20191114182043.GG24045@linux.intel.com>
In-Reply-To: <20191114182043.GG24045@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 Nov 2019 10:41:06 -0800
X-Gmail-Original-Message-ID: <CALCETrVOPT5Np9=4ypEipu5YtXyTRZhiYBQ1XZoDd2=_Q4s=yw@mail.gmail.com>
Message-ID: <CALCETrVOPT5Np9=4ypEipu5YtXyTRZhiYBQ1XZoDd2=_Q4s=yw@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/traps: Print non-canonical address on #GP
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:20 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Thu, Nov 14, 2019 at 10:00:35AM -0800, Andy Lutomirski wrote:
> > On Thu, Nov 14, 2019 at 9:46 AM Sean Christopherson
> > <sean.j.christopherson@intel.com> wrote:
> > > > +     /*
> > > > +      * For the user half, check against TASK_SIZE_MAX; this way, if the
> > > > +      * access crosses the canonical address boundary, we don't miss it.
> > > > +      */
> > > > +     if (addr_ref <= TASK_SIZE_MAX)
> > >
> > > Any objection to open coding the upper bound instead of using
> > > TASK_SIZE_MASK to make the threshold more obvious?
> > >
> > > > +             return;
> > > > +
> > > > +     pr_alert("dereferencing non-canonical address 0x%016lx\n", addr_ref);
> > >
> > > Printing the raw address will confuse users in the case where the access
> > > straddles the lower canonical boundary.  Maybe combine this with open
> > > coding the straddle case?  With a rough heuristic to hedge a bit for
> > > instructions whose operand size isn't accurately reflected in opnd_bytes.
> > >
> > >         if (addr_ref > __VIRTUAL_MASK)
> > >                 pr_alert("dereferencing non-canonical address 0x%016lx\n", addr_ref);
> > >         else if ((addr_ref + insn->opnd_bytes - 1) > __VIRTUAL_MASK)
> > >                 pr_alert("straddling non-canonical boundary 0x%016lx - 0x%016lx\n",
> > >                          addr_ref, addr_ref + insn->opnd_bytes - 1);
> > >         else if ((addr_ref + PAGE_SIZE - 1) > __VIRTUAL_MASK)
> > >                 pr_alert("potentially straddling non-canonical boundary 0x%016lx - 0x%016lx\n",
> > >                          addr_ref, addr_ref + PAGE_SIZE - 1);
> >
> > This is unnecessarily complicated, and I suspect that Jann had the
> > right idea but just didn't quite explain it enough.  The secret here
> > is that TASK_SIZE_MAX is a full page below the canonical boundary
> > (thanks, Intel, for screwing up SYSRET), so, if we get #GP for an
> > address above TASK_SIZE_MAX,
>
> Ya, I followed all that.  My point is that if "addr_ref + insn->opnd_bytes"
> straddles the boundary then it's extremely likely the #GP is due to a
> non-canonical access, i.e. the pr_alert() doesn't have to hedge (as much).

I suppose.  But I don't think we have a real epidemic of failed
accesses to user memory between TASK_SIZE_MAX and the actual boundary
that get #GP instead of #PF but fail for a reason other than
non-canonicality :)

I think we should just go back in time and fix x86_64 to either give
#PF or at least give some useful page fault for a non-canonical
address. The only difficulties I'm aware of is that Intel CPUs would
either need to be redesigned better or would have slightly odd
semantics for jumps to non-canonical addresses -- #PF in Intel's model
of "RIP literally *can't* have a non-canonical value" would be a bit
strange.  Also, my time machine is out of commission.

--Andy
