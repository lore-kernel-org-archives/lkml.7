Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E641DC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D3E212F5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="IU3RNsgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfDZQLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:11:01 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36056 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZQLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:11:00 -0400
Received: by mail-it1-f195.google.com with SMTP id y10so6637886itc.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 09:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=vqL+eBAoqQcyj0QL9U9OxlX66XIdQVKeIzxdtdKg2E0=;
        b=IU3RNsgHvt3vxeftyVcqCm38QfUQxUH+AJdua4VTJ65+wEUndmp782ljsxl6Yp+lf3
         WlvynlmNcHpUPutFoIf17PgenXM9Zzo8ZTaL5W9G5qMKVynoKe3eIm473YVP3QY6dheK
         Y+bxsm0g6lSXVk6tHhstWjllTNdneFtjnq9r8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=vqL+eBAoqQcyj0QL9U9OxlX66XIdQVKeIzxdtdKg2E0=;
        b=har6x7ShJeYitTBg3cv4H/oCuftLN1Z/gFCSicA2lKFHdiO/RZBn0JHEhH34wj39h1
         O5k3ZkPR9qV9TbHo8SwnFGv7xKQs+EO5vxyRsT4zHNAu97p6U0QYxDpG/1Vz+nfP22Iu
         SzhtdtsAkAMHNnR81wav9lb8aOlU0dQWnnoMeGmNhVndwUCST/GfGPgcCzzJ01AZuDK5
         IRftZqNDU0WZ3yzM1VzvR4KLU22pGY5ftblWoGpyusJd3joYkEdMA7aSlN45aYK9C+FA
         sEIAbRMWY5lsyqhw7gphLmiGp0433RDyjUQUTUwv8TiwZVUJ7+eLbPOXEOL+novWM4ak
         kb4w==
X-Gm-Message-State: APjAAAUPhjmici2IaW3IHLD+ov75uHPlwSihJQT/YaX5ogvQrrTkAzZL
        jE6xoo/m0WdeuOQhy4RFQZqKnQ==
X-Google-Smtp-Source: APXvYqwj+T/T4LXQpOygpMP25cLTdAsJ3yO2oCDuet/otob1iG6o9f535+K+R3mtQI7sbmypcOJ3FA==
X-Received: by 2002:a24:5784:: with SMTP id u126mr520742ita.128.1556295060015;
        Fri, 26 Apr 2019 09:11:00 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id l188sm12121150itb.24.2019.04.26.09.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 09:10:59 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH v2 09/17] sched: Introduce sched_class::pick_task()
Date:   Fri, 26 Apr 2019 16:10:56 +0000
Message-Id: <20190426161056.4624-1-vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426140209.GA2623@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I didn't get around to reading the original discussion here, but how can
> that possibly be?
>
> I can see !se, in that case curr is still selected.
>
> I can also see !curr, in that case curr is put.
>
> But I cannot see !se && !curr, per the above check we know
> cfs_rq->nr_running != 0, so there must be a cfs task to find. This means
> either curr or se must exist.

This fix was suggested as a quick fix for a crash seen in v1. But
I agree with you that this should be a bug if it happens and should
be investigated. I have tried in v2 and can no longer reproduce the
crash. Will remove the check in v3.

Thanks


