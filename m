Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECC3C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EBC22DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QqsPJhXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbfHTP1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:27:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39745 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTP1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:27:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9so6468292qtu.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 08:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yW4ipw+ijUAP2Q3jnbjwYqx48ceAaeyZl32HjbZvBF8=;
        b=QqsPJhXRoBXVjmCrsAFdhiaITVfXqO2ZbJBdqsS+9/ZmosuBXqYxWmNMrXR9TnpuUi
         QlLlAbE7omSK3rDBbAA43cD05WXgrc1Cd6jrfMZkVfD3xtp91Pks6Q/39uGWa+yOwJ/U
         x4/6+nJFRPi5XiAxs8pJ0RCXRx4TaUPN34lZQGHafrWL31jEoG5n4NHsJbl1H3ahi4kl
         XvIe+6IfT7lC6koxxwohKTu2HPDLEzE7wDyPYYD4R51boRvsJeGqsyrtz9tg4s0g9Iqq
         c0bs9IDpm44eGml2+iL4uiImn7byYZ5Mvqulc8EmX+SnUiDF8j9kAMFrtlLv8QR2lihE
         8hmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yW4ipw+ijUAP2Q3jnbjwYqx48ceAaeyZl32HjbZvBF8=;
        b=HuW1RveqItJbZUDsnWodyTrrhvgHhqBide4G+h1MbkVXXNN6DctWh/NwVjLs0Bl7T9
         IxBkxLYbPouKyiWlZH9aIBfqXHdd59e0aRTrTapV03Usqr88DxfW9gl5tJ7Xs6SSmDgA
         co4Khk0g7t9VbyXhF69w2WW/exulUgXgjlm2KlgdZLlaJNwP1nuP5tnpUIgbgxgTrdZm
         Fq22uli1tDr7j0AnOTUAi/VeurPCW72swWWFEZb4koQf+iN8GU0sjiDt6kacvQGM5aqK
         AMtPEoCgUSVOGQONKQW53S1ogsbCFuOEywAItnTKyuuFSdY8/wLQDpbCm7fobs8gusHo
         +3mw==
X-Gm-Message-State: APjAAAWndUAcltJbyr8AywWtjSty+UOmMpiDVPA4/Z4ODDgcPiQg04UH
        KXNHYnt+GoyI+w4LziEqXKSJIpk9OBg=
X-Google-Smtp-Source: APXvYqzLDWQu/fkE06n1IL3PlMALP6ghZ2NAMT8nSJjaAYIB+Oofjqoc+iLByXPCaoCuZbKxUT21Ng==
X-Received: by 2002:ac8:48c1:: with SMTP id l1mr27197055qtr.251.1566314833307;
        Tue, 20 Aug 2019 08:27:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id d12sm8931802qkk.39.2019.08.20.08.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 08:27:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i062S-0000PN-G3; Tue, 20 Aug 2019 12:27:12 -0300
Date:   Tue, 20 Aug 2019 12:27:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 4/4] mm, notifier: Catch sleeping/blocking for !blockable
Message-ID: <20190820152712.GH29246@ziepe.ca>
References: <20190820081902.24815-1-daniel.vetter@ffwll.ch>
 <20190820081902.24815-5-daniel.vetter@ffwll.ch>
 <20190820133418.GG29246@ziepe.ca>
 <20190820151810.GG11147@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820151810.GG11147@phenom.ffwll.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 05:18:10PM +0200, Daniel Vetter wrote:
> > > diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> > > index 538d3bb87f9b..856636d06ee0 100644
> > > +++ b/mm/mmu_notifier.c
> > > @@ -181,7 +181,13 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
> > >  	id = srcu_read_lock(&srcu);
> > >  	hlist_for_each_entry_rcu(mn, &range->mm->mmu_notifier_mm->list, hlist) {
> > >  		if (mn->ops->invalidate_range_start) {
> > > -			int _ret = mn->ops->invalidate_range_start(mn, range);
> > > +			int _ret;
> > > +
> > > +			if (!mmu_notifier_range_blockable(range))
> > > +				non_block_start();
> > > +			_ret = mn->ops->invalidate_range_start(mn, range);
> > > +			if (!mmu_notifier_range_blockable(range))
> > > +				non_block_end();
> > 
> > If someone Acks all the sched changes then I can pick this for
> > hmm.git, but I still think the existing pre-emption debugging is fine
> > for this use case.
> 
> Ok, I'll ping Peter Z. for an ack, iirc he was involved.
> 
> > Also, same comment as for the lockdep map, this needs to apply to the
> > non-blocking range_end also.
> 
> Hm, I thought the page table locks we're holding there already prevent any
> sleeping, so would be redundant?

AFAIK no. All callers of invalidate_range_start/end pairs do so a few
lines apart and don't change their locking in between - thus since
start can block so can end.

Would love to know if that is not true??

Similarly I've also been idly wondering if we should add a
'might_sleep()' to invalidate_rangestart/end() to make this constraint
clear & tested to the mm side?

Jason
