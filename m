Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F09C31E52
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 16:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE3921881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 16:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="Yo6/9UyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfFOQIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 12:08:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38581 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfFOQIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 12:08:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id f97so2299357plb.5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9I928AV16ooo9jWnHVJ+TbU1BzYjl5gqs5k1AXR35Ps=;
        b=Yo6/9UyMOSre2p9e2TlPcj5kPGAPwe0jyHAYNg1xpnQC6QoXxEXlu5DHEQqYKZGJ+o
         eTsctghCJ9Gqwhw7P2J/7QQirAPJhd8amp1PjtjqTqhINbzoWY9zclMYpPwwdyvovgE6
         U0YT4KT6spSRayg9itsoKCz+i/JW1RRf06hI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9I928AV16ooo9jWnHVJ+TbU1BzYjl5gqs5k1AXR35Ps=;
        b=BuARzvUmuI2lPwpqqUZZhqfHPE/fHHBv9QOSzGhT0fezczdjRtS/FinmaWRFB7TO8y
         ZeobSEPDA6YcHcNJxhAfL7unkr2M0TqYhdwOqqan0xoSHRDL+sPU4YkLUJ9U2s4RwmfU
         6yhEo0YqWOgKHVZMsykEr0s+UKrf3h1R9g9wITUl08n6rYSP8pEm2sEOtoqq1vOIH+tM
         XSqL9yfxi+78/2dhP9pRqXUVxaYxBKHvUn/pujqByEsklzMkQEQl5MB5N6MtsWiowYDU
         MLbUz67nZp/HPynImUZGAv2g9wb0waXe0ii/xBleakndCunD3ifxHxh0uyazArUh45J5
         U50A==
X-Gm-Message-State: APjAAAVmC4hiwhvMwa/NEo6pFiXTFLn+xgUNOnt3NQ4OWzjWe4g++Zkp
        F+1Thc0t5UiEs4AiNgodAtGJacNZXc0udQ==
X-Google-Smtp-Source: APXvYqxBTJ37ihL2DutojGbYbJbHsnfGkRbUmjSx6gSy91LHlFif6NhzN1Dj8LyE8MOq8FIkngDD3A==
X-Received: by 2002:a17:902:25ab:: with SMTP id y40mr43063854pla.268.1560614904698;
        Sat, 15 Jun 2019 09:08:24 -0700 (PDT)
Received: from localhost ([61.6.140.222])
        by smtp.gmail.com with ESMTPSA id s15sm8391955pfd.183.2019.06.15.09.08.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 09:08:24 -0700 (PDT)
Date:   Sun, 16 Jun 2019 00:08:20 +0800
From:   Chris Down <chris@chrisdown.name>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] memcg: Ignore unprotected parent in
 mem_cgroup_protected()
Message-ID: <20190615160820.GB1307@chrisdown.name>
References: <20190615111704.63901-1-xlpang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190615111704.63901-1-xlpang@linux.alibaba.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xunlei,

Xunlei Pang writes:
>Currently memory.min|low implementation requires the whole
>hierarchy has the settings, otherwise the protection will
>be broken.
>
>Our hierarchy is kind of like(memory.min value in brackets),
>
>               root
>                |
>             docker(0)
>              /    \
>         c1(max)   c2(0)
>
>Note that "docker" doesn't set memory.min. When kswapd runs,
>mem_cgroup_protected() returns "0" emin for "c1" due to "0"
>@parent_emin of "docker", as a result "c1" gets reclaimed.
>
>But it's hard to maintain parent's "memory.min" when there're
>uncertain protected children because only some important types
>of containers need the protection.  Further, control tasks
>belonging to parent constantly reproduce trivial memory which
>should not be protected at all.  It makes sense to ignore
>unprotected parent in this scenario to achieve the flexibility.

I'm really confused by this, why don't you just set memory.{min,low} in the 
docker cgroup and only propagate it to the children that want it?

If you only want some children to have the protection, only request it in those 
children, or create an additional intermediate layer of the cgroup hierarchy 
with protections further limited if you don't trust the task to request the 
right amount.

Breaking the requirement for hierarchical propagation of protections seems like 
a really questionable API change, not least because it makes it harder to set 
systemwide policies about the constraints of protections within a subtree.
