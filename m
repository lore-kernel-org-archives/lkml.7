Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1676C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672262187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJ6oDskv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388676AbfKGMoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:44:03 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:37267 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733250AbfKGMoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:44:02 -0500
Received: by mail-wm1-f52.google.com with SMTP id q130so2269488wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 04:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3oXRQtCvNsyXQh21unQL/FfTiJzS75xtE8a9rWkSxQA=;
        b=WJ6oDskvoMm1gpMkf1mKBxE4gXipcmYsR5x9OMbPLlgkqF3O+WQkMNCMa0VNV0FwRZ
         J1Yp1IAULIMWVSE6RDUZjAhf/y/Rd4p8Y1V8n0y+Ku77A/79mK03NxfdFXfxGgu0oxyq
         +sJ0E2bxGrsz+C4/kXbnfBjRBeO2gzO9MSjxA5uvKTSj+dkpBjr2VYd+nuUC7aaJWIgb
         0L4vRf2EqR/+4T9h6YsLwdHLceF2UPuhHZxWEYkTHkcDUtWKxem7BhvrRncKD92La4sX
         ci//6IkGLKeynWPCltqkNv7X9DqlNnNYoCwsiuNIDSqpvwfM/OYiLKPWWkcagd+3HOjG
         71sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3oXRQtCvNsyXQh21unQL/FfTiJzS75xtE8a9rWkSxQA=;
        b=sZhlobT5ViWY1AwLyr4+eOYKrhaiedyHaYVuiw5O9oBjatRVtOEzq5pVTJPJhoTSdd
         jr0J1PtYeCcIvNBfOgP0F0WqOCEUny6shKP6aNEdpqGizmXAzTvryt1k8/8m8IpKOvur
         0yPDyY8dtMWYoKQcxxKfgQCjkysq+VI7pseYDeGEMh7FHYHDogY+3TjGiOXwqFGeo5fn
         sqOUBDNi2oYCSYHSgTIQUbLZeky3EyfEeVflTMeLbAVjsHOhdDwZxdVFSu4djFsIQTTe
         rh46EjiNF1Aywi7YHDvwa3E2LTFX2opWcUmEvgpd/Llqw+WlkOSZfQ36ruZ+EmjhEBvA
         f+LA==
X-Gm-Message-State: APjAAAXK+m1I9WyVM9nBIs+hOMwA18S6UJXAO0O9ZlqhyZIabAFcE87z
        FiDUJq/cSLDr0JASwznp86v73g==
X-Google-Smtp-Source: APXvYqz3NJjXpngz22u1SKyyrajhr3OQJlGegVqsLYHnJod461QymsH1DvNgNuAxwAYexgNEDfOt3w==
X-Received: by 2002:a7b:c94e:: with SMTP id i14mr2638607wml.174.1573130640313;
        Thu, 07 Nov 2019 04:44:00 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id x8sm2013832wrm.7.2019.11.07.04.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 04:43:59 -0800 (PST)
Date:   Thu, 7 Nov 2019 12:43:55 +0000
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Aaron Lu <aaron.lwe@gmail.com>, Phil Auld <pauld@redhat.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Subject: Re: [sched] 10e7071b2f: BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20191107124355.GA161316@google.com>
References: <20191107090808.GW29418@shao2-debian>
 <fc023bbd-e282-c986-b43b-18ac31b2e362@arm.com>
 <20191107120922.GA82729@google.com>
 <20191107121551.GB82729@google.com>
 <6a23a062-9b82-668d-7945-8da34f4dc5f0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a23a062-9b82-668d-7945-8da34f4dc5f0@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 Nov 2019 at 12:37:09 (+0000), Valentin Schneider wrote:
> On 07/11/2019 12:15, Quentin Perret wrote:
> > On Thursday 07 Nov 2019 at 12:09:22 (+0000), Quentin Perret wrote:
> >> sched_move_task() follows what Peter called the 'change' pattern, so I'm
> >> thinking this is most likely the same issue. Dropping the lock causes an
> >> unmitigated race between sched_move_task() and pick_next_task_dl(), so
> >> hilarity ensues (set_next_task() being called twice for instance).
> > 
> > Bah, scratch that. 10e7071b2 is clearly before the pick_next_task()
> > rework, so that's not it :(
> > 
> 
> And besides we don't drop the lock until reaching pick_next_task_fair(),
> and the splat says it died on pick_next_task_dl() which happens earlier.

Right, with the rework of pick_next_task(), we would in fact drop the
lock before calling pick_next_task_dl(), which would explain the issue,
hence my confusion.

But that doesn't apply here, so this is another problem :(

Sorry for the noise,
Quentin
