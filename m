Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40C4ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B2721928
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFwXYPlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732778AbfJNO1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:27:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33752 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732598AbfJNO1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:27:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id a22so16882388ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TgrcIbV4YUcVsIR4rlX/SsLkjeCAujElMOWkAWBGi7g=;
        b=PFwXYPlRDvYa3/dGwTKj7ZAZAODdkGeZkahGFcaIo1u/nGTYOL7m7VcGZZUunTzFaz
         1S3TSJnzqxerg1TLxpuWDhfW0RMHlLKVT6JjxjZCCvDsAapO3NG3aILKJ+SXG35ALoIR
         DqL0GcSZP08B2NLEK36AEiG2tOuW3ek5rSVHWCCEKHLP07PUFA1kEyp5iAXg8LuUZbQn
         nWRpzhICZcFNltFUQ8PAbpLhvnxyqFr8qP0WbTPPn6RhSqViDb+WfTVKbOEfLKBfOpSx
         xncS8QOM/yhuqRPY5VuKE47uRU1nmbidY+bI7RaLjtg1btUjHfHpEU6u2KDtVsTGmIj0
         00TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TgrcIbV4YUcVsIR4rlX/SsLkjeCAujElMOWkAWBGi7g=;
        b=UTBNyw4JyGXUCpVuFsLXqkd5k7zCcvHZMCyd7U3JM8I9OXlnoYR70gxTweSae4Dms0
         m8P6Azn0U6dEG8Jieq8k47uBUynl1RG6jI0Q86iEIfaz9wCO8hKd7t1DZTt0i3uNg6dc
         NZeo7jpXnHbYCTfC3JzrsIBUoeXKF0HmbuOBppUMTGKHDemmH3x/G5XmGL88hrltLorD
         d0Vwzl8NGXr4Xrj7UU3CR9+RJSMydXYn3daEj6QFtpfanufduHpXZ1/fKjgPSUDcVL8F
         zorB1sIFmIr5Eha28VrKAUgydFg+ueUUw20kRuTo21xIvSCLP3FoR2eOICq1Kui8CFqp
         K1WA==
X-Gm-Message-State: APjAAAVbCaA260OT7kYhJblBr0fJRhPpBpsN+wZAfOorYh7FR4WJ7QiG
        /HiaAAFgCkWxQOvjfDweMXM=
X-Google-Smtp-Source: APXvYqxZ9RrwgIeT0+NIEPfGYmuMqEMTvaHl9/8Jdp7w4rDkTn9aVL+blgOdno1eQyX/+0XKkN31WQ==
X-Received: by 2002:a2e:95d9:: with SMTP id y25mr19225662ljh.217.1571063248736;
        Mon, 14 Oct 2019 07:27:28 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id s26sm4339518lfc.60.2019.10.14.07.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:27:27 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 14 Oct 2019 16:27:19 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] mm/vmalloc: remove preempt_disable/enable when do
 preloading
Message-ID: <20191014142719.GA17874@pc636>
References: <20191009164934.10166-1-urezki@gmail.com>
 <20191009151901.1be5f7211db291e4bd2da8ca@linux-foundation.org>
 <20191009221725.0b83151e@oasis.local.home>
 <20191010151749.GA14740@pc636>
 <20191011165515.a25e7d1c22e6b5e3e6fb69da@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011165515.a25e7d1c22e6b5e3e6fb69da@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 04:55:15PM -0700, Andrew Morton wrote:
> On Thu, 10 Oct 2019 17:17:49 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > > > : 	 * The preload is done in non-atomic context, thus it allows us
> > > > : 	 * to use more permissive allocation masks to be more stable under
> > > > : 	 * low memory condition and high memory pressure.
> > > > : 	 *
> > > > : 	 * Even if it fails we do not really care about that. Just proceed
> > > > : 	 * as it is. "overflow" path will refill the cache we allocate from.
> > > > : 	 */
> > > > : 	if (!this_cpu_read(ne_fit_preload_node)) {
> > > > 
> > > > Readability nit: local `pva' should be defined here, rather than having
> > > > function-wide scope.
> > > > 
> > > > : 		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
> > > > 
> > > > Why doesn't this honour gfp_mask?  If it's not a bug, please add
> > > > comment explaining this.
> > > > 
> > But there is a comment, if understand you correctly:
> > 
> > <snip>
> > * Even if it fails we do not really care about that. Just proceed
> > * as it is. "overflow" path will refill the cache we allocate from.
> > <snip>
> 
> My point is that the alloc_vmap_area() caller passed us a gfp_t but
> this code ignores it, as does adjust_va_to_fit_type().  These *look*
> like potential bugs.  If not, they should be commented so they don't
> look like bugs any more ;)
> 
I got it, there was misunderstanding from my side :) I agree.

In the first case i should have used and respect the passed "gfp_mask",
like below:

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f48cd0711478..880b6e8cdeae 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1113,7 +1113,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
                 * Just proceed as it is. If needed "overflow" path
                 * will refill the cache we allocate from.
                 */
-               pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
+               pva = kmem_cache_alloc_node(vmap_area_cachep,
+                               gfp_mask & GFP_RECLAIM_MASK, node);
 
        spin_lock(&vmap_area_lock);

It should be sent as a separate patch, i think.

As for adjust_va_to_fit_type(), i can add a comment, since we can not
sleep there and the case is one per 1000000 or even lower with your proposal.

Does it sound good?

Thank you!

--
Vlad Rezki
