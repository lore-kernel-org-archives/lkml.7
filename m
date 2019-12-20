Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A12C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB632146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576854987;
	bh=tjJPJqo4XbM3/C9A69baIe0KUxOTOVTcGBGgVAHs2bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H5af/hjndLuEbfiVl9GW3gxZdGjTKMGccWIjQRiL/6nVbXkVmacrb1bqIUIryx+Vi
	 kLZ2JO5TjKGWDwl39V7a9VW5aRStA/+/WAcJDc2MRcE5SoGz+xECk92qCh9nFJ+85M
	 Fp/zXwvrm8g17r45RaCRTuRHtPXi82mZf7X7eV3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfLTPQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:16:26 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36859 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfLTPQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:16:26 -0500
Received: by mail-qv1-f65.google.com with SMTP id m14so3741637qvl.3;
        Fri, 20 Dec 2019 07:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wtR32RRKNEDTs/i/0HQ421YyndVpqof5+Hg6YM7Jh7g=;
        b=Z1bL1dXJlZmVko46x866QEEfBsQ2JrEC/lqE+Y93VtyrPjpmrdVGZ4GM2q0Vj35iOQ
         HbS5n5NZGHLS4oC4PgLZ6lxLbPR31dCLOc4duPzBGmN/qrpWYx/Dt+cx6duAor8O4vq6
         rzFMg5irZl4gIKVA+OrGvBdUjvB3AOvMM3aBbxvfrF90JYc5gb4r3oGAQV3tKuTNWHm2
         VGk75OS6HAgCYj7MfQY/UByKgAJ9eXxxnLyB+eCZoLwga1ncvb7mU/1xMBWJ1hkxTveg
         WxWKfX0mUY6cpSQe4A/vxPLo/qIhz5IN8WRcpTvhlJyvcTih1vKMBlP1+m8/oKWeMVWs
         M+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wtR32RRKNEDTs/i/0HQ421YyndVpqof5+Hg6YM7Jh7g=;
        b=tXhzeQQyUleKOeXgtjcmfvl2VURGuJHYkB16vlFY1U6/7lhCfMcON1w3ya0TrbK5y9
         ZEf5hecJrl2pwYBXr4Z0Y1uFuPbu9xMfVu7M/6C4wp2cnr60CStQ/Y64sY59EzMcAKVW
         WVKsxWe+96pRpNKQLIOgkiiVOFPDt8Y59sr8brFBeW3RzIDHwM4rtmSsRKOhJtqDxV9g
         1zVpA6zEAy41UKiX2yh94H2+dc98RDSWi3wKK1pxYEp/JyOQLD65VP09c79I7FSxx51B
         /h2YnKL4BD99GTO+Ydsy8rDTN7FE/jIySLNdye8HxWh7xFsVBABckAkxPgpZEQHJm08P
         hCKg==
X-Gm-Message-State: APjAAAVs7RCvfiaLuXDf1D1bgSwmq7oovWU/ScpTEgNVN8nAUb5p5NYM
        e0MUIhAJUmMXQXbidaBCK4k=
X-Google-Smtp-Source: APXvYqy5PPVKIGdBFRyUQDpo+vkkLyvTPxUJRogquahZ8T9KMFOoJbhoAAQN7gx++CV5x6tlfxey8g==
X-Received: by 2002:a0c:e4cc:: with SMTP id g12mr13010703qvm.237.1576854984835;
        Fri, 20 Dec 2019 07:16:24 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::11e7])
        by smtp.gmail.com with ESMTPSA id i5sm3069968qtv.80.2019.12.20.07.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 07:16:23 -0800 (PST)
Date:   Fri, 20 Dec 2019 07:16:22 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
Message-ID: <20191220151622.GF2914998@devbig004.ftw2.facebook.com>
References: <20191220043253.3278951-1-namhyung@kernel.org>
 <20191220043253.3278951-2-namhyung@kernel.org>
 <20191220093335.GC2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220093335.GC2844@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 10:33:35AM +0100, Peter Zijlstra wrote:
> On Fri, Dec 20, 2019 at 01:32:45PM +0900, Namhyung Kim wrote:
> > To support cgroup tracking, add CGROUP event to save a link between
> > cgroup path and inode number.  The attr.cgroup bit was also added to
> > enable cgroup tracking from userspace.
> > 
> > This event will be generated when a new cgroup becomes active.
> > Userspace might need to synthesize those events for existing cgroups.
> > 
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Li Zefan <lizefan@huawei.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> TJ, is this the right thing to do? ISTR you had concerns on this topic
> on the past.

Yeah, cgroup->id is now the same as ino (on 64bit ino matchines) and
fhandle and uniquely identifies a cgroup instance in that boot
instance.  That said, id -> path mapping can be done from userspace by
passing the cgroup id to open_by_handle_at(2) and then reading the
symlink in /proc/self/fd, so this event isn't necessary per-se if the
goal is mapping back ids to paths.

Thanks.

-- 
tejun
