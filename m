Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3D9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CB22075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rAymWQyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733057AbfC0Td1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:33:27 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34884 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbfC0SCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:02:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id h39so19980077qte.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 11:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I5uALa7MVL7UzXPrEYcYU1Dm9p2rPQBrM3MAs5UYgj0=;
        b=rAymWQywHAL6cGuLPbwZYc6GHPnzTva6JXMImf+l/QA6vsyiRM3ITgughd+S5T/UST
         twIk0RyODDDlWDX2xDRPkJTuSD5Irmpn9hUlDRrCR4c/V+zQPURL77c4T7YCGiZE7NlJ
         9GDZAIkTR9Jy7Yu4QVQyfl9a9fRNdg7g6eJU+vwJTuAw1MUt/xuplZ8b2Wuw98TiKo6+
         DoGtFDjkJ1D4WgXowI27QJwWZI6wtOIeWP1thglRkPdAXo7gw06gS4M6VBjixhWxmc9w
         K94yUTVqfA/uaj3tAMKUZhgPM+h1DeBVU4jayX5ZDwiLco6oWSbrtXQoJtwWoOkykTqO
         NZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I5uALa7MVL7UzXPrEYcYU1Dm9p2rPQBrM3MAs5UYgj0=;
        b=EA4GYKdGV5ulxLecQdI/v9pWBSvaUnJZrjGFSZGQ+oRZIJU/UvOrwOuSsSGgRiWqPU
         voH6GD0rmz1DENtu9+An7/Pf/VG9ic9BJHk3hZQqgozA/l0JKoDE13wLxZOR9+phvhVi
         cn/diZAPcX8JlBpGbo1gykozov6tTOQt1rsmxoRAls/gv0fRGN2ln3kvyEyoU6bFmqAL
         mlvF/PvPPUZ8rtlbLyONuhZYHcZSi8XkvTz/obRB6szBfX8iCrcgUCTsiHiVM45TJBx/
         GK4bUEw3XMjf8XwSieV53Kp3azApmMvqOtV/B0f5PkuFGU9XnI9FB0S+caVNFlHZdgBB
         8tXA==
X-Gm-Message-State: APjAAAVPLsuSzU5RHNdh6hzuYp7WtfGZTdY/Hvwmcub/ygTiQUqPxKcj
        Mln1tzF5M28qEMBqiF2gRWokcA+9TM0=
X-Google-Smtp-Source: APXvYqxSvtALFnQF+jYQ/t44NY6L3IdneTFfmE4na1KaS1YumXhbcc8Kb66nN5Yz+mR4IiaolNEoEg==
X-Received: by 2002:a0c:d2fa:: with SMTP id x55mr32627047qvh.161.1553709750897;
        Wed, 27 Mar 2019 11:02:30 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j5sm776085qtb.30.2019.03.27.11.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 11:02:30 -0700 (PDT)
Subject: Re: [PATCH v4] kmemleak: survive in a low-memory situation
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, cl@linux.com, willy@infradead.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20190327005948.24263-1-cai@lca.pw>
 <20190327084432.GA11927@dhcp22.suse.cz>
 <20190327172955.GB17247@arrakis.emea.arm.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <49f77efc-8375-8fc8-aa89-9814bfbfe5bc@lca.pw>
Date:   Wed, 27 Mar 2019 14:02:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190327172955.GB17247@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/19 1:29 PM, Catalin Marinas wrote:
> From dc4194539f8191bb754901cea74c86e7960886f8 Mon Sep 17 00:00:00 2001
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Wed, 27 Mar 2019 17:20:57 +0000
> Subject: [PATCH] mm: kmemleak: Add an emergency allocation pool for kmemleak
>  objects
> 
> This patch adds an emergency pool for struct kmemleak_object in case the
> normal kmem_cache_alloc() fails under the gfp constraints passed by the
> slab allocation caller. The patch also removes __GFP_NOFAIL which does
> not play well with other gfp flags (introduced by commit d9570ee3bd1d,
> "kmemleak: allow to coexist with fault injection").
> 
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

It takes 2 runs of LTP oom01 tests to disable kmemleak.
