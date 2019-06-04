Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0359DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D743220717
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfFDSHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 14:07:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32818 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDSHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 14:07:36 -0400
Received: by mail-qt1-f194.google.com with SMTP id 14so14912145qtf.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 11:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=73fBt14f3pUCJec+S60pIUDJLnv+MtJaME4OItITl6A=;
        b=jp8RT/FMpSMJK0nSUNPqKCJH5bnxjxUGfH32dHhvGajGHICHEWvCL8gEV2jFwTXL6k
         bUCIvcg8G3QPvSWdJnLuDL9WmHeCfbdPd96Q9Ld0NdtlU+pg7t0DTdNzb8LBKDipZNwN
         DfnEEROJAaoyK0ESzAymfSOsPSg4s6FMgZTxucvFTekfwydRByg33gFIsU7y9hVVErRc
         ddBjMihHaAFzGNWtmoFkFBdnFA5Rpvu9MQhi4bY+53pjr5hFt7StGBeQP0OYtiYGhyMr
         HdDXJnBflcBHmiuTW2ToheVmRxHIVxjRl4CaVlmybNwNZvc+JwDHI10Xd2YRUqMReoC5
         xjiw==
X-Gm-Message-State: APjAAAXEmYqby9jqTp2P8AIdL2TmKVdqdapyX43/JPIrdR23Ap+cIgpD
        sWbzdozJ1bFQ6rx42b5BY3fWXA==
X-Google-Smtp-Source: APXvYqyxgf1WmSBazer4xd3OsrXTZLsp3jGSP0eU0YMEKNXF2LEaE0JS9J1WAW9vN/UrYUOkS2RmQw==
X-Received: by 2002:ac8:2b10:: with SMTP id 16mr11593422qtu.351.1559671655999;
        Tue, 04 Jun 2019 11:07:35 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id q29sm342103qkq.77.2019.06.04.11.07.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 11:07:35 -0700 (PDT)
Message-ID: <47b602c0a07ad5e945ab4bc706b2bf3154ea3196.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/bios: downgrade absence of tmds table to
 info from an error
From:   Lyude Paul <lyude@redhat.com>
To:     Rhys Kidd <rhyskidd@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Tue, 04 Jun 2019 14:07:33 -0400
In-Reply-To: <20190602120727.4001-1-rhyskidd@gmail.com>
References: <20190602120727.4001-1-rhyskidd@gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Sun, 2019-06-02 at 22:07 +1000, Rhys Kidd wrote:
> Absence of a TMDS Info Table is common on Optimus setups where the NVIDIA
> gpu is not connected directly to any outputs.
> 
> Reporting an error in this scenario is too harsh. Accordingly, change the
> error message to an info message.
> 
> By default the error message also causes a boot flicker for these sytems.
> 
> Signed-off-by: Rhys Kidd <rhyskidd@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_bios.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.c
> b/drivers/gpu/drm/nouveau/nouveau_bios.c
> index 66bf2aff4a3e..bdfadc63204a 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bios.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bios.c
> @@ -935,7 +935,7 @@ static int parse_bit_tmds_tbl_entry(struct drm_device
> *dev, struct nvbios *bios,
>  
>  	tmdstableptr = ROM16(bios->data[bitentry->offset]);
>  	if (!tmdstableptr) {
> -		NV_ERROR(drm, "Pointer to TMDS table invalid\n");
> +		NV_INFO(drm, "Pointer to TMDS table not found\n");
>  		return -EINVAL;
>  	}
>  
-- 
Cheers,
	Lyude Paul

