Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19634C4CECD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 01:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53DD21855
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 01:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGjZti6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfIRBeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 21:34:03 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45167 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfIRBeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 21:34:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id q64so5443166ljb.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 18:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oACsSltggDwFvHAR00vC/fD11NPczKv/oiLF+OBDplc=;
        b=iGjZti6cvwAgVLoBPDMEogRYfcGpd8FRi0SfNAM8Aw4Ugo3cLvJzQBc3U4DWUyNvC0
         SzHdILPIj1PKvKfLEiqApoBR3YBDHUwwkNtg3oqsau7a22aMr88w7ATnLski3vleZZGp
         dQ/9VV9xXI9dEnAa9bhjqzAaaY7gFChg/O1G865hLYuId8sJlrlnFNSDFz0kRgkNBHZR
         9zWfDDPWaamPLXkZO51qX6Cg2xqxTLlUtKAGYEWjOyRbGG7R/YGQBk7goZUeIlncuNS1
         DbD15EPWX5XEVQWVeS+uMTPLkZZ0ck5n0WbdDYCVpmZxZGvI5oGdKgz4AD/m/lDDNZ98
         rx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oACsSltggDwFvHAR00vC/fD11NPczKv/oiLF+OBDplc=;
        b=sgf7nj+iYlRbZZVZ/nKJy/L6edwabRu4xSxcoRATKYJQaskerAu15TmXYHWXypMkAL
         c+fNxqkzrjNdpyKpvTwy6oomk9jNhQNlN4utHvaPl2VC/TRnWYLqFImAHm27MPHZTdF9
         4kt7B5mxutHCqXm4z0LG5dXHcL1R7utGBndWeddFvtn5H4hyOOqXT8+hMw0QgwnbXQ2D
         FxaiVbLUAkKdBLH8K6ZvOYQpskOyBcH1t/exhnFAlgphG1YyPuOuZuuKXYlIQVekHv7I
         jkHlk0Fv3uC0HN09SbIMvMoiwYJPLRt6Yihx/W7rIQflvjcqBrx5tNZzOU7X1OxhzBcS
         Y1hg==
X-Gm-Message-State: APjAAAUHVaV2/k4YzuWe6meJ/Y8YQHYOhBQdeMlwz+4Ef0nKd94Q3KOx
        gUHMd4j4sDFV6XXBsmPi3EqfO9Ebf+ANd95++hk=
X-Google-Smtp-Source: APXvYqxgvAKvXZ0/+M3LivG93Cm85H8vUBxsmQJauBw2Ig6SjWBL+0UtdXH5E13vbFc7brpVfj6x7hCQWtq8iymxzO8=
X-Received: by 2002:a2e:3c14:: with SMTP id j20mr634473lja.84.1568770439623;
 Tue, 17 Sep 2019 18:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190726152101.GA27884@sinkpad> <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad> <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
 <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com> <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
 <20190911140204.GA52872@aaronlu> <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
 <20190912120400.GA16200@aaronlu> <CAERHkrsrszO4hJqVy=g7P74h9d_YJzW7GY4ptPKykTX-mc9Mdg@mail.gmail.com>
 <20190915141402.GA1349@aaronlu>
In-Reply-To: <20190915141402.GA1349@aaronlu>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Wed, 18 Sep 2019 09:33:48 +0800
Message-ID: <CAERHkrs9u24NrcNUwHq8mTW922Ffhy9rPkBGVN_afm1RBhabsQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
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

On Sun, Sep 15, 2019 at 10:14 PM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
>
> On Fri, Sep 13, 2019 at 07:12:52AM +0800, Aubrey Li wrote:
> > On Thu, Sep 12, 2019 at 8:04 PM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
> > >
> > > On Wed, Sep 11, 2019 at 09:19:02AM -0700, Tim Chen wrote:
> > > > On 9/11/19 7:02 AM, Aaron Lu wrote:
> > > > I think Julien's result show that my patches did not do as well as
> > > > your patches for fairness. Aubrey did some other testing with the same
> > > > conclusion.  So I think keeping the forced idle time balanced is not
> > > > enough for maintaining fairness.
> > >
> > > Well, I have done following tests:
> > > 1 Julien's test script: https://paste.debian.net/plainh/834cf45c
> > > 2 start two tagged will-it-scale/page_fault1, see how each performs;
> > > 3 Aubrey's mysql test: https://github.com/aubreyli/coresched_bench.git
> > >
> > > They all show your patchset performs equally well...And consider what
> > > the patch does, I think they are really doing the same thing in
> > > different ways.
> >
> > It looks like we are not on the same page, if you don't mind, can both of
> > you rebase your patchset onto v5.3-rc8 and provide a public branch so I
> > can fetch and test it at least by my benchmark?
>
> I'm using the following branch as base which is v5.1.5 based:
> https://github.com/digitalocean/linux-coresched coresched-v3-v5.1.5-test
>
> And I have pushed Tim's branch to:
> https://github.com/aaronlu/linux coresched-v3-v5.1.5-test-tim
>
> Mine:
> https://github.com/aaronlu/linux coresched-v3-v5.1.5-test-core_vruntime
>
> The two branches both have two patches I have sent previouslly:
> https://lore.kernel.org/lkml/20190810141556.GA73644@aaronlu/
> Although it has some potential performance loss as pointed out by
> Vineeth, I haven't got time to rework it yet.

In terms of these two branches, we tested two cases:

1) 32 AVX threads and 32 mysql threads on one core(2 HT)
2) 192 AVX threads and 192 mysql threads on 96 cores(192 HTs)

For case 1), we saw two branches is on par

Branch: coresched-v3-v5.1.5-test-core_vruntime
-Avg throughput:: 1865.62 (std: 20.6%)
-Avg latency: 26.43 (std: 8.3%)

Branch: coresched-v3-v5.1.5-test-tim
- Avg throughput: 1804.88 (std: 20.1%)
- Avg latency: 29.78 (std: 11.8%)

For case 2), we saw core vruntime performs better than counting forced
idle time

Branch: coresched-v3-v5.1.5-test-core_vruntime
- Avg throughput: 5528.56 (std: 44.2%)
- Avg latency: 165.99 (std: 45.2%)

Branch: coresched-v3-v5.1.5-test-tim
-Avg throughput:: 3842.33 (std: 35.1%)
-Avg latency: 306.99 (std: 72.9%)

As Aaron pointed out, vruntime is with se's weight, which could be a reason
for the difference.

So should we go with core vruntime approach?
Or Tim - do you want to improve forced idle time approach?

Thanks,
-Aubrey
