Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F936C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC002077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578547164;
	bh=MKfFFQ/PdNQuviS266fsn/Dkd0WWIwb+5JF1ej8qrLg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=haQMWNjuZZibDmzX7smu7HiT5pOob6dYQ1mXvvEtaZY64sCafjjL+j6xaJwpRhRZj
	 dpGfgEsqYunyC2XMgAMyW8/v91lHKUEcaFP7enYOOmKanjilEoepc7+kH7YR2Jg6dQ
	 1KzliSX/rlU0Hb2NF0X1OMALlWacqkNUMQ+/OGaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgAIFTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 00:19:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32998 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgAIFTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 00:19:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so5984371wrq.0;
        Wed, 08 Jan 2020 21:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wojFeiHP1iqAqF2ZFDJk6ERMuQl0qn+NvG/cb0NiTQI=;
        b=Xy8V9+s6l9NZ9fTMesbivkHhA005yiPFNENPcdwP8ryTHasDUYrFTugm+FBSFXFUhq
         UtrPAh1sFljs1+we1pQQPHzrZac/wYJwFnw2voKn774Hp7Cg7QAyEf7FVTUG8R0I8GCC
         09daIkeia9j9NG88FIfaIo4re7gMWSd1dp0foPmlwdastwUUVOPSe65FpdHo+9MtYMSh
         vGHB0SJ2kPOithrdaL5JCI6IcOpobEFL5Js/h0WFZbUKrNnEn6nBu0OVvHHvsiTjzckK
         VZRNwQY1OFp7i0snSECIb63OsNzkYl6jUkYe3ElIvWi+CDuzbywOxnJyWzyAqdKhNg3O
         JZqA==
X-Gm-Message-State: APjAAAUPXmbDw8DG089pzJ5htQe1PnpYZjo2MRsdj3JQhPWA4r5ZmkSR
        3MTfaUfe6ea+n3zZ5nOMscDazYIls/m58onLUlU=
X-Google-Smtp-Source: APXvYqzPZqlXe87+V6XDhhg6bEODb7Zev1ftLYzkZ6YUAS462nclAurQ2GtGB10dLCCNRB1kM/NA9m4AkBtOeP4z1xw=
X-Received: by 2002:adf:ef10:: with SMTP id e16mr8115715wro.336.1578547160761;
 Wed, 08 Jan 2020 21:19:20 -0800 (PST)
MIME-Version: 1.0
References: <20200107133501.327117-1-namhyung@kernel.org> <20200107133501.327117-7-namhyung@kernel.org>
 <20200108220851.GC12995@krava>
In-Reply-To: <20200108220851.GC12995@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 9 Jan 2020 14:19:09 +0900
Message-ID: <CAM9d7cgn8Y9FbOHh0+5=8bg4vGACYHjbVuX0_cM-jqGv4cEh0Q@mail.gmail.com>
Subject: Re: [PATCH 6/9] perf record: Support synthesizing cgroup events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 7:09 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 07, 2020 at 10:34:58PM +0900, Namhyung Kim wrote:
> > diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> > index 4e8ef1db0c94..5147d22b3bda 100644
> > --- a/tools/perf/util/cgroup.c
> > +++ b/tools/perf/util/cgroup.c
> > @@ -15,8 +15,7 @@ int nr_cgroups;
> >
> >  static struct rb_root cgroup_tree = RB_ROOT;
> >
> > -static int
> > -cgroupfs_find_mountpoint(char *buf, size_t maxlen)
> > +int cgroupfs_find_mountpoint(char *buf, size_t maxlen)
>
> out of scope of this change, but could this be added to api/fs/fs.c?
> it might need more checks then is currently supported, but would be
> nice to have it under same api as the rest

Makes sense, will try to move it.

Thanks
Namhyung
