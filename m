Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BEFC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B5C217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDjuKli8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbfGQKeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:34:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32960 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfGQKeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:34:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id f20so1721780pgj.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 03:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S2McoLzKqqkDIb1rRDE8NxKvbm2tGRquQgQvuYsQVBs=;
        b=kDjuKli8rFJC6Xm1qb2ogZmYQDsbaHOj9roK9i8Yne6XsPmZUdhPoe6GX7h6/B0LU0
         YzKTXbDiezDSQarA4K8V/oz6W246ISnaoSYnrBVE/XfVieYzeyM1We1wPWtPc3vSZ8Mi
         P5YG6I9ad1owLaAKCSiAXHeIYvDLh0v+sA/QNBOCJHPxg7n/3EPFJQdImXEWVYQchrs3
         uHFAN1rwDbfMJXyVr9whhfAmSg6oIY8j3bc/HV63n7F/vincPNTHJLcLEWxN4WA8Djc2
         3U4JkQ46ZN3k77TorB4iBHA7naEKHiFcsREPtv1iryBiVwvsl7K/J/XKYVDMqHtPVMdy
         VolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S2McoLzKqqkDIb1rRDE8NxKvbm2tGRquQgQvuYsQVBs=;
        b=KuXKmqD5rQ76rksjQB0aliJd1qmaXfI05tC0Y5P5Ag2p1tLfvIVdIGST2w6Knd9sLF
         o8dfFgIp9MysaNsWBo9cNYaiPKweutN0E7OiRgmh/XLGnP5tfvSjKDxXMXMfD3dKyShe
         3LUDzyzGJblI+JYe6PYAYNRFx2c+rzUY2ChgtaIsHVMyURudPO86unR/jswS6FiiyZ4I
         rKRu38VphzAkBAQhz99Tk3fR0tRkXjJ64nujjh8TbAJJUQSKpNQ9rrZQjzqkilk1jsxZ
         Ck1hbpkI/x2Xf9/0w9e/2UBZetMOM/osTogCFbPRc701HV6r9UPOrjC2tBnfJP9r43wu
         bxRg==
X-Gm-Message-State: APjAAAU5itO/pmdKOX7mbrPcCz4ZiTtSq2Zu3bm4uX8qmZXjbRqPG072
        VZpBy8zHkq0fZIPanuRGTHumjIEb8D0=
X-Google-Smtp-Source: APXvYqxOI59/uw5R/jF/fNjz3BaWzSTGHK7fjysajHtY3ytSl8DLzrJho+T3mWs3BOYVoAyPl+1lRw==
X-Received: by 2002:a17:90a:77c5:: with SMTP id e5mr40862060pjs.109.1563359639783;
        Wed, 17 Jul 2019 03:33:59 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id p68sm33370269pfb.80.2019.07.17.03.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 03:33:59 -0700 (PDT)
Date:   Wed, 17 Jul 2019 16:03:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/fair: Introduce fits_capacity()
Message-ID: <20190717103356.gb2guwxy5joko53e@vireshk-i7>
References: <b477ac75a2b163048bdaeb37f57b4c3f04f75a31.1559631700.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b477ac75a2b163048bdaeb37f57b4c3f04f75a31.1559631700.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-06-19, 12:31, Viresh Kumar wrote:
> The same formula to check utilization against capacity (after
> considering capacity_margin) is already used at 5 different locations.
> 
> This patch creates a new macro, fits_capacity(), which can be used from
> all these locations without exposing the details of it and hence
> simplify code.
> 
> All the 5 code locations are updated as well to use it..
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  kernel/sched/fair.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

@Peter: Do you suggest any modifications to this patch? Do I need to
resend it ?

-- 
viresh
