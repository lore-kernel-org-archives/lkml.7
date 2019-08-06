Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFCBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B56E214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="bav8Zaoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbfHFO1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:27:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35190 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbfHFO1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:27:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so41624218pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 07:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YvOUxLGsf5REbDYV1mt1/FJ++s5a0U4QlhLEhk90+sU=;
        b=bav8ZaojXR2Z1rc/BSjwZS8N8F2yIt51pqZ9cgUxBwuiI7HYHuqFHm1uYhsEremsJI
         azzUR1HDyAxtnNEoC+W+p2eC9uW61STp/ZcwWg/9VoU+oVBY3aQruRGgTkIIkurZoLm3
         4hjNwy/j6L6826Mb2Oz7HSMWHLSv5A0dXSrPrA2ADmADUWhJke99tYUoF4dRf3S7bgJ2
         MhsnutogSlmdTGxC78N0ZhJ3MBhlvZOihF8d+7rOwih3jSYHA6NCgFrO5k4ShxzJB+8k
         GMx9eeEZ3TtRrmShFv6Z9tNtRCtNQep2h0lHdL0Ci+d30x7RVDgNKdmZcdgt12G6eG9n
         aHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YvOUxLGsf5REbDYV1mt1/FJ++s5a0U4QlhLEhk90+sU=;
        b=p8AdVcwGst9htSIbdbSYyUxrShI8NO8tD6NoqLlOBkcBvFVFQ5KjAAqHtCDyCoRd9J
         NzRDECibHJRV/61itebJFFVCZxxjF+ciFwST731S4SL/VK0PkMaNhtP3nzD6Gcp6biKc
         avaoG9wXOtjICS1lqOsNG4H1pm6NC78SHUjQyA1bFCwb/rOAn3dc6/HxY2NUAmHODYID
         DE5y/NSu5eLDx2crRsin3JXduUy89+Qqe+MERdtkO2XTOOnhwZQI74md4v7EurO6GEMm
         diQNzI1zamPLSR+ppto8eEyRSQO9G6l+I609SJHK/sqh4vZoKn/QY2SE87rOmWW290dP
         LXMw==
X-Gm-Message-State: APjAAAUUW25KKLfFqy1Ae4kbyoTngSeYH4viBOALrEiebFL4dOYIiSn+
        yIS51UHQIAJiPrAXjMgevPSCIdsW7S4=
X-Google-Smtp-Source: APXvYqw+mL4dtvDqG/HOBlE/eKxohKGn3vxgXC9NjINqDpnyasVQ2CQ/+l+kO0tma8baClGGqllUxg==
X-Received: by 2002:a17:90a:c391:: with SMTP id h17mr3525011pjt.131.1565101651110;
        Tue, 06 Aug 2019 07:27:31 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::9890])
        by smtp.gmail.com with ESMTPSA id c26sm91636411pfr.172.2019.08.06.07.27.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 07:27:30 -0700 (PDT)
Date:   Tue, 6 Aug 2019 10:27:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-ID: <20190806142728.GA12107@cmpxchg.org>
References: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com>
 <ce102f29-3adc-d0fd-41ee-e32c1bcd7e8d@suse.cz>
 <20190805193148.GB4128@cmpxchg.org>
 <CAJuCfpHhR+9ybt9ENzxMbdVUd_8rJN+zFbDm+5CeE2Desu82Gg@mail.gmail.com>
 <398f31f3-0353-da0c-fc54-643687bb4774@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <398f31f3-0353-da0c-fc54-643687bb4774@suse.cz>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 11:36:48AM +0200, Vlastimil Babka wrote:
> On 8/6/19 3:08 AM, Suren Baghdasaryan wrote:
> >> @@ -1280,3 +1285,50 @@ static int __init psi_proc_init(void)
> >>         return 0;
> >>  }
> >>  module_init(psi_proc_init);
> >> +
> >> +#define OOM_PRESSURE_LEVEL     80
> >> +#define OOM_PRESSURE_PERIOD    (10 * NSEC_PER_SEC)
> > 
> > 80% of the last 10 seconds spent in full stall would definitely be a
> > problem. If the system was already low on memory (which it probably
> > is, or we would not be reclaiming so hard and registering such a big
> > stall) then oom-killer would probably kill something before 8 seconds
> > are passed.
> 
> If oom killer can act faster, than great! On small embedded systems you probably
> don't enable PSI anyway?
> 
> > If my line of thinking is correct, then do we really
> > benefit from such additional protection mechanism? I might be wrong
> > here because my experience is limited to embedded systems with
> > relatively small amounts of memory.
> 
> Well, Artem in his original mail describes a minutes long stall. Things are
> really different on a fast desktop/laptop with SSD. I have experienced this as
> well, ending up performing manual OOM by alt-sysrq-f (then I put more RAM than
> 8GB in the laptop). IMHO the default limit should be set so that the user
> doesn't do that manual OOM (or hard reboot) before the mechanism kicks in. 10
> seconds should be fine.

That's exactly what I have experienced in the past, and this was also
the consistent story in the bug reports we have had.

I suspect it requires a certain combination of RAM size, CPU speed,
and IO capacity: the OOM killer kicks in when reclaim fails, which
happens when all scanned LRU pages were locked and under IO. So IO
needs to be slow enough, or RAM small enough, that the CPU can scan
all LRU pages while they are temporarily unreclaimable (page lock).

It may well be that on phones the RAM is small enough relative to CPU
size.

But on desktops/servers, we frequently see that there is a wider
window of memory consumption in which reclaim efficiency doesn't drop
low enough for the OOM killer to kick in. In the time it takes the CPU
to scan through RAM, enough pages will have *just* finished reading
for reclaim to free them again and continue to make "progress".

We do know that the OOM killer might not kick in for at least 20-25
minutes while the system is entirely unresponsive. People usually
don't wait this long before forcibly rebooting. In a managed fleet,
ssh heartbeat tests eventually fail and force a reboot.

I'm not sure 10s is the perfect value here, but I do think the kernel
should try to get out of such a state, where interacting with the
system is impossible, within a reasonable amount of time.

It could be a little too short for non-interactive number-crunching
systems...
