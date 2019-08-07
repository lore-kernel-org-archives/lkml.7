Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086F2C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AF921BE3
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388037AbfHGNCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:02:35 -0400
Received: from ozlabs.org ([203.11.71.1]:44341 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387799AbfHGNCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:02:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 463Wr74L2Pz9sBF;
        Wed,  7 Aug 2019 23:02:31 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jason Yan <yanaijie@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        diana.craciun@nxp.com, christophe.leroy@c-s.fr,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        keescook@chromium.org, kernel-hardening@lists.openwall.com
Cc:     linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        yebin10@huawei.com, thunder.leizhen@huawei.com,
        jingxiangfeng@huawei.com, fanchengyang@huawei.com,
        zhaohongjiang@huawei.com, Jason Yan <yanaijie@huawei.com>
Subject: Re: [PATCH v5 02/10] powerpc: move memstart_addr and kernstart_addr to init-common.c
In-Reply-To: <20190807065706.11411-3-yanaijie@huawei.com>
References: <20190807065706.11411-1-yanaijie@huawei.com> <20190807065706.11411-3-yanaijie@huawei.com>
Date:   Wed, 07 Aug 2019 23:02:26 +1000
Message-ID: <874l2tuo0t.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Yan <yanaijie@huawei.com> writes:
> These two variables are both defined in init_32.c and init_64.c. Move
> them to init-common.c.
>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Cc: Diana Craciun <diana.craciun@nxp.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Diana Craciun <diana.craciun@nxp.com>
> Tested-by: Diana Craciun <diana.craciun@nxp.com>
> ---
>  arch/powerpc/mm/init-common.c | 5 +++++
>  arch/powerpc/mm/init_32.c     | 5 -----
>  arch/powerpc/mm/init_64.c     | 5 -----
>  3 files changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
> index a84da92920f7..152ae0d21435 100644
> --- a/arch/powerpc/mm/init-common.c
> +++ b/arch/powerpc/mm/init-common.c
> @@ -21,6 +21,11 @@
>  #include <asm/pgtable.h>
>  #include <asm/kup.h>
>  
> +phys_addr_t memstart_addr = (phys_addr_t)~0ull;
> +EXPORT_SYMBOL_GPL(memstart_addr);
> +phys_addr_t kernstart_addr;
> +EXPORT_SYMBOL_GPL(kernstart_addr);

Would be nice if these can be __ro_after_init ?

cheers
