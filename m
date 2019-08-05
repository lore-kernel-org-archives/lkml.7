Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9882C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8325F20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfHEJSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:18:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfHEJSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:18:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7ECE881DEC;
        Mon,  5 Aug 2019 09:18:15 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65BF560605;
        Mon,  5 Aug 2019 09:18:15 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 45E964E589;
        Mon,  5 Aug 2019 09:18:15 +0000 (UTC)
Date:   Mon, 5 Aug 2019 05:18:13 -0400 (EDT)
From:   Frediano Ziglio <fziglio@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
Message-ID: <1869747233.4556840.1564996693878.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190805085355.12527-1-kraxel@redhat.com>
References: <20190805085355.12527-1-kraxel@redhat.com>
Subject: Re: [Spice-devel] [PATCH] drm/qxl: get vga ioports
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.33.32.18, 10.4.195.2]
Thread-Topic: drm/qxl: get vga ioports
Thread-Index: B+Egf2oktmkF6AuofBNvusT7r7gH4A==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 05 Aug 2019 09:18:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> qxl has two modes: "native" (used by the drm driver) and "vga" (vga
> compatibility mode, typically used for boot display and firmware
> framebuffers).
> 
> Accessing any vga ioport will switch the qxl device into vga mode.
> The qxl driver never does that, but other drivers accessing vga ports
> can trigger that too and therefore disturb qxl operation.  So aquire
> the legacy vga ioports from vgaarb to avoid that.
> 
> Reporducer: Boot kvm guest with both qxl and i915 vgpu, with qxl being

typo: "Reporducer"

> first in pci scan order.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_drv.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index b57a37543613..8a2e86adc423 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -87,9 +87,15 @@ qxl_pci_probe(struct pci_dev *pdev, const struct
> pci_device_id *ent)
>  	if (ret)
>  		goto disable_pci;
>  
> +	ret = vga_get_interruptible(pdev, VGA_RSRC_LEGACY_IO);
> +	if (ret) {
> +		DRM_ERROR("can't get legacy vga ports\n");
> +		goto put_vga;

I suppose that if this fails it's secondary so should continue.
What happen configuring 2 QXL devices?
Only a card should provide VGA registers in the system so
if any other card provide them QXL won't work.

> +	}
> +
>  	ret = qxl_device_init(qdev, &qxl_driver, pdev);
>  	if (ret)
> -		goto disable_pci;
> +		goto put_vga;
>  
>  	ret = qxl_modeset_init(qdev);
>  	if (ret)
> @@ -109,6 +115,8 @@ qxl_pci_probe(struct pci_dev *pdev, const struct
> pci_device_id *ent)
>  	qxl_modeset_fini(qdev);
>  unload:
>  	qxl_device_fini(qdev);
> +put_vga:
> +	vga_put(pdev, VGA_RSRC_LEGACY_IO);

What happen if you didn't get the I/O? Maybe it's safe to
just call vga_put and avoid adding an additional label here?

>  disable_pci:
>  	pci_disable_device(pdev);
>  free_dev:
> @@ -126,6 +134,7 @@ qxl_pci_remove(struct pci_dev *pdev)
>  
>  	qxl_modeset_fini(qdev);
>  	qxl_device_fini(qdev);
> +	vga_put(pdev, VGA_RSRC_LEGACY_IO);
>  
>  	dev->dev_private = NULL;
>  	kfree(qdev);

Frediano
