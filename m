Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEADCC31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B1720665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="PlAlSnaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393045AbfFMQwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:52:19 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32991 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730125AbfFMDW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:22:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id x2so20056581qtr.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 20:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LMV8qmRyYz+ACjw7vTpB3a3X9PpgtIV1RY8/GE0Ksi8=;
        b=PlAlSnaOIx0F1iguX+ksulHPvQfnoA0CZXjUwI7XykDfXBWZ/5Amzv7U06xkkG8gi+
         a25nxcJm27v1g4+k/29+6WjsC1A8RNJBXl3x61IxxPFl7bghmocNeNLpTsQDAdmkwQMF
         Etv46nTQ3rmCcAw0p/wBiNsdIKsFRaqI6wYvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LMV8qmRyYz+ACjw7vTpB3a3X9PpgtIV1RY8/GE0Ksi8=;
        b=elWP43nIoOxhu+GtSpKwwrK1IsPW3txnJPReD+quJuhpkpzGb6JATwMZEG3u0ACkng
         c0o9POq0qw+y68RiVZxC75inZzi5qr+zgOWOzfIx/S0JYUeF5787J2JerN2x2XuFSpwT
         547FqUyJhNSud/rCJboEKSLpy6Y142yYQ0IQZT1r1kOyAcslb38kxlSIeHQfE8S4R9U+
         +S+G6stNldGAa/EjiYwWus3cSZ/6D8WdceLic2yDzKm8e7PhMh9dI/nPrw3wXZcVTlRq
         YInGiKPV2sW2zIuR7O7+PNjcZV1z0/EjL+Ac04IdeSuxCWIhcB1q4VCFmMf1hQC4/rAp
         VuMA==
X-Gm-Message-State: APjAAAUxounOECxkcGpPKZBwuUNYS3+MPkVFvgX/3PysZbtpS8ZtqUDz
        eHaJvEvk1CuXrig3szQIzu1AYQ==
X-Google-Smtp-Source: APXvYqxdXwLzWyJ+c5OXEKgknoAOryleJkXq2q5AFQQ7yCUAvCLeH3gEQi5b/debrhh4XH9r+YIZPQ==
X-Received: by 2002:ac8:26dc:: with SMTP id 28mr71243705qtp.88.1560396175685;
        Wed, 12 Jun 2019 20:22:55 -0700 (PDT)
Received: from sinkpad (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r5sm871085qkc.42.2019.06.12.20.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 20:22:54 -0700 (PDT)
Date:   Wed, 12 Jun 2019 23:22:46 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190613032246.GA17752@sinkpad>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
 <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
 <20190531210816.GA24027@sinkpad>
 <20190606152637.GA5703@sinkpad>
 <20190612163345.GB26997@sinkpad>
 <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-Jun-2019 05:03:08 PM, Subhra Mazumdar wrote:
> 
> On 6/12/19 9:33 AM, Julien Desfossez wrote:
> >After reading more traces and trying to understand why only untagged
> >tasks are starving when there are cpu-intensive tasks running on the
> >same set of CPUs, we noticed a difference in behavior in ‘pick_task’. In
> >the case where ‘core_cookie’ is 0, we are supposed to only prefer the
> >tagged task if it’s priority is higher, but when the priorities are
> >equal we prefer it as well which causes the starving. ‘pick_task’ is
> >biased toward selecting its first parameter in case of equality which in
> >this case was the ‘class_pick’ instead of ‘max’. Reversing the order of
> >the parameter solves this issue and matches the expected behavior.
> >
> >So we can get rid of this vruntime_boost concept.
> >
> >We have tested the fix below and it seems to work well with
> >tagged/untagged tasks.
> >
> My 2 DB instance runs with this patch are better with CORESCHED_STALL_FIX
> than NO_CORESCHED_STALL_FIX in terms of performance, std deviation and
> idleness. May be enable it by default?

Yes if the fix is approved, we will just remove the option and it will
always be enabled.

Thanks,

Julien
