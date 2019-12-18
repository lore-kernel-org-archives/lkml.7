Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525B2C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265DE24676
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="PNyhx+AO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfLROJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:09:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40034 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfLROJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:09:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so2444562wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 06:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dxjsGjatY6ZbcTCcZP76IfB6Z3ogOgfOc4zopQ9KHZw=;
        b=PNyhx+AOrNKPg3eDV8ybExNCbharLbfTnb/QPJsivs4Drc+dFrkWLrZiSpJzm/dOol
         5cwzbkNc0l3rz6AIjkIRe7L/lvDQUdnn4yZCYUv6VZJkKbn7U9Nyh7g83AWJylEcGA3W
         d4ZLDHApZ7hFNqnvcOOIs2oZSjbuNQKWIlnAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dxjsGjatY6ZbcTCcZP76IfB6Z3ogOgfOc4zopQ9KHZw=;
        b=MnJUWM5j5OMlpELELzPxXh1+1FCAlYDwRAETdnp1/xpFYtr2fOWjYW6LVLWdQxOxgq
         Iqn3zVL6xbcyyqkGIKb/RRSJcNzEPyMsKrI3g+TSzOx+SqqJnGBuBYa6Oz5xRgARWF9V
         20a7VrNrPNk1kzwsTZwq9XUpFXPPtQ69D/uCqkiX9kI5vG721W1OlNCzjnkP0bOA4OQs
         6z50ruFvYlg/HgB81Qm98QWew0moVFMICX6EZAZMDVMSTl0NJ14qj3ltpfdhXg29ZEQD
         riuvEfZ0gT10SDqytsiY6hHZTsDVvz3OjZZ6Mn3P+693uhidUKNvE8vj46FjF7BXZRVa
         mlQA==
X-Gm-Message-State: APjAAAU78eX7ntCSxnlljQzbhYT/gpVBSEdBCMC714NA6o2gJ+nPdCf3
        pl8jINHvM3JtyTuMlsbRzcam/Q==
X-Google-Smtp-Source: APXvYqxbgaqnKp6+tHcSJR0Hg+KDMISaNFHSKVH0qfn81gYVnqcpO9RInQXrM6+/f4otf0uySVZMdA==
X-Received: by 2002:adf:b591:: with SMTP id c17mr3068382wre.108.1576678193639;
        Wed, 18 Dec 2019 06:09:53 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id o194sm2641065wme.45.2019.12.18.06.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 06:09:53 -0800 (PST)
Date:   Wed, 18 Dec 2019 14:09:52 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Hui Zhu <teawaterz@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, guro@fb.com, shakeelb@google.com,
        yang.shi@linux.alibaba.com, tj@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: vmscan: memcg: Add global shrink priority
Message-ID: <20191218140952.GA255739@chrisdown.name>
References: <1576662179-16861-1-git-send-email-teawaterz@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1576662179-16861-1-git-send-email-teawaterz@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hui,

In general cgroup v1 is in maintenance mode -- that is, excepting specific 
bugfixes, we don't plan to add new features.

Hui Zhu writes:
>Currently, memcg has some config to limit memory usage and config
>the shrink behavior.
>In the memory-constrained environment, put different priority tasks
>into different cgroups with different memory limits to protect the
>performance of the high priority tasks.  Because the global memory
>shrink will affect the performance of all tasks.  The memory limit
>cgroup can make shrink happen inside the cgroup.  Then it can decrease
>the memory shrink of the high priority task to protect its performance.
>
>But the memory footprint of the task is not static.  It will change as
>the working pressure changes.  And the version changes will affect it too.
>Then set the appropriate memory limit to decrease the global memory shrink
>is a difficult job and lead to wasted memory or performance loss sometimes.
>
>This commit adds global shrink priority to memcg to try to handle this
>problem.

I have significant concerns with exposing scan priority to userspace. This is 
an incredibly difficult metric for users to reason about since it's a reclaim 
implementation feature and would add to an already confusing and fragmented API 
in v1.

Have you considered using memory protection (memory.low, memory.min) for this 
instead? It sounds like it can achieve the results you want, in that it allows 
you to direct and prioritise reclaim in a way that allows for ballparking (ie. 
it is compatible with applications with variable memory footprints).

Thanks,

Chris
