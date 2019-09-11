Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF45C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63B72085B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfIKPkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 11:40:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbfIKPkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:40:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2BCB53084029;
        Wed, 11 Sep 2019 15:40:37 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C6FA5C21E;
        Wed, 11 Sep 2019 15:40:35 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id A9C2118089C8;
        Wed, 11 Sep 2019 15:40:34 +0000 (UTC)
Date:   Wed, 11 Sep 2019 11:40:34 -0400 (EDT)
From:   Frediano Ziglio <fziglio@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Message-ID: <964578816.11586547.1568216434638.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190805105401.29874-1-kraxel@redhat.com>
References: <20190805105401.29874-1-kraxel@redhat.com>
Subject: Re: [PATCH v2] drm/qxl: get vga ioports
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.33.32.18, 10.4.195.2]
Thread-Topic: drm/qxl: get vga ioports
Thread-Index: d9HGlWxFC1mjLzRge3s5uc+6p+5ECg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 11 Sep 2019 15:40:37 +0000 (UTC)
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
> Reproducer: Boot kvm guest with both qxl and i915 vgpu, with qxl being
> first in pci scan order.
> 
> v2: Skip this for secondary qxl cards which don't have vga mode in the
>     first place (Frediano).
> 
> Cc: Frediano Ziglio <fziglio@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Frediano Ziglio <fziglio@redhat.com>

> ---
>  drivers/gpu/drm/qxl/qxl_drv.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index b57a37543613..fcb48ac60598 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -63,6 +63,11 @@ module_param_named(num_heads, qxl_num_crtc, int, 0400);
>  static struct drm_driver qxl_driver;
>  static struct pci_driver qxl_pci_driver;
>  
> +static bool is_vga(struct pci_dev *pdev)
> +{
> +	return pdev->class == PCI_CLASS_DISPLAY_VGA << 8;
> +}
> +
>  static int
>  qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
> @@ -87,9 +92,17 @@ qxl_pci_probe(struct pci_dev *pdev, const struct
> pci_device_id *ent)
>  	if (ret)
>  		goto disable_pci;
>  
> +	if (is_vga(pdev)) {
> +		ret = vga_get_interruptible(pdev, VGA_RSRC_LEGACY_IO);
> +		if (ret) {
> +			DRM_ERROR("can't get legacy vga ioports\n");
> +			goto disable_pci;
> +		}
> +	}
> +
>  	ret = qxl_device_init(qdev, &qxl_driver, pdev);
>  	if (ret)
> -		goto disable_pci;
> +		goto put_vga;
>  
>  	ret = qxl_modeset_init(qdev);
>  	if (ret)
> @@ -109,6 +122,9 @@ qxl_pci_probe(struct pci_dev *pdev, const struct
> pci_device_id *ent)
>  	qxl_modeset_fini(qdev);
>  unload:
>  	qxl_device_fini(qdev);
> +put_vga:
> +	if (is_vga(pdev))
> +		vga_put(pdev, VGA_RSRC_LEGACY_IO);
>  disable_pci:
>  	pci_disable_device(pdev);
>  free_dev:
> @@ -126,6 +142,8 @@ qxl_pci_remove(struct pci_dev *pdev)
>  
>  	qxl_modeset_fini(qdev);
>  	qxl_device_fini(qdev);
> +	if (is_vga(pdev))
> +		vga_put(pdev, VGA_RSRC_LEGACY_IO);
>  
>  	dev->dev_private = NULL;
>  	kfree(qdev);

Frediano
