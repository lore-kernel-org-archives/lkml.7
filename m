Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADE9C49ED6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 00:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004A92082C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 00:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="1YIRu7OB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfILAoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 20:44:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46684 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfILAoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 20:44:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id i8so22303642edn.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 17:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6StUCxf+BWs9paiGrgjzm2Rs3EDZa4/BKSwVoScmogM=;
        b=1YIRu7OBWjHb8fUC4OZsQnAZgF+XMXsYulmcYNiwsD9u1wQ8+Utdc1dw+m66iuQdix
         v5p81DWC0EjIhrdOnyRFKeqr5rM/g3udJ6VSr1MasKrLYYkh3Z4RzAF3qYUxsmA2Gnlc
         N4GHSmsEAARs3WKCX7kEct9w976BVLZXa6PkGWm4NZFKsMo7VyjuhEJCNBOWW5jc9KEJ
         vHFzHJznDAECzPgjTfQ8E23aVgbLlyG1AbpmrBx34xi0WwzzawqOkcfkQm0jqtr3FedN
         vUFDJiEZh58lxtic/ZjYeSEGnfQv/9tSJqml56+sMByvXjeASfUxcLOWfM6EzLF6sg0n
         6o8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6StUCxf+BWs9paiGrgjzm2Rs3EDZa4/BKSwVoScmogM=;
        b=Y7H16S5DYZf/uG3cUSFXR5N/PoCCI0/6vKXugPl2vnnvyeIwbzRCA2oMeBawaxTpVU
         ruoalmRiwgP+Ag9HRzmzlyBVsv0Oie7HvCqZxlb5laJWV4SANQufvAs1o5ywQM+N9aHS
         isa/tEiS5649s7hRz9LNGPo4BIqStCQkU3n1oqrmGdtbrd30MCUlK3fe8jQat7tvPTPF
         BhnhBWYVgRl11zHBc2Qc/jl5aKTHe513aYTMo2MFPFXbZIyVAQfBwDBehATIvYvXpdCF
         8uLqn8qfqpq87rY5hYcMPhlyc0GMpV+zejrmJi/2Fje+Hh0Hku54G/GxmhCl7F8/RdGP
         H9yg==
X-Gm-Message-State: APjAAAUtcz27ExPZx5bouCXICzQuiRj0Q7XlUswhogwalIZFR+7ppN/F
        VrEijrRYn6l8VxTPODRdUxz/Ch9vkKk=
X-Google-Smtp-Source: APXvYqzi7ktkOl27RjHC7fqkd1PP4Q4XGWiLksyI41yH4eDgMgZtb4qs2+CSjrzffnaM6EtMV1Zp4Q==
X-Received: by 2002:a17:906:d922:: with SMTP id rn2mr31668293ejb.169.1568249041020;
        Wed, 11 Sep 2019 17:44:01 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b36sm4490966edc.53.2019.09.11.17.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 17:44:00 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 58DAF101601; Thu, 12 Sep 2019 03:44:01 +0300 (+03)
Date:   Thu, 12 Sep 2019 03:44:01 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: avoid slub allocation while holding list_lock
Message-ID: <20190912004401.jdemtajrspetk3fh@box>
References: <20190911071331.770ecddff6a085330bf2b5f2@linux-foundation.org>
 <20190912002929.78873-1-yuzhao@google.com>
 <20190912002929.78873-2-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912002929.78873-2-yuzhao@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 06:29:28PM -0600, Yu Zhao wrote:
> If we are already under list_lock, don't call kmalloc(). Otherwise we
> will run into deadlock because kmalloc() also tries to grab the same
> lock.
> 
> Instead, statically allocate bitmap in struct kmem_cache_node. Given
> currently page->objects has 15 bits, we bloat the per-node struct by
> 4K. So we waste some memory but only do so when slub debug is on.

Why not have single page total protected by a lock?

Listing object from two pages at the same time doesn't make sense anyway.
Cuncurent validating is not something sane to do.

-- 
 Kirill A. Shutemov
