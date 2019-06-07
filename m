Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E660DC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6252089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="stPImdyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfFGMiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:38:23 -0400
Received: from mail-eopbgr130087.outbound.protection.outlook.com ([40.107.13.87]:49985
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728750AbfFGMiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFJyKt2iAr+vp7FNvzO+KKuULziVQsmbnxgUWvByZBQ=;
 b=stPImdyi/n2ZQ/MBXWzHJ1A3U7j3fGQrwf9MXVmVqP9wxhUZTxirZBqfcJuEGuqE33Rwwds3NgJgHusxvnHKI/ZMLE3rZajtQpAspUFSVbCRb36ILD/2z5JrlRaN+W+/yPVJLQDFtS+HGbildPNkw3CLDaxmk0Cvx60Brn51ti8=
Received: from AM6PR08MB4104.eurprd08.prod.outlook.com (20.179.2.31) by
 AM6PR08MB2949.eurprd08.prod.outlook.com (52.135.167.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Fri, 7 Jun 2019 12:38:13 +0000
Received: from AM6PR08MB4104.eurprd08.prod.outlook.com
 ([fe80::2dd7:c53e:ed14:2be4]) by AM6PR08MB4104.eurprd08.prod.outlook.com
 ([fe80::2dd7:c53e:ed14:2be4%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 12:38:13 +0000
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
Subject: Re: [PATCH v5 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
Thread-Topic: [PATCH v5 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
Thread-Index: AQHVHN4mrA3hwyi0E0SaKyXEfxDpkKaQIf+A
Date:   Fri, 7 Jun 2019 12:38:13 +0000
Message-ID: <20190607123811.mv6lvvtuwzfvt6hb@DESKTOP-E1NTVVP.localdomain>
References: <20190607030719.77286-1-john.stultz@linaro.org>
 <20190607030719.77286-5-john.stultz@linaro.org>
In-Reply-To: <20190607030719.77286-5-john.stultz@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::22) To AM6PR08MB4104.eurprd08.prod.outlook.com
 (2603:10a6:20b:a9::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c50463b1-fc8a-461d-06c0-08d6eb450169
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR08MB2949;
x-ms-traffictypediagnostic: AM6PR08MB2949:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM6PR08MB2949BC303D488663615AACB7F0100@AM6PR08MB2949.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(86362001)(256004)(1076003)(14444005)(229853002)(6486002)(9686003)(6512007)(6116002)(3846002)(53936002)(6246003)(6916009)(5660300002)(4326008)(2906002)(25786009)(446003)(44832011)(316002)(71200400001)(71190400001)(11346002)(478600001)(476003)(54906003)(8936002)(66476007)(58126008)(66446008)(64756008)(26005)(66556008)(66066001)(73956011)(66946007)(68736007)(7736002)(102836004)(386003)(6506007)(99286004)(81166006)(81156014)(8676002)(305945005)(186003)(6436002)(14454004)(486006)(76176011)(52116002)(7416002)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB2949;H:AM6PR08MB4104.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8A8IwRneLD48ZSB/7PvgNMLO8nxYgy0gNkeuQWJUqVAHkLvTJlRndSdgJSGfaQpy7YVYY1eAmSgXf9NDmBQvlo8jCt6RH2y3JWmj7gcDVueFpiUMhbDzh08tpTOLxZGhUr3vD0m2pCQdo9JSqrGtcR7L/k+RO8e+ZpD4wirSCemGc+S0/2t6D0E1E8xWQY7QNTDp46ta8dluqJJ7puoYEXmkelcJHOnfTnl0YpNYfMpnhPS30loTV91IydXVg3ZMayfEwDIJnGfd+7jMiD3P3eTTPnkbfMJAOqZcelotgr0YWHARksBF8/3SOUCWKmggz6gZKPBS01PMsGr0pzBBD55gpLGdviV4KPmsEZwCr1x8xONa6zp+Xdxf4oYSw2f/wpGSO7bVf5Me2mlhKLMMW7Y8iZIsgVMWHATAw+5ZZr4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A7CE21FB5B7BAB42BAF376E322837DF7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50463b1-fc8a-461d-06c0-08d6eb450169
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 12:38:13.1333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Brian.Starkey@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2949
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 07, 2019 at 03:07:18AM +0000, John Stultz wrote:
> This adds a CMA heap, which allows userspace to allocate
> a dma-buf of contiguous memory out of a CMA region.
>=20
> This code is an evolution of the Android ION implementation, so
> thanks to its original author and maintainters:
>   Benjamin Gaignard, Laura Abbott, and others!
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
> Change-Id: Ic2b0c5dfc0dbaff5245bd1c50170c64b06c73051
> ---
> v2:
> * Switch allocate to return dmabuf fd
> * Simplify init code
> * Checkpatch fixups
> v3:
> * Switch to inline function for to_cma_heap()
> * Minor cleanups suggested by Brian
> * Fold in new registration style from Andrew
> * Folded in changes from Andrew to use simplified page list
>   from the heap helpers
> v4:
> * Use the fd_flags when creating dmabuf fd (Suggested by
>   Benjamin)
> * Use precalculated pagecount (Suggested by Andrew)
> ---
>  drivers/dma-buf/heaps/Kconfig    |   8 ++
>  drivers/dma-buf/heaps/Makefile   |   1 +
>  drivers/dma-buf/heaps/cma_heap.c | 169 +++++++++++++++++++++++++++++++
>  3 files changed, 178 insertions(+)
>  create mode 100644 drivers/dma-buf/heaps/cma_heap.c
>=20
> diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfi=
g
> index 205052744169..a5eef06c4226 100644
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
> index d1808eca2581..6e54cdec3da0 100644
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
> index 000000000000..3d0ffbbd0a34
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/cma_heap.c
> @@ -0,0 +1,169 @@
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
> +	struct dma_heap *heap;
> +	struct cma *cma;
> +};
> +
> +static void cma_heap_free(struct heap_helper_buffer *buffer)
> +{
> +	struct cma_heap *cma_heap =3D dma_heap_get_data(buffer->heap_buffer.hea=
p);
> +	unsigned long nr_pages =3D buffer->pagecount;
> +	struct page *pages =3D buffer->priv_virt;
> +
> +	/* free page list */
> +	kfree(buffer->pages);
> +	/* release memory */
> +	cma_release(cma_heap->cma, pages, nr_pages);
> +	kfree(buffer);

Sorry for not managing to review the past couple of revisions where
the helper buffer pages were added, but:

I'm probably a bit dim; but I got a bit confused about "pages" vs
"buffer->pages" here and in the allocate function.

Could I suggest a different name for the CMA allocation? Even simply
"cma_pages" would be clearer IMO.

Otherwise LGTM:

Reviewed-by: Brian Starkey <brian.starkey@arm.com>

> +}
> +
> +/* dmabuf heap CMA operations functions */
> +static int cma_heap_allocate(struct dma_heap *heap,
> +				unsigned long len,
> +				unsigned long fd_flags,
> +				unsigned long heap_flags)
> +{
> +	struct cma_heap *cma_heap =3D dma_heap_get_data(heap);
> +	struct heap_helper_buffer *helper_buffer;
> +	struct page *pages;
> +	size_t size =3D PAGE_ALIGN(len);
> +	unsigned long nr_pages =3D size >> PAGE_SHIFT;
> +	unsigned long align =3D get_order(size);
> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +	struct dma_buf *dmabuf;
> +	int ret =3D -ENOMEM;
> +	pgoff_t pg;
> +
> +	if (align > CONFIG_CMA_ALIGNMENT)
> +		align =3D CONFIG_CMA_ALIGNMENT;
> +
> +	helper_buffer =3D kzalloc(sizeof(*helper_buffer), GFP_KERNEL);
> +	if (!helper_buffer)
> +		return -ENOMEM;
> +
> +	INIT_HEAP_HELPER_BUFFER(helper_buffer, cma_heap_free);
> +	helper_buffer->heap_buffer.flags =3D heap_flags;
> +	helper_buffer->heap_buffer.heap =3D heap;
> +	helper_buffer->heap_buffer.size =3D len;
> +
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
> +	helper_buffer->pagecount =3D nr_pages;
> +	helper_buffer->pages =3D kmalloc_array(helper_buffer->pagecount,
> +					     sizeof(*helper_buffer->pages),
> +					     GFP_KERNEL);
> +	if (!helper_buffer->pages) {
> +		ret =3D -ENOMEM;
> +		goto free_cma;
> +	}
> +
> +	for (pg =3D 0; pg < helper_buffer->pagecount; pg++) {
> +		helper_buffer->pages[pg] =3D &pages[pg];
> +		if (!helper_buffer->pages[pg])
> +			goto free_pages;
> +	}
> +
> +	/* create the dmabuf */
> +	exp_info.ops =3D &heap_helper_ops;
> +	exp_info.size =3D len;
> +	exp_info.flags =3D fd_flags;
> +	exp_info.priv =3D &helper_buffer->heap_buffer;
> +	dmabuf =3D dma_buf_export(&exp_info);
> +	if (IS_ERR(dmabuf)) {
> +		ret =3D PTR_ERR(dmabuf);
> +		goto free_pages;
> +	}
> +
> +	helper_buffer->heap_buffer.dmabuf =3D dmabuf;
> +	helper_buffer->priv_virt =3D pages;
> +
> +	ret =3D dma_buf_fd(dmabuf, fd_flags);
> +	if (ret < 0) {
> +		dma_buf_put(dmabuf);
> +		/* just return, as put will call release and that will free */
> +		return ret;
> +	}
> +
> +	return ret;
> +
> +free_pages:
> +	kfree(helper_buffer->pages);
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
> +static int __add_cma_heap(struct cma *cma, void *data)
> +{
> +	struct cma_heap *cma_heap;
> +	struct dma_heap_export_info exp_info;
> +
> +	cma_heap =3D kzalloc(sizeof(*cma_heap), GFP_KERNEL);
> +	if (!cma_heap)
> +		return -ENOMEM;
> +	cma_heap->cma =3D cma;
> +
> +	exp_info.name =3D cma_get_name(cma);
> +	exp_info.ops =3D &cma_heap_ops;
> +	exp_info.priv =3D cma_heap;
> +
> +	cma_heap->heap =3D dma_heap_add(&exp_info);
> +	if (IS_ERR(cma_heap->heap)) {
> +		int ret =3D PTR_ERR(cma_heap->heap);
> +
> +		kfree(cma_heap);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int add_cma_heaps(void)
> +{
> +	cma_for_each_area(__add_cma_heap, NULL);
> +	return 0;
> +}
> +device_initcall(add_cma_heaps);
> --=20
> 2.17.1
>=20
