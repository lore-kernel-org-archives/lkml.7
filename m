Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A874BC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDBA20674
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574844614;
	bh=kGKaQggGThFjVO+dEVY5JkdzMLYbLSAfscG6aqI099s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ow94OKgej+OXL8QT3As5catwP5mK9+8ZIZAUZqXh6DxrFyQu9FrgsPksO8pLRkUB2
	 NIdWVuCFjN0xgE3NiERYZvWEFu4MZQIme9O13BoxKb9+f3Sb2J+qIls/QqDtT44bs0
	 zsXLU2/XJMc0LRxprguMVopTVX6BDpn3o1QRWzkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfK0IuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:50:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40467 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfK0IuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:50:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id y5so6418887wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 00:50:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ImdFufuCLABk5owE8eytpQBnf5CgqpycdtGsCA5UGN0=;
        b=RuLGRVNMMRMVHHZrCSKT6GThkoiDsJnj0QRDuc+enKMNpRqO9bStghG8pK4bV3KDTj
         Q6e1S1+OHjraBbJ1E4eTecgtpyEcuXpLCHYywdUyAnrpTZzOSVwRxv/rlIS1niDtEsxD
         XkeeH/7D+kMcA/J4uFH5s+veXGh3vISItdJUWOeD9i3G5Q4hxvOB1Vdu2YaPEYpL8mij
         YwXmc5/gRfa4BBUdbQ/EvNH1tkng3NTiq2VUF+xwhEdsxTG74GiwTPohSO/Nt6oOBJWP
         mCsz9l+6AbWmu6MCh1m1RjB3CyC3a4Wavkd5iv/D1SwlMnA8FMAJzbSRldjCFgvHQXF6
         4utQ==
X-Gm-Message-State: APjAAAURFFxcDq0MOvldlPO0ABnBjduwIGAvTstDzKMF1MvY2QZnZi+b
        UnCWS3e754m0+u+iJe32HFM=
X-Google-Smtp-Source: APXvYqw8RWSr4foVA5g0pWSg5i8S+1/nelRYLyqWD8O/YCVpejH/DKWzrSxz5qb/ndIYzeuHmctHug==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr3246481wmj.84.1574844610057;
        Wed, 27 Nov 2019 00:50:10 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id l10sm19891393wrg.90.2019.11.27.00.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 00:50:09 -0800 (PST)
Date:   Wed, 27 Nov 2019 09:50:08 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Pengfei Li <fly@kernel.page>,
        "lixinhai.lxh@gmail.com" <lixinhai.lxh@gmail.com>,
        akpm <akpm@linux-foundation.org>,
        mgorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, cl <cl@linux.com>,
        "iamjoonsoo.kim" <iamjoonsoo.kim@lge.com>, guro <guro@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC v1 00/19] Modify zonelist to nodelist v1
Message-ID: <20191127085008.GM20912@dhcp22.suse.cz>
References: <20191125083948.GC31714@dhcp22.suse.cz>
 <828BAB69-4B46-418F-A5E2-35B0756340D0@lca.pw>
 <20191126154101.GJ20912@dhcp22.suse.cz>
 <8B426079-6091-4898-8D77-609915C273E8@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8B426079-6091-4898-8D77-609915C273E8@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-11-19 14:04:06, Qian Cai wrote:
> 
> 
> > On Nov 26, 2019, at 10:41 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > On Tue 26-11-19 10:30:56, Qian Cai wrote:
> >> 
> >> 
> >>> On Nov 25, 2019, at 3:39 AM, Michal Hocko <mhocko@kernel.org> wrote:
> >>> 
> >>> People do care about ZONE_MOVABLE and if there is a non-movable memory
> >>> sitting there then it is a bug. Please report that.
> >> 
> >> It is trivial to test yourself if you ever care. Just pass kernelcore=
> >> to as many NUMA machines you could find, an then test if ever possible
> >> to offline those memory.
> > 
> > I definitely do care if you can provide more details (ideally in a
> > separate email thread). I am using movable memory for memory hotplug
> > usecases and so far I do not remember any kernel/non-movable allocations
> > would make it in - modulo bugs when somebody might use __GFP_MOVABLE
> > when it is not appropriate.
> > 
> 
> I don’t think it is anything to do with __GFP_MOVABLE. It is about booting a kernel
> with either passing kernelcore= or movablecore=. Then, those ZONE_MOVABLE will
> have non-movable pages which looks like those from vmemmap_populate().

OK, I see. This looks like a bug in kernelcore/movablecore. And honestly
I wouldn't be surprised because these are hacks that should have been
removed. I have even attempted to do that because their main usecase is
mostly gone. There were some objections though...

> How do you create ZONE_MOVALBLE in this first place? 

The most common usecase I work with is to use movable_node parameter
which makes whole nodes marked as hotplugable to be moved to
ZONE_MOVABLE.

-- 
Michal Hocko
SUSE Labs
