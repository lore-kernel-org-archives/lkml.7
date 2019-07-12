Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB15C742D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858BB2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQjMfmek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfGLXJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 19:09:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37947 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbfGLXJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 19:09:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so10510358edo.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 16:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mp2L3+PxgXR8+xXdOZiEFJ7C433LcerfS54GdFQeN60=;
        b=LQjMfmekW6FIyum3X8Tu6KAwYJZpsP1W7C4wzzkjJaINWv0Cdlzp1a0TT/rq9nnGz7
         2x13o5w8cfwIdeVMkYonffNcDvmOI4oAQpv18KCELSgXrBu6zLzzh6HJ3I/p1GAyABIz
         +I9BcL3zfHm1V6yjnHRCGnytetrWxHup3dmQ/gcct/WJCE3DA56QZXR/Pebbl5yByrjL
         f0sSONp5AVLhtR4CYedkha4dVx2Orb+S2YVbJ5tTJmgiJ0bfLKgxQm8GUi2nEng8rtYr
         xgy/lFiJXPmwb0uN3Mgil2A1RBB3gyoEbdwZpu3fZ95dwkph4943Ei19/VO2U9NzbwYr
         bxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mp2L3+PxgXR8+xXdOZiEFJ7C433LcerfS54GdFQeN60=;
        b=Rz7QmbWkoqj2CCesWHqO8Pa3qRDMc2GS3/21Uz8MlAntreCksdXdDlUtNyz23+mjJU
         2b8+sNbUV4ZFZzPLvzihbFK4fPszsRZf7spuDLf4/ticZkDRo1c9slLijCNHFUJ94To3
         kc1tAPj1kQZNkNzhyHEjlzRZzD20YKZHR8/NBxr1H7xzkq5c6fZEMppcbkvl6rwvs9zz
         lV2pBsYnpRPKARu/LhwNRBqPI68kNhld1meuQZtrZB01YBacuSnO4uzXzfTPgBLjjPGM
         ToZ9eW6wOz5M1qUocb1nlx8Ezcj0e0IKYh2LOye5wVOA2vU3GjaS5N/i6KjzE0lG0n9Z
         7bTA==
X-Gm-Message-State: APjAAAXgmKGNxF7Xhj+/cYjZOqYi+R9Zb5W2ql/F26SRTyW8Pu90fN69
        2hY3O9np8MdWa5l2USMTuYQ=
X-Google-Smtp-Source: APXvYqzB7ir9/0LKvQ53vpsIdcgNNk/iqKUX0f46wSvbBPOxh+fd4lNokvB/gAWUwBgaIA8FAx6kjg==
X-Received: by 2002:a05:6402:14c4:: with SMTP id f4mr11724254edx.170.1562972954833;
        Fri, 12 Jul 2019 16:09:14 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c16sm2958237edc.58.2019.07.12.16.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2019 16:09:13 -0700 (PDT)
Date:   Fri, 12 Jul 2019 23:09:13 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, Qian Cai <cai@lca.pw>,
        Wei Yang <richard.weiyang@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] mm: sparse: Skip no-map regions in memblocks_present
Message-ID: <20190712230913.l35zpdiqcqa4o32f@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1562921491-23899-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562921491-23899-1-git-send-email-karahmed@amazon.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 10:51:31AM +0200, KarimAllah Ahmed wrote:
>Do not mark regions that are marked with nomap to be present, otherwise
>these memblock cause unnecessarily allocation of metadata.
>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Mike Rapoport <rppt@linux.ibm.com>
>Cc: Baoquan He <bhe@redhat.com>
>Cc: Qian Cai <cai@lca.pw>
>Cc: Wei Yang <richard.weiyang@gmail.com>
>Cc: Logan Gunthorpe <logang@deltatee.com>
>Cc: linux-mm@kvack.org
>Cc: linux-kernel@vger.kernel.org
>Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
>---
> mm/sparse.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/mm/sparse.c b/mm/sparse.c
>index fd13166..33810b6 100644
>--- a/mm/sparse.c
>+++ b/mm/sparse.c
>@@ -256,6 +256,10 @@ void __init memblocks_present(void)
> 	struct memblock_region *reg;
> 
> 	for_each_memblock(memory, reg) {
>+
>+		if (memblock_is_nomap(reg))
>+			continue;
>+
> 		memory_present(memblock_get_region_node(reg),
> 			       memblock_region_memory_base_pfn(reg),
> 			       memblock_region_memory_end_pfn(reg));


The logic looks good, while I am not sure this would take effect. Since the
metadata is SECTION size aligned while memblock is not.

If I am correct, on arm64, we mark nomap memblock in map_mem()

    memblock_mark_nomap(kernel_start, kernel_end - kernel_start);

And kernel text area is less than 40M, if I am right. This means
memblocks_present would still mark the section present. 

Would you mind showing how much memory range it is marked nomap?

>-- 
>2.7.4

-- 
Wei Yang
Help you, Help me
