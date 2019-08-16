Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD9BC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8482171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="oTA7ozdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfHPVfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:35:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41289 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfHPVfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:35:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id i4so7639892qtj.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 14:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=yu9YfNsqZTz0N34i23hzcYnxaf08XkUKNrfLRroWKrw=;
        b=oTA7ozdWCNCMbZ8nLFwGXnDT8Jo1HEz+iSAusd2wM04M11kuhx0dXxfcxUZF3/Czi1
         MhUIND6XZumEj9s7MS0x9cpKdAUtWIIvXumSSnAHLqZcgtK4TxS0fqraSvav29l7p4ov
         ZSyBWsbRbDGvdEX16qhqBykFh55kgGnxnErbJzWzNvdSKCzXrO2jFongeGtnIvf1frOk
         h0TUahiIkwzBDkCL6GZFvKgPZzvY05QJlliYMOU5zz24gdM6BwMPiLIw3t14nTWsucFM
         7uhywWQjp84lfwvFdC8ulHNuUUUj7iQo8k9jZ3zSPrtilMtacc7YJ5gZLub2L+sbSVAH
         Palw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=yu9YfNsqZTz0N34i23hzcYnxaf08XkUKNrfLRroWKrw=;
        b=VG3fRQwD3uwritC8OIebuAuH9l6DKBdDUPt+rCwGfXH+SbF0NZBRYhCyKs4K5ibVxe
         pRC9mgQlmgbRMVMrwOlILeszXyK+UvuVI1Z1d2lSbYaGYe+0phjxUxV/IB8jvm9ncgcg
         IPbSIRd1dh8BFyHgUtKpZx/nboUou9qISa0wpVs4xqXlWR7Ai/RTriBRQHfN5qob2aeg
         kCvPIvS6rUQ1oB8bOhO6MgN1wo46yNWyKXpVNnf32uEK2vnW93L20Ye5F8EuCnDZ90iz
         yVkud2M/cXGeI90Agkb0lqoqnHKU5WLvvEvG2l+j8YHwY3Ou28EURbiOdpt5PeI/aG6d
         IJBg==
X-Gm-Message-State: APjAAAWsme5Ch6mPKyLjajwiPOCBS4fMIBSP/RZkvuf8JgA4bJyYHyrs
        O833rAxhNzhQV/cflQuJrmDudw==
X-Google-Smtp-Source: APXvYqybJYkq7AGy9Li6/S8ZWwgY4wCymaGXyiJ487o68sDhG/Wr1rpDm4bVL0CX2rjFcF2foLyMLA==
X-Received: by 2002:ac8:5343:: with SMTP id d3mr10783829qto.50.1565991348387;
        Fri, 16 Aug 2019 14:35:48 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k49sm1410047qtc.9.2019.08.16.14.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 14:35:47 -0700 (PDT)
Message-ID: <1565991345.8572.28.camel@lca.pw>
Subject: devm_memremap_pages() triggers a kasan_add_zero_shadow() warning
From:   Qian Cai <cai@lca.pw>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com
Date:   Fri, 16 Aug 2019 17:35:45 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every so often recently, booting Intel CPU server on linux-next triggers this
warning. Trying to figure out if  the commit 7cc7867fb061
("mm/devm_memremap_pages: enable sub-section remap") is the culprit here.

# ./scripts/faddr2line vmlinux devm_memremap_pages+0x894/0xc70
devm_memremap_pages+0x894/0xc70:
devm_memremap_pages at mm/memremap.c:307

[   32.074412][  T294] WARNING: CPU: 31 PID: 294 at mm/kasan/init.c:496
kasan_add_zero_shadow.cold.2+0xc/0x39
[   32.077448][  T294] Modules linked in:
[   32.078614][  T294] CPU: 31 PID: 294 Comm: kworker/u97:1 Not tainted 5.3.0-
rc4-next-20190816+ #7
[   32.081299][  T294] Hardware name: HP ProLiant XL420 Gen9/ProLiant XL420
Gen9, BIOS U19 12/27/2015
[   32.084430][  T294] Workqueue: events_unbound async_run_entry_fn
[   32.086347][  T294] RIP: 0010:kasan_add_zero_shadow.cold.2+0xc/0x39
[   32.088303][  T294] Code: ff 48 c7 c7 b0 06 74 86 e8 0e e2 db ff 0f 0b e9 64
f7 ff ff 48 8b 45 98 48 89 45 b8 eb be 48 c7 c7 b0 06 74 86 e8 f1 e1 db ff <0f>
0b b8 ea ff ff ff e9 ad fe ff ff 48 c7 c7 b0 06 74 86 e8 d9 e1
[   32.094183][  T294] RSP: 0000:ffff8884428cf738 EFLAGS: 00010282
[   32.096030][  T294] RAX: 0000000000000024 RBX: ffff88833c1b8100 RCX:
ffffffff85730ba8
[   32.098391][  T294] RDX: 0000000000000000 RSI: dffffc0000000000 RDI:
ffffffff86964740
[   32.100802][  T294] RBP: ffff8884428cf750 R08: fffffbfff0d2c8e9 R09:
fffffbfff0d2c8e9
[   32.103229][  T294] R10: fffffbfff0d2c8e8 R11: ffffffff86964743 R12:
1ffff11088519ef3
[   32.105581][  T294] R13: ffff88833dbc8010 R14: 000000017a02c000 R15:
ffff88833c1b8128
[   32.107956][  T294] FS:  0000000000000000(0000) GS:ffff88844db80000(0000)
knlGS:0000000000000000
[   32.110585][  T294] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.112606][  T294] CR2: 0000000000000000 CR3: 0000000163012001 CR4:
00000000001606a0
[   32.112610][  T294] Call Trace:
[   32.112622][  T294]  devm_memremap_pages+0x894/0xc70
[   32.112635][  T294]  ? devm_memremap_pages_release+0x510/0x510
[   32.119291][  T294]  ? do_raw_read_unlock+0x2c/0x60
[   32.122470][  T332] namespace0.0 initialised, 400896 pages in 50ms
[   32.143086][  T294]  ? _raw_read_unlock+0x27/0x40
[   32.143094][  T294]  pmem_attach_disk+0x490/0x880
[   32.143106][  T294]  ? pmem_pagemap_kill+0x30/0x30
[   32.186834][    T1] debug: unmapping init [mem 0xffffffff9d602000-
0xffffffff9d7fffff]
[   32.195383][  T294]  ? kfree+0x106/0x400
[   32.195394][  T294]  ? kfree_const+0x17/0x30
[   32.314107][  T294]  ? kobject_put+0xfb/0x250
[   32.334569][  T294]  ? put_device+0x13/0x20
[   32.354169][  T294]  nd_pmem_probe+0x83/0xa0
[   32.374162][  T294]  nvdimm_bus_probe+0xaa/0x1f0
[   32.395901][  T294]  really_probe+0x1a2/0x630
[   32.416352][  T294]  driver_probe_device+0xcd/0x1f0
[   32.438901][  T294]  __device_attach_driver+0xed/0x150
[   32.463074][  T294]  ? driver_allows_async_probing+0x90/0x90
[   32.489538][  T294]  bus_for_each_drv+0xfa/0x160
[   32.511038][  T294]  ? bus_rescan_devices+0x20/0x20
[   32.731179][  T294]  ? do_raw_spin_unlock+0xa8/0x140
[   32.754475][  T294]  __device_attach+0x16d/0x220
[   32.775648][  T294]  ? device_bind_driver+0x80/0x80
[   32.798379][  T294]  ? __kasan_check_write+0x14/0x20
[   32.821550][  T294]  ? wait_for_completion_io+0x20/0x20
[   32.846143][  T294]  device_initial_probe+0x13/0x20
[   32.868959][  T294]  bus_probe_device+0x10f/0x130
[   32.891093][  T294]  device_add+0xadb/0xd00
[   32.910946][  T294]  ? root_device_unregister+0x40/0x40
[   32.935477][  T294]  ? nd_synchronize+0x20/0x20
[   32.956715][  T294]  nd_async_device_register+0x12/0x40
[   32.981106][  T294]  async_run_entry_fn+0x7f/0x2d0
[   33.003537][  T294]  process_one_work+0x53b/0xa70
[   33.026673][  T294]  ? pwq_dec_nr_in_flight+0x170/0x170
[   33.051060][  T294]  worker_thread+0x63/0x5b0
[   33.071431][  T294]  kthread+0x1df/0x200
[   33.089767][  T294]  ? process_one_work+0xa70/0xa70
[   33.112635][  T294]  ? kthread_park+0xc0/0xc0
[   33.132698][  T294]  ret_from_fork+0x35/0x40
[   33.155214][  T294] ---[ end trace 6917fee95b72ffee ]---
[   33.182365][    T1] debug: unmapping init [mem 0xffffffff86e7b000-
0xffffffff87031fff]
[   33.184491][  T332] pmem0: detected capacity change from 0 to 1642070016
[   33.251029][  T294] nd_pmem: probe of namespace1.0 failed with error -22
