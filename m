Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA749C41514
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF41A22CB9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="EuiGUkPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfGZPVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:21:10 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41533 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfGZPVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:21:09 -0400
Received: by mail-qt1-f196.google.com with SMTP id d17so52845321qtj.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 08:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=io8KTwJRjBRf7t3xou4gVUXWk4KO93fqZyXX2l+iaRU=;
        b=EuiGUkPXxYhe9DK67/TFLayUUSZTFp6sBDmksQmQX42kb8wbfVwzQLIA1oRix9Khre
         3znGaKyZZwaM6j4N9BTzp0FB3eyYIaD+0EfXQAkuNsYoC0bftmdPBlmhWabsYPEpyETE
         5wZqcWMt9LD4/YzYNR+NSikOr02X+VqSa7DbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=io8KTwJRjBRf7t3xou4gVUXWk4KO93fqZyXX2l+iaRU=;
        b=gXfU8qUqjmXhzK8btnJD2yNiPfwwS1o2C5sHbjayi4uOZ7uXcLpYF1x0NH48yF7fVs
         2zQLdqaG+ooAsup/DW2zO6B181/va/Xd70o5kQuO4xvQYDKR5Wv5Op+8TkL+AoCnBcAx
         F9zIPJXh7FG/CGtx5SHqqQzf4K9Z7bPZLypPchndvQ8fiTRd/m0rD6RONdbbmBRdJ+je
         z7XX8SK886bC1UDhlvkUrVBzLbO+xqb4N4a7M1WXWlZUjWwa/zHXsnygqhNWBlSm9V/5
         oa9RcGBL5iYJUhihk8CEIgzoJ/8vvKHNvoY6Q3fCST088sd1j8iVJ0Lp57xo/mwJh+aS
         grEA==
X-Gm-Message-State: APjAAAWlApqijo6FUvSULuQHRromxAac0oIoL6l7Fj8qX/W+tNKfeykK
        PUSE+22+1Llli8HVlg6z4pMcBQ==
X-Google-Smtp-Source: APXvYqzK2RAxvgtMwWom/lsTWJDrp6aYGl+RN+3rPmdTy+dalMgICZ07ZxtUXo6wWw+k8Kpsav/w/w==
X-Received: by 2002:ac8:42d6:: with SMTP id g22mr61864611qtm.10.1564154468802;
        Fri, 26 Jul 2019 08:21:08 -0700 (PDT)
Received: from sinkpad (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id f132sm22257084qke.88.2019.07.26.08.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jul 2019 08:21:07 -0700 (PDT)
Date:   Fri, 26 Jul 2019 11:21:01 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
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
Message-ID: <20190726152101.GA27884@sinkpad>
References: <20190531210816.GA24027@sinkpad>
 <20190606152637.GA5703@sinkpad>
 <20190612163345.GB26997@sinkpad>
 <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
 <20190613032246.GA17752@sinkpad>
 <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad>
 <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725143003.GA992@aaronlu>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-Jul-2019 10:30:03 PM, Aaron Lu wrote:
> 
> I tried a different approach based on vruntime with 3 patches following.
[...]

We have experimented with this new patchset and indeed the fairness is
now much better. Interactive tasks with v3 were complete starving when
there were cpu-intensive tasks running, now they can run consistently.
With my initial test of TPC-C running in large VMs with a lot of
background noise VMs, the results are pretty similar to v3, I will run
more thorough tests and report the results back here.

Instead of the 3/3 hack patch, we were already working on a different
approach to solve the same problem. What we have done so far is create a
very low priority per-cpu coresched_idle kernel thread that we use
instead of idle when we can't co-schedule tasks. This gives us more
control and accounting. It still needs some work, but the initial
results are encouraging, I will post more when we have something that
works well.

Thanks,

Julien
