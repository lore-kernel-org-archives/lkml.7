Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B00C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B259521873
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553160543;
	bh=pWTXYDmhy/PNqBoubgnUL9wT6AC6UMupJKPEFo7Dg8s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JaPerguzi0xjAZ1aQm9HVG1FuqmVknhmAH68zaQwdgvdwfCkXCczueAeiZnSQRIkB
	 pAl61EEROIz9ozhhmj8M/dCNaj/nbgV+w5IcdgKi3iHaHFNFHwg3aJKjK/0CLibn+X
	 39cgQZcJkzd3ZL5RNDGFRAMiAwLMUyV1iaMfM0RY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfCUJ3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:29:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39064 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfCUJ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:29:02 -0400
Received: by mail-ot1-f65.google.com with SMTP id f10so4825323otb.6;
        Thu, 21 Mar 2019 02:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWTXYDmhy/PNqBoubgnUL9wT6AC6UMupJKPEFo7Dg8s=;
        b=mGYLaZzCTQCf/QKZxM0Wqi9a7tEJihBhJ7ljOwz5muZ28RHETPNQrfa91cUASIPYiR
         /ivgLjGVOuIf4ZIt/X0wAJZeD50Hu6OELZiBSonxSnJSqqvKL/4MRJL2wIqZ7e+io3xY
         /kEjBO0pl9oHNIHJWj1JxdshAi4xadWICXsEx3A6tMylidxtius3LproriYVgq316dsQ
         pav7jaVNkUSBZOhwMF4W857XtaUX7SAVoKl5e59IqOUYLXTS4JwXyfJNjbW4CgOqKQd9
         oF6wOPpVX/Syc34dTNJJWmnXZJChxhSh2GetQTIigh7pIYr9UubHmvBtJqBzH1PJBEAU
         PjaA==
X-Gm-Message-State: APjAAAXAfEOyl+Ug9FB3YVfWwqzDYdHSDbIeDfugkfd31aXqSW2mxiy1
        sXtmHNd697bVcXll+xLsk6yJI/FruOPyww+qCFo=
X-Google-Smtp-Source: APXvYqzIuW/IC74tmX0ZK61+nxIMNRJxPtduA/iT4KXMm0qb6Luvgumsjh1w6I08zBmBFS4KPs9JEa6y/gPxqiGwyNc=
X-Received: by 2002:a9d:738c:: with SMTP id j12mr1643804otk.119.1553160541425;
 Thu, 21 Mar 2019 02:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <2816566.rddYshD6lm@aspire.rjw.lan> <20190321075807.GK6058@hirez.programming.kicks-ass.net>
 <20190321092055.GA7022@nazgul.tnic>
In-Reply-To: <20190321092055.GA7022@nazgul.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Mar 2019 10:28:50 +0100
Message-ID: <CAJZ5v0iiV3djzJrgj0GCeDuVs4hrtWKT9chtwLah5DpCw2sRaw@mail.gmail.com>
Subject: Re: [PATCH] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS handling
To:     Borislav Petkov <bp@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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

On Thu, Mar 21, 2019 at 10:21 AM Borislav Petkov <bp@suse.de> wrote:
>
> On Thu, Mar 21, 2019 at 08:58:07AM +0100, Peter Zijlstra wrote:
> > So I hate /dev/msr with a passion. It is absolute atrocious crap.
> >
> > Please, just make a real interface for this if it is important.
>
> Yeah, and we will start converting everything using /dev/msr to real
> interfaces and then taint on MSR write because, this should not have
> been allowed in the first place.

So as I've just said, I'm going to add a sysfs knob for adjusting EPB,
but I'd rather not do that in this patch.

This stuff doesn't work as intended right now, so let's fix it first
and then extend, OK?
