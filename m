Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22717C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC39A20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="m2SLpGQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfFGLZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 07:25:01 -0400
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:52025
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727754AbfFGLZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umDhZcjoSsMJDkAeX7yQ5LmgCgk+OoyOANwb0UD4iBs=;
 b=m2SLpGQuIRK870QNc3yKtzY9ooZ7q42Pm6EzzZq6iCPY/vQPiQG0GfFPNNOJNoc/Tf81mffWGSA7icD2ADOzISutYZm3baR05AW6RHnYLvEC26K+EXA3P7DcTvG6fJB7juge+KXIvPkBHDRJxjoKLLCny5I5E6jjT3zk6XBr/iM=
Received: from AM6PR08MB4104.eurprd08.prod.outlook.com (20.179.2.31) by
 AM6PR08MB4835.eurprd08.prod.outlook.com (10.255.98.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Fri, 7 Jun 2019 11:24:55 +0000
Received: from AM6PR08MB4104.eurprd08.prod.outlook.com
 ([fe80::2dd7:c53e:ed14:2be4]) by AM6PR08MB4104.eurprd08.prod.outlook.com
 ([fe80::2dd7:c53e:ed14:2be4%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 11:24:55 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v5 3/5] dma-buf: heaps: Add system heap to dmabuf heaps
Thread-Topic: [PATCH v5 3/5] dma-buf: heaps: Add system heap to dmabuf heaps
Thread-Index: AQHVHN4lESVUTjaFyUes09QEE6C8/KaQDYUA
Date:   Fri, 7 Jun 2019 11:24:55 +0000
Message-ID: <20190607112454.huov3jzuoqvnbkem@DESKTOP-E1NTVVP.localdomain>
References: <20190607030719.77286-1-john.stultz@linaro.org>
 <20190607030719.77286-4-john.stultz@linaro.org>
In-Reply-To: <20190607030719.77286-4-john.stultz@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::15) To AM6PR08MB4104.eurprd08.prod.outlook.com
 (2603:10a6:20b:a9::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12493d2c-751c-4f0d-8e7a-08d6eb3ac40d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR08MB4835;
x-ms-traffictypediagnostic: AM6PR08MB4835:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM6PR08MB483504E0EC39ED3A01EB7816F0100@AM6PR08MB4835.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(366004)(346002)(396003)(199004)(189003)(316002)(66476007)(81166006)(81156014)(66556008)(8676002)(66446008)(58126008)(64756008)(229853002)(99286004)(73956011)(66946007)(476003)(8936002)(54906003)(6436002)(14444005)(256004)(6486002)(6916009)(66066001)(4326008)(72206003)(2906002)(446003)(9686003)(3846002)(6116002)(25786009)(6512007)(486006)(86362001)(7416002)(52116002)(6246003)(102836004)(305945005)(7736002)(71200400001)(71190400001)(14454004)(26005)(1076003)(44832011)(478600001)(5660300002)(11346002)(186003)(386003)(68736007)(76176011)(6506007)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4835;H:AM6PR08MB4104.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HGjUbza+LjFzlffz1cpuxOZ/B+ctTsqHHPxeeZMMzGnyK0dAi1GPLEHFwBNEp3LksjRzS7WUnZVeBThritVhdOh5ZHeWHbSJqIIiwly+1Ziu4oOhIeT9cCyeyrbTcauDgWcdlV2aqYaUMSssgjLA3xaemGJ8OC91nMsjrMhPuYethKi6B05QGaDl+wia2p0vxtMr5AivqQ9ElVMoJxm3g+twgAgEmz2o7XItMqTJuru+/dL91cA/F4m71g9lt/bnjw0HTrypVtO2ZnnZG4WH8XUaSFPJhpIRfoFm8bnb8sHQvgRGJwubaarT1jh2C3Q/dq7hLswgX18XjCQXI9WvCobR/XuPJg83CqeQIfdp20YYXNHELgiFSwD9WFMSkJ61AayPBfLXZIKUg/rbiWHPZoEfLSeQml0vdG5SL50rjv0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF449923FEAC9944AA1A2ABABA2E2828@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12493d2c-751c-4f0d-8e7a-08d6eb3ac40d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 11:24:55.1415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Brian.Starkey@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4835
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 07, 2019 at 03:07:17AM +0000, John Stultz wrote:
> This patch adds system heap to the dma-buf heaps framework.
>=20
> This allows applications to get a page-allocator backed dma-buf
> for non-contiguous memory.
>=20
> This code is an evolution of the Android ION implementation, so
> thanks to its original authors and maintainters:
>   Rebecca Schultz Zavin, Colin Cross, Laura Abbott, and others!
>=20
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Pratik Patel <pratikp@codeaurora.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
> Cc: Sudipto Paul <Sudipto.Paul@arm.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: dri-devel@lists.freedesktop.org
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Change-Id: I4dc5ff54ccb1f7ca3ac8675661114ca33813654b
> ---
> v2:
> * Switch allocate to return dmabuf fd
> * Simplify init code
> * Checkpatch fixups
> * Droped dead system-contig code
> v3:
> * Whitespace fixups from Benjamin
> * Make sure we're zeroing the allocated pages (from Liam)
> * Use PAGE_ALIGN() consistently (suggested by Brian)
> * Fold in new registration style from Andrew
> * Avoid needless dynamic allocation of sys_heap (suggested by
>   Christoph)
> * Minor cleanups
> * Folded in changes from Andrew to use simplified page list
>   from the heap helpers
> v4:
> * Optimization to allocate pages in chunks, similar to old
>   pagepool code
> * Use fd_flags when creating dmabuf fd (Suggested by Benjamin)
> v5:
> * Back out large order page allocations (was leaking memory,
>   as the page array didn't properly track order size)
> ---
>  drivers/dma-buf/Kconfig             |   2 +
>  drivers/dma-buf/heaps/Kconfig       |   6 ++
>  drivers/dma-buf/heaps/Makefile      |   1 +
>  drivers/dma-buf/heaps/system_heap.c | 123 ++++++++++++++++++++++++++++
>  4 files changed, 132 insertions(+)
>  create mode 100644 drivers/dma-buf/heaps/Kconfig
>  create mode 100644 drivers/dma-buf/heaps/system_heap.c
>=20
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index 9b93f86f597c..434cfe646dad 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -47,4 +47,6 @@ menuconfig DMABUF_HEAPS
>  	  this allows userspace to allocate dma-bufs that can be shared between
>  	  drivers.
> =20
> +source "drivers/dma-buf/heaps/Kconfig"
> +
>  endmenu
> diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfi=
g
> new file mode 100644
> index 000000000000..205052744169
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/Kconfig
> @@ -0,0 +1,6 @@
> +config DMABUF_HEAPS_SYSTEM
> +	bool "DMA-BUF System Heap"
> +	depends on DMABUF_HEAPS
> +	help
> +	  Choose this option to enable the system dmabuf heap. The system heap
> +	  is backed by pages from the buddy allocator. If in doubt, say Y.
> diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makef=
ile
> index de49898112db..d1808eca2581 100644
> --- a/drivers/dma-buf/heaps/Makefile
> +++ b/drivers/dma-buf/heaps/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-y					+=3D heap-helpers.o
> +obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)	+=3D system_heap.o
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/=
system_heap.c
> new file mode 100644
> index 000000000000..863834499ce1
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DMABUF System heap exporter
> + *
> + * Copyright (C) 2011 Google, Inc.
> + * Copyright (C) 2019 Linaro Ltd.
> + */
> +
> +#include <asm/page.h>
> +#include <linux/dma-buf.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dma-heap.h>
> +#include <linux/err.h>
> +#include <linux/highmem.h>
> +#include <linux/mm.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +
> +#include "heap-helpers.h"
> +
> +struct system_heap {
> +	struct dma_heap *heap;
> +} sys_heap;
> +
> +

extra newline. Otherwise, LGTM:

Reviewed-by: Brian Starkey <brian.starkey@arm.com>

