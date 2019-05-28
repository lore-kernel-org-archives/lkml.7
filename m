Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F01FC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C50B20717
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="UZzU4SeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfE1WAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 18:00:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33973 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfE1WAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 18:00:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id h2so27951pgg.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 15:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zz3efGRJMkCi9u1FMXnDOgSGtU0NK8c6CTTxYaLRlUk=;
        b=UZzU4SeJuNsj1RuhrcyrwW4MS5X4kGC8Ge0T2obb1h/h/CTewhMxNkcfTqUtxV7Ybt
         l9JJno+dbcn1nkV0bH46Xhs3idLMJ4T/k55B/bpWBy9ryQnadZtrxLIcchZWxAkYBAbu
         fbhRFIDfo0/NnrAyNaE2ecYXcWho1QdaI0s/85/A+X7r9AK+tHFK+6aNWEpQy9HQs8Bb
         Li6LBCRaI75me6R17Qp1LTHnXDTPmx2UWK0vuWad9yeDuO3j4ni9wGrrdVO0l8uqGxHW
         8Dsgz6ec6+oz4dmuhnZIKpxAgp6jx6+atPwCgm0WJQwwyg81bncpkILNj4fcw8WBEp02
         G2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zz3efGRJMkCi9u1FMXnDOgSGtU0NK8c6CTTxYaLRlUk=;
        b=OQrJ+BDP1HOjW30+d3he1m46mwM+Dzj/kuDly4hL/+ozR6WBwsc2ukqiyXJgiMAbCF
         u1tGDvSfjlqzETNZ7TDY1mjsoc+7z670/8EvNY4Yzxo6pTXnNzbzrWR4C5ccKiilBHN0
         AEn5x/Nrlme5QEe2UbEyvWE6IywrPXF3Yz1uxNZM8q4q6ZwNMV2o3f0diMRGzWtFgBk6
         2GLD8Ph+5AoAr8tgrYd1GLe9jAafWBcYMnk/n/ZCWubKfpmElUUOhk/52biqG3ERJ8Vs
         kZixPoBtih6SYWgcHK4rpwFLW1Im/DMG48ywf62bYWkrZQrWGQVtKm1/e1YbImuTLP90
         QMKQ==
X-Gm-Message-State: APjAAAVygti0oHq1fYZTqR7qh+RpJk7tjW++94oxhmvRQ/h1AVRXHJfr
        F7/wVrswNOhRYxQSwf4pHSkJGQ==
X-Google-Smtp-Source: APXvYqzcjXyIC37ZtNb/BvRceiRze2ZuMVZOqei3nfqsf/GzOqhW1pZLQ48briznsQGYnG3llCRAQA==
X-Received: by 2002:aa7:8c1a:: with SMTP id c26mr146120273pfd.25.1559080831650;
        Tue, 28 May 2019 15:00:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:77ab])
        by smtp.gmail.com with ESMTPSA id i3sm8919865pfa.175.2019.05.28.15.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 15:00:30 -0700 (PDT)
Date:   Tue, 28 May 2019 18:00:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 4/7] mm: unify SLAB and SLUB page accounting
Message-ID: <20190528220028.GB26614@cmpxchg.org>
References: <20190521200735.2603003-1-guro@fb.com>
 <20190521200735.2603003-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521200735.2603003-5-guro@fb.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 01:07:32PM -0700, Roman Gushchin wrote:
> Currently the page accounting code is duplicated in SLAB and SLUB
> internals. Let's move it into new (un)charge_slab_page helpers
> in the slab_common.c file. These helpers will be responsible
> for statistics (global and memcg-aware) and memcg charging.
> So they are replacing direct memcg_(un)charge_slab() calls.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Christoph Lameter <cl@linux.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
