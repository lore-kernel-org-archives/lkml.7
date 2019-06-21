Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906D2C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 20:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5735620665
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 20:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rv+E/7b7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfFUUw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 16:52:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34539 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUUw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 16:52:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so3559420plt.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 13:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xsZwkR1O4dGnGMsIIG/ufAmeJ6Z+ZenaQocCY4Tza70=;
        b=rv+E/7b7JY6cpCuEo3QEn8sbHqI1ZR79p1uD+ayLvYUjdZXy45cMBXnpOBANzRD/h9
         AKwFkx5YKkPwDV+z+alIPV1uhD4Us31/0w7Onebbflsxun6qItXz81HGcxTZ7S45mQkF
         mdeJXXlNrRYxGieY6CO5sW7OvYILoQQwQhzFqNXgIR9sUhMfzb7yJehRXESr28JDm6lq
         IJUwCKmkCEQEHh2qvgZDsesKij6FJXeF66csul2evLnnuuXC21nlojygQcdLk+8jHF2L
         PqLK6XveRhNJzO6G5iTrQWirXDKQbFegQGPu2Np+nWTUBVb8ggftrLbBsHWiZy5kTdaQ
         g5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xsZwkR1O4dGnGMsIIG/ufAmeJ6Z+ZenaQocCY4Tza70=;
        b=cm3pmXtkon+1qkeEM0xK4BoRL1r94qn1IVOg92Ld/47UXxnGXiDJ0jCk3oXGFoit9f
         y3ZNPRcOUqMJQVVqiqYh4RUaszfjnOZAEjfCNVbRPGdSTkRCz9QjkS/8qsacKlGZaKae
         m/1eT+pydQZkpQCklY0gUWW/Bs/7giNHd+xyoeV+hYgznTpu2z2pdeqnwiCWb5OOV9eA
         qe4dPAgfAkkqNSmKMC3SJrPPnKiGO2Wb61qClDK1pdqkrD2N3m4UC9ThCUtMDUg433vs
         HH6exjRIjx7zrZnZ92gS14CnZ9/RBpB2zx4vY0EES8Jk939IfBfAsqGUOFkbNgLYaDko
         8d6w==
X-Gm-Message-State: APjAAAVzcDWGRSP8rRX3ZGs9Dz81HrArEXGOehGRNew1ApiGtIfp513K
        sWJQZIoEsbYlhLJNH3bD5/s0Nw==
X-Google-Smtp-Source: APXvYqz8pEu9QXTZCF8KWb47EU2DnXnK1n2Nyy53mjFvIfV6G+FleV8pUn/1peh0vqHcvEjyo/py0Q==
X-Received: by 2002:a17:902:f089:: with SMTP id go9mr64259063plb.81.1561150347844;
        Fri, 21 Jun 2019 13:52:27 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id f17sm3582163pgv.16.2019.06.21.13.52.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 13:52:27 -0700 (PDT)
Date:   Fri, 21 Jun 2019 13:52:26 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Shakeel Butt <shakeelb@google.com>
cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] slub: Don't panic for memcg kmem cache creation
 failure
In-Reply-To: <20190619232514.58994-1-shakeelb@google.com>
Message-ID: <alpine.DEB.2.21.1906211352130.77141@chino.kir.corp.google.com>
References: <20190619232514.58994-1-shakeelb@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2019, Shakeel Butt wrote:

> Currently for CONFIG_SLUB, if a memcg kmem cache creation is failed and
> the corresponding root kmem cache has SLAB_PANIC flag, the kernel will
> be crashed. This is unnecessary as the kernel can handle the creation
> failures of memcg kmem caches. Additionally CONFIG_SLAB does not
> implement this behavior. So, to keep the behavior consistent between
> SLAB and SLUB, removing the panic for memcg kmem cache creation
> failures. The root kmem cache creation failure for SLAB_PANIC correctly
> panics for both SLAB and SLUB.
> 
> Reported-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: David Rientjes <rientjes@google.com>
