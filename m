Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AEAC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963DC2087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551786791;
	bh=N17F4f3lPRDlgSIcwn1LV6y8RvUye44wM/BftzSmEGI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HmIKqVYACfzyXjNuMNjYbsPRQIgomja3+IagIP92GN7EcR//rEq4ai7pTZLqAZI/w
	 VCaGyAyojNcAdLQg8OPT0z3NabxlLO1hpoZo239mlr5vBD7rFOQx7qyCHaunrpk2Uq
	 iWcsGCK7RB6LrEyvHqEzLEDqRDeRnJufHcevCWg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfCELxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:53:10 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39113 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfCELxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:53:09 -0500
Received: by mail-ot1-f66.google.com with SMTP id e15so7164188otk.6;
        Tue, 05 Mar 2019 03:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N17F4f3lPRDlgSIcwn1LV6y8RvUye44wM/BftzSmEGI=;
        b=B5Geo0WKQSVgjcMqKrrYVq6QMp2kDc7ybomAgr2APoqSVZjKshUKdHCYw36cDHEZHQ
         o5pv+6fu7gK4MRzEvg8geNpmS/gGZKif7Xotr1MMB1Eq6Hm4izPfPiWkL59nf9W+IdfO
         BOMryfCoUXsqUT8D82ArDGNAJaNTGI5XYvfxOOyKEnMyRZ7PkMunkuO0f7lAXPanM8KM
         3k/d+VsmDXQhM+TYlV2noZhKMlqIi05qVSIG0GNMdHJA57tkzeknz+7CZwrD135Fd08b
         lkJu9jh2DvHIA20z9KHZ0MuyngXDv4T9BBtUGrdPKmD4ZmePFt3QDQ1VMeadrDqUGzoP
         EX1A==
X-Gm-Message-State: APjAAAWtLJm85GwjaKlZClmeCh5lCSlptYd97RvavnG3B6TNMtUJddYL
        8Oi5y/UaPHgnfl3UFpeUsQuzrWCBHLNQ1ArOH3Y=
X-Google-Smtp-Source: APXvYqyXs9hlgf/MbOtioepH3fnQIM2BlzeQEer3cQd0tZO3jAVOvQfWp4wuCkbzi8Hy6Ceawc2QYpwkEAxnALPsIXU=
X-Received: by 2002:a9d:718d:: with SMTP id o13mr647417otj.119.1551786788623;
 Tue, 05 Mar 2019 03:53:08 -0800 (PST)
MIME-Version: 1.0
References: <9956076.F4luUDm1Dq@aspire.rjw.lan> <20190305104256.7kvedlttuovmptpc@queper01-lin>
 <2336151.IZk3Z8DVvP@aspire.rjw.lan> <6357319.Iupbu3ldGQ@aspire.rjw.lan> <20190305114406.GV32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190305114406.GV32494@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Mar 2019 12:52:57 +0100
Message-ID: <CAJZ5v0iMLtnab0m56PfXHo9icg-tvSjyf8yKSiTfjuChtQbvrA@mail.gmail.com>
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU
 frequency on global turbo changes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Quentin Perret <quentin.perret@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 12:44 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 05, 2019 at 11:58:37AM +0100, Rafael J. Wysocki wrote:
> > So after the Peter's patch "sched/cpufreq: Fix 32bit math overflow"
> > I will need to recompute sg_cpu->min in sugov_limits().
>
> So there's still an open question; do we want that ->min thing to depend
> on available frequencies _at_all_ ?
>
> I'm thinking it might be a good thing to have the iowait boost curve be
> independent of all that.
>
> Like said; if we set it at 128 (static), it takes 9 consequtive wake-ups
> for it to reach 1024 (max). While now the curve depends on how wide the
> gap is between min_freq and max_freq. And it seems weird to have this
> behaviour depend on that. To me at least.
>
> Now, I don't know if 128/9 is the right curve, it is just a random
> number I pulled out of a hat. But it seems to make more sense than
> depending on frequencies.

I agree.
