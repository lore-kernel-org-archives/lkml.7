Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00E6C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8639F21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558579820;
	bh=EVhshLbtwbLXVta5mEz2uUHlz53CbxdvuJdULkIxxwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tRuGb1lpgZYljQRWHOcYJ3vVqrV3EqDkwYCK4bpG3U+ArSegGnvWXPnwoa8Kx/LYX
	 SZANq2PNVl/NR3GguKk5bpltLR72bOCcF3aL4kQ72VseM61lYOXJETjuliX7rT+m5j
	 NaYKhSxddDB6GGoAPeemoYDuJdd5Af7plRdCQN8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfEWCuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 22:50:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35797 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfEWCuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 22:50:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id t1so2309509pgc.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 19:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=toBZ1FCdllt2tn+h0ykIvTcQZ5vqDTgX+a58FRrvFAo=;
        b=EavVRmqwN6gSFjji1kOzzHxsu1ZuXCrySBo6jY9xLrbreoI5c9IvT8kWfqPngbjEBF
         9XGVMunZbmsPpOdGLkwllfj74odFClEEnQMfOJI9MxOLyW4TOKfjzsuhlBokTDBSmZOQ
         ZsWpNRBY2hNe9mz/kdsLqg5KOLp2iHXh3ziCbiYIxNGdHLbUSdHXX3i5qr9Q0TPYdwcG
         fhOaTZJUvsFM1OVPlxqsMOZhBidkAAh3YCC8VvTo/pCFfq9GFv3aXzEj2GYYli5H1Hn/
         XSO/TfAoo1OESWZdkBSbdxJpp5hVL1TFfDbF2o+Rnc0rNipwlr5Wzv6DUpgozgFLe3kN
         5xQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=toBZ1FCdllt2tn+h0ykIvTcQZ5vqDTgX+a58FRrvFAo=;
        b=U94TxNQL/Q0WxA+ys+AcDYwL4m5UiIgHyc1ON8/x92doPJ8q4ZmG6XzsjswRFuGk27
         kRs4KYsEns8yczdcyitVjXs3ZR1h0mKjtGhSKvmZrNQ3t4XmTSEPk7oPAzMXGXN8D9AE
         ueugkKqSOW/Qkz+l4ERu5VyP8z5Oi49jl9MDvYzaU6xe9mS9kA6VzUml3Wdph/MBi2hE
         JtqEgdSVnkwgY088SG6fshLzikVAthOIosfn6c4RMqA9q+cCf2jE51oyjlzcxMx/YDZO
         ue+brz/34PVmlB9Je9v8wm+mVjlaRtc6/29NpP97Tp2WChYMSt2MIEIUyBXzgUKMrjwn
         clBQ==
X-Gm-Message-State: APjAAAXQUDSKQ3a+Yv3JATV6nAHFpZciKD4TUXeBroawUSDGuQYfsv6d
        Tp4Efq3iMhRhyF2xawn7DA8jdG4N
X-Google-Smtp-Source: APXvYqz9ID17o5bLyPCucWN4VIM8c8mFPhf3cWcbgCbM4GW77qZxIoR1LL7XMg7DSRA3NPR5JynJKA==
X-Received: by 2002:aa7:87d7:: with SMTP id i23mr99441501pfo.211.1558579818681;
        Wed, 22 May 2019 19:50:18 -0700 (PDT)
Received: from google.com ([2401:fa00:d:10:75ad:a5d:715f:f6d8])
        by smtp.gmail.com with ESMTPSA id g71sm32511543pgc.41.2019.05.22.19.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 19:50:18 -0700 (PDT)
Date:   Thu, 23 May 2019 11:50:13 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Wei Li <liwei391@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, xiezhipeng1@huawei.com
Subject: Re: [PATCH v2] fix use-after-free in perf_sched__lat
Message-ID: <20190523025011.GC196218@google.com>
References: <20190508143648.8153-1-liwei391@huawei.com>
 <20190522065555.GA206606@google.com>
 <20190522110823.GR8945@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190522110823.GR8945@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 08:08:23AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 22, 2019 at 03:56:10PM +0900, Namhyung Kim escreveu:
> > On Wed, May 08, 2019 at 10:36:48PM +0800, Wei Li wrote:
> > > After thread is added to machine->threads[i].dead in
> > > __machine__remove_thread, the machine->threads[i].dead is freed
> > > when calling free(session) in perf_session__delete(). So it get a
> > > Segmentation fault when accessing it in thread__put().
> > > 
> > > In this patch, we delay the perf_session__delete until all threads
> > > have been deleted.
> > > 
> > > This can be reproduced by following steps:
> > > 	ulimit -c unlimited
> > > 	export MALLOC_MMAP_THRESHOLD_=0
> > > 	perf sched record sleep 10
> > > 	perf sched latency --sort max
> > > 	Segmentation fault (core dumped)
> > > 
> > > Signed-off-by: Zhipeng Xie <xiezhipeng1@huawei.com>
> > > Signed-off-by: Wei Li <liwei391@huawei.com>
> > 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> I'll try to analyse this one soon, but my first impression was that we
> should just grab reference counts when keeping a pointer to those
> threads instead of keeping _all_ threads alive when supposedly we could
> trow away unreferenced data structures.
> 
> But this is just a first impression from just reading the patch
> description, probably I'm missing something.

No, thread refcounting is fine.  We already did it and threads with the
refcount will be accessed only.

But the problem is the head of the list.  After using the thread, the
refcount is gone and thread is removed from the list and destroyed.
However the head of list is in a struct machine which was freed with
session already.

Thanks,
Namhyung


> 
> Thanks for providing instructions on readily triggering the segfault.
> 
> - Arnaldo
