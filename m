Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC8FC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 04:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E159D2080C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 04:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgYtsyg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbfIEEd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 00:33:27 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45442 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfIEEd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 00:33:26 -0400
Received: by mail-io1-f65.google.com with SMTP id f12so1612570iog.12;
        Wed, 04 Sep 2019 21:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9lp9rhuOjuiUtpTZbai2HQ4h+Vi7sUNNaRy+CQ2YQk=;
        b=vgYtsyg2WXd34VyqbkP05aghwRT4lvZ1s7eC0B2UvEemyrW2CCG4XVY+Oirqhhxklh
         RVjpqeQX/D8sjnATnNTYS8aJTAVTwybboUE1RgXr5FSwr651eQ5eq2rxqibcalc/oY9f
         D1dlubk0qbTK0JWtb9n8jkjX272/T1nWav8wnwzTbMLIzT/p+uobe5rtL8RyMhoZBov7
         MoUmLz4sbKd1ADh8IvEKRqGOOU/mQndzLlz3qdSgWjD8L9dYcm+3q6TWLhjIEVNcRDva
         dPxBX7ShbQIPz3dXW02LX+YHBys4IikU8eJ/U74y9msfzMdrp2NC1750E3E/ph1BWf2F
         rPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9lp9rhuOjuiUtpTZbai2HQ4h+Vi7sUNNaRy+CQ2YQk=;
        b=TkoD7UOHueXxPe8VTMPn2Yhj2iJZHq6w7LtgQDjdiFf9TyLv/STkA/ZGWQvtEvYwW1
         B9k5ws7G8aelVAMNGcKydEImUGqNMGsjoQ0tnzYcyXBEC7gJkyvDHeFJKrbda4CVzX6F
         GaMLiHEiiYhGvNpCilz+OsOkW1lFQot7VHV8F2KmXz4QiCSSbjyGegvCoggVsVTuL82R
         TvwRLMGPrDRa9aUxTmBZlkN0mA8UiRdyZjLAJhGDDheFP8bWObgNLVWtXb/qBGZlyYV6
         wfQu9m5Ssc3Nkj4WaM7W9VSerjpdlkzNV7/J3a10Vywx/fCp025Pumm/dyh9uMqhYurf
         vTtg==
X-Gm-Message-State: APjAAAVhBQobNPBEofh0ndA2CMn7ZOCEbhE3Z4QXIkOpHqk+uxZqMSLp
        Id4yTDbh0YvIWxZuQpvZ28CJNA+vwOmi6Ulv768=
X-Google-Smtp-Source: APXvYqwI06AxNfsCKmqOxx7MSL+aEzYNxe4/ymVxIAaBMvoQMCqgLN2EWGT4E8EOVJ7ZbABYbNhB62igxw+9X9uHtSI=
X-Received: by 2002:a6b:7503:: with SMTP id l3mr1689873ioh.244.1567658006037;
 Wed, 04 Sep 2019 21:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190903111342.17731-1-florian.schmidt@nutanix.com> <20190904204241.y6c335djr3bwm6xo@ca-dmjordan1.us.oracle.com>
In-Reply-To: <20190904204241.y6c335djr3bwm6xo@ca-dmjordan1.us.oracle.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 5 Sep 2019 12:32:49 +0800
Message-ID: <CALOAHbA+82kfEDvzotJu50QtskqrWv6RzHyMBiHz2gXw1ySL=Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] trace-vmscan-postprocess: fix parsing and output
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Florian Schmidt <florian.schmidt@nutanix.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 4:42 AM Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
>
> On Tue, Sep 03, 2019 at 11:14:07AM +0000, Florian Schmidt wrote:
> > This patch series updates trace-vmscan-postprocess.pl to work without
> > throwing warnings and errors which stem from updates to several trace
> > points.
>
> Cc Yafang, who made (most of?) these updates.
>

Yes, I made 3481c37ffa1d and 3b775998eca7 but didn't remeber to update
the scripts in the Document directory.
Thanks for improving it.

> > 3481c37ffa1d ("mm/vmscan: drop may_writepage and classzone_idx from
> > direct reclaim begin template") removed "may_writepage" from
> > mm_vmscan_direct_reclaim_begin, and 3b775998eca7
> > ("include/trace/events/vmscan.h: drop zone id from kswapd tracepoints")
> > removed "zid" from mm_vmscan_wakeup_kswapd. The output of
> > mm_vmscan_lru_isolate and mm_vmscan_lru_shrink_active seems to never
> > have matched the format of the trace point output since they were
> > created, or at least for as long as I can tell. Patch 1 aligns the
> > format parsing of the perl script with the current output of the trace
> > points.
>
> Thanks, patch 1 fixes the script for me for all tracepoints you touched.
>
> > In addition, the tables that are printed by the script were not properly
> > aligned any more, so patch 2 fixes the spacing.
>
> Nit, not for Pages Scanned.  With your series I get
>
> Kswapd          Kswapd      Order      Pages     Pages    Pages    Pages
> Instance       Wakeups  Re-wakeup    Scanned    Rclmed  Sync-IO ASync-IO
> kswapd0-175          1          0    253694     253691        3   129896               wake-0=1
>
> > A side remark: parsing the trace output for mm_vmscan_lru_shrink_active
> > has been in the script ever since it was created in 2010, but at no
> > point the parsed output was ever used for anything. I updated the
> > parsing code now, but I wonder if we could just get rid of that part...
>
> I wonder if we shouldn't just get rid of the whole script, it's hard to
> remember to keep in sync with vmscan changes and I can't think of a way to
> remedy that short of having mm regression tests that run this.

There are some similar scripts under tools/perf/scripts/, i.e.
compaction-times.py.
What about intergrating these vmscan scripts into perf/scripts as well ?
Something like vmscan-times.py...

> But your
> patches are an improvement for now.

Agreed.

Thanks
Yafang
