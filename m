Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA10C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D965212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cjXsqpjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfFGLSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 07:18:10 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:43744
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728073AbfFGLSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiB7qfV6i5vKkGiEnMOLGhry7OTOZsfPU7fH1Y9ZwjA=;
 b=cjXsqpjrPE4Bvl+KPfzn1c+5v2oEt//U3RWpE48WgqTjaXuWc6W/Z6i0OdQPCRd0yI1+8Zu3Jdd+cD8hz0npjWm571+sW5Q0HNb10nlg/sQnEWxNAboOQ/Q9xl7DEWOMNxTHAd8ugJTNz9Bhg1WfN+j2K0FR1XIEdjBA6sO0m8o=
Received: from AM6PR08MB4104.eurprd08.prod.outlook.com (20.179.2.31) by
 AM6PR08MB4835.eurprd08.prod.outlook.com (10.255.98.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Fri, 7 Jun 2019 11:18:04 +0000
Received: from AM6PR08MB4104.eurprd08.prod.outlook.com
 ([fe80::2dd7:c53e:ed14:2be4]) by AM6PR08MB4104.eurprd08.prod.outlook.com
 ([fe80::2dd7:c53e:ed14:2be4%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 11:18:04 +0000
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
Subject: Re: [PATCH v5 2/5] dma-buf: heaps: Add heap helpers
Thread-Topic: [PATCH v5 2/5] dma-buf: heaps: Add heap helpers
Thread-Index: AQHVHN4lp76vBFI6eE2rRMqb/pZGdqaQC5oA
Date:   Fri, 7 Jun 2019 11:18:04 +0000
Message-ID: <20190607111802.cuqnumdu3ntme24r@DESKTOP-E1NTVVP.localdomain>
References: <20190607030719.77286-1-john.stultz@linaro.org>
 <20190607030719.77286-3-john.stultz@linaro.org>
In-Reply-To: <20190607030719.77286-3-john.stultz@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0406.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::34) To AM6PR08MB4104.eurprd08.prod.outlook.com
 (2603:10a6:20b:a9::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e5e156a-b5e2-403c-482f-08d6eb39cf09
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR08MB4835;
x-ms-traffictypediagnostic: AM6PR08MB4835:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM6PR08MB4835DC0C9EEC58B08E183459F0100@AM6PR08MB4835.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(366004)(346002)(396003)(199004)(189003)(316002)(66476007)(81166006)(81156014)(66556008)(8676002)(66446008)(58126008)(64756008)(229853002)(99286004)(73956011)(66946007)(476003)(8936002)(54906003)(6436002)(14444005)(256004)(5024004)(6486002)(6916009)(66066001)(4326008)(72206003)(2906002)(446003)(9686003)(3846002)(6116002)(25786009)(6512007)(486006)(86362001)(7416002)(52116002)(6246003)(102836004)(305945005)(7736002)(71200400001)(71190400001)(14454004)(26005)(1076003)(44832011)(30864003)(478600001)(5660300002)(11346002)(186003)(386003)(68736007)(76176011)(6506007)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4835;H:AM6PR08MB4104.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vdEeYWF0RqRmsUghVqkLzgAyB9MxI9rCBme08qfi2fAC07BWETvt16DuKAGW4HzelECHg7y3Z+Y0YOGLDMZxvPfoJ0nHizhnH4G8MfNVHpJSBx7VOdVIDIZHmiMVtRQVwhLiaTjE6ny5fZQyK6lG3aPAu/r4hMacXFACscEudC89NQr51Vmp3EFd1aAbUmUOfHETLTy+llKE0A0c7GuMIOlQ88DTVENcGagd9WacJSC9K9AEnWkvt+XbyfziKFQfwTBjhkFKCpBtO4j3gwkKb8XCxAhc0jpBb/b88YSEZXtp+tuAzYPE1Zi7EXDmrg06d3+1vt9qblDwEyqKXY2nMnNDLYmU4J0jurPRn0f8dV7RTvQ4ny/Q/x5VrA8Awwx7/BYezsVMpyS+FAFk5vHhDwECBQ+KKB8JkRzPc2vj8fM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49259CE6B59B8D4185F2BE159B84AA58@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5e156a-b5e2-403c-482f-08d6eb39cf09
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 11:18:04.1157
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

Hi John,

On Fri, Jun 07, 2019 at 03:07:16AM +0000, John Stultz wrote:
> Add generic helper dmabuf ops for dma heaps, so we can reduce
> the amount of duplicative code for the exported dmabufs.
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
> Change-Id: I48d43656e7783f266d877e363116b5187639f996
> ---
> v2:
> * Removed cache management performance hack that I had
>   accidentally folded in.
> * Removed stats code that was in helpers
> * Lots of checkpatch cleanups
> v3:
> * Uninline INIT_HEAP_HELPER_BUFFER (suggested by Christoph)
> * Switch to WARN on buffer destroy failure (suggested by Brian)
> * buffer->kmap_cnt decrementing cleanup (suggested by Christoph)
> * Extra buffer->vaddr checking in dma_heap_dma_buf_kmap
>   (suggested by Brian)
> * Switch to_helper_buffer from macro to inline function
>   (suggested by Benjamin)
> * Rename kmap->vmap (folded in from Andrew)
> * Use vmap for vmapping - not begin_cpu_access (folded in from
>   Andrew)
> * Drop kmap for now, as its optional (folded in from Andrew)
> * Fold dma_heap_map_user into the single caller (foled in from
>   Andrew)
> * Folded in patch from Andrew to track page list per heap not
>   sglist, which simplifies the tracking logic
> v4:
> * Moved dma-heap.h change out to previous patch
> ---
>  drivers/dma-buf/Makefile             |   1 +
>  drivers/dma-buf/heaps/Makefile       |   2 +
>  drivers/dma-buf/heaps/heap-helpers.c | 261 +++++++++++++++++++++++++++
>  drivers/dma-buf/heaps/heap-helpers.h |  55 ++++++
>  4 files changed, 319 insertions(+)
>  create mode 100644 drivers/dma-buf/heaps/Makefile
>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.h
>=20
> diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
> index 1cb3dd104825..e3e3dca29e46 100644
> --- a/drivers/dma-buf/Makefile
> +++ b/drivers/dma-buf/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y :=3D dma-buf.o dma-fence.o dma-fence-array.o dma-fence-chain.o \
>  	 reservation.o seqno-fence.o
> +obj-$(CONFIG_DMABUF_HEAPS)	+=3D heaps/
>  obj-$(CONFIG_DMABUF_HEAPS)	+=3D dma-heap.o
>  obj-$(CONFIG_SYNC_FILE)		+=3D sync_file.o
>  obj-$(CONFIG_SW_SYNC)		+=3D sw_sync.o sync_debug.o
> diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makef=
ile
> new file mode 100644
> index 000000000000..de49898112db
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-y					+=3D heap-helpers.o
> diff --git a/drivers/dma-buf/heaps/heap-helpers.c b/drivers/dma-buf/heaps=
/heap-helpers.c
> new file mode 100644
> index 000000000000..00cbdbbb97e5
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/heap-helpers.c
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/device.h>
> +#include <linux/dma-buf.h>
> +#include <linux/err.h>
> +#include <linux/idr.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <uapi/linux/dma-heap.h>
> +
> +#include "heap-helpers.h"
> +
> +void INIT_HEAP_HELPER_BUFFER(struct heap_helper_buffer *buffer,
> +			     void (*free)(struct heap_helper_buffer *))
> +{
> +	buffer->private_flags =3D 0;
> +	buffer->priv_virt =3D NULL;
> +	mutex_init(&buffer->lock);
> +	buffer->vmap_cnt =3D 0;
> +	buffer->vaddr =3D NULL;
> +	INIT_LIST_HEAD(&buffer->attachments);
> +	buffer->free =3D free;

Should pagecount and pages be initialised here too? I'm not sure what
the metric for picking which members are/aren't initialised is.

> +}
> +

extra newline

> +
> +static void *dma_heap_map_kernel(struct heap_helper_buffer *buffer)
> +{
> +	void *vaddr;
> +
> +	vaddr =3D vmap(buffer->pages, buffer->pagecount, VM_MAP, PAGE_KERNEL);
> +	if (!vaddr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return vaddr;
> +}
> +
> +void dma_heap_buffer_destroy(struct dma_heap_buffer *heap_buffer)

can be static

> +{
> +	struct heap_helper_buffer *buffer =3D to_helper_buffer(heap_buffer);
> +
> +	if (buffer->vmap_cnt > 0) {
> +		WARN("%s: buffer still mapped in the kernel\n",
> +			     __func__);
> +		vunmap(buffer->vaddr);
> +	}
> +
> +	buffer->free(buffer);
> +}
> +
> +static void *dma_heap_buffer_vmap_get(struct dma_heap_buffer *heap_buffe=
r)
> +{
> +	struct heap_helper_buffer *buffer =3D to_helper_buffer(heap_buffer);
> +	void *vaddr;
> +
> +	if (buffer->vmap_cnt) {
> +		buffer->vmap_cnt++;
> +		return buffer->vaddr;
> +	}
> +	vaddr =3D dma_heap_map_kernel(buffer);
> +	if (WARN_ONCE(!vaddr,
> +		      "heap->ops->map_kernel should return ERR_PTR on error"))
> +		return ERR_PTR(-EINVAL);
> +	if (IS_ERR(vaddr))
> +		return vaddr;
> +	buffer->vaddr =3D vaddr;
> +	buffer->vmap_cnt++;
> +	return vaddr;
> +}
> +
> +static void dma_heap_buffer_vmap_put(struct dma_heap_buffer *heap_buffer=
)
> +{
> +	struct heap_helper_buffer *buffer =3D to_helper_buffer(heap_buffer);
> +
> +	if (!--buffer->vmap_cnt) {
> +		vunmap(buffer->vaddr);
> +		buffer->vaddr =3D NULL;
> +	}
> +}
> +
> +struct dma_heaps_attachment {
> +	struct device *dev;
> +	struct sg_table table;
> +	struct list_head list;
> +};
> +
> +static int dma_heap_attach(struct dma_buf *dmabuf,
> +			      struct dma_buf_attachment *attachment)
> +{
> +	struct dma_heaps_attachment *a;
> +	struct dma_heap_buffer *heap_buffer =3D dmabuf->priv;
> +	struct heap_helper_buffer *buffer =3D to_helper_buffer(heap_buffer);
> +	int ret;
> +
> +	a =3D kzalloc(sizeof(*a), GFP_KERNEL);
> +	if (!a)
> +		return -ENOMEM;
> +
> +	ret =3D sg_alloc_table_from_pages(&a->table, buffer->pages,
> +					buffer->pagecount, 0,
> +					buffer->pagecount << PAGE_SHIFT,
> +					GFP_KERNEL);
> +	if (ret) {
> +		kfree(a);
> +		return ret;
> +	}
> +
> +	a->dev =3D attachment->dev;
> +	INIT_LIST_HEAD(&a->list);
> +
> +	attachment->priv =3D a;
> +
> +	mutex_lock(&buffer->lock);
> +	list_add(&a->list, &buffer->attachments);
> +	mutex_unlock(&buffer->lock);
> +
> +	return 0;
> +}
> +
> +static void dma_heap_detatch(struct dma_buf *dmabuf,
> +				struct dma_buf_attachment *attachment)

s/detatch/detach/

> +{
> +	struct dma_heaps_attachment *a =3D attachment->priv;
> +	struct dma_heap_buffer *heap_buffer =3D dmabuf->priv;
> +	struct heap_helper_buffer *buffer =3D to_helper_buffer(heap_buffer);
> +
> +	mutex_lock(&buffer->lock);
> +	list_del(&a->list);
> +	mutex_unlock(&buffer->lock);
> +
> +	sg_free_table(&a->table);
> +	kfree(a);
> +}
> +
> +static struct sg_table *dma_heap_map_dma_buf(
> +					struct dma_buf_attachment *attachment,
> +					enum dma_data_direction direction)
> +{
> +	struct dma_heaps_attachment *a =3D attachment->priv;
> +	struct sg_table *table;
> +
> +	table =3D &a->table;
> +
> +	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> +			direction))
> +		table =3D ERR_PTR(-ENOMEM);
> +	return table;
> +}
> +
> +static void dma_heap_unmap_dma_buf(struct dma_buf_attachment *attachment=
,
> +			      struct sg_table *table,
> +			      enum dma_data_direction direction)
> +{
> +	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
> +}
> +
> +static vm_fault_t dma_heap_vm_fault(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma =3D vmf->vma;
> +	struct heap_helper_buffer *buffer =3D vma->vm_private_data;
> +
> +	vmf->page =3D buffer->pages[vmf->pgoff];
> +	get_page(vmf->page);
> +
> +	return 0;
> +}
> +
> +static const struct vm_operations_struct dma_heap_vm_ops =3D {
> +	.fault =3D dma_heap_vm_fault,
> +};
> +
> +static int dma_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *=
vma)
> +{
> +	struct dma_heap_buffer *heap_buffer =3D dmabuf->priv;
> +	struct heap_helper_buffer *buffer =3D to_helper_buffer(heap_buffer);
> +
> +	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) =3D=3D 0)
> +		return -EINVAL;
> +
> +	vma->vm_ops =3D &dma_heap_vm_ops;
> +	vma->vm_private_data =3D buffer;
> +
> +	return 0;
> +}
> +
> +static void dma_heap_dma_buf_release(struct dma_buf *dmabuf)
> +{
> +	struct dma_heap_buffer *buffer =3D dmabuf->priv;
> +
> +	dma_heap_buffer_destroy(buffer);
> +}
> +
> +static int dma_heap_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
> +					enum dma_data_direction direction)
> +{
> +	struct dma_heap_buffer *heap_buffer =3D dmabuf->priv;
> +	struct heap_helper_buffer *buffer =3D to_helper_buffer(heap_buffer);
> +	struct dma_heaps_attachment *a;
> +	int ret =3D 0;
> +
> +	mutex_lock(&buffer->lock);
> +	list_for_each_entry(a, &buffer->attachments, list) {
> +		dma_sync_sg_for_cpu(a->dev, a->table.sgl, a->table.nents,
> +				    direction);
> +	}
> +	mutex_unlock(&buffer->lock);
> +
> +	return ret;
> +}
> +
> +static int dma_heap_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
> +				      enum dma_data_direction direction)
> +{
> +	struct dma_heap_buffer *heap_buffer =3D dmabuf->priv;
> +	struct heap_helper_buffer *buffer =3D to_helper_buffer(heap_buffer);
> +	struct dma_heaps_attachment *a;
> +
> +	mutex_lock(&buffer->lock);
> +	list_for_each_entry(a, &buffer->attachments, list) {
> +		dma_sync_sg_for_device(a->dev, a->table.sgl, a->table.nents,
> +				       direction);
> +	}
> +	mutex_unlock(&buffer->lock);
> +
> +	return 0;
> +}
> +
> +void *dma_heap_dma_buf_vmap(struct dma_buf *dmabuf)

can be static

> +{
> +	struct dma_heap_buffer *heap_buffer =3D dmabuf->priv;
> +	struct heap_helper_buffer *buffer =3D to_helper_buffer(heap_buffer);
> +	void *vaddr;
> +
> +	mutex_lock(&buffer->lock);
> +	vaddr =3D dma_heap_buffer_vmap_get(heap_buffer);
> +	mutex_unlock(&buffer->lock);
> +
> +	return vaddr;
> +}
> +
> +void dma_heap_dma_buf_vunmap(struct dma_buf *dmabuf, void *vaddr)

can be static

> +{
> +	struct dma_heap_buffer *heap_buffer =3D dmabuf->priv;
> +	struct heap_helper_buffer *buffer =3D to_helper_buffer(heap_buffer);
> +
> +	mutex_lock(&buffer->lock);
> +	dma_heap_buffer_vmap_put(heap_buffer);
> +	mutex_unlock(&buffer->lock);
> +}
> +
> +const struct dma_buf_ops heap_helper_ops =3D {
> +	.map_dma_buf =3D dma_heap_map_dma_buf,
> +	.unmap_dma_buf =3D dma_heap_unmap_dma_buf,
> +	.mmap =3D dma_heap_mmap,
> +	.release =3D dma_heap_dma_buf_release,
> +	.attach =3D dma_heap_attach,
> +	.detach =3D dma_heap_detatch,
> +	.begin_cpu_access =3D dma_heap_dma_buf_begin_cpu_access,
> +	.end_cpu_access =3D dma_heap_dma_buf_end_cpu_access,
> +	.vmap =3D dma_heap_dma_buf_vmap,
> +	.vunmap =3D dma_heap_dma_buf_vunmap,
> +};
> diff --git a/drivers/dma-buf/heaps/heap-helpers.h b/drivers/dma-buf/heaps=
/heap-helpers.h
> new file mode 100644
> index 000000000000..a17502dc22e3
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/heap-helpers.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * DMABUF Heaps helper code
> + *
> + * Copyright (C) 2011 Google, Inc.
> + * Copyright (C) 2019 Linaro Ltd.
> + */
> +
> +#ifndef _HEAP_HELPERS_H
> +#define _HEAP_HELPERS_H
> +
> +#include <linux/dma-heap.h>
> +#include <linux/list.h>
> +
> +/**
> + * struct dma_heap_buffer - metadata for a particular buffer
> + * @heap:		back pointer to the heap the buffer came from
> + * @dmabuf:		backing dma-buf for this buffer
> + * @size:		size of the buffer
> + * @flags:		buffer specific flags
> + */
> +struct dma_heap_buffer {
> +	struct dma_heap *heap;
> +	struct dma_buf *dmabuf;
> +	size_t size;
> +	unsigned long flags;
> +};
> +
> +struct heap_helper_buffer {
> +	struct dma_heap_buffer heap_buffer;
> +
> +	unsigned long private_flags;
> +	void *priv_virt;
> +	struct mutex lock;
> +	int vmap_cnt;
> +	void *vaddr;
> +	pgoff_t pagecount;
> +	struct page **pages;
> +	struct list_head attachments;
> +
> +	void (*free)(struct heap_helper_buffer *buffer);
> +

extra newline

With the statics and the detatch typo fixed:

Reviewed-by: Brian Starkey <brian.starkey@arm.com>

> +};
> +
> +static inline struct heap_helper_buffer *to_helper_buffer(
> +						struct dma_heap_buffer *h)
> +{
> +	return container_of(h, struct heap_helper_buffer, heap_buffer);
> +}
> +
> +void INIT_HEAP_HELPER_BUFFER(struct heap_helper_buffer *buffer,
> +				 void (*free)(struct heap_helper_buffer *));
> +extern const struct dma_buf_ops heap_helper_ops;
> +
> +#endif /* _HEAP_HELPERS_H */
> --=20
> 2.17.1
>=20
