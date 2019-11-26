Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37406C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0546920727
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574782866;
	bh=MIaID3hafgAOvobitA36HQ1ZOXFldUAZQPLiYHpVTLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IJnmwVQlRIsg4Zw7dZbn1FQ4pHFlMMAYdzJMqfr2cXnCAWtbaw/tIq8/LiGAv52Vk
	 FVDMwxLSnoPL27mhdbJwWluV4hYEKv5SuTtnPc4tbNkwf7gZUg9jWcB+M0VdtLKakK
	 2xrdOTCu+q8bXDINp7sCQc5myT35OednehZQ3Nzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfKZPlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:41:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35571 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfKZPlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 10:41:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id n5so3882718wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 07:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SPgVeVHCC7EK5Hu9F1XSfDX+RpzQC7r0YCpltcwHr9g=;
        b=ljNyB/6n64JlAi+UuxMqkva7Xg1sVNHLXJv0ynL4Be1nTyRSKo1uBg1hUVk7l8BHdz
         H8jg7SR/umQGVIMxLJJ0RkimEwDZ3aGsn8W6Nse73ub96ULzaOXe6jo8ehoZolxX3Mqr
         MSKUAWRrc68GGowWVoNUglBezChrgveo98HisoHYP3kUwETUKI4chS4oujdi4ORQL9ud
         Gq0X0wodO1cBZg+xuU6Z3RxcyLjkYenzgj63uRu/Newx2GKTt9LuYQYd49Ek34Y3+Ug+
         C/ib1RduTodVv6H8HNYf8aoHQAmgOcHI7AXvwDTtPsiSI8Itj19eFtsm5iAyTTNfb9z7
         9nqw==
X-Gm-Message-State: APjAAAV3zBJIoWfpxiuLFk95SqzjTQPzI3gmE4qyeKsDv+whyDpAXwxg
        EVopZ+4E6NPTWKPs5T7aOe8=
X-Google-Smtp-Source: APXvYqymm/Db5iK7jJmisRl+LZSN5GLqBZG6XZoCXv7DCz6AP98oRtXK7ZfHJK1kNPYg2AEo7Rp2MQ==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr5137900wma.116.1574782862783;
        Tue, 26 Nov 2019 07:41:02 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id m1sm15128307wrv.37.2019.11.26.07.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 07:41:02 -0800 (PST)
Date:   Tue, 26 Nov 2019 16:41:01 +0100
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
Message-ID: <20191126154101.GJ20912@dhcp22.suse.cz>
References: <20191125083948.GC31714@dhcp22.suse.cz>
 <828BAB69-4B46-418F-A5E2-35B0756340D0@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <828BAB69-4B46-418F-A5E2-35B0756340D0@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-11-19 10:30:56, Qian Cai wrote:
> 
> 
> > On Nov 25, 2019, at 3:39 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > People do care about ZONE_MOVABLE and if there is a non-movable memory
> > sitting there then it is a bug. Please report that.
> 
> It is trivial to test yourself if you ever care. Just pass kernelcore=
> to as many NUMA machines you could find, an then test if ever possible
> to offline those memory.

I definitely do care if you can provide more details (ideally in a
separate email thread). I am using movable memory for memory hotplug
usecases and so far I do not remember any kernel/non-movable allocations
would make it in - modulo bugs when somebody might use __GFP_MOVABLE
when it is not appropriate.

-- 
Michal Hocko
SUSE Labs
