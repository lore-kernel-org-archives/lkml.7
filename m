Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C119DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939E020679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="SM/72PML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfHLPi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:38:59 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43116 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHLPi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:38:59 -0400
Received: by mail-ot1-f68.google.com with SMTP id e12so16113936otp.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zyjyZ9IF9yKP9YmOo1rW3lIJcoNsTg3G/mxjlSrkZUo=;
        b=SM/72PMLIelCgb3lWyhM30lVs68LiFi8DHWN+LknWn/Quh++yBKmoxum74Yfqt4CXT
         o9UnOy3vy4mgfQGk1vtF13V30voHjEZ6x0TR2/iDvIqffznKarydUaZcQrxzHrjM4gqP
         u78rLuBlzrnVFuoSQjrPdOQuOuvgBcWAdiZzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zyjyZ9IF9yKP9YmOo1rW3lIJcoNsTg3G/mxjlSrkZUo=;
        b=bxCLfJt4RkMQzcYjcOXyApqHVyTJqGW5qKN+YNA3MChVDCs+RGjn8sP0hHJaLAutf7
         57VvwiBJc3kH0G4zHSZj1hp6GX8OIJTPnkA7hHUZs9nZaqZzOBRiG7chM16cm61pUYAs
         pGwTfWg7ouRr0J3L65KNC+weR+7R1dYsHYWs8fvz+RAQZxLXI4CFzCrWDnSy2cg/bo03
         4QxnnBqnkOOt9hDBoA8bk6FdJHNlo0l3Wuh12PcMptN5PCkcVEOZLwGJ3RJkUjotckwY
         7XW60SlePOnDWHaxpw2vtaiw4gNRNWM+9Qrlimvc2IWJ5puS+0yvC4bLfV98lj/um2ct
         ukOA==
X-Gm-Message-State: APjAAAUcXXbrCCk7daVsNht8qyaoZUJYvzTQI20zCbxAxp2xeALL3rT5
        mSKqKv3f9s8uvZbd+gNdTzQx+SpC5ig3a9oaN05Atw==
X-Google-Smtp-Source: APXvYqwfyn2DmWsZj2bhXfvA9i4/XqS8i/McjJrxQuPNIVYFjFINgDT10ZJoH33WOPTfzc89HlMzh99B6HddHW0ucJY=
X-Received: by 2002:a05:6830:1249:: with SMTP id s9mr31776344otp.33.1565624337837;
 Mon, 12 Aug 2019 08:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad> <f4778816-69e5-146c-2a30-ec42e7f1677f@linux.intel.com>
 <20190806032418.GA54717@aaronlu> <e1c4a7ed-822e-93cb-ff1d-6a0842db115f@linux.intel.com>
 <20190806171241.GQ2349@hirez.programming.kicks-ass.net> <21933a50-f796-3d28-664c-030cb7c98431@linux.intel.com>
 <20190808064731.GA5121@aaronlu> <70d1ff90-9be9-7b05-f1ff-e751f266183b@linux.intel.com>
 <b7a83fcb-5c34-9794-5688-55c52697fd84@linux.intel.com> <20190810141556.GA73644@aaronlu>
In-Reply-To: <20190810141556.GA73644@aaronlu>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Mon, 12 Aug 2019 11:38:44 -0400
Message-ID: <CANaguZDEq4=5Q9pnFyWx0-Gfkoq-WxUXBYgiG6WKLTO5njAHUA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
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

> I have two other small changes that I think are worth sending out.
>
> The first simplify logic in pick_task() and the 2nd avoid task pick all
> over again when max is preempted. I also refined the previous hack patch to
> make schedule always happen only for root cfs rq. Please see below for
> details, thanks.
>
I see a potential issue here. With the simplification in pick_task,
you might introduce a livelock where the match logic spins for ever.
But you avoid that with the patch 2, by removing the loop if a pick
preempts max. The potential problem is that, you miss a case where
the newly picked task might have a match in the sibling on which max
was selected before. By selecting idle, you ignore the potential match.
As of now, the potential match check does not really work because,
sched_core_find will always return the same task and we do not check
the whole core_tree for a next match. This is in my TODO list to have
sched_core_find to return the best next match, if match was preempted.
But its a bit complex and needs more thought.

Third patch looks good to me.

Thanks,
Vineeth
