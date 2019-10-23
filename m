Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E830BCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA5C205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Oujg9zCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392513AbfJWQCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:02:09 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42823 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390259AbfJWQCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:02:09 -0400
Received: by mail-qt1-f195.google.com with SMTP id w14so33015075qto.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HuBYZtMC/2ECcAW9w0F4WSDn6CrA0ouxLYzbuT3eoqw=;
        b=Oujg9zCLBa9tQBIQTqDCy+i0l78T+gT/9d9EP49uk5MYfABKpewjiVNaP2E51x00IF
         Zwa7biWZoVIokr9BcQV12H0SY+DHOyTJFqUPIkCdvErh0OOUxCuNFwHu6JmrefXpXyQO
         r+G9PTaKYYtfsDyyXi98xwGM1BTpJbl82AiO0le0fp8E7JK4GAUEFEV3BbmG1Ef+VN34
         mf+wyT1VlkemxsFj6d+wViItcmVvBSWBKf0SeWoDPLuKEKTV3iGGmHmUORBnh3nFDPs9
         eeKXtpD+iKjBBUFZM8dxAFOjGZu5V0COBfwX/KRqHA2+aNYJf1QM0G27Pk5p6blzlXmR
         1q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HuBYZtMC/2ECcAW9w0F4WSDn6CrA0ouxLYzbuT3eoqw=;
        b=BSA9dVs4kfLjL7LW8gC7d2/mqA8h2BOD/EubtDE3YhjnYzD7XHlfeGtmkUvD/h2mv1
         kQltJZ6RPUZD4pzbfJD9AsJZVRUIXVK1kiTm07IDiS7+y3RHRDoD+uOej/jEX8JFoaXg
         x0EaQAg/AUxvtJqEYFssPkY22bcJF5Rf4sci8Ut6Rou2s541i9LK3lOzDDwYGX928OJl
         cYFFtx9FwbH+GdOippvqV6/FFErRZdYISGZtkIrliedIyLCAxTK/BdNdM0ZkZ4vNSqVM
         Q7PUWos9GVA/ota/YIcHSm3FQQCgRDTYOo/er/8pg454hgTOaLS73+5F9z/olAflnSk6
         DUCQ==
X-Gm-Message-State: APjAAAW/wyE3qEie93EhQpa/pqtmbQEbdk/c8A6iwK+7XA9vAs1OeGVM
        FNnqw7jqTh3vy8eaB+OmTtF1yg==
X-Google-Smtp-Source: APXvYqxPzOphiOVWEomKtrBEJMZvSJUadgOrLJBK6Urxyiyd/tnIKFneIQ5HmVcqQBRX8tR4ddjhJw==
X-Received: by 2002:ac8:21e7:: with SMTP id 36mr4238166qtz.160.1571846525149;
        Wed, 23 Oct 2019 09:02:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:c4de])
        by smtp.gmail.com with ESMTPSA id d23sm12014900qkc.127.2019.10.23.09.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 09:02:04 -0700 (PDT)
Date:   Wed, 23 Oct 2019 12:02:03 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 4/8] mm: vmscan: naming fixes: global_reclaim() and
 sane_reclaim()
Message-ID: <20191023160203.GC366316@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-5-hannes@cmpxchg.org>
 <20191022194048.GA22721@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022194048.GA22721@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 07:40:52PM +0000, Roman Gushchin wrote:
> On Tue, Oct 22, 2019 at 10:47:59AM -0400, Johannes Weiner wrote:
> > Seven years after introducing the global_reclaim() function, I still
> > have to double take when reading a callsite. I don't know how others
> > do it, this is a terrible name.
> > 
> > Invert the meaning and rename it to cgroup_reclaim().
> > 
> > [ After all, "global reclaim" is just regular reclaim invoked from the
> >   page allocator. It's reclaim on behalf of a cgroup limit that is a
> >   special case of reclaim, and should be explicit - not the reverse. ]
> > 
> > sane_reclaim() isn't very descriptive either: it tests whether we can
> > use the regular writeback throttling - available during regular page
> > reclaim or cgroup2 limit reclaim - or need to use the broken
> > wait_on_page_writeback() method. Use "writeback_throttling_sane()".
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  mm/vmscan.c | 38 ++++++++++++++++++--------------------
> >  1 file changed, 18 insertions(+), 20 deletions(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 622b77488144..302dad112f75 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -239,13 +239,13 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
> >  	up_write(&shrinker_rwsem);
> >  }
> >  
> > -static bool global_reclaim(struct scan_control *sc)
> > +static bool cgroup_reclaim(struct scan_control *sc)
> >  {
> > -	return !sc->target_mem_cgroup;
> > +	return sc->target_mem_cgroup;
> >  }
> 
> Isn't targeted_reclaim() better?
> 
> cgroup_reclaim() is also ok to me, but it sounds a bit like we reclaim
> from this specific cgroup. Also targeted/global is IMO a better opposition
> than cgroup/global (the latter reminds me days when there were global
> and cgroup LRUs).

I think "targeted" is quite a bit less descriptive when you come at
the page replacement algorithm without cgroups in mind.

> The rest of the patch looks good!
> 
> Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
