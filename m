Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9487C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7B823FEC
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559152176;
	bh=hEbkuQjYE9vHSwJJvHcAXKJHVjL3Hkgj0gHI6hIENhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DKsN8LAOag06QvblE9W8w96C/rou2oi8CCosuCJ34bQQvQB+yZhqMcFQTN92VaOaY
	 ycggolsjkRw1/Yx4oFheBO43lGq1kvc+Eh7YJPFiZRNDBTxMVG88Gs92iwvcaW5tP9
	 it3CQ2c+kJN85K70hWXcEHNqm3FV0y+y4L05Juo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfE2Rtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 13:49:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:33186 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbfE2Rtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 13:49:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C68D6ACD8;
        Wed, 29 May 2019 17:49:33 +0000 (UTC)
Date:   Wed, 29 May 2019 19:49:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dianzhang Chen <dianzhangchen0@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/slab_common.c: fix possible spectre-v1 in
 kmalloc_slab()
Message-ID: <20190529174931.GH18589@dhcp22.suse.cz>
References: <1559133448-31779-1-git-send-email-dianzhangchen0@gmail.com>
 <20190529162532.GG18589@dhcp22.suse.cz>
 <CAFbcbMDJB0uNjTa9xwT9npmTdqMJ1Hez3CyeOCjjrLF2W0Wprw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFbcbMDJB0uNjTa9xwT9npmTdqMJ1Hez3CyeOCjjrLF2W0Wprw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30-05-19 00:39:53, Dianzhang Chen wrote:
> It's come from `192+1`.
> 
> 
> The more code fragment is:
> 
> 
> if (size <= 192) {
> 
>     if (!size)
> 
>         return ZERO_SIZE_PTR;
> 
>     size = array_index_nospec(size, 193);
> 
>     index = size_index[size_index_elem(size)];
> 
> }

OK I see, I could have looked into the code, my bad. But I am still not
sure what is the potential exploit scenario and why this particular path
a needs special treatment while other size branches are ok. Could you be
more specific please?
-- 
Michal Hocko
SUSE Labs
