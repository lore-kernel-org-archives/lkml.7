Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDC8CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13512087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="FfDtwyMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfJ2UlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:41:09 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45026 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2UlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:41:09 -0400
Received: by mail-yw1-f66.google.com with SMTP id i123so72190ywe.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 13:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WuY6ILKiiGGehm6YMQNOxmZrHgw01PTiEn52jmhZoaA=;
        b=FfDtwyMjgbdzfnIywo4X2W9uOXHiEeV/UWv+Yjsjxo4A7EFWaS9lFQhbP34vclGHMR
         svX5wINVFqncLJsg/29M7iOeC1BedLpK2jJRy5rYBbhotctqIOXIrGEWfUz3zZEJs09A
         AYdTCSo8OlcK+gRVC3Tg9/AUoF2Wcsmvsno/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WuY6ILKiiGGehm6YMQNOxmZrHgw01PTiEn52jmhZoaA=;
        b=gOOBwhs3Z4Zt3Rozd6qjqTieu5txQSv1kSt/RFL6V9mmKuKpGM3Dnux21EcU/7o+6u
         106ogxTfk5yjB2YfoM6Nkd124ZmZtCSxMwO49/Lqsrymdu95JOttkX1q/+srhcfZULXt
         x4MfImc8e9aJsD9gBfOxMXg2p9YpaJdfej/RTpdmigwXhUtAKRFP4HP3rJuI0FU4sYcG
         VEgZlaQ3BzyjlKruAmXApvU/LI+/d3L7wtdH9o7+zZvf3NdUlqGa1Wv5Bz/bpRQF/PkW
         2BWPWgbA2/yb1+DoXfc9pDUkqSJQ92nTrODmaMhHMW4lpnLeskRLN1hY2y4/IEyzoGok
         8zmA==
X-Gm-Message-State: APjAAAWK4eZeM+GIvdndGD6/0/8dYhZa1lROVZuYy26j7YrAgVYdGHB2
        pYu3c6s3qZvKu6rR0wxXKJB2mQ==
X-Google-Smtp-Source: APXvYqzxnfmUiCYcK8IzDBpxXis52+iJCDi0yjqy3P5ViycIwFvgRsE2b8oY/jVgHxqU4WPTRGCADA==
X-Received: by 2002:a81:4fd7:: with SMTP id d206mr18526059ywb.344.1572381667243;
        Tue, 29 Oct 2019 13:41:07 -0700 (PDT)
Received: from sinkpad (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id m5sm9687909ywj.27.2019.10.29.13.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 13:41:06 -0700 (PDT)
Date:   Tue, 29 Oct 2019 16:40:58 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
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
Message-ID: <20191029204058.GB13345@sinkpad>
References: <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
 <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
 <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
 <20190911140204.GA52872@aaronlu>
 <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
 <20190912120400.GA16200@aaronlu>
 <CAERHkrsrszO4hJqVy=g7P74h9d_YJzW7GY4ptPKykTX-mc9Mdg@mail.gmail.com>
 <20190915141402.GA1349@aaronlu>
 <CAERHkrs9u24NrcNUwHq8mTW922Ffhy9rPkBGVN_afm1RBhabsQ@mail.gmail.com>
 <ade66e6d-cc52-4575-2f8f-e4d96c07a33c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ade66e6d-cc52-4575-2f8f-e4d96c07a33c@linux.intel.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-Sep-2019 01:40:58 PM, Tim Chen wrote:
> I think the test that's of interest is to see my load balancing added on top
> of Aaron's fairness patch, instead of using my previous version of
> forced idle approach in coresched-v3-v5.1.5-test-tim branch. 
>  
> I've added my two load balance patches on top of Aaron's patches
> in coresched-v3-v5.1.5-test-core_vruntime branch and put it in
> 
> https://github.com/pdxChen/gang/tree/coresched-v3-v5.1.5-test-core_vruntime-lb

We have been trying to benchmark with the load balancer patches and have
experienced some hard lockups with the saturated test cases, but we
don't have traces for now.

Since we are mostly focused on testing the rebased v4 currently, we will
post it without those patches and then we can try to debug more.

Thanks,

Julien
