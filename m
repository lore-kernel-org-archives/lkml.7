Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED672C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B186820643
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="UuYxKhpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfDCMYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:24:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40943 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCMX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:23:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id x12so19185142qts.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 05:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=msxtIHAtJz4OY5Sv8/Ja7X44EEFN0Z54zKL8t5s+a1A=;
        b=UuYxKhpyzwNXizySpmvdMrgOGMuu+8jYEU3E4FzENoIsoEYOZoVz100zTI2besjFKa
         W2D+rzw2OcLaWStcOgorwbS6sztHvPezDZrrq7gJ2nFqSewNYCY1V9LsQW4vbjlK5nnp
         fVZLAH4O6uf7LZ2+zbqtNYShEdiGS3oInzW/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=msxtIHAtJz4OY5Sv8/Ja7X44EEFN0Z54zKL8t5s+a1A=;
        b=PpLCZVWNC9LTMgPJ/CPggAxDLuA9xYM7YaNgAkLQdDYSGmAYxGokzb4Okh+C+3nmD0
         O5MdLeYnokNvZ87O0iFQ6BFT9auQpttabYAsaDQ7Bp2KM8F7Vup/FFQ5L5S9jhr2jFi5
         URwIA/FeIRrOTIZZ9VvJBy1AmGc631Sh0YW/v5T3n3t2mHEaDAIApmJR71SVSkfHSB2j
         Rw8iGR3pwQBEABIjC1JRRmc44LJ/buEe6TWX/xPAwgEN9KxsXR3JPZJLHllGvmOwUzQC
         4c6N192lwyBGVp5a6e32tXFSNhFJ6QGbX5ULRsaIOTqo+DU4omuAQfwyqqqW99pxFRBV
         pDjg==
X-Gm-Message-State: APjAAAWKOs+nPGiVVJtN1Ulc2QGvay0CWqvSsDA4Y5TsCYRMSVJhFbL2
        Aiigz931FHZZ03pLwhFQZA7nug==
X-Google-Smtp-Source: APXvYqyqNvmtb6PJRvTNthZo3Avx9Soy5BGJOj63KReQJj9m6VSyefDcK/b3rPrYZGf8mv+GyDPl9g==
X-Received: by 2002:a0c:b8aa:: with SMTP id y42mr61217214qvf.66.1554294238476;
        Wed, 03 Apr 2019 05:23:58 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id b37sm13576985qtb.92.2019.04.03.05.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 05:23:57 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Wed, 3 Apr 2019 08:23:52 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     nelson.dsouza@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, vincent.weaver@maine.edu, eranian@google.com,
        hpa@zytor.com, mingo@kernel.org, torvalds@linux-foundation.org,
        acme@redhat.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:perf/urgent] perf/x86/intel: Initialize TFA MSR
In-Reply-To: <alpine.DEB.2.21.1904031330060.1967@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1904030823020.29082@macbook-air>
References: <20190321123849.GN6521@hirez.programming.kicks-ass.net> <tip-d7262457e35dbe239659e62654e56f8ddb814bed@git.kernel.org> <alpine.DEB.2.21.1904031330060.1967@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019, Thomas Gleixner wrote:

> On Wed, 3 Apr 2019, tip-bot for Peter Zijlstra wrote:
> 
> > Commit-ID:  d7262457e35dbe239659e62654e56f8ddb814bed
> > Gitweb:     https://git.kernel.org/tip/d7262457e35dbe239659e62654e56f8ddb814bed
> > Author:     Peter Zijlstra <peterz@infradead.org>
> > AuthorDate: Thu, 21 Mar 2019 13:38:49 +0100
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Wed, 3 Apr 2019 11:40:32 +0200
> > 
> > perf/x86/intel: Initialize TFA MSR
> > 
> > Stephane reported that the TFA MSR is not initialized by the kernel,
> > but the TFA bit could set by firmware or as a leftover from a kexec,
> > which makes the state inconsistent.
> > 
> > Reported-by: Stephane Eranian <eranian@google.com>
> > Tested-by: Nelson DSouza <nelson.dsouza@intel.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Vince Weaver <vincent.weaver@maine.edu>
> > Cc: tonyj@suse.com
> > Link: https://lkml.kernel.org/r/20190321123849.GN6521@hirez.programming.kicks-ass.net
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> This lacks:
> 
>  1) Fixes tag
> 
>  2) Cc: stable ....
> 
> Sigh.

It would also be nice to know what a "TFA" bit is without having to go 
find a copy of the Intel documentation.

Vince
