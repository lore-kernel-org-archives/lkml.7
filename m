Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF7AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DD62173E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Tz3518yn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388880AbfHVNIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:08:35 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43510 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387491AbfHVNIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:08:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id h13so7820724edq.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 06:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=02CnF/oWum6EvkbDCiosLBlondS4OglCjhZywUsed8k=;
        b=Tz3518yn5WWULcFmtdPHCt2A7d5ApDMbK6MopGvul1So7VZJrxGoVd1hyvCU0FgAig
         ye563cwx7GI5x5B4BWPNRLocDhkAh5WkywQKqm+Jr2kFLFdo6ZvrAiASzH4UPpqYcvIR
         UI/6Ne7TBMI+JfwpqwiLplhtxJXXL3xRjQvNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=02CnF/oWum6EvkbDCiosLBlondS4OglCjhZywUsed8k=;
        b=crty5LDh+tt88zhsqTYN1aQAC5lI2Q5crJi9t/3lKSczrPDnrSzyGD2SfMa8VawN/u
         3gndq5KfCE1/CqBZVZQ4L+ZUMK6LsA48TbxkICOMwn5mswJONE0jkof2KOG7MCKXQ7Qw
         NmTqblygu+IZwZltBtf88u5nj3Cr4vo2WNqKMrS1pEmU/jiawJcb/o2iP3YzErXWI9eA
         qG6CJQgjKyECwxPDozLUQLeOUFqI71Ke5q5s5vRXmzUv5+KcliEKniRhlFAUnucsSbBd
         RgRMS70U6VQYsfxM/xYLfc3nYlGT+l57zOTdvfCJ3dB44N0S9SeDm1GlU3FQ/6kIBP57
         rtLA==
X-Gm-Message-State: APjAAAUYzD+RLPBCXnFlgpG/6FQ0xDRgVErtPu9T/J3eU3aJxdgMKzJ9
        c5xhaE8erNqYTvjGkveZJ/zE0g==
X-Google-Smtp-Source: APXvYqxNoo1owvPn0PSkGZksrLAGZl5I2D27njFoLTJGpyXSzyHhr2Krz6ugzkijunzf7H69CY/wkg==
X-Received: by 2002:a17:906:e0cd:: with SMTP id gl13mr35138284ejb.52.1566479312351;
        Thu, 22 Aug 2019 06:08:32 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id w3sm4735338edu.4.2019.08.22.06.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 06:08:31 -0700 (PDT)
Date:   Thu, 22 Aug 2019 15:08:29 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] fbdev: drop res_id parameter from
 remove_conflicting_pci_framebuffers
Message-ID: <20190822130829.GV11147@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190822090645.25410-1-kraxel@redhat.com>
 <20190822090645.25410-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822090645.25410-2-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 11:06:43AM +0200, Gerd Hoffmann wrote:
> Since commit b0e999c95581 ("fbdev: list all pci memory bars as
> conflicting apertures") the parameter was used for some sanity checks
> only, to make sure we detect any issues with the new approach to just
> list all memory bars as apertures.
> 
> No issues turned up so far, so continue to cleanup:  Drop the res_id
> parameter, drop the sanity checks.  Also downgrade the logging from
> "info" level to "debug" level and update documentation.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  include/drm/drm_fb_helper.h      |  2 +-
>  include/linux/fb.h               |  2 +-
>  drivers/video/fbdev/core/fbmem.c | 17 +++++------------
>  3 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index c8a8ae2a678a..5a5f4b1d8241 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -560,7 +560,7 @@ drm_fb_helper_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
>  	 * otherwise the vga fbdev driver falls over.
>  	 */
>  #if IS_REACHABLE(CONFIG_FB)
> -	ret = remove_conflicting_pci_framebuffers(pdev, resource_id, name);
> +	ret = remove_conflicting_pci_framebuffers(pdev, name);
>  #endif
>  	if (ret == 0)
>  		ret = vga_remove_vgacon(pdev);
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 756706b666a1..41e0069eca0a 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -607,7 +607,7 @@ extern ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
>  extern int register_framebuffer(struct fb_info *fb_info);
>  extern void unregister_framebuffer(struct fb_info *fb_info);
>  extern void unlink_framebuffer(struct fb_info *fb_info);
> -extern int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id,
> +extern int remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
>  					       const char *name);
>  extern int remove_conflicting_framebuffers(struct apertures_struct *a,
>  					   const char *name, bool primary);
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index e6a1c805064f..95c32952fa8a 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1758,21 +1758,19 @@ EXPORT_SYMBOL(remove_conflicting_framebuffers);
>  /**
>   * remove_conflicting_pci_framebuffers - remove firmware-configured framebuffers for PCI devices
>   * @pdev: PCI device
> - * @res_id: index of PCI BAR configuring framebuffer memory
>   * @name: requesting driver name
>   *
>   * This function removes framebuffer devices (eg. initialized by firmware)
> - * using memory range configured for @pdev's BAR @res_id.
> + * using memory range configured for any of @pdev's memory bars.
>   *
>   * The function assumes that PCI device with shadowed ROM drives a primary
>   * display and so kicks out vga16fb.
>   */
> -int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id, const char *name)
> +int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, const char *name)
>  {
>  	struct apertures_struct *ap;
>  	bool primary = false;
>  	int err, idx, bar;
> -	bool res_id_found = false;
>  
>  	for (idx = 0, bar = 0; bar < PCI_ROM_RESOURCE; bar++) {
>  		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
> @@ -1789,16 +1787,11 @@ int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id, const
>  			continue;
>  		ap->ranges[idx].base = pci_resource_start(pdev, bar);
>  		ap->ranges[idx].size = pci_resource_len(pdev, bar);
> -		pci_info(pdev, "%s: bar %d: 0x%lx -> 0x%lx\n", __func__, bar,
> -			 (unsigned long)pci_resource_start(pdev, bar),
> -			 (unsigned long)pci_resource_end(pdev, bar));
> +		pci_dbg(pdev, "%s: bar %d: 0x%lx -> 0x%lx\n", __func__, bar,
> +			(unsigned long)pci_resource_start(pdev, bar),
> +			(unsigned long)pci_resource_end(pdev, bar));
>  		idx++;
> -		if (res_id == bar)
> -			res_id_found = true;
>  	}
> -	if (!res_id_found)
> -		pci_warn(pdev, "%s: passed res_id (%d) is not a memory bar\n",
> -			 __func__, res_id);
>  
>  #ifdef CONFIG_X86
>  	primary = pdev->resource[PCI_ROM_RESOURCE].flags &
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
