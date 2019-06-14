Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21F7C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 00:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DAA20850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 00:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TOSu9Iw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfFNAtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 20:49:04 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17282 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFNAtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 20:49:03 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d02eeff0000>; Thu, 13 Jun 2019 17:49:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 13 Jun 2019 17:49:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 13 Jun 2019 17:49:02 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 00:49:00 +0000
Subject: Re: [PATCH] drm/nouveau/dmem: missing mutex_lock in error path
To:     Ralph Campbell <rcampbell@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>
CC:     <nouveau@lists.freedesktop.org>, <linux-mm@kvack.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20190614001121.23950-1-rcampbell@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <1fc63655-985a-0d60-523f-00a51648dc38@nvidia.com>
Date:   Thu, 13 Jun 2019 17:49:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614001121.23950-1-rcampbell@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560473343; bh=BjedhBHdC+dcOh91aticrwFWw8MgD0WBJkzQKnUq81E=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=TOSu9Iw1C1DyRb5jRymBzYQAVGIJGrsxVJQIolENnFKOatN3JUmcw1Cu7lBtGtE3X
         cc+8Hc1/d7iGZDZFhLxpWRvLO2EQqM/XPuM/S7T68j1IMK3V62F6/Gu/we7U2KMrQH
         TzSpxb5+WvPQsxgC5pSPQYT/yRLTWzMGeZg5F23F2WZiFp6OJSPuZm8DEQAuvOyfgH
         83pDBVFmfiNeFA3osDju1F4Wbw1zBq/ovn9iTiBWwe8XdP86mKRIhfcUwBSb8PDBcM
         FTNPwt4TervNTABgwRII5KXJ/FclnbDfCQfZZWdNIlPs0Rg0xcdClB5AUmpfBYvWgH
         xZac448fVDEKA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/19 5:11 PM, Ralph Campbell wrote:
> In nouveau_dmem_pages_alloc(), the drm->dmem->mutex is unlocked before
> calling nouveau_dmem_chunk_alloc().
> Reacquire the lock before continuing to the next page.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
> 
> I found this while testing Jason Gunthorpe's hmm tree but this is
> independant of those changes. I guess it could go through
> David Airlie's tree for nouveau or Jason's tree.
> 

Hi Ralph,

btw, was this the fix for the crash you were seeing? It might be nice to
mention in the commit description, if you are seeing real symptoms.


>  drivers/gpu/drm/nouveau/nouveau_dmem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index 27aa4e72abe9..00f7236af1b9 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -379,9 +379,10 @@ nouveau_dmem_pages_alloc(struct nouveau_drm *drm,
>  			ret = nouveau_dmem_chunk_alloc(drm);
>  			if (ret) {
>  				if (c)
> -					break;

Actually, the pre-existing code is a little concerning. Your change preserves
the behavior, but it seems questionable to be doing a "return 0" (whether
via the above break, or your change) when it's in this partially allocated
state. It's reporting success when it only allocates part of what was requested,
and it doesn't fill in the pages array either.



> +					return 0;
>  				return ret;
>  			}
> +			mutex_lock(&drm->dmem->mutex);
>  			continue;
>  		}
>  
> 

The above comment is about pre-existing potential problems, but your patch itself
looks correct, so:

Reviewed-by: John Hubbard <jhubbard@nvidia.com> 


thanks,
-- 
John Hubbard
NVIDIA

