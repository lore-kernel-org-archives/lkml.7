Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D461C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB53821881
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="ckUXHhXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbfHHMnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:43:24 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:40830 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfHHMnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:43:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 557D23F5AB;
        Thu,  8 Aug 2019 14:43:21 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="ckUXHhXo";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PNFA3GisQkMe; Thu,  8 Aug 2019 14:43:20 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 3DF8E3F3CA;
        Thu,  8 Aug 2019 14:43:17 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 7E6DA360301;
        Thu,  8 Aug 2019 14:43:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1565268197; bh=Y96A8mvBNgHpthhnaEAzth6EF+7dsvNIExRZqv5ZrRU=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ckUXHhXo+S5yUd29rYFyBtENLt1uaNqV4fQz+6tMl5TSrlgdFSz83TS8PgxG5M2BM
         l7fi7m93ajc+HnFDo+Bo3YlS0a8KYvERd8XbkIGWyJHAmvRn5zfcrkEtS44AWof/4U
         nG61Vc7lVzETg8PSFZWcnEaQDa9lJ74Rv42HGZvc=
Subject: Re: [PATCH v3 2/8] ttm: turn ttm_bo_device.vma_manager into a pointer
To:     Gerd Hoffmann <kraxel@redhat.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190808093702.29512-1-kraxel@redhat.com>
 <20190808093702.29512-3-kraxel@redhat.com>
 <2a90c899-19eb-5be2-3eda-f20efd31aa29@amd.com>
 <20190808103521.u6ggltj4ftns77je@sirius.home.kraxel.org>
 <20190808120252.GO7444@phenom.ffwll.local>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas@shipmail.org>
Organization: VMware Inc.
Message-ID: <36145412-3c31-e635-1e8b-b42439811742@shipmail.org>
Date:   Thu, 8 Aug 2019 14:43:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190808120252.GO7444@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/19 2:02 PM, Daniel Vetter wrote:
> On Thu, Aug 08, 2019 at 12:35:21PM +0200, Gerd Hoffmann wrote:
>> On Thu, Aug 08, 2019 at 09:48:49AM +0000, Koenig, Christian wrote:
>>> Am 08.08.19 um 11:36 schrieb Gerd Hoffmann:
>>>> Rename the embedded struct vma_offset_manager, it is named _vma_manager
>>>> now.  ttm_bo_device.vma_manager is a pointer now, pointing to the
>>>> embedded ttm_bo_device._vma_manager by default.
>>>>
>>>> Add ttm_bo_device_init_with_vma_manager() function which allows to
>>>> initialize ttm with a different vma manager.
>>> Can't we go down the route of completely removing the vma_manager from
>>> TTM? ttm_bo_mmap() would get the BO as parameter instead.
>> It surely makes sense to target that.  This patch can be a first step
>> into that direction.  It allows gem and ttm to use the same
>> vma_offset_manager (see patch #3), which in turn makes various gem
>> functions work on ttm objects (see patch #4 for vram helpers).
> +1 on cleaning this up for good, at least long-term ...
>
>>> That would also make the verify_access callback completely superfluous
>>> and looks like a good step into the right direction of de-midlayering.
>> Hmm, right, noticed that too while working on another patch series.
>> Guess I'll try to merge those two and see where I end up ...
> ... but if it gets too invasive I'd vote for incremental changes. Even if
> we completely rip out the vma/mmap lookup stuff from ttm, we still need to
> keep a copy somewhere for vmwgfx. Or would the evil plan be the vmwgfx
> would use the gem mmap helpers too?

I don't think it would be too invasive. We could simply move 
ttm_bo_vm_lookup into a vmw_mmap.

/Thomas




> -Daniel


