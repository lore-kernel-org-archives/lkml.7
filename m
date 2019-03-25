Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22E3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868262085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEneCk2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfCYIi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:38:27 -0400
Received: from mail-it1-f175.google.com ([209.85.166.175]:37959 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730307AbfCYIhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:37:22 -0400
Received: by mail-it1-f175.google.com with SMTP id m18so12611447ita.3;
        Mon, 25 Mar 2019 01:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=z+7nkfvtTneu9IAc9nPOkE1jK+Q1sW5bgIuB7n+sbEg=;
        b=tEneCk2DBOvDwWM5bKHnxu24dtnzYvGjnhsaBfGf6CGteGlL/5A4hXjWZBSOXwtFqV
         GYvWRr4RolPdRSiMp4dC2tOlOszLOOo1Ejiu2krkhz34fnMu/nc1n3D8SO9t95tpCi2X
         3vI+7ZQfQw0MCWs9I3MVINWmSyo8FgeCe6bFuU91/bZLlLU2EmoRy3MoAKcuMwRgtLuK
         I4XetwYdsU7u8DlIpbVln7Jd6MeYr1sE/2ztH21XyFPwsxbOLXLaHmQfqfQ23jETTjWe
         Tt/+fZh4j+Fe9jOULS+DinJN+2yz/gikdyHgCyki/dGPkcm84hbzpCBF5D4/NqUbM8z4
         DucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=z+7nkfvtTneu9IAc9nPOkE1jK+Q1sW5bgIuB7n+sbEg=;
        b=XCSFLXLDE0efZ1YLtgGBHnbvru6nG00Mz6n8kqxClLISDtyZFChMeyUxvK/cg/bgOO
         2jTXeOgw+/1qwHietq+NONaVA178ybjoPeKKxyiN/9lddXa0EqaSQwCcyw1oN0yU+3jF
         L7YB0W0gJKfH0ZNVKhREFs3o1nUoIr0bkGWw7T2+cCrgJWyIgzPk2dIvHYFdXibxJjpF
         SUBL8mA6DcmvrQpu8ePTG/SpKrAJHMNT6m0lERyBQcGSvOvAJWAxo+bOiuPjitDV/RUA
         DuEj837g0BOXabQ9uEvsM/fjECOo/4tsAAQvUQEjioz4iOTszvQSSRcn4sHdwBY4v6dJ
         nAsQ==
X-Gm-Message-State: APjAAAWvvV0iZKXevPxQAkROdX0wG6lSMj4jkt232Q9ddN21ukFZqgLi
        AznWJPzmaHTTUN2DY9htWjG98r+lBOYZTtb5J/g=
X-Google-Smtp-Source: APXvYqzLioj7ifEyiQBbdN4BUILKKXqwd6o59EWJMPuAq3GSCzjncDqBBOxqnOBfuxnNW1A1+YSQzUwY5RILgX3b4zY=
X-Received: by 2002:a02:a083:: with SMTP id g3mr3916773jah.44.1553503041292;
 Mon, 25 Mar 2019 01:37:21 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Mon, 25 Mar 2019 16:37:09 +0800
Message-ID: <CAL411-pwHq4Df-FsBu=Vzd4CR6Pzee2yR579hHeZuh8T7fBNJA@mail.gmail.com>
Subject: Why CMA allocater fails if there is a signal pending?
To:     Michal Nazarewicz <mina86@mina86.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        peter.chen@nxp.com, fugang.duan@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal & Marek,

I meet an issue that the DMA (CMA used) allocation failed if there is a user
signal, Eg Ctrl+C, it causes the USB xHCI stack fails to resume due to
dma_alloc_coherent
failed. It can be easy to reproduce if the user press Ctrl+C at
suspend/resume test.
Below is the call stack:

[  466.585755] [<ffff000008192f9c>] alloc_contig_range+0x1ac/0x3b8
[  466.585763] [<ffff00000820956c>] cma_alloc+0x10c/0x2d8
[  466.585772] [<ffff0000086de1bc>] dma_alloc_from_contiguous+0x3c/0x48
[  466.585779] [<ffff00000809bf20>] __dma_alloc+0xa8/0x248
[  466.585788] [<ffff0000089121e0>] xhci_mem_init+0x1c8/0x7f8
[  466.585794] [<ffff0000089074bc>] xhci_init+0x74/0x170
[  466.585800] [<ffff00000890a21c>] xhci_resume+0x184/0x630
[  466.585807] [<ffff0000088efec4>] cdns3_host_resume+0x34/0x68
[  466.585813] [<ffff0000088ebfd8>] cdns3_resume+0x1b0/0x2d0
[  466.585820] [<ffff0000086e3c10>] dpm_run_callback+0x50/0xd0
[  466.585825] [<ffff0000086e42a0>] device_resume+0xa0/0x288
[  466.585832] [<ffff0000086e5834>] dpm_resume+0xfc/0x218
[  466.585837] [<ffff0000086e5b5c>] dpm_resume_end+0x14/0x28
[  466.585844] [<ffff000008114630>] suspend_devices_and_enter+0x140/0x5b0
[  466.585849] [<ffff000008114d34>] pm_suspend+0x294/0x300
[  466.585857] [<ffff0000081136e4>] state_store+0x84/0x108
[  466.585865] [<ffff000008de9a2c>] kobj_attr_store+0x14/0x28
[  466.585873] [<ffff00000828cb90>] sysfs_kf_write+0x48/0x58
[  466.585879] [<ffff00000828be34>] kernfs_fop_write+0xcc/0x1c8
[  466.585886] [<ffff00000820e764>] __vfs_write+0x1c/0x118
[  466.585894] [<ffff00000820ea4c>] vfs_write+0xa4/0x1b0
[  466.585901] [<ffff00000820ecfc>] SyS_write+0x44/0xa0

I added WARN_ON at below code for above stack:
__alloc_contig_migrate_range
        while (pfn < end || !list_empty(&cc->migratepages)) {
                if (fatal_signal_pending(current)) {
                        WARN_ON(1);
                        ret = -EINTR;
                        break;
                }

The USB xHCI function can work well if I commented out above code.
Thanks.

BR,
Peter Chen
