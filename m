Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEC9C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1B620820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407952AbfIWNcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:32:35 -0400
Received: from foss.arm.com ([217.140.110.172]:42190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404581AbfIWNce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:32:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DC971000;
        Mon, 23 Sep 2019 06:32:34 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 155783F694;
        Mon, 23 Sep 2019 06:32:32 -0700 (PDT)
Subject: Re: [PATCH v2 03/11] drm/shmem: drop VM_DONTDUMP
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sean Paul <sean@poorly.run>
References: <20190917092404.9982-1-kraxel@redhat.com>
 <20190917092404.9982-4-kraxel@redhat.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <f1bd2517-f49f-34c0-6b75-3181c4698f60@arm.com>
Date:   Mon, 23 Sep 2019 14:32:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917092404.9982-4-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2019 10:23, Gerd Hoffmann wrote:
> Not obvious why this is needed.  According to Deniel Vetter this is most
> likely a historic artefact dating back to the days where drm drivers
> exposed hardware registers as mmap'able gem objects, to avoid dumping
> touching those registers.  shmem gem objects surely don't need that ...
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index a9a586630517..6efedab15016 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -536,7 +536,7 @@ int drm_gem_shmem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
>  		return ret;
>  	}
>  
> -	vma->vm_flags |= VM_IO | VM_MIXEDMAP | VM_DONTEXPAND | VM_DONTDUMP;
> +	vma->vm_flags |= VM_IO | VM_MIXEDMAP | VM_DONTEXPAND;
>  	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
>  	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
>  	vma->vm_ops = &drm_gem_shmem_vm_ops;
> 

