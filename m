Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2209EECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FE420659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCv2o6sI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfJOJzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:55:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36298 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfJOJzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:55:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so19565341ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 02:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nQcf0VVtrD9DpVKR/rBeJu8T/7MceZKLXuuRAT4sypo=;
        b=lCv2o6sIBekSzviaoXHNEC/oBGWzIk68tE6ZWSPawcb0FdrWE4f0CWuUdK4H917le/
         +mfI22hIt+1asuFZA2m14i/IP90Sd/sPJv88gYN8vcFhVQHAcyZpU2MitKlOuRcBhyFq
         UUEZBzv7St0n9W4WLyTNWJr2/+aYI+6DlI2rWWL+QtqQ7j3WFuNwXNwj7bZzxLUvy9d6
         z0bmhhyV36wLH61eLz2RFfdu+rqkwEOH/nL+mAI1gEdS3zh+BvP689Ob3l+3N+lsV/I3
         I1qUUdLuxxHPyB87CpTOXEERgYOOUR/mMMP6sJpGyv+aCf+XvxL7A0mRsh2XEyF3/4II
         0T/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nQcf0VVtrD9DpVKR/rBeJu8T/7MceZKLXuuRAT4sypo=;
        b=KeaJILT1J4Y/VsXd2ni8SJwhmDnHkgz+NKrkUQDMUNbVt1HJRE9JxXhUhAIj3lrfHg
         PAodektLRoO+XlLB4N/ml5vlc90b+hRjXmDkbf/5p3TMa6UwRpMyJsQP3xMZWwPF4gX/
         iamIpd4TK8OEK06mLbG9buGiGOVj2kBM/L5C+LWGBZRxmwmZ/Si2wnbFEyf9CMvnchey
         PRYKIgyJch3tGFlFrsisEYuZcgYyA9ebHFYJZdc8gsikxZxEgFu64Mj3eY49NkmAjkyw
         xwPyrbIwEyOzJBswgtTB2vcSyAaucINxx/rs4Ylr+e+pUPwyg5ZoF6pPz5ry3ZmYDfdR
         guuQ==
X-Gm-Message-State: APjAAAXiBWT+ZZ4sZYJBps0Dfgtsb1JIrtfs28aKegDrtvHgWbWg4qrb
        a/cmqx33rok+QCqey0x36GE=
X-Google-Smtp-Source: APXvYqy5jJA+oTtrURFruIDjEv83vnvGjSSH7efFto/vzoKQJgStEN13LPktAEr6TqZcwp1Qvb6aXw==
X-Received: by 2002:a2e:81cf:: with SMTP id s15mr2183402ljg.99.1571133297110;
        Tue, 15 Oct 2019 02:54:57 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id m27sm72810lfp.60.2019.10.15.02.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 02:54:55 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 15 Oct 2019 11:54:47 +0200
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] mm/vmalloc: remove preempt_disable/enable when do
 preloading
Message-ID: <20191015095447.GA31683@pc636>
References: <20191009164934.10166-1-urezki@gmail.com>
 <20191009151901.1be5f7211db291e4bd2da8ca@linux-foundation.org>
 <20191009221725.0b83151e@oasis.local.home>
 <20191010151749.GA14740@pc636>
 <20191011165515.a25e7d1c22e6b5e3e6fb69da@linux-foundation.org>
 <20191014142719.GA17874@pc636>
 <20191014163022.GL317@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014163022.GL317@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > > : 	 * The preload is done in non-atomic context, thus it allows us
> > > > > > : 	 * to use more permissive allocation masks to be more stable under
> > > > > > : 	 * low memory condition and high memory pressure.
> > > > > > : 	 *
> > > > > > : 	 * Even if it fails we do not really care about that. Just proceed
> > > > > > : 	 * as it is. "overflow" path will refill the cache we allocate from.
> > > > > > : 	 */
> > > > > > : 	if (!this_cpu_read(ne_fit_preload_node)) {
> > > > > > 
> > > > > > Readability nit: local `pva' should be defined here, rather than having
> > > > > > function-wide scope.
> > > > > > 
> > > > > > : 		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
> > > > > > 
> > > > > > Why doesn't this honour gfp_mask?  If it's not a bug, please add
> > > > > > comment explaining this.
> > > > > > 
> > > > But there is a comment, if understand you correctly:
> > > > 
> > > > <snip>
> > > > * Even if it fails we do not really care about that. Just proceed
> > > > * as it is. "overflow" path will refill the cache we allocate from.
> > > > <snip>
> > > 
> > > My point is that the alloc_vmap_area() caller passed us a gfp_t but
> > > this code ignores it, as does adjust_va_to_fit_type().  These *look*
> > > like potential bugs.  If not, they should be commented so they don't
> > > look like bugs any more ;)
> > > 
> > I got it, there was misunderstanding from my side :) I agree.
> > 
> > In the first case i should have used and respect the passed "gfp_mask",
> > like below:
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index f48cd0711478..880b6e8cdeae 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1113,7 +1113,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >                  * Just proceed as it is. If needed "overflow" path
> >                  * will refill the cache we allocate from.
> >                  */
> > -               pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
> > +               pva = kmem_cache_alloc_node(vmap_area_cachep,
> > +                               gfp_mask & GFP_RECLAIM_MASK, node);
> >  
> >         spin_lock(&vmap_area_lock);
> > 
> > It should be sent as a separate patch, i think.
> 
> Yes. I do not think this would make any real difference because that
> battle is lost long ago. vmalloc is simply not gfp mask friendly. There
> are places like page table allocation which are hardcoded GFP_KERNEL so
> GFP_NOWAIT semantic is not going to work, really. The above makes sense
> from a pure aesthetic POV, though, I would say.
I agree. Then i will create a patch.

Thank you!

--
Vlad Rezki

