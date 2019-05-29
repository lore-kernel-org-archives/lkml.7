Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C1DC28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9243523D60
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559147137;
	bh=1LYbnDID6+i96jGpOccylgW14e+dv8wtRA6L2mHibJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hKA05IZeAF6SL3canvUT1l4x49kvDICi556tgAKBSLsR4FjNM3u+/RKq4HJxFTQ9O
	 4kHrJnkUV53U/izRTVuhqHD76sk0zO9V5G4eYsZUXYyjz6IhWB5IKwgNOdo+QsckJB
	 AtVBUMDTYyFe6CgOVOnqWR7HXlXCuZ8jEVe/o5Rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfE2QZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 12:25:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:60150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbfE2QZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 12:25:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 206D5ADEA;
        Wed, 29 May 2019 16:25:34 +0000 (UTC)
Date:   Wed, 29 May 2019 18:25:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dianzhang Chen <dianzhangchen0@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab_common.c: fix possible spectre-v1 in
 kmalloc_slab()
Message-ID: <20190529162532.GG18589@dhcp22.suse.cz>
References: <1559133448-31779-1-git-send-email-dianzhangchen0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559133448-31779-1-git-send-email-dianzhangchen0@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-05-19 20:37:28, Dianzhang Chen wrote:
[...]
> @@ -1056,6 +1057,7 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
>  		if (!size)
>  			return ZERO_SIZE_PTR;
>  
> +		size = array_index_nospec(size, 193);
>  		index = size_index[size_index_elem(size)];

What is this 193 magic number?
-- 
Michal Hocko
SUSE Labs
