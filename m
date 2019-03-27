Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E04C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053532087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="sRjMs3SQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfC0OfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:35:23 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:34154 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfC0OfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=kS81Nc4ybIJrkVLSv0l2lyQUHRch0Z3fxz31cVi/kKs=;
        b=sRjMs3SQFuW9kBrRv5Ii/I3szcfmAAMuG3HtkMdfO9cIMRcGzS61pHaivXDGG7lRkkw7OYpNdHdiQn66h4znYqiMNwWazGKFGaO/ilZ27LE4miNs+VVU5lxhVtYBXdbfdrvQbp7gk8dX+OCcTGmp5KQd9RT8bfqZimX3UwNtIe+auJrltLyGg3KmeAzWjD8gMrA3pN7tg4RnCX9KiKamL245HWEBamaYkx+PT+bfT33AnV/MooU8u5ATGdCZ9J1/WTNAa64c8qv2wVKDlWZ18BqCtLZcqLl3scPFjaVxa9y1cK4JbYeXAmTk/OZ+3vdp1r4JEpy12NAAjimuwnIu2g==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:53409 helo=[192.168.10.179])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1h99eB-0005mo-NA; Wed, 27 Mar 2019 15:35:19 +0100
Subject: Re: [PATCH v3 2/5] drm/virtio: use struct to pass params to
 virtio_gpu_object_create()
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190318113332.10900-1-kraxel@redhat.com>
 <20190318113332.10900-3-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <7582e919-48a1-61cf-b697-804213776fbe@tronnes.org>
Date:   Wed, 27 Mar 2019 15:35:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190318113332.10900-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 18.03.2019 12.33, skrev Gerd Hoffmann:
> Create virtio_gpu_object_params, use that to pass object parameters to
> virtio_gpu_object_create.  This is just the first step, followup patches
> will add more parameters to the struct.  The plan is to use the struct
> for all object parameters.
> 
> Drop unused "kernel" parameter for virtio_gpu_alloc_object(), it is
> unused and always false.
> 
> Also drop "pinned" parameter.  virtio-gpu doesn't shuffle around
> objects, so effecively they all are pinned anyway.  Hardcode
> TTM_PL_FLAG_NO_EVICT so ttm knows.  Doesn't change much for the moment
> as virtio-gpu supports TTM_PL_FLAG_TT only so there is no opportunity to
> move around objects.  That'll probably change in the future though.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
