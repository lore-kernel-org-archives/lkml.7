Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCEBC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C498520828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566887328;
	bh=t/k0wxnubh6zpRCRRkmbwdN56vGyHsuCtUnVcw9bEvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yKJLUDYlT6qUa54O4p+mgTmivpWmyM7WjANUZTqt/ULapBMpe1UuqIYTV9l/vM5A0
	 +Hmwa1NR+8zOwX1nBiuFe5ACxmoq8AwGSqeV37Zdt3Gp1zezBqq1hErkNaid2RbVWM
	 N89L3LePZTxVHSawR5R/B1BM99qlXBd9Scd72vJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfH0G2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 02:28:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:56358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbfH0G2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 02:28:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D72E8B0B6;
        Tue, 27 Aug 2019 06:28:45 +0000 (UTC)
Date:   Tue, 27 Aug 2019 08:28:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Perform a bounds check in arch_add_memory
Message-ID: <20190827062844.GQ7538@dhcp22.suse.cz>
References: <20190827052047.31547-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827052047.31547-1-alastair@au1.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-08-19 15:20:46, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> It is possible for firmware to allocate memory ranges outside
> the range of physical memory that we support (MAX_PHYSMEM_BITS).

Doesn't that count as a FW bug? Do you have any evidence of that in the
field? Just wondering...

> This patch adds a bounds check to ensure that any hotplugged
> memory is addressable.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  arch/powerpc/mm/mem.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 9191a66b3bc5..de18fb73de30 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -111,6 +111,9 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
>  	int rc;
>  
> +	if ((start + size - 1) >> MAX_PHYSMEM_BITS)
> +		return -EINVAL;
> +
>  	resize_hpt_for_hotplug(memblock_phys_mem_size());
>  
>  	start = (unsigned long)__va(start);
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
