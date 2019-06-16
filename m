Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B606C31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 10:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65132133D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 10:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="kgrOCNDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfFPKht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 06:37:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38404 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfFPKht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 06:37:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id a186so4059962pfa.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D66IwRD66+bBr49h113lbcClZo8OrbEzuxhoETswyAA=;
        b=kgrOCNDV3slPKYPtT/XUkerWgc9N6kmRSVG8nhJbBPj7PsOQxHbX7sRVeKyB4adSbG
         X7fAr8BFsvhhdJFjJQq8cqqa1pm7ssLdmRZi0Pjeq1tdaHh5DNhEfm/KHevQMnlnek9+
         wFq8e/uowrLJk81/22wplVkQzIPQqnvvx6Aes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D66IwRD66+bBr49h113lbcClZo8OrbEzuxhoETswyAA=;
        b=hBBm4741khFHuEotIwk4k9DPD6YxHTVLACPpw/iO8OBtE8mN+AyY0w2BKfaLq5UtYL
         Hr+Fx1LblkeaiMhg402veupVD2zuf8yTD+BH64gzpt1MqDubiXTkGKoJ9ZN0DOIUX4F1
         LEggCy75f6c6oBL2289d/ZVnWsMi9eU7kLMZQ2FSTiWwac24ImmkKSbY6N3Zn3KHR884
         FVs9AoRQ3rYVdbIqJMNJ4gwGm24M7KsX1ZuhK9Pt+OM9qVmF2MqJHDYsF7oQqwYGoN7y
         dE/qjK9zxUzldzJxBEKxhlMRbiAgJY6TU6+0kssd1zh+MUOoL91TdddpYh+xpJhwMhh7
         aXDg==
X-Gm-Message-State: APjAAAUKOIeWVtpJeJAUAxrzB/v7pOAkghn8paFMY+XnjqC1bYx9yGjN
        7E0dl0CLQwJU2wqYrl0VzBzPjw==
X-Google-Smtp-Source: APXvYqzuJgQl+102uUA83U5N3hshdRoQSBwu1PZlD2FrUikMytjIFjhKAz6HFlQnXa6TUYRoI/Xy6A==
X-Received: by 2002:a17:90a:7f93:: with SMTP id m19mr21160942pjl.73.1560681468335;
        Sun, 16 Jun 2019 03:37:48 -0700 (PDT)
Received: from localhost ([61.6.140.222])
        by smtp.gmail.com with ESMTPSA id h11sm8294436pfn.170.2019.06.16.03.37.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 03:37:47 -0700 (PDT)
Date:   Sun, 16 Jun 2019 18:37:45 +0800
From:   Chris Down <chris@chrisdown.name>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] memcg: Ignore unprotected parent in
 mem_cgroup_protected()
Message-ID: <20190616103745.GA2117@chrisdown.name>
References: <20190615111704.63901-1-xlpang@linux.alibaba.com>
 <20190615160820.GB1307@chrisdown.name>
 <711f086e-a2e5-bccd-72b6-b314c4461686@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <711f086e-a2e5-bccd-72b6-b314c4461686@linux.alibaba.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xunlei,

Xunlei Pang writes:
>docker and various types(different memory capacity) of containers
>are managed by k8s, it's a burden for k8s to maintain those dynamic
>figures, simply set "max" to key containers is always welcome.

Right, setting "max" is generally a fine way of going about it.

>Set "max" to docker also protects docker cgroup memory(as docker
>itself has tasks) unnecessarily.

That's not correct -- leaf memcgs have to _explicitly_ request memory 
protection. From the documentation:

    memory.low

    [...]

    Best-effort memory protection.  If the memory usages of a
    cgroup and all its ancestors are below their low boundaries,
    the cgroup's memory won't be reclaimed unless memory can be
    reclaimed from unprotected cgroups.

Note the part that the cgroup itself also must be within its low boundary, 
which is not implied simply by having ancestors that would permit propagation 
of protections.

In this case, Docker just shouldn't request it for those Docker-related tasks, 
and they won't get any. That seems a lot simpler and more intuitive than 
special casing "0" in ancestors.

>This patch doesn't take effect on any intermediate layer with
>positive memory.min set, it requires all the ancestors having
>0 memory.min to work.
>
>Nothing special change, but more flexible to business deployment...

Not so, this change is extremely "special". It violates the basic expectation 
that 0 means no possibility of propagation of protection, and I still don't see 
a compelling argument why Docker can't just set "max" in the intermediate 
cgroup and not accept any protection in leaf memcgs that it doesn't want 
protection for.
