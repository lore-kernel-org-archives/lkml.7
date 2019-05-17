Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FF3C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 06:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8C620848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 06:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/Ag4ohx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfEQGNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 02:13:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36768 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfEQGNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 02:13:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so2787690pgb.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 23:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=kUjckoiL4hcazmpiRVYWRXZ1+byR8V6/hc2uWj9Ysig=;
        b=t/Ag4ohx5G5C8vnn5fyJXM4y0k89Op7ZWxUgsxV1Xd145aByUYxDEcZte/PTwB+pun
         ggfpKQTMWuvkQT+SdpuaDMqVOrX7JHIqa2JN+4SF21hFgFsa0yEsNpbj6g3lb9AevSVv
         jxOfHa1kwBVZv+IHcrbdJ3QtKzAKVUVgHqtoZdIWXlvfFuMoS4rEICsLqzX57xvmDTcG
         L5V+7EEKbEfXpxT+yzZMFHOcS4dbYlwuoxgH185T92qnWXRBdPDs/XWxXXBXXYpTfWSV
         iaBPKXUlVcSqPdsAl8E/dgUMRpZRV1oEqdlhY/IWloYEBRJ7z3aScnzW5ALwCiWpHRyK
         b3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kUjckoiL4hcazmpiRVYWRXZ1+byR8V6/hc2uWj9Ysig=;
        b=VJAVXlW63BE6Qhwbs35QqmoU/521frrxug7E6S9a2gK1RKmo6Ogm7WdBOm94Sm88i7
         /tVOTScOIWejbjgPyoAgPV89Ah5RJyXFAify4NIKiAbbnpg0JTsIpml95/JTtnx2aPhZ
         m3u9U1L9VE2eQedOs/zY4gZ+LzDbCAe0CI8h7fcjoFB7AQ8jA4DT0Q4bVGJU8xzWr2S3
         p2R1c+h/v/oi53BOL0+zSPehlmLJIFdXDqApMisXEl6XszjGoHWo9d+l2+MBu+AIBQdB
         uEkz3OpYiwhv3MCVWFuRPnwPKME5KYAW2FctdAfyKG5cN2YGRZwPITlFt6sjsEBoZwp+
         sMew==
X-Gm-Message-State: APjAAAXEfxr0d4gm8kTdx0rQHIyELHOffxu196Fd2bu5lc5CvO4NqcHY
        CEzllS6tS7U1utCHJhzd8aw=
X-Google-Smtp-Source: APXvYqxnnFmrplpftkM7cxoI/lh030At8OG7CfCN9dr3kjxbHY3VuCVSsn2e2V4tGmNN0DpfBDcmSA==
X-Received: by 2002:a62:640e:: with SMTP id y14mr39509744pfb.109.1558073624914;
        Thu, 16 May 2019 23:13:44 -0700 (PDT)
Received: from localhost ([175.223.38.122])
        by smtp.gmail.com with ESMTPSA id s24sm9246940pfe.57.2019.05.16.23.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 23:13:44 -0700 (PDT)
Date:   Fri, 17 May 2019 15:13:40 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: drm/nouveau/core/memory: kmemleak 684 new suspected memory leaks
Message-ID: <20190517061340.GA709@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

5.1.0-next-20190517

I'm looking at quite a lot of kmemleak reports coming from
drm/nouveau/core/memory, all of which are:

    unreferenced object 0xffff8deec27c4ac0 (size 16):
      comm "Web Content", pid 5309, jiffies 4309675011 (age 68.076s)
      hex dump (first 16 bytes):
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      backtrace:
        [<0000000081f2894f>] nvkm_memory_tags_get+0x8e/0x130
        [<000000007cd7c0bc>] gf100_vmm_valid+0x196/0x2f0
        [<0000000070cc6d67>] nvkm_vmm_map+0xa8/0x360
        [<00000000ab678644>] nvkm_vram_map+0x48/0x50
        [<00000000d8176378>] nvkm_uvmm_mthd+0x658/0x770
        [<00000000463fca5a>] nvkm_ioctl+0xdf/0x177
        [<000000000afc4996>] nvif_object_mthd+0xd4/0x100
        [<000000002f7a7385>] nvif_vmm_map+0xeb/0x100
        [<00000000ef2537ed>] nouveau_mem_map+0x79/0xd0
        [<0000000014ddc0cf>] nouveau_vma_new+0x19d/0x1c0
        [<00000000f99888a1>] nouveau_gem_object_open+0xd4/0x140
        [<000000009cd25861>] drm_gem_handle_create_tail+0xe3/0x160
        [<00000000191784d9>] nouveau_gem_ioctl_new+0x6e/0xd0
        [<00000000159678df>] drm_ioctl_kernel+0x8c/0xd0
        [<00000000fbaa6154>] drm_ioctl+0x1c4/0x360
        [<000000006833fe15>] nouveau_drm_ioctl+0x63/0xb0

Wondering if those are real leaks or just false positives.

For now I marked `tags' as kmemleak_not_leak(); but most
likely it's utterly wrong.

Any thoughts?

---
 drivers/gpu/drm/nouveau/nvkm/core/memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/core/memory.c b/drivers/gpu/drm/nouveau/nvkm/core/memory.c
index e85a08ecd9da..cd46f54c5c32 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/memory.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/memory.c
@@ -25,6 +25,7 @@
 #include <core/mm.h>
 #include <subdev/fb.h>
 #include <subdev/instmem.h>
+#include <linux/kmemleak.h>
 
 void
 nvkm_memory_tags_put(struct nvkm_memory *memory, struct nvkm_device *device,
@@ -92,6 +93,7 @@ nvkm_memory_tags_get(struct nvkm_memory *memory, struct nvkm_device *device,
 
 	refcount_set(&tags->refcount, 1);
 	mutex_unlock(&fb->subdev.mutex);
+	kmemleak_not_leak(tags);
 	*ptags = tags;
 	return 0;
 }
-- 
2.21.0

