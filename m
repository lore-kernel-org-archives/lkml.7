Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60718C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3D02402E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559153374;
	bh=gnKw2WEDduGax4sEEXJjd76ccNLaRKge7up8CAq41d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jWm4/csYSpZSry7J6AbPfrpcKch/5mgIToTD2bb+PMKgkkFANJkLo6zv1EzHJaBaI
	 JgcUN8ljKhEN6w0jcWeq5o/Ty1ws75FHAo9MS1no3wGvagR5AS2266mtvURAlaLOoS
	 XEVcbMshMwIxGbgR2HCp/auWI+VJU8sHaCLVK2iI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfE2SJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 14:09:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:39026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727227AbfE2SJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 14:09:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BD96AD89;
        Wed, 29 May 2019 18:09:32 +0000 (UTC)
Date:   Wed, 29 May 2019 20:09:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: kernel BUG at mm/swap_state.c:170!
Message-ID: <20190529180931.GI18589@dhcp22.suse.cz>
References: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
 <CABXGCsNq4xTFeeLeUXBj7vXBz55aVu31W9q74r+pGM83DrPjfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsNq4xTFeeLeUXBj7vXBz55aVu31W9q74r+pGM83DrPjfA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-05-19 22:32:08, Mikhail Gavrilov wrote:
> On Wed, 29 May 2019 at 09:05, Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> >
> > Hi folks.
> > I am observed kernel panic after update to git tag 5.2-rc2.
> > This crash happens at memory pressing when swap being used.
> >
> > Unfortunately in journalctl saved only this:
> >
> 
> Now I captured better trace.
> 
> : page:ffffd6d34dff0000 refcount:1 mapcount:1 mapping:ffff97812323a689
> index:0xfecec363
> : anon
> : flags: 0x17fffe00080034(uptodate|lru|active|swapbacked)
> : raw: 0017fffe00080034 ffffd6d34c67c508 ffffd6d3504b8d48 ffff97812323a689
> : raw: 00000000fecec363 0000000000000000 0000000100000000 ffff978433ace000
> : page dumped because: VM_BUG_ON_PAGE(entry != page)
> : page->mem_cgroup:ffff978433ace000
> : ------------[ cut here ]------------
> : kernel BUG at mm/swap_state.c:170!

Do you see the same with 5.2-rc1 resp. 5.1?
-- 
Michal Hocko
SUSE Labs
