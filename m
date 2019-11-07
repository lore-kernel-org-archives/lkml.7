Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89336FC6194
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515EA206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="lFJWdmZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfKGA0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 19:26:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39258 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfKGA0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 19:26:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id o9so110796plk.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 16:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KEOopLJ5iB8RmpEZTW4jEm10x8g53h0m9wq9YjVBDLY=;
        b=lFJWdmZXI9+2+oMrIJP43CTG56fV3KIfPp/Qh8xHL8cg35kS1x4Dp/SxrZkjsSECvk
         KJmBS+bONNbKXnrVc6mASGrPB7I+usQ0ttu+yCrsvvJF+Zc/64T9RuJWm4e4HJQ3LQI0
         S0ClECVzkELJiWf/U675WfVrtD4a4MaUM3tKXceQuKbqOxVAcPEKLaIjojA8q7RyvF9x
         TgjKMAtx+UWfzcbO+ICuL/CXdUpPbrjlktWidyLEk6HT/XVA6R/m+Te9n4lSFOybVZMy
         u0Yx8eJBr2sz/L5GfPpGaXnsb0G1tcE0FLjYAo8nEzCYzF0FN9eqicVMSY6W4Jl91EQ3
         0R1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KEOopLJ5iB8RmpEZTW4jEm10x8g53h0m9wq9YjVBDLY=;
        b=Y2lEQMs9w1kaOEiBbziofZMC8XxmeOQAvmUgqTpRWrtOgN3Uu2kQw1rpJJ/Fy66DH8
         5N5EleCdyq2Xim+qSsNdaI6KMFxUds7AZQ+U4r6UuEhkdbtjNunRjB2MJy20qdB5D5h3
         2JOleiK5Gw0wPgqZ+PTMsb0aPJA1eECR+WWbweH473O9XRjBY0ND+dkpCQd7XKpNunzb
         UhCNmmSTjuSfr+l2pnxPsEf4Mrr6GIbGdI8wsJneip61t/zN+PZIsosvHn2jHW2dHsle
         mqh7SKTeHdDs0jhHt6CxxI8TxyCrk7ijnt9VLax8erflB03qECYeA1H8HnnorLeGZfa8
         zQ7A==
X-Gm-Message-State: APjAAAVEtGpE3OjoMWahVtfqD0jsVYJM3/FGdQRsVygoOnXPOEeCX7sP
        vpcj20nqu++2MIze/jvYO2yajw==
X-Google-Smtp-Source: APXvYqzNhi4Z4rqSd1SYZHPd68UCauRrDczwT9rsRKj8pjv7pVf3AFuzhiJThxTX5L2Fg9OfLaicyA==
X-Received: by 2002:a17:902:7d90:: with SMTP id a16mr481361plm.149.1573086406181;
        Wed, 06 Nov 2019 16:26:46 -0800 (PST)
Received: from localhost ([2620:10d:c090:200::2:deb0])
        by smtp.gmail.com with ESMTPSA id l3sm169756pff.9.2019.11.06.16.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 16:26:45 -0800 (PST)
Date:   Wed, 6 Nov 2019 16:26:44 -0800
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, stable@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] mm: hugetlb: switch to css_tryget() in
 hugetlb_cgroup_charge_cgroup()
Message-ID: <20191107002644.GB96548@cmpxchg.org>
References: <20191106225131.3543616-1-guro@fb.com>
 <20191106225131.3543616-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106225131.3543616-2-guro@fb.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 02:51:31PM -0800, Roman Gushchin wrote:
> An exiting task might belong to an offline cgroup. In this case
> an attempt to grab a cgroup reference from the task can end up
> with an infinite loop in hugetlb_cgroup_charge_cgroup(), because
> neither the cgroup will become online, neither the task will
> be migrated to a live cgroup.
> 
> Fix this by switching over to css_tryget(). As css_tryget_online()
> can't guarantee that the cgroup won't go offline, in most cases
> the check doesn't make sense. In this particular case users of
> hugetlb_cgroup_charge_cgroup() are not affected by this change.
> 
> A similar problem is described by commit 18fa84a2db0e ("cgroup: Use
> css_tryget() instead of css_tryget_online() in task_get_css()").
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
