Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B778BC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D503214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6r2swPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392814AbfETRSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:18:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45660 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389885AbfETRSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:18:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so7073434pgi.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=PX3SK8wlBrqBu7wO9d/mgUry+iQ7KlUhXOd5Ab/YVwQ=;
        b=m6r2swPC5kWUMMSAtMK4/783ntjwFjvDijgj6mgQt/YUrZSGOuM/YgVgSFWibmljXv
         RXfsjZnHPT3yHeamwmF0aUZwHhV0SaAOxMo1hY10visSNA8P31lITP+EKpQ/wAOI4pQY
         dJwKT+XBEkcG0TQmUjrzBt9O3gI4QVhWBXsiYWqg8y6onNfcvhTKN3iTdAtqj/OZ6HJO
         6/wJrAlR+dg1irA6W8KYlzGHFpTl3aH08bTjYdgyLUSbmoz7vEFbdawl+n+Ou0UlTEdF
         db3iFpcXEAKx/iiMwpWPf5JQx5EfIbdyWWwWzeWI8KyKw/8Z0VuJlc2UWs+K7wH6p0kH
         Rypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=PX3SK8wlBrqBu7wO9d/mgUry+iQ7KlUhXOd5Ab/YVwQ=;
        b=lSdKMX8r74SptafdNgm8+EiQG42FPL01IipdOOow+oVgHhMH4Q8tpMBUYUAm/BsCFG
         pVh1g6h3pI+GGYRu8KK4b3P8J9S5nzmBPG58p5AFr5/fyJ560RBeRxir8RaGEUdtSbhc
         pWMHMgVyMVyWfIv1oXyeyvTg/lqYNOY22pM/tpdgpltwb+vVqP56nqqYgd4GK0Crn4vu
         4mdh0NjzmYpskVY85IgxHC/vr+4T5MxtcJqe+mc/jgl40Cfz/yyf5S+Hj1MtJrDqgiVT
         bL2IhsVpcL7u7TeimZjImDzcVhjRtTFtXVhyWvrNmizkM1ptceefjn449YTD+ArG4OU6
         gFXA==
X-Gm-Message-State: APjAAAUZtB5pmgQbArNY6/mYY6+XJ9Z99Ma/WjY2mKk+Rs93kGYxxKNy
        pYZNE+Q+FZh1EjaEazU5X3BUbQ==
X-Google-Smtp-Source: APXvYqy3liAXBoXBna1vQrQA3a+41azQeKFrkkEh+b97s623lHqxninIVBzsI9Krsk3batRc+c3EVw==
X-Received: by 2002:a65:5886:: with SMTP id d6mr76297081pgu.295.1558372687639;
        Mon, 20 May 2019 10:18:07 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id s134sm28571578pfc.110.2019.05.20.10.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 10:18:06 -0700 (PDT)
Date:   Mon, 20 May 2019 10:18:05 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Qian Cai <cai@lca.pw>
cc:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, catalin.marinas@arm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] slab: skip kmemleak_object in leaks_show()
In-Reply-To: <20190514144741.39460-1-cai@lca.pw>
Message-ID: <alpine.DEB.2.21.1905201017420.96074@chino.kir.corp.google.com>
References: <20190514144741.39460-1-cai@lca.pw>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019, Qian Cai wrote:

> Running tests on a debug kernel will usually generate a large number of
> kmemleak objects.
> 
>   # grep kmemleak /proc/slabinfo
>   kmemleak_object   2243606 3436210 ...
> 
> As the result, reading /proc/slab_allocators could easily loop forever
> while processing the kmemleak_object cache and any additional freeing or
> allocating objects will trigger a reprocessing. To make a situation
> worse, soft-lockups could easily happen in this sitatuion which will
> call printk() to allocate more kmemleak objects to guarantee a livelock.
> 
> Since kmemleak_object has a single call site (create_object()), there
> isn't much new information compared with slabinfo. Just skip it.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

I assume this is now obsolete since commit 7878c231dae0 ("slab: remove 
/proc/slab_allocators").
