Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33825C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 06:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EF620833
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 06:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN4XVBFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfEQGbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 02:31:39 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:46948 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfEQGbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 02:31:39 -0400
Received: by mail-pg1-f182.google.com with SMTP id t187so2783803pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 23:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tFLTgCa9Q3v9Fk3XOrXZHjMz3XZTr/fpWOYt7BtFNro=;
        b=MN4XVBFLDGRkF6cGqHB+oSilyUchIVQN4jZlbxh+pFcN4dTeSFnB91z4N6Ui5HN0z7
         csRkuj5JpwFUJLY//0tKYR1lc0iEImNxusUkTWOMmJ6xHqJQStNSRRdjhIIT2HjzwEge
         qpEBEVGHKDvzh9HIW+FfSG4r4vcqeOseHpCbsA7yzqPdBaXyYLm3TypVSvotq5vD0qJ9
         ryA+eWxA4B+eLhr9KkGsgsZ/ZUo8MqK1FGSuqfRNF5+kv+ZKfNzaadD/Uj3V0GWpdbDy
         mp0LGVPE25DNWO16m8jIc6GscynqACb15obGllpomB0CEOhX0QaB7lOTUz6KtisZzWoH
         aSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tFLTgCa9Q3v9Fk3XOrXZHjMz3XZTr/fpWOYt7BtFNro=;
        b=rEL100yllk4i0ti4/wvMU49xNz0caokY0zCabG4bBvIoim57chJc2QbT3eh20sccO2
         Lg+FAeX6jg6jlSQCcd/77BllccGp93F1Bjg1qaf6kq4CHozxJ4AdJjjx45DkJAUf8RI8
         T8me4gY0X9IbPVUaYfo//fXQRmhbP9mmDDVowxcTp997FE50rQjZXXHsS172C4fh09ZG
         PfYdGPZQhoxcZAb2fYuAzOaMSWnqLMRUubLcK3181VD4b0xSxSbp+1cqjHAji8oAZ3tS
         oUUEHkB2ag/7HdGa99eJ8qvC0sk3+n58pqedbz28eiQKEvv7ywplAksy/M/ndYqaoxCD
         iNNw==
X-Gm-Message-State: APjAAAVvBsjIYlyVM6DHj7C5dA/o4Jp6D99KQCuF6U5spl4zzB1I6onf
        vPWNKZRIUGJJGPUl2PKyxmk=
X-Google-Smtp-Source: APXvYqy0jpqTh+hQ29+o2OVxleRtYTvLKN2gJralKVGjSVErZRiY/at3t5CbSE9wnTy/CEc71m/tig==
X-Received: by 2002:aa7:8a11:: with SMTP id m17mr36588620pfa.122.1558074698675;
        Thu, 16 May 2019 23:31:38 -0700 (PDT)
Received: from localhost ([175.223.38.122])
        by smtp.gmail.com with ESMTPSA id z4sm8953277pfa.142.2019.05.16.23.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 23:31:37 -0700 (PDT)
Date:   Fri, 17 May 2019 15:31:34 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: drm/nouveau/core/memory: kmemleak 684 new suspected memory leaks
Message-ID: <20190517063134.GA812@jagdpanzerIV>
References: <20190517061340.GA709@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517061340.GA709@jagdpanzerIV>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/17/19 15:13), Sergey Senozhatsky wrote:
> 5.1.0-next-20190517
> 
> I'm looking at quite a lot of kmemleak reports coming from
> drm/nouveau/core/memory, all of which are:
> 
>     unreferenced object 0xffff8deec27c4ac0 (size 16):
>       comm "Web Content", pid 5309, jiffies 4309675011 (age 68.076s)
>       hex dump (first 16 bytes):
>         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>       backtrace:
>         [<0000000081f2894f>] nvkm_memory_tags_get+0x8e/0x130
>         [<000000007cd7c0bc>] gf100_vmm_valid+0x196/0x2f0
>         [<0000000070cc6d67>] nvkm_vmm_map+0xa8/0x360
>         [<00000000ab678644>] nvkm_vram_map+0x48/0x50
>         [<00000000d8176378>] nvkm_uvmm_mthd+0x658/0x770
>         [<00000000463fca5a>] nvkm_ioctl+0xdf/0x177
>         [<000000000afc4996>] nvif_object_mthd+0xd4/0x100
>         [<000000002f7a7385>] nvif_vmm_map+0xeb/0x100
>         [<00000000ef2537ed>] nouveau_mem_map+0x79/0xd0
>         [<0000000014ddc0cf>] nouveau_vma_new+0x19d/0x1c0
>         [<00000000f99888a1>] nouveau_gem_object_open+0xd4/0x140
>         [<000000009cd25861>] drm_gem_handle_create_tail+0xe3/0x160
>         [<00000000191784d9>] nouveau_gem_ioctl_new+0x6e/0xd0
>         [<00000000159678df>] drm_ioctl_kernel+0x8c/0xd0
>         [<00000000fbaa6154>] drm_ioctl+0x1c4/0x360
>         [<000000006833fe15>] nouveau_drm_ioctl+0x63/0xb0

Yet another one (4 leaks), but this looks more like a real leak.

unreferenced object 0xffff8f1e0cbbe840 (size 192):
  comm "swapper/0", pid 1, jiffies 4294668445 (age 742.639s)
  hex dump (first 32 bytes):
    00 90 89 0c 1e 8f ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000006933ed2b>] nouveau_conn_reset+0x20/0xb0
    [<00000000572e2e30>] nouveau_connector_create+0x356/0x54c
    [<000000008a6a13cd>] nv50_display_create+0x2fb/0x917
    [<000000007fab0a58>] nouveau_display_create+0x3e6/0x600
    [<000000008b8644c8>] nouveau_drm_device_init+0x149/0x6b0
    [<000000004fd78a1f>] nouveau_drm_probe+0x263/0x2b0
    [<00000000357716ef>] pci_device_probe+0xa3/0x110
    [<00000000061d40e4>] really_probe+0xd3/0x240
    [<000000000ade44b6>] driver_probe_device+0x50/0xc0
    [<000000009cd0024c>] device_driver_attach+0x53/0x60
    [<00000000b11ab0bb>] __driver_attach+0x4c/0xb0
    [<0000000016d8457f>] bus_for_each_dev+0x66/0x90
    [<00000000f2855f5e>] bus_add_driver+0x171/0x1c0
    [<0000000021c08fc1>] driver_register+0x6c/0xaf
    [<0000000086357843>] do_one_initcall+0x36/0x1d4
    [<00000000a6be055a>] kernel_init_freeable+0x1bf/0x24f

Seems that connector ->state is not fully destroyed.

---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 4116ee62adaf..caec1737a7de 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -251,8 +251,10 @@ nouveau_conn_reset(struct drm_connector *connector)
 	if (WARN_ON(!(asyc = kzalloc(sizeof(*asyc), GFP_KERNEL))))
 		return;
 
-	if (connector->state)
+	if (connector->state) {
 		__drm_atomic_helper_connector_destroy_state(connector->state);
+		kfree(connector->state);
+	}
 	__drm_atomic_helper_connector_reset(connector, &asyc->state);
 	asyc->dither.mode = DITHERING_MODE_AUTO;
 	asyc->dither.depth = DITHERING_DEPTH_AUTO;
-- 
2.21.0

