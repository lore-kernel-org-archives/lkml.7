Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B57C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B72214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mas8Y/k2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfHTNbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:31:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44022 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729838AbfHTNbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:31:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id b11so5962206qtp.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 06:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Rau8DTLhA75HN92GYpCRUTjDJzQh4QiLbDwyZ3veNCQ=;
        b=mas8Y/k2E852sfqmdBjki4+0c1zN+LWS95nZTvMODhRIXI5GRMbl9nccZ2+Vn6Woih
         Dah3xe19RUlkaa8o8IAFI40KKcQCWwBByL9kruX7QZlYKSD28X9fpbFwjPAZ86Dg/P1C
         cKFVKPhsro3UuqpcILFlAdo2eCq4NfBBI4O2+cQgL0Xjq3KsNiSUtC0PZMujNQLZkADv
         fE85d5hTmL1EJlG7jN+QczJ//3IFTSDXBw2EaAQXElYg13df3UJWU12j4jOOVPidGmhH
         GHXHFT/eIhecUzAgfQQFMqL1Ja9lCaB7rVn8U6eyVc5ng2FRVHBhvw37gsGE18A95KXO
         ZILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Rau8DTLhA75HN92GYpCRUTjDJzQh4QiLbDwyZ3veNCQ=;
        b=abot2wwBeL2j32db88xEcXU5uCQOsZH4r7SdmWIP+PuiE5b5yU7MBX7TO/zfNpErXV
         lsqutBndd2WIDFKMUEEj8bHeLEavaPmE/XnmoJSkT721TbspMg4CAjxteNWrDY42JekL
         dYWHL2H2+TvJEHEN7AVx0cCnjH6zRg9rdrMKXte7/DJEe4Qqg5z74fWJ1oGR1XMTd/t7
         jRAj5ifAazGIPWcRqsQxeapjo3T3TgJ30AA2MuR56iaQ6RvYkx4XIZD1135LSjMmN+HV
         c2DrTgdWL7j3bcgHjiTEb22mIO+qvaoC5/3ZEIOIN/ZFscQ7J+0a8NOIJNljsG+azSeU
         jvVQ==
X-Gm-Message-State: APjAAAW3V4LEPPSLu2KfcHNkkIcgFPSGVYlNNo5QukeVkpzDx2Hd8Iiw
        jOlc9KGvChO9zxh9ACDFKW2dYg==
X-Google-Smtp-Source: APXvYqysNleRHIxweJW4kUQqWciO4PnA7inG5RNUTSkUVmb1nCNlKeN951d2NRIAKVBELcjqlvEfqQ==
X-Received: by 2002:ac8:425a:: with SMTP id r26mr23111414qtm.309.1566307896020;
        Tue, 20 Aug 2019 06:31:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id m129sm2560940qkf.86.2019.08.20.06.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 06:31:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i04EZ-0000YV-7s; Tue, 20 Aug 2019 10:31:35 -0300
Date:   Tue, 20 Aug 2019 10:31:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/4] mm, notifier: Prime lockdep
Message-ID: <20190820133135.GF29246@ziepe.ca>
References: <20190820081902.24815-1-daniel.vetter@ffwll.ch>
 <20190820081902.24815-3-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190820081902.24815-3-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 10:19:00AM +0200, Daniel Vetter wrote:
> We want to teach lockdep that mmu notifiers can be called from direct
> reclaim paths, since on many CI systems load might never reach that
> level (e.g. when just running fuzzer or small functional tests).
> 
> Motivated by a discussion with Jason.
> 
> I've put the annotation into mmu_notifier_register since only when we
> have mmu notifiers registered is there any point in teaching lockdep
> about them. Also, we already have a kmalloc(, GFP_KERNEL), so this is
> safe.
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: linux-mm@kvack.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>  mm/mmu_notifier.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index d12e3079e7a4..538d3bb87f9b 100644
> +++ b/mm/mmu_notifier.c
> @@ -256,6 +256,13 @@ static int do_mmu_notifier_register(struct mmu_notifier *mn,
>  
>  	BUG_ON(atomic_read(&mm->mm_users) <= 0);
>  
> +	if (IS_ENABLED(CONFIG_LOCKDEP)) {
> +		fs_reclaim_acquire(GFP_KERNEL);
> +		lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
> +		lock_map_release(&__mmu_notifier_invalidate_range_start_map);
> +		fs_reclaim_release(GFP_KERNEL);
> +	}

Lets try it out at least

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
