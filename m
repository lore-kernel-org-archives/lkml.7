Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5EDC282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AD52171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="HGtEDNLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfDLUKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:10:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41700 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfDLUKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 16:10:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id w30so12688440qta.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 13:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KL4HVhtEWvgQo7HQOLpi2CSpq8VK+yUMixkba3uKDZg=;
        b=HGtEDNLthqGLuedDvcWcQ1HekO50r/XS7jrtBnh6XFA8NQFzosqhgjcfVaTaVT21+F
         w1q4VXl9ZZ9XnyKnnt0oXaOx+G2HR836hSnHm+9tRa5ftCZLstYd0AmiEW69ToQNXSTT
         UaeyyJp9/M8MV9kQTD8tmlwbXPv2hp1lB+mozU7oDB9/SA4wsWc68mC8tHAWkn5i+TDh
         om6ankdEU3FtXwv7KGCbZuNEApBQdcCi3mxFmA+66xv+wuiLEvVmNfZmkBNj6XwwGz4f
         ehrnYoRllpVANXpOkKs+Ru/sR8PkPWgDKm/CRtFatWXmj7YYDjE7crWKlgGZ7hnywrmM
         XVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KL4HVhtEWvgQo7HQOLpi2CSpq8VK+yUMixkba3uKDZg=;
        b=AJfylOZzw5FTOUZWftSI47GGJ97SxWdSqpi67zhWuFgoGspXualTyLOQ/IrbNghyQc
         G4f0mL9yl4WkcGS4uuEqBkbpHS7+6QXf0fKF3K9dYjjRyMTe5BRbIShBRs9YTsJMAcN+
         rxafJned5mtP7BibLDxzUJnDI1QgDfdU7jw1bUlSUcl+qtQ4SrXhHT9koDSwBLVwYUs2
         OuCru5XAZOGKhIRX+4t6XhuY1t+l7BVsIFjSHZkEe15/OfJkmPE1MdLzwDAVXvXfozae
         h8TtxtV6X2LMKlmVN8wrVKNTWbYvHJiXviJobZgAc3vzCtaJSjImxKdMnb0aEGX0/vGn
         /KXw==
X-Gm-Message-State: APjAAAVE+PItAyRReMlriGEgF464AH9hxZ1Z/DVrOKH4OJ5EYer96w7E
        JsKXVBImBOAs15ENw1mOBGScdg==
X-Google-Smtp-Source: APXvYqyznUBkQ5ObYucraFFP8fAIuNA92TJl1aJ+E2y+kZ9Z+GajEJUt/00i36XImcgl7jG7D8VsOQ==
X-Received: by 2002:ac8:3855:: with SMTP id r21mr48809369qtb.264.1555099806611;
        Fri, 12 Apr 2019 13:10:06 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id h22sm34758855qth.68.2019.04.12.13.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 13:10:05 -0700 (PDT)
Date:   Fri, 12 Apr 2019 16:10:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH 3/4] mm: memcontrol: fix recursive statistics correctness
 & scalabilty
Message-ID: <20190412201004.GA27187@cmpxchg.org>
References: <20190412151507.2769-1-hannes@cmpxchg.org>
 <20190412151507.2769-4-hannes@cmpxchg.org>
 <CALvZod4xu10+E41YyaamigysZAnDcdA09f5m-hGd72LeJ9VmEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4xu10+E41YyaamigysZAnDcdA09f5m-hGd72LeJ9VmEg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 12:55:10PM -0700, Shakeel Butt wrote:
> We also faced this exact same issue as well and had the similar solution.
> 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Thanks for the review!

> (Unrelated to this patchset) I think there should also a way to get
> the exact memcg stats. As the machines are getting bigger (more cpus
> and larger basic page size) the accuracy of stats are getting worse.
> Internally we have an additional interface memory.stat_exact for that.
> However I am not sure in the upstream kernel will an additional
> interface is better or something like /proc/sys/vm/stat_refresh which
> sync all per-cpu stats.

I was talking to Roman about this earlier as well and he mentioned it
would be nice to have periodic flushing of the per-cpu caches. The
global vmstat has something similar. We might be able to hook into
those workers, but it would likely require some smarts so we don't
walk the entire cgroup tree every couple of seconds.

We haven't had any actual problems with the per-cpu fuzziness, mainly
because the cgroups of interest also grow in size as the machines get
bigger, and so the relative error doesn't increase.

Are your requirements that the error dissipates over time (waiting for
a threshold convergence somewhere?) or do you have automation that
gets decisions wrong due to the error at any given point in time?
