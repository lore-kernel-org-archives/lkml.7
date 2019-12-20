Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F0FC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2EA2465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576841297;
	bh=6GLUDymjZsRIINrwWMLpG0jSQvH/y8gd6/GB3rTyfWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jbb0lo3dTmmO3UXsJnuAs9qs0aPZDhc1vEaVv7cNxwpQSKt14IsB9o0HmMN6gocVo
	 /rJyl0+1EEfcOybxkIM9Gbj66ABEfuN/AXKtNC0nMqIymV4h23Eik6kSt0OLn7OWEf
	 cPr5AbX2/Je9RX+5dl4etDQYktYXt0SmTFVGO620=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfLTL2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 06:28:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38920 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfLTL2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:28:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so8740134wmj.4;
        Fri, 20 Dec 2019 03:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P7H0JjEM/h1ZiecZaxBDb6ot6eqvvlVgo9s/z6jQoJQ=;
        b=Jl+1l4hj+7f9AhY5Qz7gJHtMIwCwDDahsp8iQqnm4KVXX8OPTFb6a8kUkDaQwlPmwN
         ubqoRl+DaFX4kW+YxWOKtpRNkJExPSBqPGu9FWGe65a3imrCsKr9M9vYsak/XTanXMmX
         Bwhj8E+F6gMYg1A4iyH1zqBYFw7PcLa5iAtjamgrunZIhGT3MWWgo8YJj1zB2B9QN+N0
         Mp0c57vdpUHy7A939iuuGkdpu6O1Trs6ppXJ1anKqib06mU1OEu8PPHET4TiqkDVBffT
         ov23ePDLl8FlkE8CeaeU/BDhsh/5MISbJ/X4pD7k/wfQki1fWqIHHEiks0CGyJ1MNDja
         jh8w==
X-Gm-Message-State: APjAAAWn/uAOkiNLj3jTkVTRwHvRlJEo0rhsIQhfm39bn3Xn3ZvuiEge
        Id7Ab5H7q83MrdjYL5D9+ll32FERALu2g24eZaI=
X-Google-Smtp-Source: APXvYqxIrbpVUxPrzCbwB3w6KQgiwIxCvgUURLDGJtQ8gYrKW+WOPh8/N3hJ2Enw3KJFjLG/CCGaSrYxu8c6EaZY3bM=
X-Received: by 2002:a7b:c757:: with SMTP id w23mr14709851wmk.166.1576841293044;
 Fri, 20 Dec 2019 03:28:13 -0800 (PST)
MIME-Version: 1.0
References: <20191220043253.3278951-1-namhyung@kernel.org> <20191220043253.3278951-2-namhyung@kernel.org>
 <20191220093335.GC2844@hirez.programming.kicks-ass.net>
In-Reply-To: <20191220093335.GC2844@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 20 Dec 2019 20:28:01 +0900
Message-ID: <CAM9d7ch5vc--pXFp4c1K-GyXf0KkS0Y0VpeNzJ==ej3Qvno_4A@mail.gmail.com>
Subject: Re: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Dec 20, 2019 at 6:33 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
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

Oh, I should've updated the changelog.  Now it uses 64bit cgroup id which
was converted by Tejun.

https://lkml.org/lkml/2019/11/4/1551

Thanks
Namhyung
