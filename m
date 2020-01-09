Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31183C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E668D206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UakHrUek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732166AbgAIS6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 13:58:17 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53]:34177 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbgAIS6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 13:58:16 -0500
Received: by mail-pj1-f53.google.com with SMTP id s94so1126244pjc.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 10:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=8miCelK+kNkKyg1qAxJi49qKtsPH/zr98yoCqmNSeCw=;
        b=UakHrUekXPvlhCN2k/yNKWdf6usnysaDd+tYSh6J/VljjRWDx9a59SsyGmX96QhIFj
         OKSesuYx23CaVWYQTi31UZZzrSMkJaFKhlWeuhjwpvu2qv3eUaN9g6OJzd+0f0VyZCHh
         OLNGIXwlAh9IkzClpP2/N7U76W/HoyV6lpOs0Tw58/4/NDZ8Opr0wA0qZSR0Xeyf4gIw
         pwr03WAKyRciGBUPeHx3TAeZ3uC5UQm14YKab/y5VrSmPi8mleFB47ickO5eCoVVLfvi
         Bjzf24VswqWNJ/ih5GdLUGY5fATnjx18Y+Qt2oBpqgrtP4ARyC0LO4uSVoYEv1Be8oqJ
         4rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=8miCelK+kNkKyg1qAxJi49qKtsPH/zr98yoCqmNSeCw=;
        b=qdFgUK2KX5KyFgRgBj9xXYYV00fDeBNA/kN0Uvey/LaMDt830YuaBGtzd03iOoCzaI
         Vbiadpoo4EPpIxE35BnIHkVEAKeN27vjrg9KNcDpsnDRcR+vhXm4+o6K3nAkMi8flv4a
         H0I7tBS7tXS5bDkaLK/94rDv+fDcH1PzAn28CZPnRYlvzPzHqcZ+9IL1Aj5RbQ7mQhfy
         ilrlGzGvexOKIaVXY9rLjCFpNCxVa5ASKjIl3r6H2H3fsIW7fwY6hXa9PMu1HuQt67+f
         AB/Ilm6Vx6KHNbIDnnHrHfhL/z1YhG/CglZLooktPkY7ELe9gv0l+46T8yjT8iHxDesu
         5XtQ==
X-Gm-Message-State: APjAAAWsy6le8avDhQfk6hNlIs5pmutyOf0lYeBGPoSuGf2fMwMo3cBQ
        mXBe88ABKLh2w3aeYC6ky/cpAXbBo98=
X-Google-Smtp-Source: APXvYqwWn6ivHvumB6Z57+qSecJtCaKEtnrUN0AqGN8qOc5VMfrTeUW9687xwzPRUZBc8kk16zHu6w==
X-Received: by 2002:a17:902:47:: with SMTP id 65mr13852948pla.130.1578596295719;
        Thu, 09 Jan 2020 10:58:15 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id b185sm9152254pfa.102.2020.01.09.10.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 10:58:15 -0800 (PST)
Date:   Thu, 9 Jan 2020 10:58:14 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Robin Murphy <robin.murphy@arm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, baekhw@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [rfc] dma-mapping: preallocate unencrypted DMA atomic pool
In-Reply-To: <20200109143108.GA22656@lst.de>
Message-ID: <alpine.DEB.2.21.2001091055460.57374@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <3213a6ac-5aad-62bc-bf95-fae8ba088b9e@arm.com> <20200107105458.GA3139@lst.de> <alpine.DEB.2.21.2001071152020.183706@chino.kir.corp.google.com> <20200109143108.GA22656@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2020, Christoph Hellwig wrote:

> > I'll rely on Thomas to chime in if this doesn't make sense for the SEV 
> > usecase.
> > 
> > I think the sizing of the single atomic pool needs to be determined.  Our 
> > peak usage that we have measured from NVMe is ~1.4MB and atomic_pool is 
> > currently sized to 256KB by default.  I'm unsure at this time if we need 
> > to be able to dynamically expand this pool with a kworker.
> >
> > Maybe when CONFIG_AMD_MEM_ENCRYPT is enabled this atomic pool should be 
> > sized to 2MB or so and then when it reaches half capacity we schedule some 
> > background work to dynamically increase it?  That wouldn't be hard unless 
> > the pool can be rapidly depleted.
> > 
> 
> Note that a non-coherent architecture with the same workload would need
> the same size.
> 
> > Do we want to increase the atomic pool size by default and then do 
> > background dynamic expansion?
> 
> For now I'd just scale with system memory size.
> 

Thanks Christoph and Robin for the help, we're running some additional 
stress tests to double check that our required amount of memory from this 
pool is accurate.  Once that's done, I'll refresh the patch with th 
suggestions and propose it formally.
