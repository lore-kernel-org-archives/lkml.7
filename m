Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26530C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83B52082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rE/O3t6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbfDBPJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:09:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40276 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730616AbfDBPJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:09:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so11920191ljq.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 08:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z0pplf97Qa0x1rfBTzORlWE9huCotnwaWGrQII1utZo=;
        b=rE/O3t6kk/QZPxvR2GzRLQD302tFR94BdOxcFNt9+9xXwn8mC/PQVR5fMtUVd+PKTV
         V7gfrBiOYdTFhfs97HJfwGlwIrE7reerUu3s4GZ4UPkB+IAri7fMYiCT40zkXaQPRTPj
         tQIf5e9r6Sx+I65f1HDO8pFsEznZjWMDu5wbRoBB4q+BjLIK5Mr9W4ld6ouveTkAh6d7
         4Dfit8dyteqL/tI7Kto6GyNkoOzR+r9BMKYktmXQZyxqBeSy6vRGBw+G1RLdyZi0/0fA
         srarGE9Ws27HXnggdiE2ORG6FW5avTHszk98JHORXreyKbJ2cZdFF+/6Lgckp8Nf5n6d
         +HuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z0pplf97Qa0x1rfBTzORlWE9huCotnwaWGrQII1utZo=;
        b=ON8zfNZv/FnMQKju1id9F//xjYrzaZzwoOF0XNds3v9E/9cJZUXG+/rpCO47gg1eG7
         6T4dW+UFoRpiqJAWD0e18b57wEhKcPaDpwqCtu2/HXQ+U8/3FKqkCC/91hO7ajhIpDY2
         pa7W0Rb52TYukFf+wuTDK/xxekrj0/5GaC0ENx6ogC9jv5sH8bTh+jZCCjAaO3QMDL7z
         lqJ1IgxjwhK0NiSi0c2a7ruYdam6p1dhbtfbeLH1ZxRb2GiaCzG8UwLfIXhmu1jWj3LU
         ae71QfXwbayC4fYWz7a/rVORKRCjqYkdJJS3YhRo8p3eXbfTxatLP0uogdABhpPtnXre
         ZOzg==
X-Gm-Message-State: APjAAAXQozn+GUZablfKfhTxabXQZI8PUQ/qMfCUb+udrtystD8daTW9
        7FK8UIE+IXh4ZI5QGs83qTQ=
X-Google-Smtp-Source: APXvYqxlwltxLwsMB57nBq3BAq/8ihS7+yBVpsGSWmDe/waZJ8o+BUqpg/7P5oDdo1FmlQz7VWEEbg==
X-Received: by 2002:a2e:9812:: with SMTP id a18mr34388969ljj.146.1554217779060;
        Tue, 02 Apr 2019 08:09:39 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id f25sm2505744lfc.46.2019.04.02.08.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 08:09:38 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 7C95A4601CA; Tue,  2 Apr 2019 18:09:36 +0300 (MSK)
Date:   Tue, 2 Apr 2019 18:09:36 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Vince Weaver <vince@deater.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [RFC PATCH v3 0/3] x86/perf/amd: AMD PMC counters and NMI latency
Message-ID: <20190402150936.GB23501@uranus>
References: <155415519143.24457.2706922532995302758.stgit@tlendack-t1.amdoffice.net>
 <20190402130302.GL12232@hirez.programming.kicks-ass.net>
 <20190402132200.GA23501@uranus>
 <alpine.DEB.2.21.1904021050090.15645@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904021050090.15645@pianoman.cluster.toy>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 10:53:38AM -0400, Vince Weaver wrote:
> On Tue, 2 Apr 2019, Cyrill Gorcunov wrote:
> > On Tue, Apr 02, 2019 at 03:03:02PM +0200, Peter Zijlstra wrote:
> > > I have vague memories of the P4 thing crashing with Vince's perf_fuzzer,
> > > but maybe I'm wrong.
> > 
> > No, you're correct. p4 was crashing many times before we manage to make
> > it more-less stable. The main problem though that to find working p4 box
> > is really a problem.
> 
> I do have some a functioning p4 system I can test on.
> I can easily run the fuzzer and report crashes, but I only have limited 
> time/skills to actually fix the problems it turns up.

You know, running fuzzer on p4 might worth in anycase. As to potential
problems to fix -- i could try find some time slot for, still quite
limited too 'cause of many other duties :(

> One nice thing is that as of Linux 5.0 *finally* the fuzzer can run 
> indefinitely on most modern Intel chips without crashing (still triggers a 
> few warnings).  So finally we have the ability to tell when a new crash is 
> a regression and potentially can bisect it.  Although obviously this 
> doesn't necessarily apply to the p4.
> 
> I do think the number of people trying to run perf on a p4 is probably 
> pretty small these days.

Quite agree. Moreover current p4 perf code doesn't cover all potential
functionality (for example cascaded counters) and nobody ever complained
about it, I think exactly because not that many p4 boxes left and putting
efforts into this perf module development doesn't look like a good investment,
better to stick with more modern cpus and deprecate p4 with small steps.
