Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE47CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28240222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2YK7nxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404286AbfJRJhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:37:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45843 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfJRJhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:37:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id q64so5486039ljb.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 02:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XgKygpmqdxOai3YVrfrSn5tFWpbBq87jsIt+y3JevpI=;
        b=d2YK7nxnPnGzleOVegU5uASqFkj1Q6gDqyDHoSzwQxDkvAt/H+d3c4uHLTXsKb2Pkw
         I4TM6AxL8JJj70znbIhoqYNhkMfZ/rt0keQbpxy+XQQ4O62EbZYIApbmNANYrw0BIjrg
         hM3+lnVqMWReQAsqGN47SCjbSufQm5xgJIKUOOXT8G/CrNzstLnw61/D5q51VJZKxUp5
         QAnkV+4OLNHH5/f8+9huR7gpNmkXNCeA1YkXpH/z9SiRuAxEkAmA3LAToiHAxefz0cQn
         6k6pk/VhobFDSLzZ3qcdJCodVdxdLRyTsoJBQlZ2kiTUwUg4qdED/wSebMuoBYS+i95R
         WsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XgKygpmqdxOai3YVrfrSn5tFWpbBq87jsIt+y3JevpI=;
        b=MgiuCNgqCHbKnVycjobC12aDKWxPeSfW0rMNLHnrpxL2cyQkNWa7CrDApnuo0iQW6v
         TNmPpaFBYiqi0eSRJy8G5aDK126ibdOP1YXADjN7VDJaUVCnOESdOkeXJP3UgL7l0lcT
         hg/iQTGzf15RQnHPbaGP7S+FCWh0sbygTrpX+6yLJsnZk5SMnPEDxX5iR53JtW0y+GG8
         lAKg6QlqW9DYuLSjFntUhwTG+JK3gjkDVwsVxJS60rRh44Y2vhkHdJn2M1R3c+PQh423
         M6Tu1ctYAp7bg1/qYpSKBiGdyin9AGkIiIcEzehvgIni7B7NvU5Dx/UV49pb14FCzKzu
         cd8w==
X-Gm-Message-State: APjAAAWAsarT2KCrlWTrFThZ9Nm+TF84j/y37seWzrSp/RmumNpGkjsK
        jPXF7j1lpKyvcO8sMuf34JE=
X-Google-Smtp-Source: APXvYqzRCf0C+MAldjnpnN1uCmIYuwJA4nk5XkcFPvv/jbXljZbNr7sMXTeDm5Ltw995gG3+//mHRg==
X-Received: by 2002:a2e:9d06:: with SMTP id t6mr5592328lji.253.1571391470011;
        Fri, 18 Oct 2019 02:37:50 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id f22sm2074597lfk.56.2019.10.18.02.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 02:37:49 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 18 Oct 2019 11:37:41 +0200
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 1/3] mm/vmalloc: remove preempt_disable/enable when do
 preloading
Message-ID: <20191018093741.GA8744@pc636>
References: <20191016095438.12391-1-urezki@gmail.com>
 <20191016105928.GS317@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016105928.GS317@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Michal.

Sorry for late reply. See my comments enclosed below:

> On Wed 16-10-19 11:54:36, Uladzislau Rezki (Sony) wrote:
> > Some background. The preemption was disabled before to guarantee
> > that a preloaded object is available for a CPU, it was stored for.
> 
> Probably good to be explicit that this has been achieved by combining
> the disabling the preemption and taking the spin lock while the
> ne_fit_preload_node is checked resp. repopulated, right?
> 
Right, agree with your comment!


> > The aim was to not allocate in atomic context when spinlock
> > is taken later, for regular vmap allocations. But that approach
> > conflicts with CONFIG_PREEMPT_RT philosophy. It means that
> > calling spin_lock() with disabled preemption is forbidden
> > in the CONFIG_PREEMPT_RT kernel.
> > 
> > Therefore, get rid of preempt_disable() and preempt_enable() when
> > the preload is done for splitting purpose. As a result we do not
> > guarantee now that a CPU is preloaded, instead we minimize the
> > case when it is not, with this change.
> 
> by populating the per cpu preload pointer under the vmap_area_lock.
> This implies that at least each caller which has done the preallocation
> will not fallback to an atomic allocation later. It is possible that the
> preallocation would be pointless or that no preallocation is done
> because of the race but your data shows that this is really rare.
> 
That makes sense to add. Please find below updated comment:

<snip>
mm/vmalloc: remove preempt_disable/enable when do preloading

Some background. The preemption was disabled before to guarantee
that a preloaded object is available for a CPU, it was stored for.
That was achieved by combining the disabling the preemption and
taking the spin lock while the ne_fit_preload_node is checked.

The aim was to not allocate in atomic context when spinlock
is taken later, for regular vmap allocations. But that approach
conflicts with CONFIG_PREEMPT_RT philosophy. It means that
calling spin_lock() with disabled preemption is forbidden
in the CONFIG_PREEMPT_RT kernel.

Therefore, get rid of preempt_disable() and preempt_enable() when
the preload is done for splitting purpose. As a result we do not
guarantee now that a CPU is preloaded, instead we minimize the
case when it is not, with this change, by populating the per
cpu preload pointer under the vmap_area_lock.

This implies that at least each caller that has done the preallocation
will not fallback to an atomic allocation later. It is possible
that the preallocation would be pointless or that no preallocation
is done because of the race but the data shows that this is really
rare.

For example i run the special test case that follows the preload
pattern and path. 20 "unbind" threads run it and each does
1000000 allocations. Only 3.5 times among 1000000 a CPU was
not preloaded. So it can happen but the number is negligible.

V2 - > V3:
    - update the commit message

V1 -> V2:
  - move __this_cpu_cmpxchg check when spin_lock is taken,
    as proposed by Andrew Morton
  - add more explanation in regard of preloading
  - adjust and move some comments
<snip>

Do you agree on that?

Thank you!

--
Vlad Rezki
