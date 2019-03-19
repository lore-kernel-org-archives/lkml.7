Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC960C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757782133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CGTX7oMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfCSOxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:53:47 -0400
Received: from mail-eopbgr60068.outbound.protection.outlook.com ([40.107.6.68]:64327
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727798AbfCSOxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IXOwGvJYBedhi3AB3e0xXo/Lo3S89a7M2qsbdhEh2U=;
 b=CGTX7oMuIyWc5NRBKxwg8PvoM02k7Q580xivbQKBxCnyTraAKpXMAIZtrq+yErQr1UAeC8MFLoOaML8LAc10m/9IAXb2wGzPm6nQkw51Lsa8liGhxE5vPqsuRG3a+BBEL/1uJWl+kBJzjLTpucK0uwNa6bpACzh5ENT1aOeIHfk=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB5073.eurprd08.prod.outlook.com (10.255.29.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 14:53:41 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::7e:6dfb:116b:befd]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::7e:6dfb:116b:befd%2]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 14:53:41 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [RFC][PATCH 4/5 v2] dma-buf: heaps: Add CMA heap to dmabuf heapss
Thread-Topic: [RFC][PATCH 4/5 v2] dma-buf: heaps: Add CMA heap to dmabuf
 heapss
Thread-Index: AQHU05WtkobGSuQc70OySitqC31CTqYTH+gA
Date:   Tue, 19 Mar 2019 14:53:41 +0000
Message-ID: <20190319145340.nbunzlwguyotthvw@DESKTOP-E1NTVVP.localdomain>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-5-git-send-email-john.stultz@linaro.org>
In-Reply-To: <1551819273-640-5-git-send-email-john.stultz@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LNXP123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::22) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efd0f68d-0fd3-4494-2637-08d6ac7aad11
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB5073;
x-ms-traffictypediagnostic: AM0PR08MB5073:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB5073291264CBA87396BF8ADAF0400@AM0PR08MB5073.eurprd08.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(316002)(25786009)(4326008)(58126008)(26005)(186003)(71190400001)(446003)(6246003)(53936002)(71200400001)(476003)(14444005)(106356001)(97736004)(9686003)(2906002)(105586002)(54906003)(68736007)(86362001)(256004)(6512007)(6916009)(102836004)(7416002)(76176011)(229853002)(5660300002)(6116002)(99286004)(3846002)(11346002)(486006)(52116002)(6436002)(3716004)(478600001)(386003)(6506007)(6486002)(66066001)(8936002)(72206003)(305945005)(44832011)(7736002)(81156014)(8676002)(14454004)(1076003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5073;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a0Cv+Xp9oDpFa+vzlDb4VGky8h0t7IPKOoCtehBk30Al4JFadcnKuc5Ps1kQCDJdRjWmjXM52uFtEXPM0OeHaPAT5eP4YqYh6M3aY0HF+2M6nncC8XsrJT9NY6BNpEFluAX5pJNv+IQZubi4t79VkY3mv+uUwcq6rmXDacA2igqze+KDWlDECTJm76SATdIOHsMd16hBPv3D/F4YZW2fRsRc/XzJilh9uJWoh04TgCFiY21BEReQl4FysoE/ra6V2c+cYyFHmQMt7OLhoJbDXfqIKOIByukkTf1ZtDfnNL529Wkq8fx4zCwOidAHTUNe/He9k2BeNb5BqmJJUboTWRBE4uc2GcUEyLCuKkBTztUVskpvGoG5qqvMHIxuuP80CLTseZXfnAbcs2nCTqlqgQFV6jTywPkFKcdzTm/HL94=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DE7957A7D5C0094781C1733EB4355A54@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd0f68d-0fd3-4494-2637-08d6ac7aad11
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 14:53:41.1205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 12:54:32PM -0800, John Stultz wrote:
> This adds a CMA heap, which allows userspace to allocate
> a dma-buf of contiguous memory out of a CMA region.
>=20
> This code is an evolution of the Android ION implementation, so
> thanks to its original author and maintainters:
>   Benjamin Gaignard, Laura Abbott, and others!
>=20
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2:
> * Switch allocate to return dmabuf fd
> * Simplify init code
> * Checkpatch fixups
> ---
>  drivers/dma-buf/heaps/Kconfig    |   8 ++
>  drivers/dma-buf/heaps/Makefile   |   1 +
>  drivers/dma-buf/heaps/cma_heap.c | 164 +++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 173 insertions(+)
>  create mode 100644 drivers/dma-buf/heaps/cma_heap.c
>=20
> diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfi=
g
> index 2050527..a5eef06 100644
> --- a/drivers/dma-buf/heaps/Kconfig
> +++ b/drivers/dma-buf/heaps/Kconfig
> @@ -4,3 +4,11 @@ config DMABUF_HEAPS_SYSTEM
>  	help
>  	  Choose this option to enable the system dmabuf heap. The system heap
>  	  is backed by pages from the buddy allocator. If in doubt, say Y.
> +
> +config DMABUF_HEAPS_CMA
> +	bool "DMA-BUF CMA Heap"
> +	depends on DMABUF_HEAPS && DMA_CMA
> +	help
> +	  Choose this option to enable dma-buf CMA heap. This heap is backed
> +	  by the Contiguous Memory Allocator (CMA). If your system has these
> +	  regions, you should say Y here.
> diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makef=
ile
> index d1808ec..6e54cde 100644
> --- a/drivers/dma-buf/heaps/Makefile
> +++ b/drivers/dma-buf/heaps/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-y					+=3D heap-helpers.o
>  obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)	+=3D system_heap.o
> +obj-$(CONFIG_DMABUF_HEAPS_CMA)		+=3D cma_heap.o
> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma=
_heap.c
> new file mode 100644
> index 0000000..33c18ec
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/cma_heap.c
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DMABUF CMA heap exporter
> + *
> + * Copyright (C) 2012, 2019 Linaro Ltd.
> + * Author: <benjamin.gaignard@linaro.org> for ST-Ericsson.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/dma-buf.h>
> +#include <linux/dma-heap.h>
> +#include <linux/slab.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/cma.h>
> +#include <linux/scatterlist.h>
> +#include <linux/highmem.h>
> +
> +#include "heap-helpers.h"
> +
> +struct cma_heap {
> +	struct dma_heap heap;
> +	struct cma *cma;
> +};
> +
> +

extra line

> +#define to_cma_heap(x) container_of(x, struct cma_heap, heap)
> +
> +

extra line

> +static void cma_heap_free(struct heap_helper_buffer *buffer)
> +{
> +	struct cma_heap *cma_heap =3D to_cma_heap(buffer->heap_buffer.heap);
> +	struct page *pages =3D buffer->priv_virt;
> +	unsigned long nr_pages;
> +
> +	nr_pages =3D PAGE_ALIGN(buffer->heap_buffer.size) >> PAGE_SHIFT;

As you align at alloc time, I don't think the PAGE_ALIGN is really
necessary here.

> +
> +	/* release memory */
> +	cma_release(cma_heap->cma, pages, nr_pages);
> +	/* release sg table */
> +	sg_free_table(buffer->sg_table);
> +	kfree(buffer->sg_table);
> +	kfree(buffer);
> +}
> +
> +/* dmabuf heap CMA operations functions */
> +static int cma_heap_allocate(struct dma_heap *heap,
> +				unsigned long len,
> +				unsigned long flags)
> +{
> +	struct cma_heap *cma_heap =3D to_cma_heap(heap);
> +	struct heap_helper_buffer *helper_buffer;
> +	struct sg_table *table;
> +	struct page *pages;
> +	size_t size =3D PAGE_ALIGN(len);
> +	unsigned long nr_pages =3D size >> PAGE_SHIFT;
> +	unsigned long align =3D get_order(size);
> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +	struct dma_buf *dmabuf;
> +	int ret =3D -ENOMEM;
> +
> +	if (align > CONFIG_CMA_ALIGNMENT)
> +		align =3D CONFIG_CMA_ALIGNMENT;
> +
> +	helper_buffer =3D kzalloc(sizeof(*helper_buffer), GFP_KERNEL);
> +	if (!helper_buffer)
> +		return -ENOMEM;
> +
> +	INIT_HEAP_HELPER_BUFFER(helper_buffer, cma_heap_free);
> +	helper_buffer->heap_buffer.flags =3D flags;
> +	helper_buffer->heap_buffer.heap =3D heap;
> +	helper_buffer->heap_buffer.size =3D len;
> +
> +

extra line

> +	pages =3D cma_alloc(cma_heap->cma, nr_pages, align, false);
> +	if (!pages)
> +		goto free_buf;
> +
> +	if (PageHighMem(pages)) {
> +		unsigned long nr_clear_pages =3D nr_pages;
> +		struct page *page =3D pages;
> +
> +		while (nr_clear_pages > 0) {
> +			void *vaddr =3D kmap_atomic(page);
> +
> +			memset(vaddr, 0, PAGE_SIZE);
> +			kunmap_atomic(vaddr);
> +			page++;
> +			nr_clear_pages--;
> +		}
> +	} else {
> +		memset(page_address(pages), 0, size);
> +	}
> +
> +	table =3D kmalloc(sizeof(*table), GFP_KERNEL);
> +	if (!table)
> +		goto free_cma;
> +
> +	ret =3D sg_alloc_table(table, 1, GFP_KERNEL);
> +	if (ret)
> +		goto free_table;
> +
> +	sg_set_page(table->sgl, pages, size, 0);
> +
> +	/* create the dmabuf */
> +	exp_info.ops =3D &heap_helper_ops;
> +	exp_info.size =3D len;
> +	exp_info.flags =3D O_RDWR;
> +	exp_info.priv =3D &helper_buffer->heap_buffer;
> +	dmabuf =3D dma_buf_export(&exp_info);
> +	if (IS_ERR(dmabuf)) {
> +		ret =3D PTR_ERR(dmabuf);
> +		goto free_table;
> +	}
> +
> +	helper_buffer->heap_buffer.dmabuf =3D dmabuf;
> +	helper_buffer->priv_virt =3D pages;
> +	helper_buffer->sg_table =3D table;
> +
> +	ret =3D dma_buf_fd(dmabuf, O_CLOEXEC);
> +	if (ret < 0) {
> +		dma_buf_put(dmabuf);
> +		/* just return, as put will call release and that will free */
> +		return ret;
> +	}
> +
> +	return ret;
> +free_table:
> +	kfree(table);
> +free_cma:
> +	cma_release(cma_heap->cma, pages, nr_pages);
> +free_buf:
> +	kfree(helper_buffer);
> +	return ret;
> +}
> +
> +static struct dma_heap_ops cma_heap_ops =3D {
> +	.allocate =3D cma_heap_allocate,
> +};
> +
> +static int __add_cma_heaps(struct cma *cma, void *data)

nit: __add_cma_heap (not plural) seems more accurate.

Whatever you decide for the above, you can add my r-b.

Thanks,
-Brian

> +{
> +	struct cma_heap *cma_heap;
> +
> +	cma_heap =3D kzalloc(sizeof(*cma_heap), GFP_KERNEL);
> +
> +	if (!cma_heap)
> +		return -ENOMEM;
> +
> +	cma_heap->heap.name =3D cma_get_name(cma);
> +	cma_heap->heap.ops =3D &cma_heap_ops;
> +	cma_heap->cma =3D cma;
> +
> +	dma_heap_add(&cma_heap->heap);
> +
> +	return 0;
> +}
> +
> +static int add_cma_heaps(void)
> +{
> +	cma_for_each_area(__add_cma_heaps, NULL);
> +	return 0;
> +}
> +device_initcall(add_cma_heaps);
> --=20
> 2.7.4
>=20
