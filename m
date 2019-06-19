Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0AAC48BE0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 23:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6024205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 23:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t5CyOJNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbfFSXEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 19:04:41 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44874 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfFSXEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 19:04:41 -0400
Received: by mail-yw1-f67.google.com with SMTP id l79so304031ywe.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 16:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NbzMOyrZckNlP/Lcg+Lm/vM3zrC2t8DPpb83xlh9FiI=;
        b=t5CyOJNfaac+Q7sPzpACyPTDx6EHsMBAXAnNFHc1O5tDZWecDaCzf1vYTuyz7Zjf/e
         67AVLo3wFwFhYh4mwpzgD+9UNuTSphgseGd0AVOtn7iOtYOElLcQ3s+WX4gwDSQUJSAG
         kHzUBPWbM3Dmo4KyNNeKLuRTTau5zxBm1pYUE8IUgg96i3/B0ojjp1aZCvK8b5YvIrRq
         3y/D3kCzgimUMVAjolJtiirGA8S5lSRCCmJdB1ggTynoPqquMl1gDOrFf2Hao69SK3nD
         qqRIODa4r7NbdVpNTrP+mSFxZxA2I3Lap/PkRe7pPMQAA9C50Yxp8L3JthprklpEeTg/
         Qmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NbzMOyrZckNlP/Lcg+Lm/vM3zrC2t8DPpb83xlh9FiI=;
        b=Z0QeQo7X/hAr+z9/gp4kRXAB/YTpLc+uGpxDXbMXepAe4JIXUKLhh4w4s8KCmGbevi
         X8QP6fEdCnVfzZ5AFhJS+f54fjj2SRKL4elT/C7fwh2X2LylOyA4Jh3kyLki2e/UKV1K
         Tohvwb2qCYsVa+iovqOKs93HErEYzB7rMe9NWemG1c/aNzHVZ7CezsmVmzppVnIg1jcz
         gK3sQBjdYOJPsH897MIvF7SaF3qfj7Qw5S9hz17nrny2FCML9mTRUorNgQHfb636uEXe
         mCF8NHkkn/REjOyfG/OlNVigG8D19/nC4TOdhwMl7rREPwH4KLBT2MU/Yf558P7KLS7R
         TDAQ==
X-Gm-Message-State: APjAAAVP06Ol9I+Zz9tKYe0YIwlHXvyrr2tNZV+wG1CLxyc03yYGU9YS
        ZVpvk4HF5ZoFNHyjvSyFLvS2lctdVtbgTClkexoRBw==
X-Google-Smtp-Source: APXvYqwwLc9GbuN1yski600QDsOdlXMt97I/+eg7SO2Z7GQo/t8DI3dWtHIREvPeuOmKIK1eoWONOQDWPdZIfMaHZBs=
X-Received: by 2002:a81:a55:: with SMTP id 82mr37722007ywk.205.1560985479831;
 Wed, 19 Jun 2019 16:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <e5cfe17c-a59f-b1d1-19ce-590245106068@intel.com>
In-Reply-To: <e5cfe17c-a59f-b1d1-19ce-590245106068@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 19 Jun 2019 16:04:28 -0700
Message-ID: <CALvZod6Bfbi57mRmbYetO+R=gB07kkewo=F9sTyMdWpDXGgwDg@mail.gmail.com>
Subject: Re: memcg/kmem panics
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 3:50 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> I have a bit of a grievance to file.  :)
>
> I'm seeing "Cannot create slab..." panic()s coming from
> kmem_cache_open() when trying to create memory cgroups on a Fedora
> system running 5.2-rc's.  The panic()s happen when failing to create
> memcg-specific slabs because the memcg code passes through the
> root_cache->flags, which can include SLAB_PANIC.
>
> I haven't tracked down the root cause yet, or where this behavior
> started.  But, the end-user experience is that systemd tries to create a
> cgroup and ends up with a kernel panic.  That's rather sad, especially
> for the poor sod that's trying to debug it.
>
> Should memcg_create_kmem_cache() be, perhaps filtering out SLAB_PANIC
> from root_cache->flags, for instance?  That might make the system a bit
> less likely to turn into a doorstop if and when something goes mildly
> wrong.  I've hacked out the panic()s and the system actually seems to
> boot OK.

You must be using CONFIG_SLUB and I see that in kmem_cache_open() in
SLUB doing a SLAB_PANIC check. I think we should remove that
altogether from SLUB as SLAB does not do this and failure in memcg
kmem cache creation can and should be handled gracefully. I can send a
patch to remove that check.

Shakeel
