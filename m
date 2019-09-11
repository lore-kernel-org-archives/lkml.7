Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64050C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3809320838
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="EIcFZCwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfIKQrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:47:48 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38340 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbfIKQrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:47:48 -0400
Received: by mail-oi1-f194.google.com with SMTP id 7so14695561oip.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UyBgw3AODQFVN+4HIEsd/XrS1E/piEwo3I8b+tw/RVY=;
        b=EIcFZCwiNCLKLgzI01OETGWXiJMvC3C5nUTiqtRi7Ez04rFp7Y2XUZR31V/+BVso0Y
         dfhQpSmWtVm7DhlL5OGmTxV+ccvXfV7MLve0lCBUILV9MyHRdqwUKevxzs/TNmvLgipA
         deuNb39T14E0bLyiv4cwPjNEmsxKOh6Dr+XwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UyBgw3AODQFVN+4HIEsd/XrS1E/piEwo3I8b+tw/RVY=;
        b=Pjj8V2fwLDOryDN1maQyXDSxuhE7JQFO14ojXfUFXhbD6HjPAzSjdHu1LHvUKyo/Bp
         kUuf2/dQhZVnNMflImOCPqLCaL1c2RUgevL0GHBpgTr6LWPI7ORg4zq14J5V8BQGqwVA
         hNuTLcYlV947Y7AjnRqM4kVlKwcRS/LYEyyBM3LZdtL5Xgmw26Q7/CaVyVyoLeQ5S36p
         tGDFNV8AYyAWJ4NGxvNVK6lN651XX1s9L+BbVfzX85TN3rp0mYQGyZuMsDQPxkCK9Dwr
         82gYopo/nLyINRdJroHAdb1Nk6JbqC1NS91k7VZhgZkFamS6qDnTNBi/zS4cptzUTC64
         +UbQ==
X-Gm-Message-State: APjAAAUy8Y9AZHDnWBk0yFovSrz/pG2gEwGKrPXvtOilmKYrM60uqoD7
        59Y4eNi9K9J4BHcBWli02HAn1mtp+c63sTOvZF7fng==
X-Google-Smtp-Source: APXvYqxngOKuvwOss0eH9pdiMhxCTkuwo4+ViAGBU4DgcVhDRVJWpB8/f0oP/5Qxbgfe/M/nLmd4UEdfjzMDgWGeT2Q=
X-Received: by 2002:aca:ab84:: with SMTP id u126mr4754572oie.115.1568220465630;
 Wed, 11 Sep 2019 09:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190619183302.GA6775@sinkpad> <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu> <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com> <20190802153715.GA18075@sinkpad>
 <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com> <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
 <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com> <20190911140204.GA52872@aaronlu>
 <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
In-Reply-To: <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Wed, 11 Sep 2019 12:47:34 -0400
Message-ID: <CANaguZCH-jjHrWwycU3vz6RfNkW9xN+DoRkHnL3n8-DneNV3FQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
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

> > So both of you are working on top of my 2 patches that deal with the
> > fairness issue, but I had the feeling Tim's alternative patches[1] are
> > simpler than mine and achieves the same result(after the force idle tag
>
> I think Julien's result show that my patches did not do as well as
> your patches for fairness. Aubrey did some other testing with the same
> conclusion.  So I think keeping the forced idle time balanced is not
> enough for maintaining fairness.
>
There are two main issues - vruntime comparison issue and the
forced idle issue.  coresched_idle thread patch is addressing
the forced idle issue as scheduler is no longer overloading idle
thread for forcing idle. If I understand correctly, Tim's patch
also tries to fix the forced idle issue. On top of fixing forced
idle issue, we also need to fix that vruntime comparison issue
and I think thats where Aaron's patch helps.

I think comparing parent's runtime also will have issues once
the task group has a lot more threads with different running
patterns. One example is a task group with lot of active threads
and a thread with fairly less activity. So when this less active
thread is competing with a thread in another group, there is a
chance that it loses continuously for a while until the other
group catches up on its vruntime.

As discussed during LPC, probably start thinking along the lines
of global vruntime or core wide vruntime to fix the vruntime
comparison issue?

Thanks,
Vineeth
