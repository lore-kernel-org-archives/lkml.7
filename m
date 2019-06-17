Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB923C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843892086A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfFQK4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:56:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:60332 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfFQK4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:56:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A1C0CAB99;
        Mon, 17 Jun 2019 10:56:00 +0000 (UTC)
Subject: Re: [RFC PATCH 16/16] xen/grant-table: host_addr fixup in mapping on
 xenhost_r0
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-17-ankur.a.arora@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <a35ab9a8-4874-fbc8-0148-aa07543e8672@suse.com>
Date:   Mon, 17 Jun 2019 12:55:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509172540.12398-17-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.19 19:25, Ankur Arora wrote:
> Xenhost type xenhost_r0 does not support standard GNTTABOP_map_grant_ref
> semantics (map a gref onto a specified host_addr). That's because
> since the hypervisor is local (same address space as the caller of
> GNTTABOP_map_grant_ref), there is no external entity that could
> map an arbitrary page underneath an arbitrary address.
> 
> To handle this, the GNTTABOP_map_grant_ref hypercall on xenhost_r0
> treats the host_addr as an OUT parameter instead of IN and expects the
> gnttab_map_refs() and similar to fixup any state that caches the
> value of host_addr from before the hypercall.
> 
> Accordingly gnttab_map_refs() now adds two parameters, a fixup function
> and a pointer to cached maps to fixup:
>   int gnttab_map_refs(xenhost_t *xh, struct gnttab_map_grant_ref *map_ops,
>   		    struct gnttab_map_grant_ref *kmap_ops,
> -		    struct page **pages, unsigned int count)
> +		    struct page **pages, gnttab_map_fixup_t map_fixup_fn,
> +		    void **map_fixup[], unsigned int count)
> 
> The reason we use a fixup function and not an additional mapping op
> in the xenhost_t is because, depending on the caller, what we are fixing
> might be different: blkback, netback for instance cache host_addr in
> via a struct page *, while __xenbus_map_ring() caches a phys_addr.
> 
> This patch fixes up xen-blkback and xen-gntdev drivers.
> 
> TODO:
>    - also rewrite gnttab_batch_map() and __xenbus_map_ring().
>    - modify xen-netback, scsiback, pciback etc
> 
> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Without seeing the __xenbus_map_ring() modification it is impossible to
do a proper review of this patch.


Juergen
