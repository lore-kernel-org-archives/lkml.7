Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CA1C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2280F20873
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rh6FqwC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfEQHfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:35:11 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:37963 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfEQHfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:35:10 -0400
Received: by mail-pf1-f171.google.com with SMTP id b76so3265150pfb.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 00:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UcaBfi1RcfCM+fQaIDSrzEfG2lN6ZvmfEpq0ih52Kx8=;
        b=rh6FqwC9IwW9Lgd8HQTloFfd3HmbQbBGciIE04NoXYiVugCCptB70BTvcOGlA3cmfc
         5wkKrkKClNBvUTrEbzeAWTbtFzjnwNupx8zpfPOWeyztwONH7C38ga66KbzVVIYDeoBw
         ceMOnRb47ShNXLggf/EIRYQR1a9G1DeXp1YHuI2KZikwEbKntzR8cLDRBZoTtm2k81dA
         zVDRBxMcKILb9wkCeAo+6X4QRpp6VtXu8zNtODSOgSHdVz0cgC/zH6cRHL6sV1HFxQ9B
         NyelfHsgQN8lKXOUOfxPNCfqPx2PX0LFM+oR/4re3iL2sKtyZlCuiWIj8eM5dAs0OB65
         f0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UcaBfi1RcfCM+fQaIDSrzEfG2lN6ZvmfEpq0ih52Kx8=;
        b=LcMchB+1axAYrnOxYfWQaH63qSBu4c0vB85uAleVRUp0/1CFw6HpWgGTBogWjWN5xg
         PWM9ju6x0PqhWQb+PvtlWyc0XQXIZRPjkPwI+XzOk/BbJ1pBx9ZPdPrHPNy33J9cV2E0
         7n1l+9gtQWZznweY/wGe0YgcsxCRIhQCB+RHGuDdOpps2R+RG0HtL9jRxznXcaYPMdye
         Aa1ThKGU9B7yCugngr7/0Z3hu4UEKwPJxGZpBkRHQU7PYEYm7bcbBo0oGNHoKUcbSy5F
         4XYIe9q/Tm4AEiZuPTeluyJAUjJEK0vikfOrEWmoBoN7mcqHlVVIh+MrtKenDYc4JLH6
         /aXQ==
X-Gm-Message-State: APjAAAVS+AZJBkrIzEEEurQlN9KTpsNQSP6pSVjd68bkZl40JkDjvjaR
        FUGUUoN4UFfIrxvZ52QzZxE=
X-Google-Smtp-Source: APXvYqw3w87YR06oknkwpYs/AFOdVPDmALqqgvTH+nL6zMlckTE6u+9pJmZN3GBud0TKYhfAlb+tJQ==
X-Received: by 2002:a65:6494:: with SMTP id e20mr46551747pgv.117.1558078509402;
        Fri, 17 May 2019 00:35:09 -0700 (PDT)
Received: from localhost ([175.223.38.122])
        by smtp.gmail.com with ESMTPSA id c16sm5127082pfd.99.2019.05.17.00.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 00:35:08 -0700 (PDT)
Date:   Fri, 17 May 2019 16:35:05 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: drm/nouveau/core/memory: kmemleak 684 new suspected memory leaks
Message-ID: <20190517073505.GA7102@jagdpanzerIV>
References: <20190517061340.GA709@jagdpanzerIV>
 <20190517072737.GA651@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517072737.GA651@jagdpanzerIV>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/17/19 16:27), Sergey Senozhatsky wrote:
> > ... but most likely it's utterly wrong.
> > 
> 
> JFI, I removed kmemleak annotation

meeehhh....

kmemleak: 2046 new suspected memory leaks (see /sys/kernel/debug/kmemleak)

unreferenced object 0xffff95cbea4e6060 (size 16):
  comm "Web Content", pid 1191, jiffies 4294795669 (age 735.950s)
  hex dump (first 16 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000d0781ea4>] nvkm_memory_tags_get+0x8e/0x130
    [<00000000061f3c89>] gf100_vmm_valid+0x196/0x2f0
    [<00000000d79084b7>] nvkm_vmm_map+0xa8/0x360
    [<00000000e3174e33>] nvkm_vram_map+0x48/0x50
    [<00000000006adddb>] nvkm_uvmm_mthd+0x658/0x770
    [<00000000b36f3a8b>] nvkm_ioctl+0xdf/0x177
    [<0000000003acea2c>] nvif_object_mthd+0xd4/0x100
    [<0000000033824292>] nvif_vmm_map+0xeb/0x100
    [<00000000537f8629>] nouveau_mem_map+0x79/0xd0
    [<00000000c3b20b73>] nouveau_vma_new+0x19d/0x1c0
    [<00000000dc91383f>] nouveau_gem_object_open+0xd4/0x140
    [<000000005a53123b>] drm_gem_handle_create_tail+0xe3/0x160
    [<00000000e733f5a8>] nouveau_gem_ioctl_new+0x6e/0xd0
    [<00000000b5bebef5>] drm_ioctl_kernel+0x8c/0xd0
    [<000000004f28d8a6>] drm_ioctl+0x1c4/0x360
    [<00000000b08b5723>] nouveau_drm_ioctl+0x63/0xb0

	-ss
