Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B45C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFA7216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Slx6Q233"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbfI3PWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 11:22:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44369 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731127AbfI3PWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 11:22:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id u40so17514457qth.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 08:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8HKacM6sHRzyZgKopSHdE59j+eiLZ00J50hLlPkJ1XA=;
        b=Slx6Q233ul7BctWF7jvQiBNkK0Wuthfu75EYw66j3xhD6wzh9IedmDVhLN5t0+eAa1
         /zS9A4cOYUzMrnzgJXa53Q0usr5z5vhBtjU5blb8XG1Ko5uglOqgy+r15b6exW0MtIp4
         V5JD4+63UfsY0v+yUuJVaSzbKCdbW1rJHLg0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8HKacM6sHRzyZgKopSHdE59j+eiLZ00J50hLlPkJ1XA=;
        b=uaMJCS7SH7+aA5ye/x7a4yHuQoPDWF6oNIA5ei+LiPMcgNp2kwpgkliZ7S2Fy8GM7n
         E48f/2zBirBEXqMG3yfzCJyFw24J6r19NDTV57Nbl5a5qOsI5aFWOVD4t19hGfUZH5M/
         En4JyMfKr+T3iLnhTfW168W8P55Wo+IrGI2TRo6t3Mg7rV8i8UzextLvj83lzYKLK9IV
         a9QcvKKixA/OqZfWFAVbdKc6jkMsaocZhGc+BjuA7vam8CJ/ZRU+gVwgik4+Q4q1F7gQ
         OZ3uzsBHnF2BKvNmoY31oA9A1D5eoVxni+IORmNAQv/bOz/aTttXd60x89Bd7dVP8Rjv
         vUeg==
X-Gm-Message-State: APjAAAUpWnHMqvFW1aFf8aJkosshaHVokqpiB9c8Buz6DUOtGDKT7QSy
        4L2DFPdzK4YHOCWCB3xbVO1HjA==
X-Google-Smtp-Source: APXvYqyGSWEFEqgll1VZfxwrv9tQVOa1pXhPWe24T7nqqT5gaaBmnhAgkw1J6KUPFLXtP5dw6JhWVg==
X-Received: by 2002:ac8:5414:: with SMTP id b20mr8636045qtq.85.1569856969775;
        Mon, 30 Sep 2019 08:22:49 -0700 (PDT)
Received: from sinkpad (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id 139sm6168276qkf.14.2019.09.30.08.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Sep 2019 08:22:48 -0700 (PDT)
Date:   Mon, 30 Sep 2019 11:22:40 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Dario Faggioli <dfaggioli@suse.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20190930152240.GA13385@sinkpad>
References: <20190619183302.GA6775@sinkpad>
 <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu>
 <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
 <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
 <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I've made an attempt in the following two patches to address
> the load balancing of mismatched load between the siblings.
> 
> It is applied on top of Aaron's patches:
> - sched: Fix incorrect rq tagged as forced idle
> - wrapper for cfs_rq->min_vruntime
>   https://lore.kernel.org/lkml/20190725143127.GB992@aaronlu/
> - core vruntime comparison
>   https://lore.kernel.org/lkml/20190725143248.GC992@aaronlu/
> 
> I will love Julien, Aaron and others to try it out.  Suggestions
> to tune it is welcomed.

Just letting you know that I will be testing your load balancing patches
this week along with the changes Vineeth is currently doing. I didn't
test it before because I was focused on single threaded and pinned
micro-benchmarks, but I am back on scaling tests so it will be
interesting to see.

Thanks,

Julien
