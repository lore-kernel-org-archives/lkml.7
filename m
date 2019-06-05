Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D38C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A847B206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="vlf6zi91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfFEPVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 11:21:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55190 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbfFEPVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:21:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so2676607wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 08:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DGsitu4Q8ELsSoteFe1OlbCf/b8MR09vSmItaqRr+rc=;
        b=vlf6zi91KMaTR26M8VT2Pu+HH1tYzrODet+yGebCgn9wkmDOiljtE8dZCV4wnpPouw
         AE+MTMSGPXOON73ttZuPelVWCUMogNqPri0ndLIOLgsFsaFEXZOhx0oteXq1ALr43k1k
         OCKpkoI2WtihMe3/qEJkJbStk3fQBWNZLUDJPbrWEJU2h4mlwRmK/64c0QIa6jvujuP3
         x8Kvrvn8W/kpez4tGRfZTlKW/LBspW8ROnYNlpUawpfvDOGn6OAJU6XVjY8EviEJXI3I
         wo5knrrlUUNaGiEO2XvrUYbDy4U8cqozgwVCnPLfianqAWRANJfj/MLaqTYy9v8OZf4n
         483g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DGsitu4Q8ELsSoteFe1OlbCf/b8MR09vSmItaqRr+rc=;
        b=RwEihFYMXhMlotHPgQuTnunEYrsY8YyRJY3b1hLtiLw8VmhxSDMCx/rGffdGdaito7
         K0OFGOPyWJnCve0vwld8zZESjHHOG0IBZXCr5mOmeIktDd11rp6q16+9TzSGjZEvqVuw
         30osihQwc6/tcWBigQuWCLBlR/izvodWC6s3jAhIWg8xrnh/PgGw5HQdRB8dzF6j0/w6
         AcABGp6i0CGN9r5/PGBjo/khPpj97nQsQCyRwOS2esO5skf1z3nrLOa9wJbIAvVWPAUp
         mLv2Nt6CBkUUZk82G69naMx0UoDk28lENWm0aGIcqxXdAI9QzLi5mHLfANY6I/AqZ7TP
         UVdA==
X-Gm-Message-State: APjAAAVpAKFXqUs4tlA0dLcl7COKYs9nQzAmnDTP4iQ2hB9Yq5jzJ6Qe
        8V2YPMPrBQwl9ToDvokUq0h08Q==
X-Google-Smtp-Source: APXvYqy2VzOaH9kit+HDBQaloY4J6auVF0+RXbW/VUXYiS18ek1SsRzWTJLJ1oHsTbE3WHhzFyYVUA==
X-Received: by 2002:a1c:e702:: with SMTP id e2mr23042348wmh.38.1559748099240;
        Wed, 05 Jun 2019 08:21:39 -0700 (PDT)
Received: from localhost (ip-62-245-91-87.net.upcbroadband.cz. [62.245.91.87])
        by smtp.gmail.com with ESMTPSA id c5sm21103499wma.19.2019.06.05.08.21.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 08:21:38 -0700 (PDT)
Date:   Wed, 5 Jun 2019 17:21:37 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: objagg: Use struct_size() in kzalloc()
Message-ID: <20190605152137.GE3202@nanopsycho>
References: <20190605144516.GA3383@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605144516.GA3383@embeddedor>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jun 05, 2019 at 04:45:16PM CEST, gustavo@embeddedor.com wrote:
>One of the more common cases of allocation size calculations is finding
>the size of a structure that has a zero-sized array at the end, along
>with memory for some number of elements for that array. For example:
>
>struct objagg_stats {
>	...
>        struct objagg_obj_stats_info stats_info[];
>};
>
>size = sizeof(*objagg_stats) + sizeof(objagg_stats->stats_info[0]) * count;
>instance = kzalloc(size, GFP_KERNEL);
>
>Instead of leaving these open-coded and prone to type mistakes, we can
>now use the new struct_size() helper:
>
>instance = kzalloc(struct_size(instance, stats_info, count), GFP_KERNEL);
>
>Notice that, in this case, variable alloc_size is not necessary, hence it
>is removed.
>
>This code was detected with the help of Coccinelle.
>
>Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
