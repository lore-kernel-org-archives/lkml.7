Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0661C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8C6206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="NGA3Zsso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfCMQHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:07:52 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42878 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfCMQHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:07:52 -0400
Received: by mail-yw1-f68.google.com with SMTP id e76so1884903ywa.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 09:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UvCYDdnf/RFGLbHek+yGIUV6NWeZaltScEJghB6OD0Y=;
        b=NGA3ZssoNF/S9CAdceP1jG1KWyrw56jfjrQz+ZkNYA/b4MTGXmhZddavjbZpoEE8Tc
         m/r1gIvzg6gmJHVSmepHn8ieLciOciO5GSihS5Mq7DZfF31OIO+vJ1T7UsAz8Kx6CLlY
         spDLc4f7IGXfe72lp3qMD+etk0Cz+ltEYDO+nh9+0mSbxz10yc+Sx8f8fjTYCc1OVV96
         +UVe+ZABsuLQIxrpyc+fKeRrY1UVbtNGZm6J+lMYP0wdvFChFYJVHe+7NKiseJhc3eWf
         vFE7OlTj7FJ3099WcSVXXYJitcCglSYIfSvn1QvBFj8SkPpLhsh5pmfpMG3CD2CEuU1S
         3z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UvCYDdnf/RFGLbHek+yGIUV6NWeZaltScEJghB6OD0Y=;
        b=Omr8xcitNN40o70nKoDrjKU+bL86czj+4z9EUY4tn5BT8iRwcDzlI2gYw4Yu6WQ4M/
         KCMC9TtHUAE1PoxfMVVjYsAYrpVZsiaTCelvUfbuusT4Rq9Gh2rnpG3zXQer4MhGPosO
         eaBzuDBKalLDVnq8I2F64UwETKn3+iTeCw/2/jghYZgwXHFmaIPEK0H9ukocAPkOWXPc
         TDIcjHK4AV7tCusTvtjYiiedD4l/6kUfFysMpEDb1mQfszFImpjdHfgFFMDkvC6LCunz
         tedpoRLGxLd68zm3hpiHZFzYdKv4bhu1oStcj977oOyZk3aG8yXldzEYR20f5Ps2cjia
         ooVQ==
X-Gm-Message-State: APjAAAXWwuAI030fZuziZDrLkhDDSk/7q5jaKf5J8JVgzMFGyVL7klfy
        HheNaDYx3DE+NL8qzWSSKhhsMQ==
X-Google-Smtp-Source: APXvYqytV8vriWXbd2cv/6S1LiJ2RCYtAwfoGBHfkDec1dlcbynkQD7DF6ZQInBeFxyQolTFnHo6wA==
X-Received: by 2002:a25:2bc3:: with SMTP id r186mr19264999ybr.292.1552493270952;
        Wed, 13 Mar 2019 09:07:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:5e6])
        by smtp.gmail.com with ESMTPSA id u185sm742557ywc.1.2019.03.13.09.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 09:07:50 -0700 (PDT)
Date:   Wed, 13 Mar 2019 12:07:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     linux-mm@kvack.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v2 6/6] mm: refactor memcg_hotplug_cpu_dead() to use
 memcg_flush_offline_percpu()
Message-ID: <20190313160749.GB31891@cmpxchg.org>
References: <20190312223404.28665-1-guro@fb.com>
 <20190312223404.28665-8-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312223404.28665-8-guro@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 03:34:04PM -0700, Roman Gushchin wrote:
> @@ -2180,50 +2179,8 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
> +	for_each_mem_cgroup(memcg)
> +		memcg_flush_offline_percpu(memcg, get_cpu_mask(cpu));

cpumask_of(cpu) is the official API function, with kerneldoc and
everything. I think get_cpu_mask() is just an implementation helper.

[hannes@computer linux]$ git grep cpumask_of | wc -l
400
[hannes@computer linux]$ git grep get_cpu_mask | wc -l
20

Otherwise, looks good to me!
