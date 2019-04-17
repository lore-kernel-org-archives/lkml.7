Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5555C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08702176F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ouFaE+KB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfDQAEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:04:34 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40910 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbfDQAEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 20:04:33 -0400
Received: by mail-oi1-f195.google.com with SMTP id f196so7813579oib.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 17:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwvutNTYcOXRQe3RoAMKK7TXAD1RtScdWgy+YAtCgh8=;
        b=ouFaE+KBlMmTLWWUDrpOoEUpO+wSy3BeDEMQGztu/P6W+7YYMtu2B/cKvYHGN8/BJe
         lHzcNqMvobiwRNDG/mfnZ1E2gT/UYWuksfdSyEVfPozAU66PS8J/urAiqZJ9RE7MB8FW
         opiSJkphDRt/e6Gx+eSSQtadV85LnlT7VsAdj3fCSGw/wczeKnpniAS6XQNiYxAcJyvG
         j4MfZMTpMUD+VIAShX/G6ddTf8GHTAvYLLATKz3sqlSEAFIHHCZwAHjlIcH0lOGa+q9f
         KRlIXLxlcn3zW/7xjjxL7++Iyk8Up2Fu/9b0opWe7+Wk+ep3XvjFsMBkkZgCUq0oHiP8
         39KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwvutNTYcOXRQe3RoAMKK7TXAD1RtScdWgy+YAtCgh8=;
        b=NX0kXZDOoOdy//mXAyU3gCcV90cRHJ3KDoiqQZJBTbEr0XzSKYhrUpVZaO+PxvTrj5
         j2lR7hoShz5yh/ry+tHlh7HbDAtLXwKJtOD38Lpz3oAyxO+Wx0m9OkaWZ56DTqyL7mEE
         RZCoOtUeBGWjgsrk6CzKcH8tr2SQhWnz3R3EhXuvoe3IDMII9diUFxLPAdIeW5rS4aJL
         nQ/hn2R71NEbdVmeolvVXAgDEaIXgcTN6ry+pA/t1IhRm/6CQ5GgyHgNg0BJUAtUIGCN
         kdsPDi2L9swhnWQ3Xjde3jBXYdrQC0vnLzvXSLSPt1H6XZmHJFLgfeKUZ1H2JvdbG93w
         zGkA==
X-Gm-Message-State: APjAAAWODRFRNaqY3Y+25zEtGGj+eebrOgAv4iVJuAWsm7Rh/eRELcjE
        jVCQ4XhDhMNIepBqF2JBRRNOzEPZtPQ1vv2PMcZ9AfDlwuo=
X-Google-Smtp-Source: APXvYqyjthnKh3yftLBP4Zzxceqv6bmhLskpJNNqFMkBqw1sBcZYzu4g11z5X2BE8WBexkGi7yVyfUzbGHvuP7rtG7U=
X-Received: by 2002:aca:d513:: with SMTP id m19mr24770386oig.73.1555459472688;
 Tue, 16 Apr 2019 17:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <155544804466.1032396.13418949511615676665.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190416164418.3ca1d8cef2713a1154067291@linux-foundation.org>
In-Reply-To: <20190416164418.3ca1d8cef2713a1154067291@linux-foundation.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Apr 2019 17:04:21 -0700
Message-ID: <CAPcyv4iJxyiGWqjGKLuRgjr9UgDO9ERSghUi3k597gk=X5votQ@mail.gmail.com>
Subject: Re: [PATCH] init: Initialize jump labels before command line option parsing
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 4:44 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 16 Apr 2019 13:54:04 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
>
> > When a module option, or core kernel argument, toggles a static-key it
> > requires jump labels to be initialized early. While x86, PowerPC, and
> > ARM64 arrange for jump_label_init() to be called before parse_args(),
> > ARM does not.
> >
> >   Kernel command line: rdinit=/sbin/init page_alloc.shuffle=1 panic=-1 console=ttyAMA0,115200 page_alloc.shuffle=1
> >   ------------[ cut here ]------------
> >   WARNING: CPU: 0 PID: 0 at ./include/linux/jump_label.h:303
> >   page_alloc_shuffle+0x12c/0x1ac
> >   static_key_enable(): static key 'page_alloc_shuffle_key+0x0/0x4' used
> >   before call to jump_label_init()
> >   Modules linked in:
> >   CPU: 0 PID: 0 Comm: swapper Not tainted
> >   5.1.0-rc4-next-20190410-00003-g3367c36ce744 #1
> >   Hardware name: ARM Integrator/CP (Device Tree)
> >   [<c0011c68>] (unwind_backtrace) from [<c000ec48>] (show_stack+0x10/0x18)
> >   [<c000ec48>] (show_stack) from [<c07e9710>] (dump_stack+0x18/0x24)
> >   [<c07e9710>] (dump_stack) from [<c001bb1c>] (__warn+0xe0/0x108)
> >   [<c001bb1c>] (__warn) from [<c001bb88>] (warn_slowpath_fmt+0x44/0x6c)
> >   [<c001bb88>] (warn_slowpath_fmt) from [<c0b0c4a8>]
> >   (page_alloc_shuffle+0x12c/0x1ac)
> >   [<c0b0c4a8>] (page_alloc_shuffle) from [<c0b0c550>] (shuffle_store+0x28/0x48)
> >   [<c0b0c550>] (shuffle_store) from [<c003e6a0>] (parse_args+0x1f4/0x350)
> >   [<c003e6a0>] (parse_args) from [<c0ac3c00>] (start_kernel+0x1c0/0x488)
> >
> > Move the fallback call to jump_label_init() to occur before
> > parse_args(). The redundant calls to jump_label_init() in other archs
> > are left intact in case they have static key toggling use cases that are
> > even earlier than option parsing.
>
> Has it been confirmed that this fixes
> mm-shuffle-initial-free-memory-to-improve-memory-side-cache-utilization.patch
> on beaglebone-black?

This only fixes dynamically enabling the shuffling on 32-bit ARM.
Guenter happened to run without the mm-only 'force-enable-always'
patch and when he went to use the command line option to enable it he
hit the jump-label warning.

The original beaglebone-black failure was something different and
avoided this case because the jump-label was never used.

I am otherwise unable to recreate the failure on either the original
failing -next, nor on v5.1-rc5 plus the latest state of the patches. I
need from someone who is actually still seeing the failure so they can
compare with the configuration that is working for me. For reference
that's the Yocto beaglebone-black defconfig:

https://github.com/jumpnow/meta-bbb/blob/thud/recipes-kernel/linux/linux-stable-5.0/beaglebone/defconfig
