Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE75C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB572343A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567205480;
	bh=aElmCKOQy9j2zbkhdT338JDLjl8qVFJyTmw92zX3/vQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UoerSWdPIlcmNDv/MUMjdAv+iGFMepB6Gy3rOXA+o/3G0HzkqSybATsMecENk1KLo
	 qgMWJdLBMbiI0wt7e6pYVZwmnbTdxLayXpBZbApd7hitlNhLCjrh932W0OCJFNWhWc
	 KMoaKxGskwg0ofWVp1f0SyPdGhy8EfWrc6yYUDoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfH3WvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 18:51:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38688 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbfH3WvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:51:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id e16so8425756wro.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 15:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMwW2EFAsl3nY9QZdgsRrkVeza7wV7B06nKlJIsctzU=;
        b=obk7wlpNO7fRBfYl7G0ybVtlH+NXtweczJFgACa0lRVfY4XsxDAI0EOj1OU3IqMtin
         bDMSDlqIs4wZJmBWrHABzkULTLm8tuvlMLcbpiWBhpmy+pt+yh/tkvnyUEG12cgEjPQh
         ktvPUsgLz4RqZkQCvg1KWCoix8sL/ZBApgyIXCZuHrnUJUTzTYw9YzhmxDuZdZK65IJt
         BU36UDTX2dN2ZDs2ImSb8tlVPikb9bUmzfVhTSCkI99xNru3XSFrLvIvhClz9z5ECLEn
         q4Gj7+rqJdq5OJkoGCieHXGNyrw7EkiA2w9nyVIMZUMbMyG0zCQQBeObeuWF+3CBB4t8
         rf4Q==
X-Gm-Message-State: APjAAAW68976RhPg+4+htKRKmC8he0AhEOOZM2uP99YQ1VLYvI3Zdi2d
        K43dFVnrwabXAOmTFW7n5hJQsKFdknowKaQY5xw=
X-Google-Smtp-Source: APXvYqyxS5goAd1rgG1iDFFS0Mei4ACwKvmGMivml4pq5PjE4VLrRW9bMe0gZzkyDbZj2KxFUN17Gdnsc0rbQIr0S1Y=
X-Received: by 2002:a05:6000:188:: with SMTP id p8mr11178290wrx.220.1567205477081;
 Fri, 30 Aug 2019 15:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190828073130.83800-1-namhyung@kernel.org> <20190828073130.83800-4-namhyung@kernel.org>
 <20190830125524.GA4082@kernel.org>
In-Reply-To: <20190830125524.GA4082@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 31 Aug 2019 07:51:06 +0900
Message-ID: <CAM9d7chH75jQy5DJJZQNAHkAXwg6r+BGtLjYPtkcUc+vo44aeA@mail.gmail.com>
Subject: Re: [PATCH 3/9] perf tools: Basic support for CGROUP event
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Fri, Aug 30, 2019 at 9:55 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Aug 28, 2019 at 04:31:24PM +0900, Namhyung Kim escreveu:
> > Implement basic functionality to support cgroup tracking.  Each cgroup
> > can be identified by inode number which can be read from userspace
> > too.  The actual cgroup processing will come in the later patch.
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/include/uapi/linux/perf_event.h | 17 +++++++++++++++--
>
> Try to have the synchronization of tools/include/ with the kernel to be
> done in a separate patch, please, there is a number of projects such as
> libbpf and in time libperf that will have a mirror repo outside the
> kernel tree and that will get just the needed csets.

OK, will do that in v2.

Thanks,
Namhyung
