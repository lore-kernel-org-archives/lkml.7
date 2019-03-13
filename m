Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB57C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC702146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="OnWbLuxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfCMTsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:48:53 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37416 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfCMTss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:48:48 -0400
Received: by mail-yw1-f67.google.com with SMTP id w66so2490456ywd.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 12:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ctaB5au7utl3Gx2JywUyoePNtfp/SVRLeNPeDseyDJs=;
        b=OnWbLuxJUnJM/J0oMb5kwfpcPSBBvgndkRUIdj1Of5FyPfO08VbDXbFmlNVzmRVL4p
         mQUwSvPlqYMcNLAJ8YCO7rRrcAV1iQfb8V4MXysCtaiVX9tmNvRZyAhzulMzdmbBNBPe
         MUO0U1YNBaS7QOW7PfCODPfZx/VPVPHBWGL7tP6MRvtki+Lt3mB6HiAy+qhMUcq6qaE9
         1mJmoPPW8nM2UUjSlsB8ZZLSjXXvTKmQKacK0PgYLsvmmpBn6wVl3F3yTeaffyzrXKDg
         F904F9pO0vhglCrjhO8Rw0eeAEUHQDraSLAuvtSFLxPt9PbJ5TlwYTocy0p0jtiSADoj
         1xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ctaB5au7utl3Gx2JywUyoePNtfp/SVRLeNPeDseyDJs=;
        b=MppdHZB46g2q+8zWAj+3hWUdCYFKStZRdEm1gH5Uz4ytgGcm2k3NYGKgJnDZqXCkS0
         jGOWKZl6PxfnIfTzNhukSW1xPBWmFXxsc4qat5gmIDl0fUo+bF6w1XqFkrfEd4Uib4C5
         q7XjdSpRQId9AvRcXCCS5nezv2L9vzKHIXAVVyHV1J8PD8lpDWC9z811jfcXxE/i7SaW
         qZNG4/ZJcEd6UFtFm/GEso2bAjoPf/fWbvzqOsaWCWkI0pjUxRjjZ4qeSglqJ+VOnLeZ
         NXccwK0AKxZNRSdDYQwsSdFOq0EJiwqdstuJQitWJ9JdlAiKkNTo9652TtiXY2yNHxqS
         7WpQ==
X-Gm-Message-State: APjAAAViJj9/UHS2gUfir1RCs8i1wvbJKxZvpKKzv0qiKOdERAdN6oQS
        fNwYAvW0azHEYWVplGYKUGeZqQ==
X-Google-Smtp-Source: APXvYqyAlTREA7MYT/TBB0yTNoQ3Snqb0+I/lcx9HWdX+jEh4Hya3vdEqloX9ZGZMvipUA07u+QWRQ==
X-Received: by 2002:a81:c546:: with SMTP id o6mr4753314ywj.508.1552506527798;
        Wed, 13 Mar 2019 12:48:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::468c])
        by smtp.gmail.com with ESMTPSA id h5sm5599866ywh.3.2019.03.13.12.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 12:48:47 -0700 (PDT)
Date:   Wed, 13 Mar 2019 15:48:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     linux-mm@kvack.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v3 6/6] mm: refactor memcg_hotplug_cpu_dead() to use
 memcg_flush_offline_percpu()
Message-ID: <20190313194846.GA6683@cmpxchg.org>
References: <20190313183953.17854-1-guro@fb.com>
 <20190313183953.17854-7-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313183953.17854-7-guro@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 11:39:53AM -0700, Roman Gushchin wrote:
> It's possible to remove a big chunk of the redundant code by making
> memcg_flush_offline_percpu() to take cpumask as an argument and flush
> percpu data on all cpus belonging to the mask instead of all possible cpus.
> 
> Then memcg_hotplug_cpu_dead() can call it with a single CPU bit set.
> 
> This approach allows to remove all duplicated code, but safe the
> performance optimization made in memcg_flush_offline_percpu():
> only one atomic operation per data entry.
> 
> for_each_data_entry()
> 	for_each_cpu(cpu. cpumask)
> 		sum_events()
> 	flush()
> 
> Otherwise it would be one atomic operation per data entry per cpu:
> for_each_cpu(cpu)
> 	for_each_data_entry()
> 		flush()
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
