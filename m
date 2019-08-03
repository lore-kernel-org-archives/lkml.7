Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE377C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 19:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6746D206A2
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 19:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="TMiecfdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfHCTLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 15:11:02 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:35992 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfHCTLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 15:11:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 6A42E3F616;
        Sat,  3 Aug 2019 21:10:50 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=TMiecfdZ;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sz9Pv9uA3-kQ; Sat,  3 Aug 2019 21:10:37 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 81C153F58A;
        Sat,  3 Aug 2019 21:10:36 +0200 (CEST)
Received: from linlap1.host.shipmail.org (94.191.159.101.mobile.tre.se [94.191.159.101])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 5943C36006D;
        Sat,  3 Aug 2019 21:10:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1564859436; bh=t9VeR/VU7Ow5VEA74vJl+ITNBqmCkFNGjgY4leLgSXo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TMiecfdZynF6GJw5brMyR2OSoG/JowNY9vX0iDBTc/c4v0bk2OZ8n7RffczOcI9XE
         3EyrhXgJqgt1pKDPq1+Yyx7xIVwAgUpFuX+OWH552kr0otemEnuIhSLGb7ty8VD8/m
         O15YRcc04O2Qxta8mn73V/ntL5htrgvcYBvaYGUc=
Subject: Re: [PATCH v4 12/17] drm/vmwgfx: switch driver from bo->resv to
 bo->base.resv
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     ckoenig.leichtzumerken@gmail.com, tzimmermann@suse.de,
        daniel@ffwll.ch, bskeggs@redhat.com,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20190802052247.18427-1-kraxel@redhat.com>
 <20190802052247.18427-13-kraxel@redhat.com>
From:   Thomas Hellstrom <thomas@shipmail.org>
Message-ID: <37ef501f-a962-bead-35bd-5f7e9e3fb38e@shipmail.org>
Date:   Sat, 3 Aug 2019 21:10:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802052247.18427-13-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Still doesn't like this very much, but anyway

Acked-by: Thomas Hellstrom <thellstrom@vmware.com>

On 8/2/19 7:22 AM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/vmwgfx/vmwgfx_blit.c     | 4 ++--
>   drivers/gpu/drm/vmwgfx/vmwgfx_bo.c       | 8 ++++----
>   drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c  | 4 ++--
>   drivers/gpu/drm/vmwgfx/vmwgfx_resource.c | 6 +++---
>   4 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> index fc6673cde289..917eeb793585 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> @@ -459,9 +459,9 @@ int vmw_bo_cpu_blit(struct ttm_buffer_object *dst,
>   
>   	/* Buffer objects need to be either pinned or reserved: */
>   	if (!(dst->mem.placement & TTM_PL_FLAG_NO_EVICT))
> -		lockdep_assert_held(&dst->resv->lock.base);
> +		lockdep_assert_held(&dst->base.resv->lock.base);
>   	if (!(src->mem.placement & TTM_PL_FLAG_NO_EVICT))
> -		lockdep_assert_held(&src->resv->lock.base);
> +		lockdep_assert_held(&src->base.resv->lock.base);
>   
>   	if (dst->ttm->state == tt_unpopulated) {
>   		ret = dst->ttm->bdev->driver->ttm_tt_populate(dst->ttm, &ctx);
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> index 0d9478d2e700..4a38ab0733c4 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> @@ -342,7 +342,7 @@ void vmw_bo_pin_reserved(struct vmw_buffer_object *vbo, bool pin)
>   	uint32_t old_mem_type = bo->mem.mem_type;
>   	int ret;
>   
> -	lockdep_assert_held(&bo->resv->lock.base);
> +	lockdep_assert_held(&bo->base.resv->lock.base);
>   
>   	if (pin) {
>   		if (vbo->pin_count++ > 0)
> @@ -690,7 +690,7 @@ static int vmw_user_bo_synccpu_grab(struct vmw_user_buffer_object *user_bo,
>   		long lret;
>   
>   		lret = reservation_object_wait_timeout_rcu
> -			(bo->resv, true, true,
> +			(bo->base.resv, true, true,
>   			 nonblock ? 0 : MAX_SCHEDULE_TIMEOUT);
>   		if (!lret)
>   			return -EBUSY;
> @@ -1007,10 +1007,10 @@ void vmw_bo_fence_single(struct ttm_buffer_object *bo,
>   
>   	if (fence == NULL) {
>   		vmw_execbuf_fence_commands(NULL, dev_priv, &fence, NULL);
> -		reservation_object_add_excl_fence(bo->resv, &fence->base);
> +		reservation_object_add_excl_fence(bo->base.resv, &fence->base);
>   		dma_fence_put(&fence->base);
>   	} else
> -		reservation_object_add_excl_fence(bo->resv, &fence->base);
> +		reservation_object_add_excl_fence(bo->base.resv, &fence->base);
>   }
>   
>   
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
> index b4f6e1217c9d..e142714f132c 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
> @@ -169,7 +169,7 @@ static int vmw_cotable_unscrub(struct vmw_resource *res)
>   	} *cmd;
>   
>   	WARN_ON_ONCE(bo->mem.mem_type != VMW_PL_MOB);
> -	lockdep_assert_held(&bo->resv->lock.base);
> +	lockdep_assert_held(&bo->base.resv->lock.base);
>   
>   	cmd = VMW_FIFO_RESERVE(dev_priv, sizeof(*cmd));
>   	if (!cmd)
> @@ -311,7 +311,7 @@ static int vmw_cotable_unbind(struct vmw_resource *res,
>   		return 0;
>   
>   	WARN_ON_ONCE(bo->mem.mem_type != VMW_PL_MOB);
> -	lockdep_assert_held(&bo->resv->lock.base);
> +	lockdep_assert_held(&bo->base.resv->lock.base);
>   
>   	mutex_lock(&dev_priv->binding_mutex);
>   	if (!vcotbl->scrubbed)
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
> index 1d38a8b2f2ec..ccd7f758bf8c 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
> @@ -402,14 +402,14 @@ void vmw_resource_unreserve(struct vmw_resource *res,
>   
>   	if (switch_backup && new_backup != res->backup) {
>   		if (res->backup) {
> -			lockdep_assert_held(&res->backup->base.resv->lock.base);
> +			lockdep_assert_held(&res->backup->base.base.resv->lock.base);
>   			list_del_init(&res->mob_head);
>   			vmw_bo_unreference(&res->backup);
>   		}
>   
>   		if (new_backup) {
>   			res->backup = vmw_bo_reference(new_backup);
> -			lockdep_assert_held(&new_backup->base.resv->lock.base);
> +			lockdep_assert_held(&new_backup->base.base.resv->lock.base);
>   			list_add_tail(&res->mob_head, &new_backup->res_list);
>   		} else {
>   			res->backup = NULL;
> @@ -691,7 +691,7 @@ void vmw_resource_unbind_list(struct vmw_buffer_object *vbo)
>   		.num_shared = 0
>   	};
>   
> -	lockdep_assert_held(&vbo->base.resv->lock.base);
> +	lockdep_assert_held(&vbo->base.base.resv->lock.base);
>   	list_for_each_entry_safe(res, next, &vbo->res_list, mob_head) {
>   		if (!res->func->unbind)
>   			continue;


