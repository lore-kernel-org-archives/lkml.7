Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DE0C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A2F20659
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qlBsdqb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388710AbfGPU21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:28:27 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43587 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbfGPU2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 16:28:25 -0400
Received: by mail-vs1-f65.google.com with SMTP id j26so14850200vsn.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UjTFcdnVd7s1YEwLwLvsfGG9sPlxZRXqbP8Kb8AL9ZQ=;
        b=qlBsdqb1KQr1ExF9/YzSOXtCovLJ6CtV2qWiLG5wJnwV6nQg/i/H3R52CVt5c8Eqf9
         B+0hnD2r1zE9RSTzJqiOVJKUZw+0WE9TYUFtaEWwEhnTVO9bSsoplLU0CCfoD+gVwEv+
         Y6oKIZgbWJJ61IRNuXDVJ0O33dnXn7Y2+FQ+VKXZsQmDvvadhPyoBILBFvw82/Dhd2BR
         9wQNkdx/4Pu0YNVqj1+tHaUj+F7dFFakpniLUPA4c1L4/3wwTr9QqzJEbdnf6oEN4h4y
         NbzX9f/M9fQO0j924PX3RRr86L9XAahk1cmcPOeou7pE9t/F76sCsYK29AGBT+cOOSGM
         Q1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UjTFcdnVd7s1YEwLwLvsfGG9sPlxZRXqbP8Kb8AL9ZQ=;
        b=qIqnQgfwpJ7b5MdRi6GTQp+v5xU8cgxxmMgnIgvyAmyLXiWSzFdcaAkvXG2lx35nkN
         8C+DjOVf3NIfYxQ5cAOpJpJkGXiBdHrL1YTaKq4x81zdIqD3Ix1bHNnlncUN+KcdEY/X
         6uIi4a25Rk5J1Y1ZMjvgVAYBnYrbq/1r5pM2PoeI7LC1Z3llpAvqQi+fHatvFglC1Cxr
         aP2jtOSBmDVdRIf+rvDynjB2A2ZNpBrm7AMediNqh5O3abdxDcV+gvrbKrEScpRkG5/m
         dkNY91upbKL0nCyDfP+4o6kQHMBrRzECFP9DIZREEKowXV9PBTl5f+HYweygSieQT+0H
         zUYA==
X-Gm-Message-State: APjAAAX+370qFLNPlSP0jMQM7jDP4e09jaAtxgFFnqtzIVU7H1tAj3WR
        9qib40094Vd3sgGnhRHQW0z+Ig==
X-Google-Smtp-Source: APXvYqx8BSAvMkaR3wy2NivfcuCgXjFmOhNmRIjDK4T8nCSa7DOvd2utZH77Ki+v2aCCiXzIQgMuAA==
X-Received: by 2002:a67:d39e:: with SMTP id b30mr21307008vsj.212.1563308904667;
        Tue, 16 Jul 2019 13:28:24 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g66sm5590218vkh.7.2019.07.16.13.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 13:28:23 -0700 (PDT)
Message-ID: <1563308901.4610.12.camel@lca.pw>
Subject: Re: [PATCH] Revert "kmemleak: allow to coexist with fault injection"
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, catalin.marinas@arm.com,
        dvyukov@google.com, rientjes@google.com, willy@infradead.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Jul 2019 16:28:21 -0400
In-Reply-To: <20190716200715.GA14663@dhcp22.suse.cz>
References: <1563299431-111710-1-git-send-email-yang.shi@linux.alibaba.com>
         <1563301410.4610.8.camel@lca.pw>
         <a198d00d-d1f4-0d73-8eb8-6667c0bdac04@linux.alibaba.com>
         <1563304877.4610.10.camel@lca.pw> <20190716200715.GA14663@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-16 at 22:07 +0200, Michal Hocko wrote:
> On Tue 16-07-19 15:21:17, Qian Cai wrote:
> [...]
> > Thanks to this commit, there are allocation with __GFP_DIRECT_RECLAIM that
> > succeeded would keep trying with __GFP_NOFAIL for kmemleak tracking object
> > allocations.
> 
> Well, not really. Because low order allocations with
> __GFP_DIRECT_RECLAIM basically never fail (they keep retrying) even
> without GFP_NOFAIL because that flag is actually to guarantee no
> failure. And for high order allocations the nofail mode is actively
> harmful. It completely changes the behavior of a system. A light costly
> order workload could put the system on knees and completely change the
> behavior. I am not really convinced this is a good behavior of a
> debugging feature TBH.

While I agree your general observation about GFP_NOFAIL, I am afraid the
discussion here is about "struct kmemleak_object" slab cache from a single call
site create_object(). 

> 
> > Otherwise, one kmemleak object allocation failure would kill the
> > whole kmemleak.
> 
> Which is not great but quite likely a better than an unpredictable MM
> behavior caused by NOFAIL storms. Really, this NOFAIL patch is a
> completely broken behavior. There shouldn't be much discussion about
> reverting it. I would even argue it shouldn't have been merged in the
> first place. It doesn't have any acks nor reviewed-bys while it abuses
> __GFP_NOFAIL which is generally discouraged to be used.

Again, it seems you are talking about GFP_NOFAIL in general. I don't really see
much unpredictable MM behavior which would disrupt the testing or generate
false-positive bug reports when "struct kmemleak_object" allocations with
GFP_NOFAIL apart from some warnings. All I see is that kmemleak stay alive help
find real memory leaks.
