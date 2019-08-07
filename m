Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A975FC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE832186A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="fgAle9Op"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389372AbfHGVer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 17:34:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43224 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfHGVeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:34:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so42823380pfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 14:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L+M4+2pGsDRUyWSE4KWHyF4gGN/CTdrXfy8qftEaVU8=;
        b=fgAle9OpDpnJ7GKQv0WtHbnZoKzcB8hPE4HOnQKm0VzYK81k8Q7cif033smKCs6zXw
         UxFxvbTClbbOkt2DzoYqMPsWd/JtUR6WO/58/L6gGzELqNPyroeUg1AQD8SOr0c1Tt80
         ondZOC7Xw7YyiyOFPPNOS67ELbBfwxbTaqzUZ/2NpGl9wW+yd5G/1UTq5bmKSivBOJNk
         Myiix8N6eWA5kgUgyOtBLebt4+a81tQ5C+Foveh+lL7Te+X1eQ5mi29r6dV5y5lm+CMQ
         inJiYzjr2BoXWtPGe/7WyAz1JuhnIy2buR4K9S+62kEZ8/xkaLWQome9OUbJHLbDCf5y
         3Emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L+M4+2pGsDRUyWSE4KWHyF4gGN/CTdrXfy8qftEaVU8=;
        b=fZpByRyfy5IFyNGD8Cz9+2IDYwGrzMKPZM7R+SGbe/ntkDZC2SotKF4oOIqGIqbTt/
         xJigfKSM3lleUwYaNqVdahH2pvzSBRIpf4Yzfp8Hn9vSE8Iggg/1HwBej89KCRND3EaX
         iPxBRU/gWxqMfIBTcC1EOZ2fSM9hpB9DVbQ9aO1/podUXTLBK9YXfKfzhYLhCkZtujHG
         R7XSjksbufcPoYWNgglP3hzJL31MXDbE5ngqsjjnQQjCC5l/4x16f+8Ne7YPPZS4T7nm
         WfvSfGF/XXIRDnBDD1LLAmTeXdVhRSAKqiiKMwjvfVRYjVGPbfaRPiwjVjy+p1oTsezw
         qcgQ==
X-Gm-Message-State: APjAAAVXVwiqsQZIcNOdGgDeznbcWWj37mf/JfQMtmlk0VkTIDeP5rZA
        bXlYZunX1cvpHG8L9W5oMCneyQ==
X-Google-Smtp-Source: APXvYqx9Uyn/xw2tiJ8g/Ou75InfUAPJucpury6bca7dwFHlpwvJgJOH8wkakJmYsrVu3gqwJHNNlw==
X-Received: by 2002:a63:1f1b:: with SMTP id f27mr9431471pgf.233.1565213686124;
        Wed, 07 Aug 2019 14:34:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:f7c1])
        by smtp.gmail.com with ESMTPSA id y14sm45924523pge.7.2019.08.07.14.34.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 14:34:45 -0700 (PDT)
Date:   Wed, 7 Aug 2019 17:34:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-ID: <20190807213443.GA11227@cmpxchg.org>
References: <20190805193148.GB4128@cmpxchg.org>
 <CAJuCfpHhR+9ybt9ENzxMbdVUd_8rJN+zFbDm+5CeE2Desu82Gg@mail.gmail.com>
 <398f31f3-0353-da0c-fc54-643687bb4774@suse.cz>
 <20190806142728.GA12107@cmpxchg.org>
 <20190806143608.GE11812@dhcp22.suse.cz>
 <CAJuCfpFmOzj-gU1NwoQFmS_pbDKKd2XN=CS1vUV4gKhYCJOUtw@mail.gmail.com>
 <20190806220150.GA22516@cmpxchg.org>
 <20190807075927.GO11812@dhcp22.suse.cz>
 <20190807205138.GA24222@cmpxchg.org>
 <20190807140130.7418e783654a9c53e6b6cd1b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807140130.7418e783654a9c53e6b6cd1b@linux-foundation.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 02:01:30PM -0700, Andrew Morton wrote:
> On Wed, 7 Aug 2019 16:51:38 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > However, eb414681d5a0 ("psi: pressure stall information for CPU,
> > memory, and IO") introduced a memory pressure metric that quantifies
> > the share of wallclock time in which userspace waits on reclaim,
> > refaults, swapins. By using absolute time, it encodes all the above
> > mentioned variables of hardware capacity and workload behavior. When
> > memory pressure is 40%, it means that 40% of the time the workload is
> > stalled on memory, period. This is the actual measure for the lack of
> > forward progress that users can experience. It's also something they
> > expect the kernel to manage and remedy if it becomes non-existent.
> > 
> > To accomplish this, this patch implements a thrashing cutoff for the
> > OOM killer. If the kernel determines a sustained high level of memory
> > pressure, and thus a lack of forward progress in userspace, it will
> > trigger the OOM killer to reduce memory contention.
> > 
> > Per default, the OOM killer will engage after 15 seconds of at least
> > 80% memory pressure. These values are tunable via sysctls
> > vm.thrashing_oom_period and vm.thrashing_oom_level.
> 
> Could be implemented in userspace?
> </troll>

We do in fact do this with oomd.

But it requires a comprehensive cgroup setup, with complete memory and
IO isolation, to protect that daemon from the memory pressure and
excessive paging of the rest of the system (mlock doesn't really cut
it because you need to potentially allocate quite a few proc dentries
and inodes just to walk the process tree and determine a kill target).

In a fleet that works fine, since we need to maintain that cgroup
infra anyway. But for other users, that's a lot of stack for basic
"don't hang forever if I allocate too much memory" functionality.
