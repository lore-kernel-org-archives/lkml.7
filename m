Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4484AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066C020675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJf28etv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfCGLQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:16:09 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35409 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCGLQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:16:09 -0500
Received: by mail-lf1-f67.google.com with SMTP id h6so7134281lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 03:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WMVyycMTsIe4Nr/6crMm8olRB10R6ZOP2aiYf26xmmI=;
        b=BJf28etvckVHxeo9MvwwUbmc9QIZ8Esf9IKVMcdBigrfpEcna4elY6WN7hZBWZwDKk
         QdazJTwEokYaINgTiQpDex4Q5o2d9jB7j8KeVyIAHhOnOVt6GZ5lSbjEV4cKcVjgBzyH
         FZNEt1NKUmnBtqX29bMMmhuDcMNxADk74cmE05j7kNQG5ybM28yIAROAihig89jgocz8
         dT4xfuXok4sVzNx9Drr1UGUGa96w/f5ujTlwmmdqaxjO6hj3cHyCgAQ2xgfRmSdTIt7B
         wWu13TrfKymBeDSE/q72DqiWC1OOWYdjn8qjdKpw4RXChr2Hb+yB93jC4U01D4Hd+bAa
         Qokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WMVyycMTsIe4Nr/6crMm8olRB10R6ZOP2aiYf26xmmI=;
        b=AXMdSrYrkMYq7XLCWyUfrbVi6OFJofz5zzf46NZJvmrOS+XeOjJWJMhShQGZ/syR/r
         Pt8wAemktLSacUzVRMaQ8Y/jXzWrPIDemHpv76JPnBAgfU2GNoQutbArtwGhykYxUWA0
         3f34p4iLeG5zxrJh41WuUGr46bwSbFcdTSd7uMPVIO/K7q+ewc/zI105VlpWfWToayvP
         fYkCcv5sBCKYCOKwqax5rFfO+odjLsitmALt0LDR/D5qUUNvYYAY3Idu7OMacEwPV3Sy
         0IqNKMw9JbPq/qwiJy6lXPC7V1P8ZqqL94n0B0dTdn3RnP1a6Ij+3uADPKWbiSSJ75Lb
         bUBw==
X-Gm-Message-State: APjAAAUJexqMX6tH5GawkjJm+wyvrMlhNAMxwuTShMrHiVQXCnFtHdOg
        A1jUzbwUipKpLLnaFR1l/W4=
X-Google-Smtp-Source: APXvYqxGDqSz9m4M1vH9THRh0aQvp9dJ49oRkFP6utyKZKRK2KdjRwasldkXhq+TE5OwRh2Yz6p2GQ==
X-Received: by 2002:ac2:562c:: with SMTP id b12mr4913007lff.160.1551957367396;
        Thu, 07 Mar 2019 03:16:07 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id e83sm790905lji.68.2019.03.07.03.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 03:16:06 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 7 Mar 2019 12:15:59 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v1 2/2] mm: add priority threshold to
 __purge_vmap_area_lazy()
Message-ID: <20190307111559.gnqsk7juhojjuopp@pc636>
References: <20190124115648.9433-1-urezki@gmail.com>
 <20190124115648.9433-3-urezki@gmail.com>
 <20190128224528.GB38107@google.com>
 <20190129173936.4sscooiybzbhos77@pc636>
 <20190306162519.GB193418@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306162519.GB193418@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 
> > > I'm a bit concerned that this will introduce the latency back if vmap_lazy_nr
> > > is greater than half of lazy_max_pages(). Which IIUC will be more likely if
> > > the number of CPUs is large.
> > > 
> > The threshold that we establish is two times more than lazy_max_pages(),
> > i.e. in case of 4 system CPUs lazy_max_pages() is 24576, therefore the
> > threshold is 49152, if PAGE_SIZE is 4096.
> > 
> > It means that we allow rescheduling if vmap_lazy_nr < 49152. If vmap_lazy_nr 
> > is higher then we forbid rescheduling and free areas until it becomes lower
> > again to stabilize the system. By doing that, we will not allow vmap_lazy_nr
> > to be enormously increased.
> 
> Sorry for late reply.
> 
> This sounds reasonable. Such an extreme situation of vmap_lazy_nr being twice
> the lazy_max_pages() is probably only possible using a stress test anyway
> since (hopefully) the try_purge_vmap_area_lazy() call is happening often
> enough to keep the vmap_lazy_nr low.
> 
> Have you experimented with what is the highest threshold that prevents the
> issues you're seeing? Have you tried 3x or 4x the vmap_lazy_nr?
> 
I do not think it make sense to go with 3x/4x/etc threshold for many
reasons. One of them is we just need to prevent that skew, returning back
to reasonable balance.

>
> I also wonder what is the cost these days of the global TLB flush on the most
> common Linux architectures and if the whole purge vmap_area lazy stuff is
> starting to get a bit dated, and if we can do the purging inline as areas are
> freed. There is a cost to having this mechanism too as you said, which is as
> the list size grows, all other operations also take time.
> 
I guess if we go with flushing the TLB each time per each vmap_area freeing,
then i think we are in trouble. Though, i have not analyzed how that approach
impacts performance.

I agree about the cost of having such mechanism. Basically it is one of the
source of bigger fragmentation(not limited to it). But from the other hand
the KVA allocator has to be capable of effective and fast allocation even
in that condition.

I am working on v2 of https://lkml.org/lkml/2018/10/19/786. When i complete
some other job related tasks i will upload a new RFC.

--
Vlad Rezki
