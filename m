Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF38C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE32A206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="X9kZZAea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfHFMY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:24:29 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46777 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFMY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:24:29 -0400
Received: by mail-ot1-f67.google.com with SMTP id z23so63591870ote.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 05:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+OtseeKLSiM3o2ZCafh2q89vJhJltkIdOIzMnLRVtP4=;
        b=X9kZZAeawbYIt+4ShKknt0vQ/h0Xz8bq70+1ovNArQ/0LHG+mJXv6X1cjLavzyzIb2
         4R8RZ7ob7yPl0gS1hcvVB1ASuKHgAcPwUSXPoPLf+OzESICI9LrRQvQnowSkMRWZE0Wk
         ZXfY2tKmm95YP1ZpZj8heCaeKiqV7ShI70lLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+OtseeKLSiM3o2ZCafh2q89vJhJltkIdOIzMnLRVtP4=;
        b=KCrNZnfvPeC2kzqLPGbx3olg7SnRud8muAyryFk5FYZhcDvDq6+4TohCdLT8KAj1wJ
         rUKhvC7eShFLb5Ad4Q2tD8sUNs9BR3pNvsnyxzG8SeUTMDOzUFWyE/hdmLe0YPOkxawz
         WBQcPOvtg72o8ij174gGUvY2jBrXei2PXesw1Qg+75hFxvRhukt41pUXD/E5Wp2cTLLm
         csYZHpjdqp5UXHVebsjVy9gZ8TwlD+UxKX8drvH+y5FbZjy/uXRQP1A0ygjj90sp0aJl
         PNqAUuF6MChj1cM8HvOXwt2QB9/aRplCxFM9chvgzwyIfvCjjVmMDXQq49JTGMBeIhId
         KgJA==
X-Gm-Message-State: APjAAAW0V6zFlqJNhKdu38Zpj5Q7Y4Mwl+Y9FHfTlS9Ac7RIxZFwr+40
        uJL5m7u4nfFE7Wn1YiYjb8XPteP9uPGMoXVBOUVas43e
X-Google-Smtp-Source: APXvYqxSoEKndvUUPPo/MEfH60uc0V9NpBCE2blADx1AEIGIJLn6U4S/dFHwHNDN2IuoiVyzEg2Bhcu9yvTIxKbVYIg=
X-Received: by 2002:a9d:5788:: with SMTP id q8mr2706168oth.237.1565094268049;
 Tue, 06 Aug 2019 05:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190613032246.GA17752@sinkpad> <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad> <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu> <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com> <20190802153715.GA18075@sinkpad>
 <f4778816-69e5-146c-2a30-ec42e7f1677f@linux.intel.com> <20190806032418.GA54717@aaronlu>
 <CAERHkrtJ3f1ggfG7Qo-KnznGo66p0Y3E0sAfb3ki6U=ADT6__g@mail.gmail.com> <54fa27ff-69a7-b2ac-6152-6915f78a57f9@linux.alibaba.com>
In-Reply-To: <54fa27ff-69a7-b2ac-6152-6915f78a57f9@linux.alibaba.com>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Tue, 6 Aug 2019 08:24:17 -0400
Message-ID: <CANaguZDPdUp3Nb7hYjEiTpJTMVrKJyw2JDKP5EEphMjV-PAYpA@mail.gmail.com>
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

> >
> > I also think a way to make fairness per cookie per core, is this what you
> > want to propose?
>
> Yes, that's what I meant.

I think that would hurt some kind of workloads badly, especially if
one tenant is
having way more tasks than the other. Tenant with more task on the same core
might have immediate requirements from some threads than the other and we
would fail to take that into account. With some hierarchical management, we can
alleviate this, but as Aaron said, it would be a bit messy.

Peter's rebalance logic actually takes care of most of the runq
imbalance caused
due to cookie tagging. What we have found from our testing is, fairness issue is
caused mostly due to a Hyperthread going idle and not waking up. Aaron's 3rd
patch works around that. As Julien mentioned, we are working on a per thread
coresched idle thread concept. The problem that we found was, idle thread causes
accounting issues and wakeup issues as it was not designed to be used in this
context. So if we can have a low priority thread which looks like any other task
to the scheduler, things becomes easy for the scheduler and we achieve security
as well. Please share your thoughts on this idea.

The results are encouraging, but we do not yet have the coresched idle
to not spin
100%. We will soon post the patch once it is a bit more stable for
running the tests
that we all have done so far.

Thanks,
Vineeth
