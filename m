Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FB8C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C14B2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556356643;
	bh=RXvCiqxrKsd6av/gPwycKFehtN6eh+6QYsObHNJySyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jWskobA317mNnnuGDK3lrU/hH0vhIWCJP9BeK/wy1MkfxLx7vjc+KuROL4g1ZxIiC
	 DM+Caqkz7gROj6Qhwx8X2P0HVgxDWtWvo5LxskgASxN/pGJzcdOLqjRmLK5AdUYFmC
	 lWu+6mLgIcsmfSJyi8WsvepU10E1CInXSjQtkbGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfD0JRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 05:17:22 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:38544 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfD0JRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 05:17:21 -0400
Received: by mail-wr1-f42.google.com with SMTP id k16so7855141wrn.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 02:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8se/O6KFdh76pDCnsqVEe1RzLyU3I0mTGKKL1WGa/UM=;
        b=bDVQpYhRLAUg1qHbeiiwtTxqFPIwEw9pO8ROsCsxbrrNNPFar9+uE1zq2embcPEdIB
         OiKIo55BOKzBYAGzPAHCnHcqYppjThyXBYER8nz+1M2ZqzVqc9LxOb3p7CbFJ2Qif3UB
         ChsQ8llIji2jOAqfPgWkae01uvjexqOoh/veOTDDhyh9GEz0yUXuICuk3JhFXGw4lyJI
         WQZtUv7jLyCxNKxOnNQB0H2p+HQoKNP9dB2y+YSxEsE0KmR1wfte0el06F+usrpZ6hrQ
         63M9pzZ/MKpd0M5NLmnHECU/dQvaTcR4U5621Vb2CYkx8U2h9pAPp3b4zD5QCdEi3Rcy
         O5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8se/O6KFdh76pDCnsqVEe1RzLyU3I0mTGKKL1WGa/UM=;
        b=UX/o54O4kiK4iOTE6bne2wOiJBZQu+FOCCB/LmLShdkOzAc6C5evFCGZwezkU8r5Z+
         CWCJAcoEfJ48/t2kJQCfAUT2JJ8B8wQRiMUJbIYEtT7aXUMTeT8GTV3z0LDAtK/3VPRY
         5aNM9YZg1qdFuKenxRfzbtmYWyBEimvGZl7qzEiAOD0Z4QKzj3oudjGtlB/w+4iBS588
         tQOUhKquXetmYl00XePlB7qH04+Jf2QfLK5zdDEGYdPQ8rd1HbizSXEL5SdyOauzGPed
         GYL1I5iBkuU9//8AlkBy96V888tVFOZrRf9cR6IMnTKAklFGEi8AmiuR3XGNXSxFp79Z
         +aUQ==
X-Gm-Message-State: APjAAAUAD1lClPAPYA99W9p6TsQAmctECqrNNl7HMJGGi284PJhM8rx0
        WsJaW6EYJIk8UwRT0qtDF6mvHTFA
X-Google-Smtp-Source: APXvYqxi/83f/6D08Nmp+nqxpth2SsTw7eMsB77jVXsZajebc/+b3kQtbXWesw/MOPOzQ5R47ZEWrg==
X-Received: by 2002:adf:edc8:: with SMTP id v8mr3523266wro.206.1556356640232;
        Sat, 27 Apr 2019 02:17:20 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e15sm4615293wrr.69.2019.04.27.02.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 02:17:19 -0700 (PDT)
Date:   Sat, 27 Apr 2019 11:17:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Message-ID: <20190427091716.GC99668@gmail.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad>
 <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com>
 <CAERHkrs0=xcx9UUZbZPYq4QbznUqHAuVbTnafSVpZFKwAEFyMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkrs0=xcx9UUZbZPYq4QbznUqHAuVbTnafSVpZFKwAEFyMA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Aubrey Li <aubrey.intel@gmail.com> wrote:

> I have the same environment setup above, for nosmt cases, I used
> /sys interface Thomas mentioned, below is the result:
> 
> NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> 1/1      1.987( 1.97%)   2.043( 1.76%) -2.84% 1.985( 1.70%)  0.12%
> NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> 2/2      2.074( 1.16%)   2.057( 2.09%)  0.81% 2.072( 0.77%)  0.10%
> NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> 4/4      2.140( 0.00%)   2.138( 0.49%)  0.09% 2.137( 0.89%)  0.12%
> NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> 8/8      2.140( 0.00%)   2.144( 0.53%) -0.17% 2.140( 0.00%)  0.00%
> NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> 16/16    2.361( 2.99%)   2.369( 2.65%) -0.30% 2.406( 2.53%) -1.87%
> NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> 32/32    5.032( 8.68%)   3.485( 0.49%) 30.76% 6.002(27.21%) -19.27%
> NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> 64/64    7.577(34.35%)   3.972(23.18%) 47.57% 18.235(14.14%) -140.68%
> NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> 128/128 24.639(14.28%)  27.440( 8.24%) -11.37% 34.746( 6.92%) -41.02%
> NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> 256/256 38.797( 8.59%)  44.067(16.20%) -13.58% 42.536( 7.57%) -9.64%

What do these numbers mean? Are these latencies, i.e. lower is better?

Thanks,

	Ingo
