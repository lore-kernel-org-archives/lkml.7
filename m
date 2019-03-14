Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1140C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E68A21019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ut1VptzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfCNKhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:37:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36735 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfCNKhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:37:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id e4so4172952edi.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 03:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=j4Sp/d45kuPj/bu/0V+pPpceqHIOF3OeyYxUYryeLEA=;
        b=Ut1VptzTQxgk5faZTZjdxL78ERFrBuRlrvAh1uiwNLcsoAGouzCIx9sigi1E5YprFF
         xoLUkHapYADAAG/h3f/E3hsG0rzOyynEcjPnwCgw3L5Y1fgIMUHtPCL1RoU2w6wKqwxa
         0VPEAYSDVwc2MvvhKtIFzbB5Y18YLyjZuTpIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=j4Sp/d45kuPj/bu/0V+pPpceqHIOF3OeyYxUYryeLEA=;
        b=PgOWQWA0VmSAKBlMWkazhSRL9Qo+cP7yuhvbkAkslsMSLM8vjGfjWe2qjqAxsE++0w
         5yH6ogDnLpACzM8baIXLxckxvn2t99FC4K7H3MXkCBSOqZdgxOkHVNhbfdA1eB97XQbK
         ZWjeyQrgrZVmH1/y0IGjeUM5ELE8BXNZKxP8FL55c+cDWqFVIfyt9MhX42YLHRyH0SOr
         9YwHa1GMu5uqEGoPClqCRz6hJ5SIdpOpm6seNlrahxyMDWaIPZkgT52QNT2/Borjer9a
         0GYV8BXBSFYlsLqhHjGUUlKOZzHdI+hvDM/DJ8/65KAsL/lH9tU7i7zSjqHu3gi2wha6
         MIcQ==
X-Gm-Message-State: APjAAAX1JRGf/1JN6LXHyU0IPB/ZBlCdH3+skwWBQmZ8gP0PP0Rxw4ny
        VRQ45QnG22vvqTRuEx2sT/X81g==
X-Google-Smtp-Source: APXvYqwuvhZkg2jbNhCgjFebmEZj6HXKP8ziVQswTD0LRslUPIDO6z5kfrCQBxoGRP52osxl9nyDcg==
X-Received: by 2002:a50:add2:: with SMTP id b18mr11156749edd.43.1552559836346;
        Thu, 14 Mar 2019 03:37:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id me7sm1005449ejb.46.2019.03.14.03.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 03:37:15 -0700 (PDT)
Date:   Thu, 14 Mar 2019 11:37:13 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RfC PATCH] fbdev: list all memory bars as conflicting apertures
Message-ID: <20190314103713.GQ2665@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190313110741.6541-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313110741.6541-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 12:07:41PM +0100, Gerd Hoffmann wrote:
> Simply add all pci memory bars to struct apertures_struct in
> remove_conflicting_pci_framebuffers().  That allows to drop
> the res_id parameter.
> 
> TODO: actually remove the res_id parameter.

I think best to do that in a cleanup patch afterwards.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/video/fbdev/core/fbmem.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index cb43a2258c51..e8223c231de2 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1879,14 +1879,28 @@ int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id, const
>  {
>  	struct apertures_struct *ap;
>  	bool primary = false;
> -	int err;
> +	int err, idx, cnt, bar;
>  
> -	ap = alloc_apertures(1);
> +	for (cnt = 0, bar = 0; bar < PCI_ROM_RESOURCE; bar++) {
> +		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
> +			continue;
> +		cnt++;
> +	}
> +
> +	ap = alloc_apertures(cnt);
>  	if (!ap)
>  		return -ENOMEM;
>  
> -	ap->ranges[0].base = pci_resource_start(pdev, res_id);
> -	ap->ranges[0].size = pci_resource_len(pdev, res_id);
> +	for (idx = 0, bar = 0; bar < PCI_ROM_RESOURCE; bar++) {
> +		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
> +			continue;
> +		ap->ranges[idx].base = pci_resource_start(pdev, bar);
> +		ap->ranges[idx].size = pci_resource_len(pdev, bar);
> +		pci_info(pdev, "%s: bar %d: 0x%lx -> 0x%lx\n", __func__, bar,
> +			 (unsigned long)pci_resource_start(pdev, bar),
> +			 (unsigned long)pci_resource_end(pdev, bar));
> +		idx++;
> +	}

lgtm. I think this is ok to merge as-is already ...

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Maybe if you want to be paranoid in the conversion add a check that we're
not skipping the pci bar requested in res_id. Then we could test this for
a kernel and remove the parameter later on.
-Daniel


>  #ifdef CONFIG_X86
>  	primary = pdev->resource[PCI_ROM_RESOURCE].flags &
>  					IORESOURCE_ROM_SHADOW;
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
