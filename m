Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F259FC28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4912054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="zXrO8KZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfE3MIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 08:08:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46349 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfE3MIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:08:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id n12so827002edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pTUXDtN/G8tAI7G/XWKZT9rjJMafN/rAkwsNs0hRrJ8=;
        b=zXrO8KZU/bIpALQ5nQ7nlUslj6ODQZSWnIyQchfuY9cAMGZ6QY9HVEbpN44ZVtsAtY
         UcSf2lRJYAfprTOv2qmbx5dCYaJeK2Fv0x9uGw9JH7dQnmjw6YQVVE7aKd08Nlg2knEE
         opr44llZBxLoORCxnLzANIKsBMHOI44URrT5ObPeEdkHJgOqQhYmoyrZ9WWZ+gVAKfpJ
         jNlu3NTUpT93k9miVXATJVKEk6pFx2oJu91CNQu3OreOVJHN7y0EYVRnhdJ5FiIKNqdR
         Ent82r0XiPyT3XwYoZM5/j7npQnH8q9TneS+HpniB0NkkWt80uVODvzr9oD2RJR54Ha0
         M7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pTUXDtN/G8tAI7G/XWKZT9rjJMafN/rAkwsNs0hRrJ8=;
        b=cZEQei0Ei4tzgZYoaCmQCIRzC3F1cY3bLQfFPJH6/9i4GYXzj2sBiyXVg/tfjZmRaO
         1wjhYCX6zi56m1r8t6Kt97a519iGefceKfItsvbijZ/8DMnSPWR7LT1fcAKWSMW8pJeH
         pnSKDes5JDmY2dIwtH/ieGMNnP4bKacdDey0kFel2+1Wh4L6TJOAYDsskVMRMPV5Dybp
         2riQpmt5wjUJHUMm2HhlqxjaKGgcdWbK1vKxbejXqxkA/T22Y/sSsBWaUy8v2zts2vb3
         bTrKWbAtE7ixSWsLcIpsIqezpobuYiO7th8VLOOr4t9TYfqJLSk6ddNjOIqE4ia3gnF3
         jWKA==
X-Gm-Message-State: APjAAAU1YCgKEoKm4ys6Cw2poXex+gJhQr1c1DpK2+9Wp1Tb3GB1FPLG
        BuBb/KFNjZTDVPlmGTEQa3hArw==
X-Google-Smtp-Source: APXvYqzKJsNIKOFT+ULZ9yJACrnn3QN4bI+DsmkrXTovJ/S8j3DqZH7dMiwGajoNuYn3Y8aUpYhN8w==
X-Received: by 2002:a17:906:470a:: with SMTP id y10mr3092113ejq.238.1559218102315;
        Thu, 30 May 2019 05:08:22 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p27sm401293ejf.65.2019.05.30.05.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 05:08:21 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6FB831041ED; Thu, 30 May 2019 15:08:20 +0300 (+03)
Date:   Thu, 30 May 2019 15:08:20 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     ktkhai@virtuozzo.com, hannes@cmpxchg.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        shakeelb@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: shrinker: make shrinker not depend on memcg kmem
Message-ID: <20190530120820.l5crrblgybcii63f@box>
References: <1559047464-59838-1-git-send-email-yang.shi@linux.alibaba.com>
 <1559047464-59838-4-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559047464-59838-4-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 08:44:24PM +0800, Yang Shi wrote:
> @@ -81,6 +79,7 @@ struct shrinker {
>  /* Flags */
>  #define SHRINKER_NUMA_AWARE	(1 << 0)
>  #define SHRINKER_MEMCG_AWARE	(1 << 1)
> +#define SHRINKER_NONSLAB	(1 << 3)

Why 3?

-- 
 Kirill A. Shutemov
