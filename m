Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B457C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B2320882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="CWAB6vz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfDDNZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:25:54 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:33875 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDDNZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:25:53 -0400
Received: by mail-qt1-f174.google.com with SMTP id k2so3197016qtm.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 06:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MoJEbnNU/V386aeTrabGdg0XpgK1f04Dz8sL2bmp6FQ=;
        b=CWAB6vz2njn64UmaJTggQoDv4cwz9BQCqhbeTs4Fko0QH+Hj+6+GH6C0MOlvKj0Ed2
         ORsOn6u5sO0VaIfF8yrQ/GKLTyH0XRYJ7xf4HkgxM1if/P22msm0cfR4dU6GFFcuA69E
         kJhM2tosbU02b0no8Rf34aEKpWoG0w40S6xQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MoJEbnNU/V386aeTrabGdg0XpgK1f04Dz8sL2bmp6FQ=;
        b=HAeYA0292i1RzpHJiim2xNKqxLeLYgoSX5Qenihcp9Ph2UTYfrvyB1ZZA4cnFvBrQO
         K1MQSlcORYc3ufEww+h6oAa+sPxokq1N/Ub5C4YfDVUZl1u/fCyif+/YkvMpqR/z7VwM
         TzNIg1vmQv+GI2oXUXTWFyHvKbwJKafxllXKT2fMT2LotVl0R8nCkk2pcWjGhSxaB9lX
         tLErnsD53HM5QeewMNmm1rZp9SneL3UPi3+getqxLOjwN8Sn9dCA/cJ/r9HgYgkp71fJ
         kf3RONSUM/ndqu8FJfZF85BFgY0XqK7NuUOz7SrMlxX636QsIvawWvvPywNbdXxIOG+k
         Jc6A==
X-Gm-Message-State: APjAAAX1D43B/CajxJ8v8UgObQiujG5rX9a5zZ2ECWzE/osQhYXpx9VB
        QzSEMtToJarpOFpXmapyYkXAeA==
X-Google-Smtp-Source: APXvYqzd2HVjq6pUz+HAYPbDRCFqxHvFf596T7ht72mljwUoTSfZc1sJF4taHEV3c6YjefqwaG1lNg==
X-Received: by 2002:ac8:2deb:: with SMTP id q40mr5214202qta.272.1554384352340;
        Thu, 04 Apr 2019 06:25:52 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id l129sm10051154qkb.44.2019.04.04.06.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 06:25:51 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 4 Apr 2019 09:25:47 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     Cyrill Gorcunov <gorcunov@gmail.com>
cc:     Vince Weaver <vincent.weaver@maine.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: perf: perf_fuzzer crashes on Pentium 4 systems
In-Reply-To: <20190403203144.GI1421@uranus.lan>
Message-ID: <alpine.DEB.2.21.1904040922350.3758@macbook-air>
References: <alpine.DEB.2.21.1904031043170.29188@macbook-air> <20190403191944.GH1421@uranus.lan> <20190403203144.GI1421@uranus.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019, Cyrill Gorcunov wrote:

> On Wed, Apr 03, 2019 at 10:19:44PM +0300, Cyrill Gorcunov wrote:
> > 
> > You know, seems I got what happened -- p4_general_events do
> > not cover all general events, they stop at PERF_COUNT_HW_BUS_CYCLES,
> > while more 3 general event left. This is 'cause I've not been following
> > pmu evolution in code. I will try to cover this events hopefully more
> > less soon and send you a patch to test (if you don't mind).
> 
> Still this should not cause nil deref, continue investigating. Vince
> could oyu please apply the patch below, I doubt if it help with nil
> issue but worth having anyway


It looks like there are at least two bugs here, one that's a full 
hardlockup with nothing on serial console.  The other is the NULL 
dereference.

Just ran with your patch applied and it hit the hard lockup case.

I'll have to see if things are reproducible and I can try to see if I can 
get a reproducible value for what even caused the issue.  perf_fuzzer has 
some infrastructure for determining that but it's hit or miss if you can 
get anything useful from it.

I'll keep running things, but I'm a bit busy at work here the next few 
days so there might be some delay in the results.

Vince
