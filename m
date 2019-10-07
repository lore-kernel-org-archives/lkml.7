Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4397FECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1566B206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570457817;
	bh=teMLV8Iz9qfXHV7s29rC79TJKNcq2fVUAmEvZNLryd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yDxNa1HhLOr9VWJdKABazERMwYLoE4KMs/YOAZNOKk3T1zXCV6MBFH1z+kQUKqWlL
	 D8p0Xztf3lZtq0y37VZbHVNkdiTd663hHb17yEur6W6kNuE5NM6YvKLcMMCDXzcsEK
	 8pL51SqAE8t4mlJHIoyu1WODgmltMz5Sd1yvWIe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfJGOQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:16:55 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35044 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfJGOQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:16:54 -0400
Received: by mail-qk1-f193.google.com with SMTP id w2so12706406qkf.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zvKl4rV2AjklsOkgx1c2aD+bMqyHUQQs7onDhB0qO2o=;
        b=leBry9/WNfZ/oq8AeBCsfkTk+gWtEAY6yD8y8cDbs4/alpsbiB8WuQDBiPviTS1GaF
         A0ljO72N98qNaMxJi5EmcFX2hEFBA7xYDW8c6rNJmgggUbE8PW1QLFiMzVCiLmq1j+ac
         myidbYFAmj+zhSi5na/TmbQ8D0Hk8NQQaGiW0P1ctHpsFMwopao0276hxAWpUCxST7yS
         ViTALc/s0We06s0qShX/orpAPUg+CszLaYzP+n6hATTaj64294u025cZbtBx0JNBgVMW
         mhuWUyF9dtfioG/R80f1GSYMKwQK0MIN2H2yxH0uUK5BwJcRc2UHIfMJX2BK4sBgrLx7
         czzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zvKl4rV2AjklsOkgx1c2aD+bMqyHUQQs7onDhB0qO2o=;
        b=XFqjGQANcYA4HeMgPkFMgHburPy/Y+1wQzLB94JQg+IKjjMA5yMQG9iDyIFkkIm3s0
         cqg21iX3rxuypCWEfZey4qC+BK9p0iAnD7f7i/VBEYLrG5oWjpW6bECYNQqTMZ4S1rRS
         jd0jWX9XugwqGY1ZF1So3LRGJTCCLP6tZb4r73J3hyUAChvXFtjORJaPAah33/T69c+c
         orwI2rCdvILaamCvDXXiNws+ZhX9VndXbpnoOX7XjpXubDCyzrv55or3ifA3lDCyxZf9
         Xy/Gy7VsTV9NAQPZhAXM6GklkrUHX2zYGiJpxyZpZ9ezjGUceK3F1j0xH9L6mwqdHyX8
         fECw==
X-Gm-Message-State: APjAAAXLDa2aHDUOM7U6MJoghsLuFt794e5TilRNI4slXxLojDANPUK9
        xQcA4ZVNpA0c0nAjcbCbMHwAQ605two=
X-Google-Smtp-Source: APXvYqwLBxZnXYULogP9N1p2Ph6rg8zGZn8LrKS5VVb3q1qtvmFLs1MCqp0VQ+IaKqK/FutTJsJ6yA==
X-Received: by 2002:a37:a44f:: with SMTP id n76mr1953022qke.414.1570457813449;
        Mon, 07 Oct 2019 07:16:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:a536])
        by smtp.gmail.com with ESMTPSA id r55sm8333049qtj.86.2019.10.07.07.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 07:16:52 -0700 (PDT)
Date:   Mon, 7 Oct 2019 07:16:51 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Song Liu <liu.song.a23@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
Message-ID: <20191007141651.GE3404308@devbig004.ftw2.facebook.com>
References: <20190828073130.83800-3-namhyung@kernel.org>
 <20190828144911.GR2263813@devbig004.ftw2.facebook.com>
 <20190831030321.GA93532@google.com>
 <20190831045815.GE2263813@devbig004.ftw2.facebook.com>
 <CAPhsuW42ivYU=U5E9jLMWZZgXP_Dv0C_SMFBsiXa53=6bN-=Wg@mail.gmail.com>
 <20190916152325.GD3084169@devbig004.ftw2.facebook.com>
 <CAPhsuW54+YNkj3fnmS6P0=eEdzZ4YvV7Yv+t-d-OnRNNgxPS+Q@mail.gmail.com>
 <CAM9d7cg_AKCyifV7xDm7sJ4=wgG_K=qu013TSTHqLiCRh9m_pg@mail.gmail.com>
 <20190920210411.GB2233839@devbig004.ftw2.facebook.com>
 <CAM9d7cjbt6TYL_uiwu9DSiJLW-nx3P=BpWvqu-pR=DNSD2Dzdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjbt6TYL_uiwu9DSiJLW-nx3P=BpWvqu-pR=DNSD2Dzdg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Oct 02, 2019 at 03:28:00PM +0900, Namhyung Kim wrote:
> On Sat, Sep 21, 2019 at 6:04 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Fri, Sep 20, 2019 at 05:47:45PM +0900, Namhyung Kim wrote:
> > > Thanks for the sharing information!  For 32-bit, while the ino itself is not
> > > monotonic, gen << 32 + ino is monotonic right?  I think we can use the
> >
> > It's not.  gen gets incremented on every allocation, so it has not
> > high but still realistic chance of collisions.
> 
> In __kernfs_new_node(), gen gets increased only if idr_alloc_cyclic()
> returns lower than the cursor...  I'm not sure you talked about it.

Ah, I forgot that it's using cyclic idr, so yeah, it's not as bad in
terms of recycling although cyclic allocation on idr is pretty
inefficient.  I still think it'd be better to switch to rbtree and so
that 64bit can simply use monotonically increasing numbers but that
definitely isn't a must and we can juse continue with the current
allocation method.

Thanks.

-- 
tejun
