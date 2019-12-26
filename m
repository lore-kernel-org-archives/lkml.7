Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50ADC2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 12:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDDA206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 12:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crCpRltY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfLZMrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 07:47:05 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51019 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLZMrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 07:47:05 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so3308730pjb.0;
        Thu, 26 Dec 2019 04:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VjrrqasrAVtUBkYexP8cTS4R2mKJw8jo9Wmw8KQzHns=;
        b=crCpRltYcWxhf/UuPq6JSxcWjEj+oEcvzMtWPJzigRpaFGqPgWDl9SYxQKH/dfqByJ
         RZCCaDG5u/dRl+cTgmnqhew/v00EVbuEO5kPHZT+UxOTpHG5Qe9Uib1+mg462bxrlR3Q
         xYbAv45huQrhVtyJl3eJDNsz4QQRfAEXhjntTquRSwk9dT2Mfbv3wCbiub/AGpoKTGNe
         u+nuiPMqKOQD6OAi63yLs1erMCICmPTWir4/BtnzgJtOgArUkq0NOB/1RFDApv72aSDe
         sa++wbd+Ptr0T9e0ppXDCZc5VVVw96wIFi6NxmbGQIWAo802claa9272ueW5X7p+XErw
         w7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VjrrqasrAVtUBkYexP8cTS4R2mKJw8jo9Wmw8KQzHns=;
        b=SxDCoG7cOw/wPHzE0jmSVJdKy+JsJ2DQJuKO8E3VEG30Vroot7fVQ0xrirx46IROG5
         PSPmltNybhP20FQbRkMOVH32PZ8CRs+zlQ3OFHoCi1eFx3AsJMPvEeH5DCCFdlSUE4g/
         q/ANu/ANKC3Dh/Byl/bVF1vratW08G/PdBo1Eml0+fIti7GyXrgKuJFp8yus6hmt/bTz
         dbxvpLcLPyVDrNyPnUeU+uCPKjCYtIyZz4W4dC+aqipSgp6Os4+0SmNlJEFovAjVhM+5
         T2MbHf+U9SR8aQU4+8XQgibbtjL0XC/rurxVKQM4UU904MFKBy1Jgbql4NrUDuBZfIVX
         D0Pg==
X-Gm-Message-State: APjAAAUT6lQ8H1RR2OdDNVB6cuN1MSzAvAX6sRtqUaLyMk84j1suhJdW
        2cT7lLXlg4ZQbFzN3Pfsgso=
X-Google-Smtp-Source: APXvYqwuBLB1sBJkg9fcF0tj7P6bhub+/FTamF8nP6P8VdmwdngazX5VZZlOpEfCeX9GQfsSWcjUZQ==
X-Received: by 2002:a17:90a:d0c1:: with SMTP id y1mr18628798pjw.126.1577364424213;
        Thu, 26 Dec 2019 04:47:04 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id z4sm36582863pfn.42.2019.12.26.04.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 04:47:03 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C6EE340CB9; Thu, 26 Dec 2019 09:46:59 -0300 (-03)
Date:   Thu, 26 Dec 2019 09:46:59 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCHSET 0/9] perf: Improve cgroup profiling (v3)
Message-ID: <20191226124659.GA20204@kernel.org>
References: <20191223060759.841176-1-namhyung@kernel.org>
 <alpine.DEB.2.21.1912231235090.775@macbook-air>
 <CAM9d7cj06Hj3hOSdcyTpRWaoBY0wLjPpt7_+CbUqtsF-_08Czg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj06Hj3hOSdcyTpRWaoBY0wLjPpt7_+CbUqtsF-_08Czg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 24, 2019 at 09:40:04AM +0900, Namhyung Kim escreveu:
> On Tue, Dec 24, 2019 at 2:35 AM Vince Weaver <vincent.weaver@maine.edu> wrote:
> > On Mon, 23 Dec 2019, Namhyung Kim wrote:
> > > This work is to improve cgroup profiling in perf.  Currently it only
> > > supports profiling tasks in a specific cgroup and there's no way to
> > > identify which cgroup the current sample belongs to.  So I added
> > > PERF_SAMPLE_CGROUP to add cgroup id into each sample.  It's a 64-bit
> > > integer having file handle of the cgroup.  And kernel also generates
> > > PERF_RECORD_CGROUP event for new groups to correlate the cgroup id and
> > > cgroup name (path in the cgroup filesystem).  The cgroup id can be
> > > read from userspace by name_to_handle_at() system call so it can
> > > synthesize the CGROUP event for existing groups.

> > so is there a patch to the manpage that describes this new behavior in
> > perf_event_open()?

> Not yet.  I'll cook a patch once it's merged to the Linus' tree.

Vince, was it ever considered to carry the man page in the kernel
sources and then make it so that new features need to come with the
respective changes to the man page? I think that would be a good move,
you would be the maintainer for that file, what do you think?

- Arnaldo
