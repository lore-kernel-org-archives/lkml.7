Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F2DC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E950720665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="cJlYpUlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388324AbfHBPha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:37:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37872 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfHBPha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:37:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id y26so74317989qto.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jv/NZoBvl7h7xSNp5mqC+DC1X6Mcvs4zQZLilLuxBX0=;
        b=cJlYpUlQpNAUL7Rn36cXtRaIN9MKSXwFEeuaiVu/UnHGWMYr1eeZO0DK0BhhyTZ6J1
         ZhnPVggRLGXPJA9g2iX1gbNt4/qhcddPEhNJWQwiR3hMGmvN8z58wwTxXGYL5ecENeoF
         svjYww4B/P8qerHQx7Qk9rlabVkBMkVgT4f78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jv/NZoBvl7h7xSNp5mqC+DC1X6Mcvs4zQZLilLuxBX0=;
        b=tzGFiHmv3BM/0aDuz8LUZx0gi48RT5+g4gMWIQx+E7H8H4ql71RUUwvKqesiuF72fz
         IBXEduI7CPdbMjLdC/PzrJD8fuik2Xk6az5/vrbvIb1ZYGosEuy8lR6JrKwBVvwgkydN
         WHr4XSf8XRgsdZoNmVaYgkNKYOu1nqG20Qwrqcpvo7005BVIt/1Hn940ArS000/8z6b3
         2C8eAFUGPeHwh4kSB/NkANhmu2fs5x0vgIPfaNr5Yp7Voo2PK9rMY7+u3rDuhNWmEri2
         spAd8NEOP1E+8imR7lg69wZBcEddTjl3bPUtQXu9t7r4+fBTv+qvppeEtg45NxPxwwOw
         GorQ==
X-Gm-Message-State: APjAAAUq9jAA0ZuL2eX96PROn0NCeA0QZtVD8M4SccYJdLE80BG9xXgo
        innq/DSvU7n9MbcEjT5fzS6Wdw==
X-Google-Smtp-Source: APXvYqwlulgCCn/mp+s4XpxoEZe3TKoB59KnHq4PhgKymnz2fu+Pl88KeWuTqNgFfEuud2lg1+H0FQ==
X-Received: by 2002:ac8:303c:: with SMTP id f57mr96036240qte.294.1564760248496;
        Fri, 02 Aug 2019 08:37:28 -0700 (PDT)
Received: from sinkpad (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id a67sm34122957qkg.131.2019.08.02.08.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Aug 2019 08:37:27 -0700 (PDT)
Date:   Fri, 2 Aug 2019 11:37:15 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
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
Message-ID: <20190802153715.GA18075@sinkpad>
References: <20190612163345.GB26997@sinkpad>
 <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
 <20190613032246.GA17752@sinkpad>
 <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad>
 <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu>
 <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We tested both Aaron's and Tim's patches and here are our results.

Test setup:
- 2 1-thread sysbench, one running the cpu benchmark, the other one the
  mem benchmark
- both started at the same time
- both are pinned on the same core (2 hardware threads)
- 10 30-seconds runs
- test script: https://paste.debian.net/plainh/834cf45c
- only showing the CPU events/sec (higher is better)
- tested 4 tag configurations:
  - no tag
  - sysbench mem untagged, sysbench cpu tagged
  - sysbench mem tagged, sysbench cpu untagged
  - both tagged with a different tag
- "Alone" is the sysbench CPU running alone on the core, no tag
- "nosmt" is both sysbench pinned on the same hardware thread, no tag
- "Tim's full patchset + sched" is an experiment with Tim's patchset
  combined with Aaron's "hack patch" to get rid of the remaining deep
  idle cases
- In all test cases, both tasks can run simultaneously (which was not
  the case without those patches), but the standard deviation is a
  pretty good indicator of the fairness/consistency.

No tag
------
Test                            Average     Stdev
Alone                           1306.90     0.94
nosmt                           649.95      1.44
Aaron's full patchset:          828.15      32.45
Aaron's first 2 patches:        832.12      36.53
Aaron's 3rd patch alone:        864.21      3.68
Tim's full patchset:            852.50      4.11
Tim's full patchset + sched:    852.59      8.25

Sysbench mem untagged, sysbench cpu tagged
------------------------------------------
Test                            Average     Stdev
Alone                           1306.90     0.94
nosmt                           649.95      1.44
Aaron's full patchset:          586.06      1.77
Aaron's first 2 patches:        630.08      47.30
Aaron's 3rd patch alone:        1086.65     246.54
Tim's full patchset:            852.50      4.11
Tim's full patchset + sched:    390.49      15.76

Sysbench mem tagged, sysbench cpu untagged
------------------------------------------
Test                            Average     Stdev
Alone                           1306.90     0.94
nosmt                           649.95      1.44
Aaron's full patchset:          583.77      3.52
Aaron's first 2 patches:        513.63      63.09
Aaron's 3rd patch alone:        1171.23     3.35
Tim's full patchset:            564.04      58.05
Tim's full patchset + sched:    1026.16     49.43

Both sysbench tagged
--------------------
Test                            Average     Stdev
Alone                           1306.90     0.94
nosmt                           649.95      1.44
Aaron's full patchset:          582.15      3.75
Aaron's first 2 patches:        561.07      91.61
Aaron's 3rd patch alone:        638.49      231.06
Tim's full patchset:            679.43      70.07
Tim's full patchset + sched:    664.34      210.14

So in terms of fairness, Aaron's full patchset is the most consistent, but only
Tim's patchset performs better than nosmt in some conditions.

Of course, this is one of the worst case scenario, as soon as we have
multithreaded applications on overcommitted systems, core scheduling performs
better than nosmt.

Thanks,

Julien
