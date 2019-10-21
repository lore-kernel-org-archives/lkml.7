Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7371CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4921321A4A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="UXTT+DKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfJUMae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:30:34 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35053 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJUMad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:30:33 -0400
Received: by mail-ot1-f65.google.com with SMTP id z6so10818841otb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2CvQfJp0jZuEapaWIymH7i0ajtc/1eie3Idb6/0rzdk=;
        b=UXTT+DKD4aFgG0sPNlAE13Fiinq+4YhuM7PhQcg/qTjplekxUMkBaIeNnt8PqW74G9
         wSD5FJMpIn+BnO0OPVESwSofnzghEdh+kkI52RlMdHKm1mJ8fwvyZFT3aPh0B9Wd64ul
         I+SWpM2QxPUmXIglB5YFksCvbwh8MylNguh4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2CvQfJp0jZuEapaWIymH7i0ajtc/1eie3Idb6/0rzdk=;
        b=F7gXimk91/UBO+6sKU2Fql2fli+uK+oCrmpZjtkh6JMYGgNE5sGIgd53MMCjq6hilY
         6Beu1pgODXUX1JTHSZWh4BX2lezknCSUXJpy/6PMeToWJrgzsUoP88xCPlb46k95jhor
         t87y8ZDIBPQ+jNTmvTbilwsESxOQqDLLGprs+vfweQIdiw2zGPb3yCsVclYTA/GysMYY
         /C9/NvE4KCXZuK+9eNI4EagnmDbqAMtC1gOSYw/20uMAVZeimbfvGOeJZ0B73eQUalj/
         NcphPlKK+AktB2RUxBn5Kqc732Gx7d4IwtF41FJjqJR3KghtLbKo00aJM4Zg5h2efJPN
         CxVg==
X-Gm-Message-State: APjAAAXeBGOxidZ1HthiK03CGg843PbqbNgq7vj5rDfop4T7vXj3tVsd
        tHdbYeCQJAtqM6lpaFNEg5zAqs5ktlL8PtQH/quqpQ==
X-Google-Smtp-Source: APXvYqze1XJEkEgPezaKfsHEQ5jE5WjuS89LDcBZhg094jURalfq4JQ1Gaa971y651k64eQQkafcQ85B0mWMRdb8iTQ=
X-Received: by 2002:a9d:73c8:: with SMTP id m8mr19093933otk.75.1571661032652;
 Mon, 21 Oct 2019 05:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <CANaguZBTiLQiRQU9MJR2Qys8S2S=-PTe66_ZPi5DVzpPbJ93zw@mail.gmail.com>
 <CANaguZDOb+rVcDPMS+SR1DKc73fnctkBK0EbfBrf90dztr8t=Q@mail.gmail.com>
 <20191010135436.GA67897@aaronlu> <CANaguZDCtmXpm_rpTkjsfPPBscHCwz4u1OHwUt3XztzgLJa_jA@mail.gmail.com>
 <20191011073338.GA125778@aaronlu> <CANaguZCkKQTmgye+9nQhzQqYBrsnCmcjA46TPmLwN60vvMQ_7w@mail.gmail.com>
 <20191011114851.GA8750@aaronlu> <CANaguZBgv5N2Spv-Ldio5Umn6qU7dC0Px66sL9s11W7SK3f4Hg@mail.gmail.com>
 <20191012035503.GA113034@aaronlu> <CANaguZBevMsQ_Zy1ozKn2Z5Uj6WBviC6UU+zpTQOVdDDLK6r2w@mail.gmail.com>
 <20191014095725.GA78693@aaronlu>
In-Reply-To: <20191014095725.GA78693@aaronlu>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Mon, 21 Oct 2019 08:30:21 -0400
Message-ID: <CANaguZBo+sQ95X0Q8tAxkUxBw0_VAbhT-j6ddnMY5EPbHMJz4A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Mon, Oct 14, 2019 at 5:57 AM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
>
> I now remembered why I used max().
>
> Assume rq1 and rq2's min_vruntime are both at 2000 and the core wide
> min_vruntime is also 2000. Also assume both runqueues are empty at the
> moment. Then task t1 is queued to rq1 and runs for a long time while rq2
> keeps empty. rq1's min_vruntime will be incremented all the time while
> the core wide min_vruntime stays at 2000 if min() is used. Then when
> another task gets queued to rq2, it will get really large unfair boost
> by using a much smaller min_vruntime as its base.
>
> To fix this, either max() is used as is done in my patch, or adjust
> rq2's min_vruntime to be the same as rq1's on each
> update_core_cfs_min_vruntime() when rq2 is found empty and then use
> min() to get the core wide min_vruntime. Looks not worth the trouble to
> use min().

Understood. I think this case is a special case where one runqueue is empty
and hence the min_vruntime of the core should match the progressing vruntime
of the active runqueue. If we use max as the core wide min_vruntime, I think
we may hit starvation elsewhere. On quick example I can think of is during
force idle. When a sibling is forced idle, and if a new task gets enqueued
in the force idled runq, it would inherit the max vruntime and would starve
until the other tasks in the forced idle sibling catches up. While this might
be okay, we are deviating from the concept that all new tasks inherits the
min_vruntime of the cpu(core in our case). I have not tested deeply to see
if there are any assumptions which may fail if we use max.

The modified patch actually takes care of syncing the min_vruntime across
the siblings so that, core wide min_vruntime and per cpu min_vruntime
always stays in sync.

Thanks,
Vineeth
