Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E233C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138F524659
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="OyvBITRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfLEXQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 18:16:38 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37438 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfLEXQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 18:16:37 -0500
Received: by mail-qk1-f196.google.com with SMTP id m188so4917155qkc.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 15:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dBY8m+DHccXvJ5TnoY1vddTxvF8FWWEtYV2qrc6mL4c=;
        b=OyvBITRZeb/sOQNiYi7+aXXItWQnIt2KsBz+L5VyPLwpKmIyFEZcGT3cy/3NADs9Cd
         qn98KTrh2Rdw3sagryAMy/0gM+9b8NFyQnZJfjoik35yOwwSo8TFyh18otEZsHl20LCG
         uyWg856ybI6mkD6eWAnyK+QgualHbPtute5Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dBY8m+DHccXvJ5TnoY1vddTxvF8FWWEtYV2qrc6mL4c=;
        b=DaeN9iqZXXx60+ykG2MYebQgSRqPv/FjzU3iYrZ6h0A3GaoLkKw2RScWHwy2UuihOL
         3YFyqKixUsTGwex6hE240J/zQfOFVm3VWn6H/3cHUF48TjXw+vsE6opThxA1a/vyLH7L
         Fm/5Eb9SUwyb17vALBVNt32UWBzLBOpmVDR+nk6hCS0BOig2ombee3K9GOUhHSlqzvgM
         Cy6d/Jc9nqIiEfsQyfbQWHpOGUyRt0UV/YAH3YOaT05Dw7LlT23aYf3yExFnTzaOnDG6
         XGlGkqwiZnKkLayjqu39yePA0hs2xS49B6inB+/qxqXkJv0V3TGs+NL9qKCozWtc4AmE
         2pPg==
X-Gm-Message-State: APjAAAXIXaMRugA1DXFeZoeB6WoID37JkjFwayKMQKupnIsWbJIossde
        7eTXz5YcN5XYFRFSAZqYD+gN5W/9eq3I7A==
X-Google-Smtp-Source: APXvYqwHnYpscUASmeuu7HU4LutiUPN6gq71/531cwu2PtoHhcNN/4e4D5uvKkEC3coIl8KAUkv8Ew==
X-Received: by 2002:a05:620a:149b:: with SMTP id w27mr10953882qkj.37.1575587796770;
        Thu, 05 Dec 2019 15:16:36 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:d1c8])
        by smtp.gmail.com with ESMTPSA id u57sm5925231qth.68.2019.12.05.15.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 15:16:36 -0800 (PST)
Date:   Thu, 5 Dec 2019 18:16:35 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: account security cred as well to kmemcg
Message-ID: <20191205231635.GA1191846@chrisdown.name>
References: <20191205223721.40034-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191205223721.40034-1-shakeelb@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shakeel Butt writes:
>The cred_jar kmem_cache is already memcg accounted in the current
>kernel but cred->security is not. Account cred->security to kmemcg.
>
>Recently we saw high root slab usage on our production and on further
>inspection, we found a buggy application leaking processes. Though that
>buggy application was contained within its memcg but we observe much
>more system memory overhead, couple of GiBs, during that period. This
>overhead can adversely impact the isolation on the system. One of source
>of high overhead, we found was cred->secuity objects.

Makes sense. I took a look through other cred-related allocations to see if any 
others stood out and this looks like it covers all the relevant cases.  
__alloc_file is the only other one that caught my eye, but SLAB_ACCOUNT is on 
the filp cache already.

Thanks :-)

>Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Chris Down <chris@chrisdown.name>
