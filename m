Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5C3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E090220811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553508410;
	bh=ddv2SRO96T7ZTTNIitsUpQePQh8qeS4OclPRLhccjs8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=02PdLslR8MzVIJVnz1SbfqNlhy1tRitmNdIAnB6huuUjuA8OCRR/Fk+vDGVz3q7jR
	 JaBhvP0ta+35HZz1FlMrKxfDSbid6r0tCKns60VZNxtR/06up49GZsECKxlL4OMbNN
	 iIgwfO9yhNqNvLU/6Ded3oQ3CbBgyaeal/xUX+nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbfCYKGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:06:48 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35084 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730250AbfCYKGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:06:48 -0400
Received: by mail-oi1-f196.google.com with SMTP id j132so6475066oib.2;
        Mon, 25 Mar 2019 03:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZfAvtcaD10LSRbbHpyJ6l1C9HkgDSWpRkludz+xyChM=;
        b=fTx5aAtV8rDgmIAsf1b80sSXeWdm4oEkas/494bnFpIUBk4M1+/g/6rKBEyxZKt5ma
         s814AgNK5QpuMIALGROFwAxHtS2TJl81oUX3I21jjI5m3erulWUi+HtaLCLdU00UgUV7
         z8AUQwsO+YN6chAQuRPWeEXgXUCnLzI9UO3lOUaSnG2dRPMxyqKQ443tQDPSsNsVFSYe
         e3CKgYT3xvrnhWkROYxXrOkfXN47O1vzjOoP5IwN4YWyI7CvYtS/A+xB/P75Kr7/fbNA
         Ewt2H0iByO48uxua5BO/+2CO47u7NwdknUb/f1JkkrutFgl9F45Kh4UAmD0jRbLyefxQ
         f60A==
X-Gm-Message-State: APjAAAU12KjopiUtPKQOVKjqvLQQoYbkvRvIzPKgH5iiQ++zO/ASS3/E
        zYyWvWyioUYmitXCRlIo2V5oc5afXwySWasv5Ds=
X-Google-Smtp-Source: APXvYqyrfLXgX3seqVHYTteU/AUNH1/zYJtX2zyAblDbZVxbKHSxP07/Vu4feXYb39EcDRt1n0Z6tyPT0CZmQ+rwRLo=
X-Received: by 2002:aca:5c55:: with SMTP id q82mr11238738oib.95.1553508407504;
 Mon, 25 Mar 2019 03:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <1637073.gl2OfxWTjI@aspire.rjw.lan> <1605148.8jT99SsvVP@aspire.rjw.lan>
 <20190322142828.GA12472@zn.tnic>
In-Reply-To: <20190322142828.GA12472@zn.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Mar 2019 11:06:36 +0100
Message-ID: <CAJZ5v0hBRXhQqqXp4wSe+EJNcsJRN5knx0DONnc5UTa+601mug@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS handling
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Schricker <sschricker@suse.de>,
        Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 3:28 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Mar 21, 2019 at 11:18:01PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The current handling of MSR_IA32_ENERGY_PERF_BIAS in the kernel is
> > problematic, because it may cause changes made by user space to that
> > MSR (with the help of the x86_energy_perf_policy tool, for example)
>
> One more reason to control MSR accesses from userspace. I'm working on
> a series to even completely forbid accesses to some MSRs over /dev/msr
> so I think accessing MSR_IA32_ENERGY_PERF_BIAS solely over the new
> interface in patch 2 would be much better.
>
> So, you're carrying those and you'd like to have an ACK from me?
>
> Btw, a couple of nitpicks below.
>
> > Index: linux-pm/arch/x86/kernel/cpu/intel_epb.c
> > ===================================================================
> > --- /dev/null
> > +++ linux-pm/arch/x86/kernel/cpu/intel_epb.c
> > @@ -0,0 +1,131 @@
> > +// SPDX-License-Identifier: GPL-2.0
>
> ...
>
> > +static DEFINE_PER_CPU(u8, saved_epb);
> > +
> > +#define EPB_MASK     0x0fULL
> > +#define EPB_SAVED    0x10ULL
> > +
> > +static int intel_epb_save(void)
>
> I'd drop that "intel_epb_" prefix from those static functions, but your
> call...

They help indexing tools (elixir.bootlin.com and similar) a bit, so
I'd rather retain them.

> > +{
> > +     u64 epb;
> > +
> > +     rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
> > +     /*
> > +      * Ensure that saved_epb will always be nonzero after this write even if
> > +      * the EPB value read from the MSR is 0.
> > +      */
> > +     this_cpu_write(saved_epb, (epb & EPB_MASK) | EPB_SAVED);
> > +
> > +     return 0;
> > +}
>
> ...
>
> > Index: linux-pm/Documentation/admin-guide/pm/intel_epb.rst
> > ===================================================================
> > --- /dev/null
> > +++ linux-pm/Documentation/admin-guide/pm/intel_epb.rst
>
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #345: FILE: Documentation/admin-guide/pm/intel_epb.rst:1:

Well, this is documentation, so ...
