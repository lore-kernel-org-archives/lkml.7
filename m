Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43F1C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 09:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6D123426
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 09:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ECY/8G9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfHaJNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 05:13:18 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41064 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfHaJNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 05:13:18 -0400
Received: by mail-io1-f65.google.com with SMTP id j5so19000867ioj.8
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 02:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjP1K4B+dJg4KiSw2tkIWX3jIArsrWzA1uaNHVJvlN0=;
        b=ECY/8G9VMWkU8NkmeoAPTBGwZKyqTh/0buwe3wSCqSCkeqp3BzM+7oO/JHpnh/ommu
         b8MdYwzPvfhgtrMkO1AdzVFJXguJZr/5FVKX1x/O4TuzWdsRnHe+ux5I4cpPIHEm1CY2
         RGd3YR6AMNcRYvcJJHIW34c5Z9lsd95tzZwU/eTxnMfZSJNl8//BWonTqKt2sPPP9S52
         U1WaxdM+pzKOjVj2OBaOw+FmDxGO2LN69kTyMOxCFvaDmRnWTqd/ydnN5Ba0Ejj5IrNo
         rbHSzezZnygxAi09/2x950anFWbi6vQcxPowzXLJ/0apKokBCeOdyQEg05SDzZE7imaR
         BN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjP1K4B+dJg4KiSw2tkIWX3jIArsrWzA1uaNHVJvlN0=;
        b=eu/WXBEF4ibUESX9DX7ADfuND2mtNqGKcEPumAwdT+bAKKpNN6EFmZIiSwA/KRNpk4
         jUqp24LwfN7rtIDPV8r/kDUGw1DdU+kVSq8CsFT6uyIudYR4R3QS6up5lbGjRpXYoXdv
         r9VJqMifMOAXV3cYEyrpJepCGGJdh/k2mthoO6DR09T5nNWOIYHW80LfO/2AJD0oHLKK
         p3k/D/nd5RJ4+OUqfjQEQp4ZB18cyYf0IexfaMvMlWtyIChZlx4Xpons/2Cnnb35ZgaL
         QDwQamsYY2blGfGf5SdjrQSLpl3q6cKZVNZL/STe4HitJkIUrYil21sVXHgNgf85BzFd
         oH7A==
X-Gm-Message-State: APjAAAXZB85r1xW3dAucl0yDgW7Sb4lY0bOvPt9TPHckvv6cwE2tRZCa
        JfqH1LszhybBtMu1UWusHF5b/NrVuOiwPcOEUMpDGw==
X-Google-Smtp-Source: APXvYqzgFQdus/RgPacid4CblEeawTeMIW58koQjqbhYpmMZVkjjCI0tduXeqDr8KU1lQfZXxBYwIiESTrWT/w/O3ug=
X-Received: by 2002:a5e:a90f:: with SMTP id c15mr6701972iod.41.1567242797252;
 Sat, 31 Aug 2019 02:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-4-kan.liang@linux.intel.com> <CABPqkBTS8bRjSwOBm2HxtuDWhxeZrTGa_E8mqfRfEJPzX1BNhw@mail.gmail.com>
 <20190831003110.GA5447@tassilo.jf.intel.com>
In-Reply-To: <20190831003110.GA5447@tassilo.jf.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Sat, 31 Aug 2019 02:13:05 -0700
Message-ID: <CABPqkBSPfZ6iQ_t1ESZf334q+dNVf=RvoNHdmKZSs5GLokbjFQ@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 3/8] perf/x86/intel: Support hardware TopDown metrics
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Fri, Aug 30, 2019 at 5:31 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> > the same manner. It would greatly simplify the kernel implementation.
>
> I tried that originally. It was actually more complicated.
>
> You can't really do deltas on raw metrics, and a lot of the perf
> infrastructure is built around deltas.
>
How is RAPL handled? No deltas there either. It uses the snapshot model.
At each interval, perf stat just reads the current count, and does not compute
a delta since previous read.
With PERF_METRICS, the delta is always since previous read. If you read
frequently enough you do not lose precision.

>
> To do the regular reset and not lose precision over time internally
> you have to keep expanded counters anyways. And if you do that
> you can just expose them to user space too, and have everything
> in user space just work without any changes (except for the final
> output)
>
> -Andi
>
