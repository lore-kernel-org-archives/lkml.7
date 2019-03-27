Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65971C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C54A2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="DRV6k+EN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfC0OlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:41:23 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:57499 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfC0OlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=wpZ+x6WUWobL0QUmvQTek9He896onSI0fLiH+PG8MLk=;
        b=DRV6k+ENbRWy+1y9SsONc6yUWAzpK8UIS+LugAKQujReu3KrGzh5XU/MTfn5lyZ+WmavEeDGzYEXI6cIqkVUuOL/lWaZCcWcoGBQ+YKQfAF/IJBQSoRb1jDXAU9unNed8IoV7/Q3u7pdlqJkymcpfh3RbxOsMWTOU1bVfcOtn0QqzXwlkxsheA8BL4IJRuPLyVFYf2iJ5NcAwPkulLX1nWGiGVTATvHfJyNR40kw/VnIYMGnUypLL6zTmYqwvwp1/F4PMHHX5hhNccF9jsH/eabw+OkR64NBUdFyF37QUMu4zOstWAwAcH23ugRcGevyrvuqhHeSAoCcF8fxQgx11A==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:53420 helo=[192.168.10.179])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1h99k1-00083u-QW; Wed, 27 Mar 2019 15:41:21 +0100
Subject: Re: [PATCH v3 5/5] drm/virtio: rework resource creation workflow.
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190318113332.10900-1-kraxel@redhat.com>
 <20190318113332.10900-6-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <4561a2be-cc58-9e87-2a60-7d05a7e6f6df@tronnes.org>
Date:   Wed, 27 Mar 2019 15:41:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190318113332.10900-6-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 18.03.2019 12.33, skrev Gerd Hoffmann:
> This patch moves the virtio_gpu_cmd_create_resource() call (which
> notifies the host about the new resource created) into the
> virtio_gpu_object_create() function.  That way we can call
> virtio_gpu_cmd_create_resource() before ttm_bo_init(), so the host
> already knows about the object when ttm initializes the object and calls
> our driver callbacks.
> 
> Specifically the object is already created when the
> virtio_gpu_ttm_tt_bind() callback invokes virtio_gpu_object_attach(),
> so the extra virtio_gpu_object_attach() calls done after
> virtio_gpu_object_create() are not needed any more.
> 
> The fence support for the create ioctl becomes a bit more tricky though.
> The code moved into virtio_gpu_object_create() too.  We first submit the
> (fenced) virtio_gpu_cmd_create_resource() command, then initialize the
> ttm object, and finally attach just created object to the fence for the
> command in case it didn't finish yet.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
