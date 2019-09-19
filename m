Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00376C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 06:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DE320640
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 06:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFy9Egus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388449AbfISGm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 02:42:59 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32889 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfISGm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 02:42:59 -0400
Received: by mail-qk1-f195.google.com with SMTP id x134so2299275qkb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 23:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TioUqcn9xxs3wz80pyFIy3YrEPedMyWoKFVcDEh/XcY=;
        b=qFy9Egus2lq9N5nyc4pj6uipjQEgzwGpducAQlmD73zSZn2/5cv7jPTVUQhtc6hpvb
         ov4Q1igTnbv493zIeYjg+BEcsYPKUxh9FicP0/9YL9mpUdoCNcxgIV8/3jDe2p3mIIas
         iH3bhQC9M5CiHykjPTckMEhc8MRUXwnubxNEzWSE6qbzdiWwKxtWC1tgqmsEBgQ6yaB8
         nNLhp6YWBp8JqY45TXU8W/pjwnFQ2nzyuUGktOUWuaDdKlgxBbG18tbUPtmJECfPcovi
         //BGnbTJVil6R2t1teAqc2YAdK+SdwqVvY0KL9JP2c+hjcYzlQg4JFuyRr//2NqX8+ql
         vSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TioUqcn9xxs3wz80pyFIy3YrEPedMyWoKFVcDEh/XcY=;
        b=mGsdPftAgYTCrjvTaRtGpKO8ptOxnJd7LHbrtZSdDbHzmjmLY6z2gYJT2Nk4/2xZ7H
         8GFuU31xVmsrQea7cxGsF0vGQ2gHRk31LNHjHMTTmTCkILB/f5NZtYeQdzHMwftFztW+
         bPRSr+w8CwVsBOguKLNvbwdpJNk3ETX9fXnEHukaOtgf1CVoZfXv+srrxa0bYcnpDDMf
         8evgiXYVTCX3KCP86QMluSdIOmHULUn1VArzLcqTH+qv1yqE34mPPYNyhswqXMR4BJLO
         pt4AODEzNGle+NkF6Y+40q/7j6xsTBGo8hQ70vMxG4EOrXym6np/9A5u+gltwxigwT72
         IaQA==
X-Gm-Message-State: APjAAAX6edQlyHWvtCNBpf5y6iyP9lgEKbNFQDEfVKfxpF3Gw37Zr7vF
        BUm7X1vu3RO2I+CoiLKuikO1yWm8dKUV4yBZuVk=
X-Google-Smtp-Source: APXvYqyRC5whbTSKCle+sMq+HLayLIKdEjR5qqrD35u5PgMsZaN4CS3TV/agtnRNI1HviPQxtzwPsjXTB1Pn/XqjIXk=
X-Received: by 2002:a05:620a:49b:: with SMTP id 27mr1270792qkr.89.1568875378642;
 Wed, 18 Sep 2019 23:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190828073130.83800-1-namhyung@kernel.org> <20190828073130.83800-3-namhyung@kernel.org>
 <20190828144911.GR2263813@devbig004.ftw2.facebook.com> <20190831030321.GA93532@google.com>
 <20190831045815.GE2263813@devbig004.ftw2.facebook.com> <CAPhsuW42ivYU=U5E9jLMWZZgXP_Dv0C_SMFBsiXa53=6bN-=Wg@mail.gmail.com>
 <20190916152325.GD3084169@devbig004.ftw2.facebook.com>
In-Reply-To: <20190916152325.GD3084169@devbig004.ftw2.facebook.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 19 Sep 2019 07:42:47 +0100
Message-ID: <CAPhsuW54+YNkj3fnmS6P0=eEdzZ4YvV7Yv+t-d-OnRNNgxPS+Q@mail.gmail.com>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
To:     Tejun Heo <tj@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 4:23 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Song.
>
> On Sat, Sep 14, 2019 at 03:02:51PM +0100, Song Liu wrote:
> > I think we don't need a perfect identifier in this case. IIUC, the goal of
>
> I really don't want different versions of imperfect identifiers
> proliferating.
>
> > this patchset is to map each sample with a cgroup name (or full path).
> > To achieve this, we need
> >
> > 1. PERF_RECORD_CGROUP, that maps
> >            "64-bit number" => cgroup name/path
> > 2. PERF_SAMPLE_CGROUP, that adds "64-bit number" to each sample.
> >
> > I call the id a "64-bit number" because it is not required to be a globally
> > unique id. As long as it is consistent within the same perf-record session,
> > we won't get any confusion. Since we add PERF_RECORD_CGROUP
> > for each cgroup creation, we will map most of samples correctly even
> > when the  "64-bit number" is recycled within the same perf-record session.
> >
> > At the moment, I think ino is good enough for the "64-bit number" even
> > for 32-bit systems. If we don't call it "ino" (just call it "cgroup_tag" or
> > "cgroup_id", we can change it when kernfs provides a better 64-bit id.
>
> So, a firm nack on this direction.
>
> > About full path name: The user names the full path here. If the user gives
> > two different workloads the same name/path, we really cannot change that.
> > Reasonable users would be able to make sense from the full path.
>
> I don't see why we wanna be causing this avoidable problem to users.

Sharing some offline discussions with Tejun.

ino in current kernfs is not a good unique ID for cgroup, because it doesn't
increase monotonically. So we need to improve kernfs.

For 64-bit, we can make the ino monotonic, and use it as the ID.
For 32-bit, we need to make the ino monotonic. and use <ino> and <gen>
as the 64-bit ID.

Thanks,
Song
