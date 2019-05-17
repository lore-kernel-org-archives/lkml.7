Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD80C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 06:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DD3206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 06:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3BX4dvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfEQGpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 02:45:36 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:43078 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfEQGpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 02:45:35 -0400
Received: by mail-pf1-f180.google.com with SMTP id c6so3173290pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 23:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OCGt5sorLDt5jdtak0xEKE4FwBcATBkxh3vb31cAln0=;
        b=B3BX4dvAt3wfbRi48Rd5OGamVLSZ/vdClEM7/KqeoYCrK9HT7z4ibwc3XoOhGtC8RZ
         JxEd0t9PbteNa7C0JL5n4KRibx7VIgDHEah34gUqB0x9D7tEIue6E6PAwDjigEN5L7Gw
         fN+U4cqZtnHI8nIn+Wx4amHhRARq8WPiN2CMwQHE1ld6Kt/mZGwbBt5KPrnRGoAF5oIr
         5zOMwWlxOI63bSF+lCZXIdKjQWqh50fdAuxRDQPtynaEEuc037kLVyK5nijsABrxVhy1
         C7udA2vN17dlaj3meXOhohT5cebji5PaCdP9tsLrQ1xcyeBHoqSo1sV660J+t0YFVWej
         lUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OCGt5sorLDt5jdtak0xEKE4FwBcATBkxh3vb31cAln0=;
        b=WXQZ6jRnA0SRYSpRilBWBfDcoeDwys5XNdRy9JnC4Qdf/7faBdbOHKX9MvKci9Ufg9
         txMkTDj8H+NPj9j8HM2ysVwu6lIZV/Zj+EHK/4fPYPnPfRvNKPnVfFM7f8BpzHp3XEXS
         6C1pRtS8FW1EhhVRl5GRDHULSexeV707ihT1c2py0Umo52p6wvOHGBOQQ8ZxiY6+e2Hl
         21JVqSDc90bzQogisVeM3jTWUBiGXTMjdPCsUAohlWP3o6WNKxQqhh0xKemzH8QF7TdZ
         UDjJYK0LR+0grQu114AR+0tqAVSlIMzO80eLEzvCZDjIgsisqhpKLDdvEr4n2t9KAJUi
         actA==
X-Gm-Message-State: APjAAAVOFDR0CsMIShR7ShqPhBaczIng0c/Xq2MrMb8cL3QrUi6ZMC8w
        1ftihr/2rIVXXoblSQUetgU=
X-Google-Smtp-Source: APXvYqzUJe8dCu8GqEpUM7OC8HKxKZXnZ08TMVDZ6+sAZTCmiFehuzAtJ6anieNtNnZk9Pjb59JtKg==
X-Received: by 2002:a62:2706:: with SMTP id n6mr21934249pfn.150.1558075534897;
        Thu, 16 May 2019 23:45:34 -0700 (PDT)
Received: from localhost ([175.223.38.122])
        by smtp.gmail.com with ESMTPSA id u6sm9285681pfm.10.2019.05.16.23.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 23:45:34 -0700 (PDT)
Date:   Fri, 17 May 2019 15:45:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: drm/nouveau/core/memory: kmemleak 684 new suspected memory leaks
Message-ID: <20190517064530.GA6986@jagdpanzerIV>
References: <20190517061340.GA709@jagdpanzerIV>
 <20190517063134.GA812@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517063134.GA812@jagdpanzerIV>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/17/19 15:31), Sergey Senozhatsky wrote:
> >       backtrace:
> >         [<0000000081f2894f>] nvkm_memory_tags_get+0x8e/0x130
> >         [<000000007cd7c0bc>] gf100_vmm_valid+0x196/0x2f0
> >         [<0000000070cc6d67>] nvkm_vmm_map+0xa8/0x360
> >         [<00000000ab678644>] nvkm_vram_map+0x48/0x50
> >         [<00000000d8176378>] nvkm_uvmm_mthd+0x658/0x770
> >         [<00000000463fca5a>] nvkm_ioctl+0xdf/0x177
> >         [<000000000afc4996>] nvif_object_mthd+0xd4/0x100
> >         [<000000002f7a7385>] nvif_vmm_map+0xeb/0x100
> >         [<00000000ef2537ed>] nouveau_mem_map+0x79/0xd0
> >         [<0000000014ddc0cf>] nouveau_vma_new+0x19d/0x1c0
> >         [<00000000f99888a1>] nouveau_gem_object_open+0xd4/0x140
> >         [<000000009cd25861>] drm_gem_handle_create_tail+0xe3/0x160
> >         [<00000000191784d9>] nouveau_gem_ioctl_new+0x6e/0xd0
> >         [<00000000159678df>] drm_ioctl_kernel+0x8c/0xd0
> >         [<00000000fbaa6154>] drm_ioctl+0x1c4/0x360
> >         [<000000006833fe15>] nouveau_drm_ioctl+0x63/0xb0
[..]
>   backtrace:
>     [<000000006933ed2b>] nouveau_conn_reset+0x20/0xb0
>     [<00000000572e2e30>] nouveau_connector_create+0x356/0x54c
>     [<000000008a6a13cd>] nv50_display_create+0x2fb/0x917
>     [<000000007fab0a58>] nouveau_display_create+0x3e6/0x600
>     [<000000008b8644c8>] nouveau_drm_device_init+0x149/0x6b0
>     [<000000004fd78a1f>] nouveau_drm_probe+0x263/0x2b0
>     [<00000000357716ef>] pci_device_probe+0xa3/0x110
>     [<00000000061d40e4>] really_probe+0xd3/0x240
>     [<000000000ade44b6>] driver_probe_device+0x50/0xc0
>     [<000000009cd0024c>] device_driver_attach+0x53/0x60
>     [<00000000b11ab0bb>] __driver_attach+0x4c/0xb0
>     [<0000000016d8457f>] bus_for_each_dev+0x66/0x90
>     [<00000000f2855f5e>] bus_add_driver+0x171/0x1c0
>     [<0000000021c08fc1>] driver_register+0x6c/0xaf
>     [<0000000086357843>] do_one_initcall+0x36/0x1d4
>     [<00000000a6be055a>] kernel_init_freeable+0x1bf/0x24f

And one more:

	iccsense->rail = kmalloc_array(cnt, sizeof(struct pwr_rail_t), GFP_KERNEL);

unreferenced object 0xffff94e5ccdc7600 (size 96):
  comm "swapper/0", pid 1, jiffies 4294667774 (age 913.205s)
  hex dump (first 32 bytes):
    00 00 00 cc e5 94 ff ff 00 00 00 00 00 00 00 00  ................
    04 00 f1 ff 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000242abcb3>] nvbios_iccsense_parse+0xdc/0x250
    [<00000000b5c70490>] nvkm_iccsense_oneinit+0x55/0x370
    [<0000000020e0a743>] nvkm_subdev_init+0x53/0xd0
    [<000000004d8c6ef1>] nvkm_device_init+0x10d/0x190
    [<00000000bd7a4da4>] nvkm_udevice_init+0x41/0x60
    [<0000000047effcfc>] nvkm_object_init+0x3e/0x100
    [<000000006d6bad21>] nvkm_ioctl_new+0x145/0x1e0
    [<00000000fc4e7e48>] nvkm_ioctl+0xdf/0x177
    [<000000004cdc9cf8>] nvif_object_init+0xd6/0x130
    [<000000001637584b>] nvif_device_init+0xe/0x50
    [<00000000830683d4>] nouveau_cli_init+0x17d/0x410
    [<00000000fd93c306>] nouveau_drm_device_init+0x55/0x6b0
    [<000000007bc74e3f>] nouveau_drm_probe+0x263/0x2b0
    [<000000000f94f913>] pci_device_probe+0xa3/0x110
    [<00000000f82d21be>] really_probe+0xd3/0x240
    [<00000000a8b8b02e>] driver_probe_device+0x50/0xc0

	-ss
