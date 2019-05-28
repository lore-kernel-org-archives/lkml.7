Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEF9C04AB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 02:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0986A20823
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 02:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rH68e9QO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfE1CcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 22:32:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58800 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfE1CcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 22:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5RRvYTM2e/gWTemJvl1KdhwwgyigP6WYDybbXx30ARA=; b=rH68e9QOC0T6i0j0JEOunQHUk
        bSUHRoEG8nQBZVYuEdUfAQa5xwOVJBxARWlDxwTFfB9OfG7UE6fXQgSGpayk6K8qCUqEaAbiTIBxw
        6fcRpqJ4+JtMcW4ZyfOBxSTBUlz9pguIowppJM9q/fnLBH93FNRe+5Fl0fmhfiJVLJCFk6/f6/6ll
        pFOG8LtSDV4i+AwAoHFlLFJIec87JPrvyZccSKIyE2xadWbBtj8lXL6EgHfLmy4ErYBeD9PrBFZKz
        HdBZZUrFWk7OrNeL2WhBHRAtV7OkTOXbOlBXWt9rT5eShGzAkcR+Dh0AzvnLFj+EdT6iBUP9snA0h
        ZwtgpaOow==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVRuF-0004PH-Q8; Tue, 28 May 2019 02:32:03 +0000
Subject: Re: [PATCH] ia64: fix build errors by exporting paddr_to_nid()
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
References: <eaa72e00-e1ea-4a86-327e-8b8cca8ea492@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <877e524b-6b84-740e-a79b-5cec378bb22d@infradead.org>
Date:   Mon, 27 May 2019 19:32:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <eaa72e00-e1ea-4a86-327e-8b8cca8ea492@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

On 5/3/19 9:42 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build errors on ia64 when DISCONTIGMEM=y and NUMA=y by
> exporting paddr_to_nid().
> 
> Fixes these build errors:
> 
> ERROR: "paddr_to_nid" [sound/core/snd-pcm.ko] undefined!
> ERROR: "paddr_to_nid" [net/sunrpc/sunrpc.ko] undefined!
> ERROR: "paddr_to_nid" [fs/cifs/cifs.ko] undefined!
> ERROR: "paddr_to_nid" [drivers/video/fbdev/core/fb.ko] undefined!
> ERROR: "paddr_to_nid" [drivers/usb/mon/usbmon.ko] undefined!
> ERROR: "paddr_to_nid" [drivers/usb/core/usbcore.ko] undefined!
> ERROR: "paddr_to_nid" [drivers/md/raid1.ko] undefined!
> ERROR: "paddr_to_nid" [drivers/md/dm-mod.ko] undefined!
> ERROR: "paddr_to_nid" [drivers/md/dm-crypt.ko] undefined!
> ERROR: "paddr_to_nid" [drivers/md/dm-bufio.ko] undefined!
> ERROR: "paddr_to_nid" [drivers/ide/ide-core.ko] undefined!
> ERROR: "paddr_to_nid" [drivers/ide/ide-cd_mod.ko] undefined!
> ERROR: "paddr_to_nid" [drivers/gpu/drm/drm.ko] undefined!
> ERROR: "paddr_to_nid" [drivers/char/agp/agpgart.ko] undefined!
> ERROR: "paddr_to_nid" [drivers/block/nbd.ko] undefined!
> ERROR: "paddr_to_nid" [drivers/block/loop.ko] undefined!
> ERROR: "paddr_to_nid" [drivers/block/brd.ko] undefined!
> ERROR: "paddr_to_nid" [crypto/ccm.ko] undefined!
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: linux-ia64@vger.kernel.org
> ---
>  arch/ia64/mm/numa.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- lnx-51-rc7.orig/arch/ia64/mm/numa.c
> +++ lnx-51-rc7/arch/ia64/mm/numa.c
> @@ -55,6 +55,7 @@ paddr_to_nid(unsigned long paddr)
>  
>  	return (i < num_node_memblks) ? node_memblk[i].nid : (num_node_memblks ? -1 : 0);
>  }
> +EXPORT_SYMBOL(paddr_to_nid);
>  
>  #if defined(CONFIG_SPARSEMEM) && defined(CONFIG_NUMA)
>  /*
> 
> 


-- 
~Randy
