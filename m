Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98E2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872BD21741
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="OMdCtJAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbfC0NFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:05:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45306 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729314AbfC0NFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:05:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id v20so18605408qtv.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 06:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d8vohrDHmXaj8dPeFxTgq9hFa6mnamq9JQBWUjd1a/E=;
        b=OMdCtJAOXebwBZD85kjEwulAskD+huji+vaYW52nRq+9CBDXpY53JyqfSKEi7EmIWT
         yvDGt42qPNSv3hSlnuL4syyy3ntEKa0rZYusPb5qDvK+diGG8aS3W5HuTM+5k2PCfw36
         EajfVK64CbZzIqq0rugOlQatseZOB5P9cY5zfVpR+1qjdzOqtBfoO8DpbJAYct7QpPkB
         c1uNEXhRqr8tJjIepFBjyezk9bL5v33YRovDkB0n8OjWzQgQmb2daPFy7JGGMpYWb6+H
         yrNRJvHoy7oT94KfCnURKxnhyIkOItKtbGsesRdWd5gZcPjFyGTyJvVY2LFgWnYhSiq2
         Hrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d8vohrDHmXaj8dPeFxTgq9hFa6mnamq9JQBWUjd1a/E=;
        b=EZUvYDJO8uaafmlYm0g3jlsha/MdYYFzfz9U8IXMrwa4M01UMnsuMEYr3FHpD6ebxY
         tRJcDpjySCDq/4/jt325A3a2zm27yJ5m3E8i0az80F0/QGDgIZ8PsERLQfE6442KxUIz
         GK0NCaj+tblyZtlfRCcP/42JWOAZnpAsL7Gw4bUgnTsD7exFt2wVCPDAFvAQLVrpGaA7
         uot05h2uITGrlIQ+P6UMRgppV0EgTE+TVWgNJGtv9J/r7jbWHeFGajuTbpFizbd+jbUq
         3V9cN/pkxGyb2PbZZ1caZiYNwBbM3ohQqrG3p4jRVxjp7YaatINDsvSWwg84ES9y7HPh
         9zeQ==
X-Gm-Message-State: APjAAAX72VRtNSRX860CUTwTjTFQnAmgFk7vPAKFtjmLI+0KjwO66aSP
        I8wFnf9fwyFOMh9Vrt7n8o5ehAbPCv0=
X-Google-Smtp-Source: APXvYqyowtPb8iUVv0sqpgQw1DZfVAzV8hh9EtnJ9RGb27LO1hsBlIuqOKgOexg0m3zetsNP9fd+zA==
X-Received: by 2002:a0c:8693:: with SMTP id 19mr30981574qvf.73.1553691934222;
        Wed, 27 Mar 2019 06:05:34 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z20sm5101396qkb.52.2019.03.27.06.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 06:05:33 -0700 (PDT)
Subject: Re: [PATCH v4] kmemleak: survive in a low-memory situation
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com, cl@linux.com,
        willy@infradead.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190327005948.24263-1-cai@lca.pw>
 <20190327084432.GA11927@dhcp22.suse.cz>
 <651bd879-c8c0-b162-fee7-1e523904b14e@lca.pw>
 <20190327114458.GF11927@dhcp22.suse.cz>
From:   Qian Cai <cai@lca.pw>
Message-ID: <68cff59d-2b0e-5a7b-bca9-36784522059b@lca.pw>
Date:   Wed, 27 Mar 2019 09:05:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190327114458.GF11927@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/19 7:44 AM, Michal Hocko wrote> What? Normal spin lock implementation
doesn't disable interrupts. So
> either I misunderstand what you are saying or you seem to be confused.
> the thing is that in_atomic relies on preempt_count to work properly and
> if you have CONFIG_PREEMPT_COUNT=n then you simply never know whether
> preemption is disabled so you do not know that a spin_lock is held.
> irqs_disabled on the other hand checks whether arch specific flag for
> IRQs handling is set (or cleared). So you would only catch irq safe spin
> locks with the above check.

Exactly, because kmemleak_alloc() is only called in a few call sites, slab
allocation, neigh_hash_alloc(), alloc_page_ext(), sg_kmalloc(),
early_amd_iommu_init() and blk_mq_alloc_rqs(), my review does not yield any of
those holding irq unsafe spinlocks.

Could future code changes suddenly call kmemleak_alloc() with a irq unsafe
spinlock held? Always possible, but it is unlikely to happen. I could put some
comments on kmemleak_alloc() about this though.
