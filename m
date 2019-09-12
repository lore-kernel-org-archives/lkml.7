Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ABDC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 23:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018DB2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 23:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZYuNMhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfILXNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 19:13:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34638 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfILXNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 19:13:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id h2so18732262ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 16:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cMjlgriNCzvIkVTB26pcWV68J130Qu1Uc+SjWIpj8f4=;
        b=HZYuNMhW5ZekwtHAd1wOVinsQ5DFyx8ZZ3iFj9JV5qfXzdxdD5L5ntCcvh38nWkuaZ
         IXdIkRco2aopxVb7df/kXb+h3miFufJQYDToUBfpRp7GIdyllNpIqbkkioxXdNJvWUEB
         nR4qiPn+FYjtwP0I3mu94FqzobiEzTDSNd/YM+d9kmTYnm9SPI+KQU+AEyniv23VyDHz
         7YAaspbwcV4VKi7yrnOERiz70NVJpo0pwkJ58j15TPZMQhI4EQUjMyWm0pz73rD0tHxx
         kl+5EnhaRqUsN5QY5Lu2qCk/7SsDPqeef+aG8/biRrQxLg7snzMP0Qgpt4Z/hvKAtx0W
         83Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cMjlgriNCzvIkVTB26pcWV68J130Qu1Uc+SjWIpj8f4=;
        b=mrZW4P2MNx42Z9KUen9LCdERv8E1FHq7T/LSYTcnh7PIp/m+y2d2gQRZAUzPoxqBJg
         hhRPNkw9ahDurezC95gDnKdKKW6abaAokIE1v7xRrGqEYgAivGpb1fQxfI8AS6p/zZaM
         aitDX9YT+Yx5eSGYfSK3eJx5LHUaUn9vLfDBIh6jZafasuLzWID4RFwrpHIv79l1uS69
         YpXyVHDS1idtssZKZuBa/n7eGKdEzJFR4NQsYxTMtGEwXAV/LSxQFppe/X/2t/kcIF+R
         ZVJWQo8zDOYESLGKjOw12R0DQFpiAk6K9Jntkwt3+jpSOlOVdZ0mEgtztVORvm0JWdoS
         hbtQ==
X-Gm-Message-State: APjAAAUbgFhtFBJni3Z8KjQjRqIUwqbylQdxux7qSevwj7vsfleXqxge
        SAtVs4kGGfx9fwgM4urwmW8eRd0Dx2wbZx9H5WU=
X-Google-Smtp-Source: APXvYqyvfX805aUi6JxjJDejRyfEy27oF3Ik+oT5mN/VqnJT2/aVR5TrtTInkPcJjJwoSamsF7mCf8NnecfolxldfTQ=
X-Received: by 2002:a2e:9114:: with SMTP id m20mr3928672ljg.103.1568329984026;
 Thu, 12 Sep 2019 16:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu> <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com> <20190802153715.GA18075@sinkpad>
 <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com> <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
 <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com> <20190911140204.GA52872@aaronlu>
 <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com> <20190912120400.GA16200@aaronlu>
In-Reply-To: <20190912120400.GA16200@aaronlu>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Fri, 13 Sep 2019 07:12:52 +0800
Message-ID: <CAERHkrsrszO4hJqVy=g7P74h9d_YJzW7GY4ptPKykTX-mc9Mdg@mail.gmail.com>
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

On Thu, Sep 12, 2019 at 8:04 PM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
>
> On Wed, Sep 11, 2019 at 09:19:02AM -0700, Tim Chen wrote:
> > On 9/11/19 7:02 AM, Aaron Lu wrote:
> > I think Julien's result show that my patches did not do as well as
> > your patches for fairness. Aubrey did some other testing with the same
> > conclusion.  So I think keeping the forced idle time balanced is not
> > enough for maintaining fairness.
>
> Well, I have done following tests:
> 1 Julien's test script: https://paste.debian.net/plainh/834cf45c
> 2 start two tagged will-it-scale/page_fault1, see how each performs;
> 3 Aubrey's mysql test: https://github.com/aubreyli/coresched_bench.git
>
> They all show your patchset performs equally well...And consider what
> the patch does, I think they are really doing the same thing in
> different ways.

It looks like we are not on the same page, if you don't mind, can both of
you rebase your patchset onto v5.3-rc8 and provide a public branch so I
can fetch and test it at least by my benchmark?

Thanks,
-Aubrey
