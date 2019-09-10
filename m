Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585A7C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C3B206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568099434;
	bh=dyDleg6lbv3xe4Ownoc01zEp5AK36yxlU+/VO7fM8ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FlElRtG0m4YIc7YRAXfwGVNecDwIGb4mSCj2qORPpzVSs86OkJa6/z1mMZEXztVt9
	 M1KS0QHkJ6QtGHmpyGxK57Gi0r3O5RSmA7r1QNfGjGN6CxVpCpIP5k7T1EaM4myIU7
	 2yAJ+oVVjx09AmwCNr/OXgrGuMy0Lk4klqnr5hM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406579AbfIJHKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 03:10:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:39702 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406564AbfIJHKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 03:10:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 523C0AFF5;
        Tue, 10 Sep 2019 07:10:31 +0000 (UTC)
Date:   Tue, 10 Sep 2019 09:10:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add dummy can_do_mlock() helper
Message-ID: <20190910071030.GG2063@dhcp22.suse.cz>
References: <20190909204201.931830-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909204201.931830-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-09-19 22:41:40, Arnd Bergmann wrote:
> On kernels without CONFIG_MMU, we get a link error for the siw
> driver:
> 
> drivers/infiniband/sw/siw/siw_mem.o: In function `siw_umem_get':
> siw_mem.c:(.text+0x4c8): undefined reference to `can_do_mlock'
> 
> This is probably not the only driver that needs the function
> and could otherwise build correctly without CONFIG_MMU, so
> add a dummy variant that always returns false.
> 
> Fixes: 2251334dcac9 ("rdma/siw: application buffer management")
> Suggested-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Makes sense
Acked-by: Michal Hocko <mhocko@suse.com>

but IB on nonMMU? Whut? Is there any HW that actually supports this?
Just wondering...

> ---
>  include/linux/mm.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 66f296181bcc..cc292273e6ba 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1424,7 +1424,11 @@ extern void pagefault_out_of_memory(void);
>  
>  extern void show_free_areas(unsigned int flags, nodemask_t *nodemask);
>  
> +#ifdef CONFIG_MMU
>  extern bool can_do_mlock(void);
> +#else
> +static inline bool can_do_mlock(void) { return false; }
> +#endif
>  extern int user_shm_lock(size_t, struct user_struct *);
>  extern void user_shm_unlock(size_t, struct user_struct *);
>  
> -- 
> 2.20.0
> 

-- 
Michal Hocko
SUSE Labs
