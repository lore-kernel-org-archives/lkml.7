Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D40DC10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFBA2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="FKW7sXZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfCKOA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:00:26 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34221 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfCKOA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:00:26 -0400
Received: by mail-qt1-f195.google.com with SMTP id x20so5101242qto.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7e/sIv9a3FB59iaDh6xa82eP/WupGN03SOOLFKiW9uQ=;
        b=FKW7sXZULHfKT2P3soD8Z3Buc4yB+G5oFrPwXEGz3MTOcCGcLfcv3vA8A2xW+T7S42
         izCoAN5FhrH633LNdM2D66G2vru16qJMCdMC0SjBSYBbH3RjNasqSg5B5SfLOMmh4S+i
         GILZNC5HwZRTWZAQ1pA1tZnIWKo09omSlPyF958K+fq7zFbgkfKY7mkEBbSHnRG5bqid
         Pe81R7jn2FIASRyBNSzADzMwgY8jI8eGG1iar5MfUlE6Zqq3jYHacGXXOwEqCX64Drzg
         fy0SVDDf9EpbQa/cdaG09gH7RcT8WbDl2agK1t0cIUBAqarLyO50y1Ei5/jFyEPTdXNE
         C3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7e/sIv9a3FB59iaDh6xa82eP/WupGN03SOOLFKiW9uQ=;
        b=NR7oH5JQ8/hdIcSjB1d3dx0nYkhPbtLP2ALKxMwqwsyEPy0mWDTfV8YxwBGuJxNiQp
         LJgmRl1vjEuF3FIUHj78THxQ8WkmYkphkDnVk6cnGVAVvmjLyjeJBHYnyOcU3zAeO8qM
         zpDqyAI4roDwVBIMeBhZcnI8O/oLJDgU03NF+xOX/61lTp1YmNbRe+x9wgaPQdZRMq7C
         WNfXXkvxVaohTbAd4Bz/f9oKfuG3Zbi0jpJIUcRmm2/UtamLQNHCC/eBty3Ffkm5xZdZ
         o26iiD8s44sDCckNiqFESKTa0VWqlpewBxI1TT85QRAlfaAN0nmSJRpZzFn8zq1GQmKf
         4VXg==
X-Gm-Message-State: APjAAAVNniRXR5rnNlajeBKmJnvQb6Mhveln18L4NojXG6ltvEEh0S9w
        J2C/xyJwCLIkosLsSflMI8+Rcp+sEg0=
X-Google-Smtp-Source: APXvYqyrzbHp30AOtaNKWbhPUW4Yv76xWC0kK28w3JfGZFJnRhi8OQzdW/LL3jtw2cjzksSuvs/wgg==
X-Received: by 2002:a0c:9508:: with SMTP id l8mr25723897qvl.88.1552312824439;
        Mon, 11 Mar 2019 07:00:24 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u31sm3957532qth.15.2019.03.11.07.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 07:00:23 -0700 (PDT)
Message-ID: <1552312822.7087.11.camel@lca.pw>
Subject: Re: [PATCH] mm/debug: add a cast to u64 for atomic64_read()
From:   Qian Cai <cai@lca.pw>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 11 Mar 2019 10:00:22 -0400
In-Reply-To: <20190311122100.GF22862@mellanox.com>
References: <20190310183051.87303-1-cai@lca.pw>
         <20190311035815.kq7ftc6vphy6vwen@linux-r8p5>
         <20190311122100.GF22862@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-11 at 12:21 +0000, Jason Gunthorpe wrote:
> On Sun, Mar 10, 2019 at 08:58:15PM -0700, Davidlohr Bueso wrote:
> > On Sun, 10 Mar 2019, Qian Cai wrote:
> > 
> > > atomic64_read() on ppc64le returns "long int", so fix the same way as
> > > the commit d549f545e690 ("drm/virtio: use %llu format string form
> > > atomic64_t") by adding a cast to u64, which makes it work on all arches.
> > > 
> > > In file included from ./include/linux/printk.h:7,
> > >                 from ./include/linux/kernel.h:15,
> > >                 from mm/debug.c:9:
> > > mm/debug.c: In function 'dump_mm':
> > > ./include/linux/kern_levels.h:5:18: warning: format '%llx' expects
> > > argument of type 'long long unsigned int', but argument 19 has type
> > > 'long int' [-Wformat=]
> > > #define KERN_SOH "\001"  /* ASCII Start Of Header */
> > >                  ^~~~~~
> > > ./include/linux/kern_levels.h:8:20: note: in expansion of macro
> > > 'KERN_SOH'
> > > #define KERN_EMERG KERN_SOH "0" /* system is unusable */
> > >                    ^~~~~~~~
> > > ./include/linux/printk.h:297:9: note: in expansion of macro 'KERN_EMERG'
> > >  printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
> > >         ^~~~~~~~~~
> > > mm/debug.c:133:2: note: in expansion of macro 'pr_emerg'
> > >  pr_emerg("mm %px mmap %px seqnum %llu task_size %lu\n"
> > >  ^~~~~~~~
> > > mm/debug.c:140:17: note: format string is defined here
> > >   "pinned_vm %llx data_vm %lx exec_vm %lx stack_vm %lx\n"
> > >              ~~~^
> > >              %lx
> > > 
> > > Fixes: 70f8a3ca68d3 ("mm: make mm->pinned_vm an atomic64 counter")
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> > 
> > Acked-by: Davidlohr Bueso <dbueso@suse.de>
> 
> Not saying this patch shouldn't go ahead..
> 
> But is there a special reason the atomic64*'s on ppc don't use the u64
> type like other archs? Seems like a better thing to fix than adding
> casts all over the place.
> 

A bit of history here,

https://patchwork.kernel.org/patch/7344011/#15495901

