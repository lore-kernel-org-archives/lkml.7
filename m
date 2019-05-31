Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4E7C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 05:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D021B263B0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 05:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVhfIp8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfEaFMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 01:12:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36885 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaFMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 01:12:54 -0400
Received: by mail-lf1-f66.google.com with SMTP id m15so6838247lfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 22:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YglXuDcWf9alTVQYtcbGhpd+g01E+BzX09PlpWU7znI=;
        b=vVhfIp8bGmjkhBghXDT5wKTG0FfDZVItFEl3sfCf172am+PmH1Adz/XHBDFUqhtu+x
         PdzEkUr9EJIUrSdSVgOW+hb72EbhNrKOaiHJ56nCFjWy9yEo9bxOj2PMGD0M0zqQnUbF
         YVEBUhkwt1MXpWVuZ2jsfZ3VM4H3OY7H3xEQuM2p76dmYDARwDcHwPtB1aBTVjgvzGvt
         6mi2luQHRT/irnsvNznPZANGcjVnMNo9kVtokTpYdN8YlrO+WTCsabpAOPCQXiUZIRWQ
         vKRL2OwX7vgz49zDCahE3/HkLkwZC2/lhAYLoGmLXJCHjP4PxwtFf4U+LO+H43ok1ksg
         7aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YglXuDcWf9alTVQYtcbGhpd+g01E+BzX09PlpWU7znI=;
        b=LE+Oyv+BD28oVNj2Qm5fJWaxEVePPXRDHIkfdHMMMIUJcj+igpMN8xI0F/k2GuKVC5
         21GfclAfRGiGJSdXbnoxPLBxNJveBZ/ExNx8pibMcweUnhGYZ73ouw+mk1PSBTmXR6tk
         RQeyQUp0cfPgFmhSDAV4aE3cPe4V6A9SWLMIDHlxMqRMzqZwtYiNynWEIBMaoK+DzWEJ
         eb586YSNJtGn4IPgpegrCCVw4qCkHP5TA8fgsJnBiiP29cREmOOGUb9GF1oeHZ+DINVS
         yngwjOIgu+ct0UUx85LL2ykYbwG0/P2ZO0ZzUO6Q8sLlDbqy1JoJtGO4UqvA7qLFk/IX
         QJWQ==
X-Gm-Message-State: APjAAAVUNEEqkoPTCuDsCfgqELrFjwNACHn1zgG9QregwUFp8oBFDpCE
        J7KLS4cgqM7VV4kH/29SKETRSMU+hW+zkv1xujo=
X-Google-Smtp-Source: APXvYqzxNanFqrzcDcuTnlHnXqkPxPoGos2xY39RE5g+INO2w2Vk/edgPmduLJWKiGd5hdWWAeZ+HBCuAyKUw/Xzsl8=
X-Received: by 2002:a19:2045:: with SMTP id g66mr4252270lfg.132.1559279572547;
 Thu, 30 May 2019 22:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com> <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
In-Reply-To: <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Fri, 31 May 2019 13:12:40 +0800
Message-ID: <CAERHkruVthrTgGqiH=yhCspZWpMDAu0G4rNcrDTKQzgPq9eqQQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
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

On Fri, May 31, 2019 at 11:01 AM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
>
> This feels like "date" failed to schedule on some CPU
> on time.
>
> My first reaction is: when shell wakes up from sleep, it will
> fork date. If the script is untagged and those workloads are
> tagged and all available cores are already running workload
> threads, the forked date can lose to the running workload
> threads due to __prio_less() can't properly do vruntime comparison
> for tasks on different CPUs. So those idle siblings can't run
> date and are idled instead. See my previous post on this:
> https://lore.kernel.org/lkml/20190429033620.GA128241@aaronlu/
> (Now that I re-read my post, I see that I didn't make it clear
> that se_bash and se_hog are assigned different tags(e.g. hog is
> tagged and bash is untagged).

Yes, script is untagged. This looks like exactly the problem in you
previous post. I didn't follow that, does that discussion lead to a solution?

>
> Siblings being forced idle is expected due to the nature of core
> scheduling, but when two tasks belonging to two siblings are
> fighting for schedule, we should let the higher priority one win.
>
> It used to work on v2 is probably due to we mistakenly
> allow different tagged tasks to schedule on the same core at
> the same time, but that is fixed in v3.

I have 64 threads running on a 104-CPU server, that is, when the
system has ~40% idle time, and "date" is still failed to be picked
up onto CPU on time. This may be the nature of core scheduling,
but it seems to be far from fairness.

Shouldn't we share the core between (sysbench+gemmbench)
and (date)? I mean core level sharing instead of  "date" starvation?

Thanks,
-Aubrey
