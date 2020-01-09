Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277FBC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA65820673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="mP6aEY6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbgAIPaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:30:11 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39739 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731052AbgAIPaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:30:10 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so6163692qtm.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 07:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Twt5NWaUi/oSEH7E7cF5IXCKhNEDwF3MBqc2/OHa0qI=;
        b=mP6aEY6Zt6ZJV1KldQt+uvcIwh+jnX8fG0AASAukPxhv3MZJ31M7IZZw8OvADx8CX+
         ko1Ht33JO4QQXJNfLTy4FBEJxH4VnCqpgebtF05EdN+bl1PINxSe24VIJlPhnKMTXb2n
         6V++mv5xH5OyzHiLQiPbd7bBbbU3CBpTZXntC8SuOKPw0p8L6LfIUkc3qbKjzuo9UqOt
         tQMGBWVoKy9fTTA+gPjhD3U13yWqzBkHw+Ud9d3d1VchhABkLARXNmsHwk4R2e9q77vt
         SShw3rLMuF97Ay8nCJ9l6mVpAg0rvj8yWuVHH9J6UYOjnV9Qfke3/hVt8OVZRPDzZMgd
         LiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Twt5NWaUi/oSEH7E7cF5IXCKhNEDwF3MBqc2/OHa0qI=;
        b=dqAqUcbeuXNwQvXIkms4WZD4hQ0MIA7VcgBo2IMCy6XfyWxEGtkeRe8pqCwq5ig0rj
         EObS0pxFNjarP7Inu9bDx5w8kbvbVLmE5rxVNLery0ELHGyixyVhuVHK3PUxy10gZOJ1
         JErsSSgQqkKqsom35p9aZmbyiq6WZ1e/I58nEgQut8+W9QKfvOL2j+wdB/nwcrVncQDD
         Ra1zKEC+hG6axhf32f4MSO87qpbomvrCj387i3pzSoVRXbNllpy0eOcVwxXgMzb6REU5
         kE/ufb/GJXB2aoUvN7wGQWrcD7kM7fddMFWH77wzdLdcT1YV+8U1JYqf3hNgoKFg3FJr
         3Amw==
X-Gm-Message-State: APjAAAVarwRnFTpkjN7KmyRwo0ZAf4S9WaIKe8GgR9SAYQ/lEoJ3Deao
        /au+JQKLR3vtjyicb2OCqMkSPA==
X-Google-Smtp-Source: APXvYqwTFzAQQ9478bLzzuI3PUeKPzbIM/CzuF7HZJv35tW58SLdFtokdB8zEConeqwSRh4zML799A==
X-Received: by 2002:aed:3e21:: with SMTP id l30mr8663136qtf.357.1578583804811;
        Thu, 09 Jan 2020 07:30:04 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:d72d])
        by smtp.gmail.com with ESMTPSA id b40sm2813472qta.86.2020.01.09.07.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 07:30:03 -0800 (PST)
Date:   Thu, 9 Jan 2020 10:30:02 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Wang Long <w@laoqinren.net>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/psi: create /proc/pressure and
 /proc/pressure/{io|memory|cpu} only when psi enabled
Message-ID: <20200109153002.GA8547@cmpxchg.org>
References: <1576672698-32504-1-git-send-email-w@laoqinren.net>
 <20200108135526.GH2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108135526.GH2844@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:55:26PM +0100, Peter Zijlstra wrote:
> On Wed, Dec 18, 2019 at 08:38:18PM +0800, Wang Long wrote:
> > when CONFIG_PSI_DEFAULT_DISABLED set to N or the command line set psi=0,
> > I think we should not create /proc/pressure and
> > /proc/pressure/{io|memory|cpu}.
> > 
> > In the future, user maybe determine whether the psi feature is enabled by
> > checking the existence of the /proc/pressure dir or
> > /proc/pressure/{io|memory|cpu} files.
> 
> Works for me; Johannes?

Seems reasonable, and the patch looks good to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
