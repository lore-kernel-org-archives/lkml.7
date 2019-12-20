Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89997C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EEA121D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="A0aDjvyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfLTE31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 23:29:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44737 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfLTE31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 23:29:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so8060749wrm.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 20:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yRRnujDGn+DKixV01iK1kQ9R1Hb6ldjE0k/esoxvtVg=;
        b=A0aDjvyHIdJhLqDtp99NMEN/80Jxl6wvh+lvb7+lH/qp6guNY98LBPwD0tcfMsFfk6
         g6s7MAEi2vlSscOrVsRDLJm1UzTKiVag9IlTkT+joi/WQhHf0NJ5d4IHH/ekSVlZyili
         wBB35uFGXtDvGNNUvJK8qm8EHrv+BJC+5cCJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yRRnujDGn+DKixV01iK1kQ9R1Hb6ldjE0k/esoxvtVg=;
        b=l935aQcpV+P4QVQgw5JJV6Seql0ur3vpixdL4+DycRdsOrGk6IAg8AwduMCCbXBfAj
         zGkdmuX0jqmu7b5VC7FvDQfVkbNFNXvde5x+oziW7Biq/6cWjnYjCMGCRJY0M0LWxqYL
         E8MuxUiA7gXVwqgWAkCH1HCfnKDFaDRCkCLwNLvIlFkaE0syzM4oCEG4qGYVog9OSecr
         btnOGer0c0tH1cUjFs/W4TR8SKbOuVCt+j/GEU7JkYwpPA/cfvk5W7CGE+Mr0/0MPp/D
         sooYV03R/6WyBrL3IEChMq8qCnasYA/o+dOStk4UpiisuHBQZsWl9QhJlW98SsB7nO/r
         EydQ==
X-Gm-Message-State: APjAAAUw2RxHXRzuYEU7QGMGAIaI/ISlK+mvVg3dFicxcL15IY3K2YV/
        g9ezIlYLZHOK8GspqKpd8Ipq8Q==
X-Google-Smtp-Source: APXvYqwLRAXyAkhlCKztZpOXJtBJaYt9dagkawITr0ZMAIpf7TA6fhV48XsQuPRBh7oEnf2WLQ3OVQ==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr12721685wrn.133.1576816164528;
        Thu, 19 Dec 2019 20:29:24 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id x1sm8274608wru.50.2019.12.19.20.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 20:29:24 -0800 (PST)
Date:   Fri, 20 Dec 2019 04:29:23 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 0/3] mm: memcontrol: recursive memory protection
Message-ID: <20191220042923.GA388018@chrisdown.name>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191219200718.15696-1-hannes@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner writes:
>Changes since v1:
>- improved Changelogs based on the discussion with Roman. Thanks!
>- fix div0 when recursive & fixed protection is combined
>- fix an unused compiler warning
>
>The current memory.low (and memory.min) semantics require protection
>to be assigned to a cgroup in an untinterrupted chain from the
>top-level cgroup all the way to the leaf.
>
>In practice, we want to protect entire cgroup subtrees from each other
>(system management software vs. workload), but we would like the VM to
>balance memory optimally *within* each subtree, without having to make
>explicit weight allocations among individual components. The current
>semantics make that impossible.
>
>This patch series extends memory.low/min such that the knobs apply
>recursively to the entire subtree. Users can still assign explicit
>protection to subgroups, but if they don't, the protection set by the
>parent cgroup will be distributed dynamically such that children
>compete freely - as if no memory control were enabled inside the
>subtree - but enjoy protection from neighboring trees.

Thanks, from experience working with these semantics in userspace, I agree that 
this design makes it easier to configure the protections in a way that is 
meaningful.

For the series:

Acked-by: Chris Down <chris@chrisdown.name>

>Patch #1 fixes an existing bug that can give a cgroup tree more
>protection than it should receive as per ancestor configuration.
>
>Patch #2 simplifies and documents the existing code to make it easier
>to reason about the changes in the next patch.
>
>Patch #3 finally implements recursive memory protection semantics.

Just as an off-topic aside, although I'm sure you already have it in mind, we 
should definitely make sure to clearly point this out to those in the container 
management tooling space who are in the process of moving to support/default to 
v2. For example, I wonder about CoreOS' systemwide strategy around memory 
management and whether it can benefit from this.
