Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF45DC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E87D207FC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567949319;
	bh=3nlMaO/LW2x2dskNwOWa/hM07fvVxoE8qsuh7IELeVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IdnshOEudLepcBqXGiAQxm1xqyEi45iMQakvg0iKe87H2FYmI9GgV/L9MXE7zRL7j
	 wvcmZNJ4IEBhXleNPg6HrE7hmdZRTbpE7Yc3uNlnaJ04vvg0bR5f7PqnFLr2jHz1sB
	 WfYZqXOyNJLag6Anh97n0Clsi5O/5UX9mjP1DRug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfIHN2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 09:28:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33951 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfIHN2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 09:28:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so6219123pgc.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 06:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ZwrBUri+d18UEK4qrDRumREvD34OK8LqGR0qEKANdw=;
        b=CftcUb+YuWDTPYw1yhiPTq1c+/d/oXB2+zJ43bCzUuY3gIBwK89TXLOCVEYhBAO9TC
         ZxWaIQmOc3uYjBE2SUDh0VmWJgm1ftYt9ewbu90+2qZ7b0yzjX0BbTcrZ4UTdAXZzp2F
         INuD9BncuAw9nf6i/aTsqpVEKD5Fdh2wxhwfTqsuiLfkWS7eYNroisdF7BuCXrVO8FFP
         VvtMnydfutrVSStlWW4H/7R8lc6ZGdtdutgbZwDX8CVdpzbAWfsoysMz8Vp7p0IBkDWr
         amFCXsLkc2im4KQEkB/zd5/Kv1FqhU5dXLqpR2jS1e9r3Z0RdiNeyv5pneLDod0FYDxS
         tM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ZwrBUri+d18UEK4qrDRumREvD34OK8LqGR0qEKANdw=;
        b=RkS5sm+wdrhV8aomyCmsYg+bnGHqAirG9o7TyEYxh2S4IvKpk9bFh5bqB4kbPWtE0e
         SLkWEQGaFIvmSaaBWBFpb+GRNiDgtOy/I245Qw6KN0twJ+Nz9WjqIU3LhycV6UwxL+fu
         Z/uyc6CFH1tPJAv5TH+cYM8mzNOuTJ9gxtGOwtO+7NuRcxxHnuKZlYOQlchpqsHUNh6A
         U8Qz/DS9LpABjIpn3xidueuXFf/5ePGhtvV3dG6BEjsIOq0Ih0FkxXlwH8C5XPj3ctDp
         14tNPve3X9l0TdkhJyxI+NzuLemyZlXpWHk16PwgepUeEEXmHGhABlydN+WpMyrYGGQh
         dGQA==
X-Gm-Message-State: APjAAAUrYjFrSb1nPAqi3rQPQqIKugLekZd5G/D0mal/K+MLFm3lA0N1
        0UigjZ9LvU0GJrXHWxFvgk1F3Psn
X-Google-Smtp-Source: APXvYqzXZpzKccGGaDQFpvgd6GMbqd3IgGpPvMOs5zEFqd9jaTBFYnUU+KgmzH9n5twJ7YX8ipGnIQ==
X-Received: by 2002:a17:90a:f83:: with SMTP id 3mr20029036pjz.90.1567949317378;
        Sun, 08 Sep 2019 06:28:37 -0700 (PDT)
Received: from google.com ([182.210.106.196])
        by smtp.gmail.com with ESMTPSA id j128sm19203592pfg.51.2019.09.08.06.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 06:28:36 -0700 (PDT)
Date:   Sun, 8 Sep 2019 22:28:32 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
Message-ID: <20190908132830.GA222866@google.com>
References: <20190828073130.83800-1-namhyung@kernel.org>
 <20190828073130.83800-3-namhyung@kernel.org>
 <20190828144911.GR2263813@devbig004.ftw2.facebook.com>
 <20190831030321.GA93532@google.com>
 <20190831045815.GE2263813@devbig004.ftw2.facebook.com>
 <20190903021306.GA217888@google.com>
 <20190905165655.GK2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190905165655.GK2263813@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Thu, Sep 05, 2019 at 09:56:55AM -0700, Tejun Heo wrote:
> Hello, Namhyung.
> 
> On Tue, Sep 03, 2019 at 10:13:08AM +0800, Namhyung Kim wrote:
> > So is my understanding below correct?
> > 
> >  * currently kernfs ino+gen is different than inode's ino+gen
> 
> They're the same.  It's just that cgroup has other less useful IDs
> too.

Ah, ok.

> 
> >  * but it'd be better to make them same
> >  * so move (generic?) inode's ino+gen logic to cgroup
> >  * and kernfs node use the same logic (and number)
> >  * so perf sampling code (NMI) just access kernfs node
> >  * and userspace can use file handle for comparison
> 
> The rest, yes, pretty much.

Thanks for the clarification.  I'll take a look at it.

Thanks
Namhyung
