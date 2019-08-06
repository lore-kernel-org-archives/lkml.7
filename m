Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8A8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5AC208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="WFRJal7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387709AbfHFQPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:15:00 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41882 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731840AbfHFQPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:15:00 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so93861281ota.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTE111eKmDfq20DLh90XUK2BGBhl3RK0/oln1LKQ/2M=;
        b=WFRJal7F1q9bz+XSCllS+X0xpTzXGm1xWfuuP6DausGQ4GZX/uFd33saZQcvRwVlF1
         GGSG+uQ/hI3sEZ3uNtmP4pv8sJnV3qjPnFhu853AahhgEZgj7++6rOY1sHB0Mqy7gFOg
         +VFj5JZzGjmFswS9BusY0bCYrCQQR02Lz83Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTE111eKmDfq20DLh90XUK2BGBhl3RK0/oln1LKQ/2M=;
        b=trQZv+9/R9LvDeaemDKDTWNtfmX2bexjUWCpcy2JVNbQNjqDyemmCIuQ6ua+m0RVrN
         7RY60m4jIpBGBA3ncKxkWZ8y/8yjq4QvkF3hbtM04fZvHVun5E+HVwq219KQHFOO3wJ9
         1i5REhkgOiSoHaIb9vQQvPzKyuk8DXYlF3PL0XbC0K/crgbnVOybHKt/gZFsak4Utxi/
         QI6yxyPK9hdefOaOm6nbIJ38X2TwvmoyZjvDXOqBM8wbWZoKgDvB29Y8RxyVPDIHE4Ar
         DH/g18KtKWe6v6Tpg3ZgFUY9elduLM5FKbeJ+L1y2/elrhLLaJBao4KRoqY9actjg7cw
         DP1g==
X-Gm-Message-State: APjAAAUqdXWKKloTERnNe82XaVOw0AD5iSqyGGfz3aLxIbYLb02ry5th
        /9NpN1FeUsbTYn21wmUfCzTvJW9bXiOvSAFMUMQODw==
X-Google-Smtp-Source: APXvYqy9nyBmd5Pkm17+mP+ZfNwPrA1UkWdTEyoe0ZMFyiApCnxW9WZHyZFUOczin98Lq60HndXvNpJ9SQbmW+cBRJ4=
X-Received: by 2002:a9d:5788:: with SMTP id q8mr3610538oth.237.1565108099662;
 Tue, 06 Aug 2019 09:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu> <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com> <20190802153715.GA18075@sinkpad>
 <f4778816-69e5-146c-2a30-ec42e7f1677f@linux.intel.com> <20190806032418.GA54717@aaronlu>
 <CAERHkrtJ3f1ggfG7Qo-KnznGo66p0Y3E0sAfb3ki6U=ADT6__g@mail.gmail.com>
 <54fa27ff-69a7-b2ac-6152-6915f78a57f9@linux.alibaba.com> <CANaguZDPdUp3Nb7hYjEiTpJTMVrKJyw2JDKP5EEphMjV-PAYpA@mail.gmail.com>
 <20190806134949.GA46757@aaronlu>
In-Reply-To: <20190806134949.GA46757@aaronlu>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Tue, 6 Aug 2019 12:14:48 -0400
Message-ID: <CANaguZAPZLLfqwMqUQwp=YdwUguekzDK7Gyuy+a179QR51TYZA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
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

> I think tenant will have per core weight, similar to sched entity's per
> cpu weight. The tenant's per core weight could derive from its
> corresponding taskgroup's per cpu sched entities' weight(sum them up
> perhaps). Tenant with higher weight will have its core wide vruntime
> advance slower than tenant with lower weight. Does this address the
> issue here?
>
I think that makes sense. Should work. We should also consider how to
classify untagged processes so that they are not starved .

>
> Care to elaborate the idea of coresched idle thread concept?
> How it solved the hyperthread going idle problem and what the accounting
> issues and wakeup issues are, etc.
>
So we have one coresched_idle thread per cpu and when a sibling
cannot find a match, instead of forcing idle, we schedule this new
thread. Ideally this thread would be similar to idle, but scheduler doesn't
now confuse idle cpu with a forced idle state. This also invokes schedule()
as vruntime progresses(alternative to your 3rd patch) and vruntime
accounting gets more consistent. There are special cases that need to be
handled so that coresched_idle never gets scheduled in the normal
scheduling path(without coresched) etc. Hope this clarifies.

But as Peter suggested, if we can differentiate idle from forced idle in
the idle thread and account for the vruntime progress, that would be a
better approach.

Thanks,
Vineeth
