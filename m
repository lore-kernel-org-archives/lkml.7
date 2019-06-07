Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353DEC468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECAD5212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ZP+Ui8e5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfFGK6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 06:58:09 -0400
Received: from mail-eopbgr40087.outbound.protection.outlook.com ([40.107.4.87]:6603
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727935AbfFGK6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 06:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELNvcvhfTanP7MJAT57DXxmoZERBXbKcq927GKdYl2w=;
 b=ZP+Ui8e5TVq31NFF5QMeqRRp6QUwJ8fnYg5Wqt01YSWLSg0kpBAwrmI/7to4mwpI50ZNmmmAHsIzN75YqWJK2xNQEckj4L9Wjf/TsnENp7RCc0+FkY6V6gU3CodnjqPTHXHfK8i+Yq1iAteF2eAnHbd7XpVUbk47dmAI/8FX67c=
Received: from AM6PR08MB4104.eurprd08.prod.outlook.com (20.179.2.31) by
 AM6PR08MB3958.eurprd08.prod.outlook.com (20.179.1.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 10:57:57 +0000
Received: from AM6PR08MB4104.eurprd08.prod.outlook.com
 ([fe80::2dd7:c53e:ed14:2be4]) by AM6PR08MB4104.eurprd08.prod.outlook.com
 ([fe80::2dd7:c53e:ed14:2be4%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 10:57:57 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v5 1/5] dma-buf: Add dma-buf heaps framework
Thread-Topic: [PATCH v5 1/5] dma-buf: Add dma-buf heaps framework
Thread-Index: AQHVHN4lU1U1V3GCJkO+vNsokC2hpaaQBfwA
Date:   Fri, 7 Jun 2019 10:57:57 +0000
Message-ID: <20190607105756.cuvxlwzi7mu7aglh@DESKTOP-E1NTVVP.localdomain>
References: <20190607030719.77286-1-john.stultz@linaro.org>
 <20190607030719.77286-2-john.stultz@linaro.org>
In-Reply-To: <20190607030719.77286-2-john.stultz@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LNXP123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::31) To AM6PR08MB4104.eurprd08.prod.outlook.com
 (2603:10a6:20b:a9::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75d0c333-cfc6-4828-6eb4-08d6eb36fff8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR08MB3958;
x-ms-traffictypediagnostic: AM6PR08MB3958:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM6PR08MB3958EE6E8E02F58A827C011DF0100@AM6PR08MB3958.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(39850400004)(346002)(199004)(189003)(73956011)(229853002)(7416002)(25786009)(6506007)(30864003)(66946007)(76176011)(386003)(66476007)(66556008)(64756008)(66446008)(1076003)(53946003)(6436002)(6486002)(86362001)(6512007)(9686003)(102836004)(2906002)(6116002)(3846002)(71200400001)(71190400001)(6916009)(68736007)(7736002)(256004)(14444005)(305945005)(99286004)(52116002)(8936002)(8676002)(81156014)(58126008)(54906003)(5660300002)(44832011)(486006)(53936002)(72206003)(14454004)(81166006)(4326008)(316002)(66066001)(6246003)(11346002)(446003)(186003)(26005)(478600001)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3958;H:AM6PR08MB4104.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1ZfSX1sh1wLnElpYz7aOxNyyBP9vC1r9ZugBNufr3NCH0/k5nINWOshnbgI2yWqR3vRGvLssx6zsgUNgL1l+AL63QRAysAhP/KqnPR/RK3Ypp26xiYpAAa8iUXQD1NZgARjh+zmk53FNqBAr2ZPZXG9MBApFnKNnmojX3Wm+eihhlYkAnxiBEPAZIfVH2ZVcZLnuf077HCNPOOA+K+yAVx6nNYhmyUvwZiSj7MkC/msVNhUtm0KJqD5oh9a7FBYOefrgtvDh3yblQV0Pu7UuTYurgQ9WICM8vokfbXZw939PkP+F2I7nLV+pfxyMK0a68HmJTQy72anWSFjprfOFaPFm925rLLooaoWmXdQqJPTnmfUaN+8D8nXmoH4/RAqY6N8Jq28AqhITaFLSjfSK7o1mAnBxPJ7yPQ/fudkY3ec=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13EF419AC44F98459B1F018D42E51DE3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d0c333-cfc6-4828-6eb4-08d6eb36fff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 10:57:57.7375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Brian.Starkey@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3958
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

I think it's looking good. I spotted a couple of error paths which I
think are missing cleanup, no complaints about the API though.

On Fri, Jun 07, 2019 at 03:07:15AM +0000, John Stultz wrote:
> From: "Andrew F. Davis" <afd@ti.com>
>=20
> This framework allows a unified userspace interface for dma-buf
> exporters, allowing userland to allocate specific types of memory
> for use in dma-buf sharing.
>=20
> Each heap is given its own device node, which a user can allocate
> a dma-buf fd from using the DMA_HEAP_IOC_ALLOC.
>=20
> This code is an evoluiton of the Android ION implementation,
> and a big thanks is due to its authors/maintainers over time
> for their effort:
>   Rebecca Schultz Zavin, Colin Cross, Benjamin Gaignard,
>   Laura Abbott, and many other contributors!
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
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Change-Id: I4af43a137ad34ff6f7da4d6b2864f3cd86fb7652
> ---
> v2:
> * Folded down fixes I had previously shared in implementing
>   heaps
> * Make flags a u64 (Suggested by Laura)
> * Add PAGE_ALIGN() fix to the core alloc funciton
> * IOCTL fixups suggested by Brian
> * Added fixes suggested by Benjamin
> * Removed core stats mgmt, as that should be implemented by
>   per-heap code
> * Changed alloc to return a dma-buf fd, rather then a buffer

nit:s/then/than/

>   (as it simplifies error handling)
> v3:
> * Removed scare-quotes in MAINTAINERS email address
> * Get rid of .release function as it didn't do anything (from
>   Christoph)
> * Renamed filp to file (suggested by Christoph)
> * Split out ioctl handling to separate function (suggested by
>   Christoph)
> * Add comment documenting PAGE_ALIGN usage (suggested by Brian)
> * Switch from idr to Xarray (suggested by Brian)
> * Fixup cdev creation (suggested by Brian)
> * Avoid EXPORT_SYMBOL until we finalize modules (suggested by
>   Brian)
> * Make struct dma_heap internal only (folded in from Andrew)
> * Small cleanups suggested by GregKH
> * Provide class->devnode callback to get consistent /dev/
>   subdirectory naming (Suggested by Bjorn)
> v4:
> * Folded down dma-heap.h change that was in a following patch
> * Added fd_flags entry to allocation structure and pass it
>   through to heap code for use on dma-buf fd creation (suggested
>   by Benjamin)
> v5:
> * Minor cleanups
> ---
>  MAINTAINERS                   |  18 +++
>  drivers/dma-buf/Kconfig       |   8 ++
>  drivers/dma-buf/Makefile      |   1 +
>  drivers/dma-buf/dma-heap.c    | 237 ++++++++++++++++++++++++++++++++++
>  include/linux/dma-heap.h      |  59 +++++++++
>  include/uapi/linux/dma-heap.h |  56 ++++++++
>  6 files changed, 379 insertions(+)
>  create mode 100644 drivers/dma-buf/dma-heap.c
>  create mode 100644 include/linux/dma-heap.h
>  create mode 100644 include/uapi/linux/dma-heap.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6954776a37e..5aded7e9a062 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4813,6 +4813,24 @@ F:	include/linux/*fence.h
>  F:	Documentation/driver-api/dma-buf.rst
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
> =20
> +DMA-BUF HEAPS FRAMEWORK
> +M:	Sumit Semwal <sumit.semwal@linaro.org>
> +R:	Andrew F. Davis <afd@ti.com>
> +R:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
> +R:	Liam Mark <lmark@codeaurora.org>
> +R:	Laura Abbott <labbott@redhat.com>
> +R:	Brian Starkey <Brian.Starkey@arm.com>
> +R:	John Stultz <john.stultz@linaro.org>
> +S:	Maintained
> +L:	linux-media@vger.kernel.org
> +L:	dri-devel@lists.freedesktop.org
> +L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
> +F:	include/uapi/linux/dma-heap.h
> +F:	include/linux/dma-heap.h
> +F:	drivers/dma-buf/dma-heap.c
> +F:	drivers/dma-buf/heaps/*
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +
>  DMA GENERIC OFFLOAD ENGINE SUBSYSTEM
>  M:	Vinod Koul <vkoul@kernel.org>
>  L:	dmaengine@vger.kernel.org
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index d5f915830b68..9b93f86f597c 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -39,4 +39,12 @@ config UDMABUF
>  	  A driver to let userspace turn memfd regions into dma-bufs.
>  	  Qemu can use this to create host dmabufs for guest framebuffers.
> =20
> +menuconfig DMABUF_HEAPS
> +	bool "DMA-BUF Userland Memory Heaps"
> +	select DMA_SHARED_BUFFER
> +	help
> +	  Choose this option to enable the DMA-BUF userland memory heaps,
> +	  this allows userspace to allocate dma-bufs that can be shared between
> +	  drivers.
> +
>  endmenu
> diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
> index e8c7310cb800..1cb3dd104825 100644
> --- a/drivers/dma-buf/Makefile
> +++ b/drivers/dma-buf/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y :=3D dma-buf.o dma-fence.o dma-fence-array.o dma-fence-chain.o \
>  	 reservation.o seqno-fence.o
> +obj-$(CONFIG_DMABUF_HEAPS)	+=3D dma-heap.o
>  obj-$(CONFIG_SYNC_FILE)		+=3D sync_file.o
>  obj-$(CONFIG_SW_SYNC)		+=3D sw_sync.o sync_debug.o
>  obj-$(CONFIG_UDMABUF)		+=3D udmabuf.o
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> new file mode 100644
> index 000000000000..bbeaf3192a0d
> --- /dev/null
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -0,0 +1,237 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Framework for userspace DMA-BUF allocations
> + *
> + * Copyright (C) 2011 Google, Inc.
> + * Copyright (C) 2019 Linaro Ltd.
> + */
> +
> +#include <linux/cdev.h>
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/dma-buf.h>
> +#include <linux/err.h>
> +#include <linux/xarray.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +
> +#include <linux/dma-heap.h>
> +#include <uapi/linux/dma-heap.h>
> +
> +#define DEVNAME "dma_heap"
> +
> +#define NUM_HEAP_MINORS 128
> +
> +/**
> + * struct dma_heap - represents a dmabuf heap in the system
> + * @name:		used for debugging/device-node name
> + * @ops:		ops struct for this heap
> + * @minor		minor number of this heap device
> + * @heap_devt		heap device node
> + * @heap_cdev		heap char device
> + *
> + * Represents a heap of memory from which buffers can be made.
> + */
> +struct dma_heap {
> +	const char *name;
> +	struct dma_heap_ops *ops;
> +	void *priv;
> +	unsigned int minor;
> +	dev_t heap_devt;
> +	struct cdev heap_cdev;
> +};
> +
> +static dev_t dma_heap_devt;
> +static struct class *dma_heap_class;
> +static DEFINE_XARRAY_ALLOC(dma_heap_minors);
> +
> +static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> +				 unsigned int fd_flags,
> +				 unsigned int heap_flags)
> +{
> +	/*
> +	 * Allocations from all heaps have to begin
> +	 * and end on page boundaries.
> +	 */
> +	len =3D PAGE_ALIGN(len);
> +	if (!len)
> +		return -EINVAL;
> +
> +	return heap->ops->allocate(heap, len, fd_flags, heap_flags);
> +}
> +
> +static int dma_heap_open(struct inode *inode, struct file *file)
> +{
> +	struct dma_heap *heap;
> +
> +	heap =3D xa_load(&dma_heap_minors, iminor(inode));
> +	if (!heap) {
> +		pr_err("dma_heap: minor %d unknown.\n", iminor(inode));
> +		return -ENODEV;
> +	}
> +
> +	/* instance data as context */
> +	file->private_data =3D heap;
> +	nonseekable_open(inode, file);
> +
> +	return 0;
> +}
> +
> +static long dma_heap_ioctl_allocate(struct file *file, unsigned long arg=
)
> +{
> +	struct dma_heap_allocation_data heap_allocation;
> +	struct dma_heap *heap =3D file->private_data;
> +	int fd;
> +
> +	if (copy_from_user(&heap_allocation, (void __user *)arg,
> +			   sizeof(heap_allocation)))
> +		return -EFAULT;
> +
> +	if (heap_allocation.fd ||
> +	    heap_allocation.reserved0 ||
> +	    heap_allocation.reserved1) {
> +		pr_warn_once("dma_heap: ioctl data not valid\n");
> +		return -EINVAL;
> +	}
> +
> +	if (heap_allocation.fd_flags & ~DMA_HEAP_VALID_FD_FLAGS) {
> +		pr_warn_once("dma_heap: fd_flags has invalid or unsupported flags set\=
n");
> +		return -EINVAL;
> +	}
> +
> +	if (heap_allocation.heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS) {
> +		pr_warn_once("dma_heap: heap flags has invalid or unsupported flags se=
t\n");
> +		return -EINVAL;
> +	}
> +
> +
> +	fd =3D dma_heap_buffer_alloc(heap, heap_allocation.len,
> +				   heap_allocation.fd_flags,
> +				   heap_allocation.heap_flags);
> +	if (fd < 0)
> +		return fd;
> +
> +	heap_allocation.fd =3D fd;
> +
> +	if (copy_to_user((void __user *)arg, &heap_allocation,
> +			 sizeof(heap_allocation)))

I guess there's some cleanup to be done on the dmabuf here.

> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static long dma_heap_ioctl(struct file *file, unsigned int cmd,
> +			   unsigned long arg)
> +{
> +	int ret =3D 0;
> +
> +	switch (cmd) {
> +	case DMA_HEAP_IOC_ALLOC:
> +		ret =3D dma_heap_ioctl_allocate(file, arg);
> +		break;
> +	default:
> +		return -ENOTTY;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct file_operations dma_heap_fops =3D {
> +	.owner          =3D THIS_MODULE,
> +	.open		=3D dma_heap_open,
> +	.unlocked_ioctl =3D dma_heap_ioctl,
> +};
> +
> +/**
> + * dma_heap_get_data() - get per-subdriver data for the heap
> + * @heap: DMA-Heap to retrieve private data for
> + *
> + * Returns:
> + * The per-subdriver data for the heap.
> + */
> +void *dma_heap_get_data(struct dma_heap *heap)
> +{
> +	return heap->priv;
> +}
> +
> +struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_inf=
o)
> +{
> +	struct dma_heap *heap;
> +	struct device *dev_ret;
> +	int ret;
> +
> +	if (!exp_info->name || !strcmp(exp_info->name, "")) {
> +		pr_err("dma_heap: Cannot add heap without a name\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (!exp_info->ops || !exp_info->ops->allocate) {
> +		pr_err("dma_heap: Cannot add heap with invalid ops struct\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	heap =3D kzalloc(sizeof(*heap), GFP_KERNEL);
> +	if (!heap)
> +		return ERR_PTR(-ENOMEM);

It looks like 'heap' is leaked in all the error paths below.

> +
> +	heap->name =3D exp_info->name;
> +	heap->ops =3D exp_info->ops;
> +	heap->priv =3D exp_info->priv;
> +
> +	/* Find unused minor number */
> +	ret =3D xa_alloc(&dma_heap_minors, &heap->minor, heap,
> +			XA_LIMIT(0, NUM_HEAP_MINORS - 1), GFP_KERNEL);
> +	if (ret < 0) {
> +		pr_err("dma_heap: Unable to get minor number for heap\n");
> +		return ERR_PTR(ret);
> +	}

Do we need xa_erase() after this point, too?

> +
> +	/* Create device */
> +	heap->heap_devt =3D MKDEV(MAJOR(dma_heap_devt), heap->minor);
> +
> +	cdev_init(&heap->heap_cdev, &dma_heap_fops);
> +	ret =3D cdev_add(&heap->heap_cdev, heap->heap_devt, 1);
> +	if (ret < 0) {
> +		pr_err("dma_heap: Unable to add char device\n");
> +		return ERR_PTR(ret);
> +	}
> +
> +	dev_ret =3D device_create(dma_heap_class,
> +				NULL,
> +				heap->heap_devt,
> +				NULL,
> +				heap->name);
> +	if (IS_ERR(dev_ret)) {
> +		pr_err("dma_heap: Unable to create device\n");
> +		cdev_del(&heap->heap_cdev);
> +		return (struct dma_heap *)dev_ret;
> +	}
> +
> +	return heap;
> +}
> +
> +static char *dma_heap_devnode(struct device *dev, umode_t *mode)
> +{
> +	return kasprintf(GFP_KERNEL, "dma_heap/%s", dev_name(dev));
> +}
> +

extra newline

> +
> +static int dma_heap_init(void)
> +{
> +	int ret;
> +
> +	ret =3D alloc_chrdev_region(&dma_heap_devt, 0, NUM_HEAP_MINORS, DEVNAME=
);
> +	if (ret)
> +		return ret;
> +
> +	dma_heap_class =3D class_create(THIS_MODULE, DEVNAME);
> +	if (IS_ERR(dma_heap_class)) {
> +		unregister_chrdev_region(dma_heap_devt, NUM_HEAP_MINORS);
> +		return PTR_ERR(dma_heap_class);
> +	}
> +	dma_heap_class->devnode =3D dma_heap_devnode;
> +
> +	return 0;
> +}
> +subsys_initcall(dma_heap_init);
> diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
> new file mode 100644
> index 000000000000..7a1b633ac02f
> --- /dev/null
> +++ b/include/linux/dma-heap.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * DMABUF Heaps Allocation Infrastructure
> + *
> + * Copyright (C) 2011 Google, Inc.
> + * Copyright (C) 2019 Linaro Ltd.
> + */
> +
> +#ifndef _DMA_HEAPS_H
> +#define _DMA_HEAPS_H
> +
> +#include <linux/cdev.h>
> +#include <linux/types.h>
> +
> +struct dma_heap;
> +
> +/**
> + * struct dma_heap_ops - ops to operate on a given heap
> + * @allocate:		allocate dmabuf and return fd
> + *
> + * allocate returns dmabuf fd  on success, -errno on error.
> + */
> +struct dma_heap_ops {
> +	int (*allocate)(struct dma_heap *heap,
> +			unsigned long len,
> +			unsigned long fd_flags,
> +			unsigned long heap_flags);
> +};
> +
> +/**
> + * struct dma_heap_export_info - information needed to export a new dmab=
uf heap
> + * @name:	used for debugging/device-node name
> + * @ops:	ops struct for this heap
> + * @priv:	heap exporter private data
> + *
> + * Information needed to export a new dmabuf heap.
> + */
> +struct dma_heap_export_info {
> +	const char *name;
> +	struct dma_heap_ops *ops;
> +	void *priv;
> +};
> +
> +/**
> + * dma_heap_get_data() - get per-heap driver data
> + * @heap: DMA-Heap to retrieve private data for
> + *
> + * Returns:
> + * The per-heap data for the heap.
> + */
> +void *dma_heap_get_data(struct dma_heap *heap);
> +
> +/**
> + * dma_heap_add - adds a heap to dmabuf heaps
> + * @exp_info:		information needed to register this heap
> + */
> +struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_inf=
o);
> +
> +#endif /* _DMA_HEAPS_H */
> diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-heap.=
h
> new file mode 100644
> index 000000000000..c382280277d7
> --- /dev/null
> +++ b/include/uapi/linux/dma-heap.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * DMABUF Heaps Userspace API
> + *
> + * Copyright (C) 2011 Google, Inc.
> + * Copyright (C) 2019 Linaro Ltd.
> + */
> +#ifndef _UAPI_LINUX_DMABUF_POOL_H
> +#define _UAPI_LINUX_DMABUF_POOL_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +/**
> + * DOC: DMABUF Heaps Userspace API
> + *

Is that line needed?

Thanks,
-Brian

> + */
> +
> +/* Valid FD_FLAGS are O_CLOEXEC, O_RDONLY, O_WRONLY, O_RDWR */
> +#define DMA_HEAP_VALID_FD_FLAGS (O_CLOEXEC | O_ACCMODE)
> +
> +/* Currently no heap flags */
> +#define DMA_HEAP_VALID_HEAP_FLAGS (0)
> +
> +/**
> + * struct dma_heap_allocation_data - metadata passed from userspace for
> + *                                      allocations
> + * @len:		size of the allocation
> + * @fd:			will be populated with a fd which provdes the
> + *			handle to the allocated dma-buf
> + * @fd_flags:		file descriptor flags used when allocating
> + * @heap_flags:		flags passed to heap
> + *
> + * Provided by userspace as an argument to the ioctl
> + */
> +struct dma_heap_allocation_data {
> +	__u64 len;
> +	__u32 fd;
> +	__u32 fd_flags;
> +	__u64 heap_flags;
> +	__u32 reserved0;
> +	__u32 reserved1;
> +};
> +
> +#define DMA_HEAP_IOC_MAGIC		'H'
> +
> +/**
> + * DOC: DMA_HEAP_IOC_ALLOC - allocate memory from pool
> + *
> + * Takes an dma_heap_allocation_data struct and returns it with the fd f=
ield
> + * populated with the dmabuf handle of the allocation.
> + */
> +#define DMA_HEAP_IOC_ALLOC	_IOWR(DMA_HEAP_IOC_MAGIC, 0, \
> +				      struct dma_heap_allocation_data)
> +
> +#endif /* _UAPI_LINUX_DMABUF_POOL_H */
> --=20
> 2.17.1
>=20
