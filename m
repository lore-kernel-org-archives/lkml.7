Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8207C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E9A21874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553160994;
	bh=5ULhsZSHxO7GdmlhMp8D0gQVLx0X5d1ufDcvzNxQO68=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nALAivgS+1b0rquOtadsj4FPYrw9Rr5VqMqRtNv1ZvMJ879mErkvnfBk2nHA5YEuJ
	 aU54hZFcUZ7EL01IZ4g3yyrK6vcfbmuFCF9lBrQX0p6vohThvGlS0z+p56U+6owP7j
	 Lj2ZMl5c8z2q9UTiI+V79DK9/6mrWhzyux5MMF+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfCUJgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:36:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40606 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfCUJgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:36:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id x8so2958082otg.7;
        Thu, 21 Mar 2019 02:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ULhsZSHxO7GdmlhMp8D0gQVLx0X5d1ufDcvzNxQO68=;
        b=Gl8bk+rTQz12X5NGs/OnkQxAzfphX6LmNHWMy20xfF9lum6NMqJPoHIyUuRG0c3//Z
         kIfTvSTc/FO8RfeXQmkjQNCz5J5Oxh0AeydCj5tFaGl4JsZEOpbRYb8k9Spq+QEMv6Y4
         wSCO7yUwLAO3yrH0616PL36SFhoqBCaGjDhkXBKksApdbuUebGOKNYKtD4L5+aEuXXzP
         4FTE9wyuoLsFWFSty6MjxC346DqgCbmhpLmj95FKxclk+/GBLfOipjQbwNnuL9lABmIw
         fNd8XNFNETQ94NHFwhfpYraftoxzgXOLVXzHICINYPz2t+45SAe3gWugl9WLIZX7pFic
         Ur5A==
X-Gm-Message-State: APjAAAVAOkKchGeW+YagXiu5oghI9a83hO+IGtLF64Pq9SSygdfLbfx1
        RKHthB/3yptPa6/qgZ4rNEHS2bIPyxWINPWrmVc=
X-Google-Smtp-Source: APXvYqworj+mxaes1i69nqj/MmjO1ex8R8oDa2+3uIjdGeMpLmhSAOeHFmhkpeIGkVGUYXpzXULAUJcHk30LQgZeuZc=
X-Received: by 2002:a05:6830:13cd:: with SMTP id e13mr1858177otq.139.1553160991935;
 Thu, 21 Mar 2019 02:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <2816566.rddYshD6lm@aspire.rjw.lan> <20190321075807.GK6058@hirez.programming.kicks-ass.net>
 <20190321092055.GA7022@nazgul.tnic> <CAJZ5v0iiV3djzJrgj0GCeDuVs4hrtWKT9chtwLah5DpCw2sRaw@mail.gmail.com>
 <20190321093217.GB7022@nazgul.tnic>
In-Reply-To: <20190321093217.GB7022@nazgul.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Mar 2019 10:36:21 +0100
Message-ID: <CAJZ5v0ifgnvgJ2jPD=5y9H9noSPLYJxXrESJtfzAaVztZ5gQxQ@mail.gmail.com>
Subject: Re: [PATCH] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS handling
To:     Borislav Petkov <bp@suse.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Schricker <sschricker@suse.de>,
        Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 10:32 AM Borislav Petkov <bp@suse.de> wrote:
>
> On Thu, Mar 21, 2019 at 10:28:50AM +0100, Rafael J. Wysocki wrote:
> > So as I've just said, I'm going to add a sysfs knob for adjusting EPB,
> > but I'd rather not do that in this patch.
>
> Yes, but let's do it ontop pls. Otherwise we'll never get off this
> /dev/msr perpetual insanity.

Sure.
