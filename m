Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45814C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136D5218BA
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565076990;
	bh=eMqXwK0tQDPBESDAMIQWfR7xspiUeVckQJNWSDh1wX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Aa95gggy0kks0sDvUCam5cK4s+dNjp3bHoUiSMSFwYVt+KjY7bBPF+iP2XXWZVX0K
	 3+k/7GrpBt31q2DSio6LYmR6uKsDvUjwWUpsFwO2h0uhzQzkOJ8v/PpOkIn4Fobhtk
	 anLRFll+/PIV9aQwhhqq0jQmhx70ueSY4F+1wYhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbfHFHg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:36:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:35596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728798AbfHFHg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:36:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 922ECAD7F;
        Tue,  6 Aug 2019 07:36:27 +0000 (UTC)
Date:   Tue, 6 Aug 2019 09:36:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH RFC] mm/memcontrol: reclaim severe usage over high limit
 in get_user_pages loop
Message-ID: <20190806073624.GD11812@dhcp22.suse.cz>
References: <156431697805.3170.6377599347542228221.stgit@buzz>
 <20190729154952.GC21958@cmpxchg.org>
 <20190729185509.GI9330@dhcp22.suse.cz>
 <20190802094028.GG6461@dhcp22.suse.cz>
 <105a2f1f-de5c-7bac-3aa5-87bd1dbcaed9@yandex-team.ru>
 <20190802114438.GH6461@dhcp22.suse.cz>
 <20190806070728.GB11812@dhcp22.suse.cz>
 <c6b2c864-985a-2565-95e7-3af9e3e015f8@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6b2c864-985a-2565-95e7-3af9e3e015f8@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-08-19 10:19:49, Konstantin Khlebnikov wrote:
> On 8/6/19 10:07 AM, Michal Hocko wrote:
> > On Fri 02-08-19 13:44:38, Michal Hocko wrote:
> > [...]
> > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > index ba9138a4a1de..53a35c526e43 100644
> > > > > --- a/mm/memcontrol.c
> > > > > +++ b/mm/memcontrol.c
> > > > > @@ -2429,8 +2429,12 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > > > >    				schedule_work(&memcg->high_work);
> > > > >    				break;
> > > > >    			}
> > > > > -			current->memcg_nr_pages_over_high += batch;
> > > > > -			set_notify_resume(current);
> > > > > +			if (gfpflags_allow_blocking(gfp_mask)) {
> > > > > +				reclaim_high(memcg, nr_pages, GFP_KERNEL);
> > > 
> > > ups, this should be s@GFP_KERNEL@gfp_mask@
> > > 
> > > > > +			} else {
> > > > > +				current->memcg_nr_pages_over_high += batch;
> > > > > +				set_notify_resume(current);
> > > > > +			}
> > > > >    			break;
> > > > >    		}
> > > > >    	} while ((memcg = parent_mem_cgroup(memcg)));
> > > > > 
> > 
> > Should I send an official patch for this?
> > 
> 
> I prefer to keep it as is while we have no better solution.

Fine with me.

-- 
Michal Hocko
SUSE Labs
