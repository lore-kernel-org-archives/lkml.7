Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13849C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F4C2070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="ZV2HOe+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbfHFPxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:53:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34590 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbfHFPxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:53:41 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so93754604otk.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 08:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2kU8vUtngahEqmHW2S1XUf53K0cOdiBL/zU2if7hPBA=;
        b=ZV2HOe+CkdXIYkkrGxoHzBb8ECZ5a8TqwsoVCM9YlCbr5ENgND/M6cdDMMxkCj3ZhM
         /JOY25ozOsGv+H4ffZ/gbxam8GLnd6ZfV3R3s29cPPOHz4PremFjPtHsSRiG/hzEMh70
         gmnEIxYF+Q9/DteRTAgr47v/e1UagfFKgc7TY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2kU8vUtngahEqmHW2S1XUf53K0cOdiBL/zU2if7hPBA=;
        b=cApkmlzGFslC5WnDryynAoB+FV8tqkzebw24XI+iN/+qtng6cX7eMiMk6aEoQ+nIRF
         AVhvUyWL1vpmXk1PIJDZ89ALaJwvHtZ+pewH6552QhiIskMSgZtX3VXBvVsgouA+yiMw
         pG45h/Bj/qaN/nN9uqgVIT6jffTT5UoAo2p+J7kerfWQdSYCuyU0YJy+0DMhy7EIUdYq
         MIt5W+xZDQH46A+30JoOtEph1Xj7EpAxy1/tADdXJaosqou8tAE9F5EhU3Uqg/UJBFU8
         o08uhvwXcmf57DxyJssOV99KcJqxgZsIZxNuqOKYzrhrIpURKTExmcG6uA66Cws9InKa
         2CRw==
X-Gm-Message-State: APjAAAX13MqG1W+XG3UnYX/LN42tiyQDVewhF/BuIR3hGDNhwX/WINhS
        1q8UjOA8e706ANmkGo+gtIxxY9HGU9oGDpTQIVRyGw==
X-Google-Smtp-Source: APXvYqzpmByq6A/E8d5eLnNZE80zcbFYNntbCOMNcIoRtcAid6s5ymWFNmPfqR0SQ04DnqwYRtNH4JTKJRSnHW7csRw=
X-Received: by 2002:a9d:5787:: with SMTP id q7mr4050241oth.75.1565106820218;
 Tue, 06 Aug 2019 08:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu> <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com> <20190802153715.GA18075@sinkpad>
 <f4778816-69e5-146c-2a30-ec42e7f1677f@linux.intel.com> <20190806032418.GA54717@aaronlu>
 <CAERHkrtJ3f1ggfG7Qo-KnznGo66p0Y3E0sAfb3ki6U=ADT6__g@mail.gmail.com>
 <54fa27ff-69a7-b2ac-6152-6915f78a57f9@linux.alibaba.com> <CANaguZDPdUp3Nb7hYjEiTpJTMVrKJyw2JDKP5EEphMjV-PAYpA@mail.gmail.com>
 <20190806141617.GR2332@hirez.programming.kicks-ass.net>
In-Reply-To: <20190806141617.GR2332@hirez.programming.kicks-ass.net>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Tue, 6 Aug 2019 11:53:29 -0400
Message-ID: <CANaguZC3v-x7O0RV3G7vk6p4BdW1E4uxBqf9NA=MOipeBWt+fw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> What accounting in particular is upset? Is it things like
> select_idle_sibling() that thinks the thread is idle and tries to place
> tasks there?
>
The major issue that we saw was, certain work load causes the idle cpu to never
wakeup and schedule again even when there are runnable threads in there. If
I remember correctly, this happened when the sibling had only one cpu intensive
task and did not enter the pick_next_task for a long time. There were other
situations as well which caused this prolonged idle state on the cpu.
One was when
pick_next_task was called on the sibling but it always won there
because vruntime
was not progressing on the idle cpu.

Having a coresched idle makes sure that the idle thread is not overloaded. Also
vruntime moves forward and tsk vruntime comparison across cpus works when
we normalize.

> It should be possible to change idle_cpu() to not report a forced-idle
> CPU as idle.
I agree. If we can identify all the places the idle thread is
considered special and
also account for the vruntime progress for force idle, this should be a better
approach compared to coresched idle thread per cpu.

>
> (also; it should be possible to optimize select_idle_sibling() for the
> core-sched case specifically)
>
We haven't seen this because, most of our micro test cases did not have more
threads than the cpus. Thanks for pointing this out, we shall cook some tests
to observe this behavior.

Thanks,
Vineeth
