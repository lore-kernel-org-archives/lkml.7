Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B86C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 03:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F7D20659
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 03:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567137382;
	bh=xcQIAyQ1lp9Azi1F7v0Nnp+xnz/22i/uJok5bgvaCIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U59GRKjTQiQV04BmDNg9wE+5n/h9n9hx2kapqRyziGkMU8o5ChEfdwGoJz86US6Uk
	 mcY6IR2omYQ3jcJ48yjQFJrc9GCAWEjWZkHSqarGPAT9LH0GfBxMIjo/1lBqjGzOAX
	 jhpDIpU3BBx/fqK6rsz7E4LT3pFyqUkYDcP20Xvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfH3D4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 23:56:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42668 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbfH3D4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 23:56:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id b16so5449799wrq.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 20:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocQtEStflZxIuihvafAK7EGGQ6iNiCmKabe8FgYSRcU=;
        b=pgDyR5n0vEWcyF4mK7B7JKw1Kak17VHQbj2M3Hp3PitZ+iA4H+9RNGB3Su4xwKM8yp
         rbZCHB4Ul0uL2tKLqapP79SpQ7jkWzC/NnhR/QKnv1HKjlBEFizhi3RttLgk+K6ykmf7
         kPbzJzfMe9rfXBT1UhoI4j6O05/3luLRnngWs2Hc+NmfIWi02eyT0JsdDBvzCnioAFHy
         hAZ/9QNvaxyJ1nkq320+KlNgGq+lizl0BOYrnNXluk+12xyuaJs4bg+iHALQumOAYuiR
         Luz/P83qlayytWmxmAtL66P/Va0YzIZbNd2uXqo8zw1tUCc9jaLZoNB6gD7yjSBoYVTM
         Iu8w==
X-Gm-Message-State: APjAAAVxb7fc/imqHBoI5A6aN3SveMGwAekkWJxbTVNuwrmWaO11wmLS
        dXzamlwi9xq9IcL7X4rP4LlP4iLVdlhp1UeAZjc=
X-Google-Smtp-Source: APXvYqx+KNemY0Dhr16K2V2ol6cAIcXgp6k2ocV8ZDHoGaivPd7xRhrs9zz3tkQorUlQxGLFDUQ5sTLRN0BUqS0Rvx0=
X-Received: by 2002:adf:f0ce:: with SMTP id x14mr15650857wro.31.1567137373367;
 Thu, 29 Aug 2019 20:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190828073130.83800-1-namhyung@kernel.org> <20190828073130.83800-2-namhyung@kernel.org>
 <20190828144830.GQ2263813@devbig004.ftw2.facebook.com>
In-Reply-To: <20190828144830.GQ2263813@devbig004.ftw2.facebook.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 30 Aug 2019 12:56:02 +0900
Message-ID: <CAM9d7cgFAc7WyZY4n82YLU=5yAifrVqoCtHh2iE-aLKx=uC4=w@mail.gmail.com>
Subject: Re: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
To:     Tejun Heo <tj@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Wed, Aug 28, 2019 at 11:48 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Namhyung.
>
> On Wed, Aug 28, 2019 at 04:31:22PM +0900, Namhyung Kim wrote:
> > +      * struct {
> > +      *      struct perf_event_header        header;
> > +      *      u64                             ino;
> > +      *      u64                             path_len;
> > +      *      char                            path[];
>
> ino and path aren't great identifers for cgroups because both can get
> recycled pretty quickly.  Can you please take a look at
> KERNFS_ROOT_SUPPORT_EXPORTOP?  That's the fhandle that cgroup uses,
> currently the standard ino+gen which isn't ideal but good enough.
> Another benefit is that the path can also be resolved efficiently from
> userspace given the handle.

Thanks for the info, I'll take a look at it.
Namhyung
