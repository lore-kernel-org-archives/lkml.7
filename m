Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF0AC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 23:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B618206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 23:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G9Al7jqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbfHNXvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 19:51:02 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:46882 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbfHNXvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 19:51:02 -0400
Received: by mail-pf1-f202.google.com with SMTP id g185so449519pfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 16:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mCCHjAlFO5vAUYuV0pCQwN/48vRzFq+YkLLf8FK8aNk=;
        b=G9Al7jqBBI41vvj+P2TFIYHmTeK4JuIVUzUNnvWpI/c+YcsaiX3h+JT3tdTS6X5Opc
         kAYlb9p4SKnw8DgbDCx+LpcimPK8C68h5/K+lVbuq0M7F5eIV6rfRL1xuz+j7G+ip6Vh
         RZMtWaJzLPg4FKl6BNENo618JCDxuHq2mGhmrlacvzf+eWFxRzzNdig1eCrg/blI1LJu
         2x6x7SnN9RiUXFPycEY9XiEM1qkzYe59zFwUZRKYMIgedOLfg53VHus55qOkD4k9gyVD
         8uXyBC8NzgfGeGFcrZmj15kI+1F7/cbAZweQBLvyQ+wDcsQG3KHaa7FCr1DGTNymyM3H
         C1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mCCHjAlFO5vAUYuV0pCQwN/48vRzFq+YkLLf8FK8aNk=;
        b=rMWY2qmkkysL1J/2YjSUf5OOMA1GHRpr54iLaxO2yba7SH6Ue5jY/UR9HRJhJT0Q5y
         qXEXYKPTuqXNt468FXCy7c67aRAeBT4bOpb/ouilfz5LF4Xa/ULuoj1NoAfZEFRwbLXH
         1JynNFuef+yakQvyC91GaRtNYTe8jo3HKmgBL8lyRLY6paIziStrRMxyhiW7rjZ8Djko
         RRtEIT7Q8a4uHj/kZoRBoELSiyblZRUwJlecHJto+dTPLlRG3/p/41gQEINi/dZd56qT
         oK6qbLGep6/NMiXGaXEX0WKWZrtYQBPbm9pj7lAYayM2ibsJfV6Sef3M6kkzdvchoUdY
         u0rA==
X-Gm-Message-State: APjAAAU/rafViQdSac8r9XxvR9bgoH3THL7dpK12zXiJKsmhYFc6xRRK
        8l5HX5YZ0TKZOtFQCnKuUjdMWwnHNA==
X-Google-Smtp-Source: APXvYqwQ7ZXfkseheaq9a7yygbzrcKzjgwsKviofG2LNhIBKUnkwv4PaV9kndL49aji1M5iN0KAYlk6+lgk=
X-Received: by 2002:a63:7709:: with SMTP id s9mr1334272pgc.296.1565826661481;
 Wed, 14 Aug 2019 16:51:01 -0700 (PDT)
Date:   Wed, 14 Aug 2019 16:50:58 -0700
In-Reply-To: <CANLsYkz3_bzRCQEVb00Tbf3Rdww13mePN-woncctOu7OanF00A@mail.gmail.com>
Message-Id: <20190814235058.184204-1-yabinc@google.com>
Mime-Version: 1.0
References: <CANLsYkz3_bzRCQEVb00Tbf3Rdww13mePN-woncctOu7OanF00A@mail.gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: Re: [PATCH v2] coresight: tmc-etr: Fix perf_data check.
From:   Yabin Cui <yabinc@google.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Did you actually see the check fail or is this a theoretical thing?
> I'm really perplex here has I have tested this scenario many times
> without issues.
>
I have seen this warning in dmesg output, that's how I find the problem.

> In CPU wide scenarios each perf event (one per CPU) is associated with
> an event_data during the setup process.  The event_data is the
> etr_perf holding a reference to the perf ring buffer for that specific
> event along with the etr_buf, regardless of who created the latter.

Agree.

> From there, when the event is installed on a CPU, the csdev for that
> CPU is given a reference to the event_data of that event[1].  Before
> going further notice how there is a per CPU csdev and event handle to
> keep track of event specifics[2]. As such both (per CPU) csdev and
> event handle carry the exact same reference to the etr_perf.
>
On my test device (Pixel 3), there is an ETM device on each cpu, but only
one ETR device for the whole device. So there is only one instance of etr
csdev in the kernel. If multiple cpus are scheduling on etm perf events at
the same time, all of them are trying to set their event_data to the same
etr csdev. And different perf events have different event_data. A warning
situation is as below:

   cpu 0
   schedule on event A (set etr csdev->perf_data to event_a.etr_perf)

   cpu 1
   schedule on event B (set etr csdev->perf_data to event_b.etr_perf)

   cpu 1
   schedule off event B (update buffer, does nothing since csdev->refcnt != 1)

   cpu 0
   schedule off event A (update buffer, but etr csdev->perf_data check fail)
