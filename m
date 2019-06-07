Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD65C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E695206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="S+yn6q0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfFGNBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 09:01:18 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:6228
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727512AbfFGNBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcZV03+9rRYAh9aoXMWv+yBiJfTawXKjyKc94OTpGXA=;
 b=S+yn6q0HBJTiPrVRuQhIPUc5NZjoYy14YdPCQqRUTA1SMX+wx2JAgnWgV6vpLJ/KqMdvj5a3OLxnIalRJ5vKdBEyahj2eP7S+Ai0fsgVKL4UlBYn8WbKeWdmkp52XvD3yuMs9gpwC7jgDA1jDThx0K4NGRC8gMUUfF2A66hJrQ0=
Received: from AM6PR08MB4104.eurprd08.prod.outlook.com (20.179.2.31) by
 AM6PR08MB3878.eurprd08.prod.outlook.com (20.178.90.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 13:01:11 +0000
Received: from AM6PR08MB4104.eurprd08.prod.outlook.com
 ([fe80::2dd7:c53e:ed14:2be4]) by AM6PR08MB4104.eurprd08.prod.outlook.com
 ([fe80::2dd7:c53e:ed14:2be4%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 13:01:11 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH v5 5/5] kselftests: Add dma-heap test
Thread-Topic: [PATCH v5 5/5] kselftests: Add dma-heap test
Thread-Index: AQHVHN4nXn+cC1NFK0KVQX8Ui8Df66aQKGsA
Date:   Fri, 7 Jun 2019 13:01:11 +0000
Message-ID: <20190607130110.juiwpliqticwuazn@DESKTOP-E1NTVVP.localdomain>
References: <20190607030719.77286-1-john.stultz@linaro.org>
 <20190607030719.77286-6-john.stultz@linaro.org>
In-Reply-To: <20190607030719.77286-6-john.stultz@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0196.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::16) To AM6PR08MB4104.eurprd08.prod.outlook.com
 (2603:10a6:20b:a9::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3aeb4c1-d64c-412b-337a-08d6eb4836b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR08MB3878;
x-ms-traffictypediagnostic: AM6PR08MB3878:
x-ms-exchange-purlcount: 1
nodisclaimer: True
x-microsoft-antispam-prvs: <AM6PR08MB38787C4CEA3D90650D98223DF0100@AM6PR08MB3878.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:331;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39850400004)(396003)(366004)(189003)(199004)(4326008)(229853002)(386003)(6506007)(71200400001)(102836004)(9686003)(6436002)(1076003)(966005)(76176011)(3716004)(71190400001)(6486002)(6116002)(14444005)(99286004)(256004)(8936002)(7416002)(3846002)(52116002)(25786009)(81166006)(72206003)(81156014)(66066001)(8676002)(476003)(86362001)(14454004)(11346002)(6306002)(2906002)(446003)(316002)(58126008)(7736002)(68736007)(6246003)(6512007)(66476007)(305945005)(66556008)(44832011)(66946007)(6916009)(478600001)(53936002)(64756008)(66446008)(54906003)(26005)(186003)(73956011)(486006)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3878;H:AM6PR08MB4104.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gkBPr8wP8tm0Abua3rOYsfLb+ppi9rbLPH/5R4W08qvoUiMyRTatH/DYZmOzGaxR5jgm+uada4kDeYqwVvzCKsJlLXVSDSNVdJLipX9GQ8Fl+xXDzA7nBEbGB4xxVhh5cMyrRVRywiZbwaW2QzMKclni+WxMOsV8sB/yn9LyBXd2phguR1COCqVkwG/4dYMlngtaXT5YwaOXJKmbzRVZmC6G+WfPiE4b7Xn6gRd6Mm22crol2MY5PsF2y2Ns/EWpC+uhCN2WLjb7ob9/QnnBI8l7ME9gE+1U78lE/p/ZrAoIzXk4ycawSl2jW+mW006DbGH9qCveF8nsKnKwZJ2dI1oEVHkS4OeIhXLXINqEjSykA77Q+qiwTsjkYepAI8YFbvKm9swfzG7cDtWGEKRweLvHbrC8cQBPnFQWf1bruG0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <34B941F5B759D5429630941A37587F6B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3aeb4c1-d64c-412b-337a-08d6eb4836b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 13:01:11.1541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Brian.Starkey@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3878
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

I haven't looked at any selftests before, but is there any advantage
to using the test harness?
https://www.kernel.org/doc/html/v5.1/dev-tools/kselftest.html#test-harness

Couple of minor things below

On Fri, Jun 07, 2019 at 03:07:19AM +0000, John Stultz wrote:
> Add very trivial allocation and import test for dma-heaps,
> utilizing the vgem driver as a test importer.
>=20
> A good chunk of this code taken from:
>   tools/testing/selftests/android/ion/ionmap_test.c
>   Originally by Laura Abbott <labbott@redhat.com>
>=20
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
> Change-Id: Ib98569fdda6378eb086b8092fb5d6bd419b8d431
> ---
> v2:
> * Switched to use reworked dma-heap apis
> v3:
> * Add simple mmap
> * Utilize dma-buf testdev to test importing
> v4:
> * Rework to use vgem
> * Pass in fd_flags to match interface changes
> * Skip . and .. dirs
> ---
>  tools/testing/selftests/dmabuf-heaps/Makefile |  11 +
>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 232 ++++++++++++++++++
>  2 files changed, 243 insertions(+)
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>=20
> diff --git a/tools/testing/selftests/dmabuf-heaps/Makefile b/tools/testin=
g/selftests/dmabuf-heaps/Makefile
> new file mode 100644
> index 000000000000..c414ad36b4bf
> --- /dev/null
> +++ b/tools/testing/selftests/dmabuf-heaps/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +CFLAGS +=3D -static -O3 -Wl,-no-as-needed -Wall
> +#LDLIBS +=3D -lrt -lpthread -lm
> +
> +# these are all "safe" tests that don't modify
> +# system time or require escalated privileges
> +TEST_GEN_PROGS =3D dmabuf-heap
> +

newline

> +
> +include ../lib.mk
> +
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/t=
esting/selftests/dmabuf-heaps/dmabuf-heap.c
> new file mode 100644
> index 000000000000..33d4b105c673
> --- /dev/null
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <dirent.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +
> +#include <linux/dma-buf.h>
> +#include <drm/drm.h>
> +
> +
> +#include "../../../../include/uapi/linux/dma-heap.h"
> +
> +#define DEVPATH "/dev/dma_heap"
> +
> +int check_vgem(int fd)

Functions can be static

> +{
> +	drm_version_t version =3D { 0 };
> +	char name[5];
> +	int ret;
> +
> +	version.name_len =3D 4;
> +	version.name =3D name;
> +
> +	ret =3D ioctl(fd, DRM_IOCTL_VERSION, &version);
> +	if (ret)
> +		return 1;
> +
> +	return strcmp(name, "vgem");
> +}
> +
> +int open_vgem(void)
> +{
> +	int i, fd;
> +	const char *drmstr =3D "/dev/dri/card";
> +
> +	fd =3D -1;
> +	for (i =3D 0; i < 16; i++) {
> +		char name[80];
> +
> +		sprintf(name, "%s%u", drmstr, i);
> +
> +		fd =3D open(name, O_RDWR);
> +		if (fd < 0)
> +			continue;
> +
> +		if (check_vgem(fd)) {

It's a minor thing, but the naming vs the logic reads backwards to me
here. I'd expect check_vgem() to return true for vgem.

> +			close(fd);
> +			continue;
> +		} else {
> +			break;
> +		}
> +
> +	}
> +	return fd;
> +}
> +
> +int import_vgem_fd(int vgem_fd, int dma_buf_fd, uint32_t *handle)
> +{
> +	struct drm_prime_handle import_handle =3D { 0 };
> +	int ret;
> +
> +	import_handle.fd =3D dma_buf_fd;
> +	import_handle.flags =3D 0;
> +	import_handle.handle =3D 0;

You could just initialise import_handle directly. Same for the other
functions

> +
> +	ret =3D ioctl(vgem_fd, DRM_IOCTL_PRIME_FD_TO_HANDLE, &import_handle);
> +	if (ret =3D=3D 0)
> +		*handle =3D import_handle.handle;
> +	return ret;
> +}
> +
> +void close_handle(int vgem_fd, uint32_t handle)
> +{
> +	struct drm_gem_close close =3D { 0 };
> +
> +	close.handle =3D handle;
> +	ioctl(vgem_fd, DRM_IOCTL_GEM_CLOSE, &close);
> +}
> +
> +
> +int dmabuf_heap_open(char *name)
> +{
> +	int ret, fd;
> +	char buf[256];
> +
> +	ret =3D sprintf(buf, "%s/%s", DEVPATH, name);
> +	if (ret < 0) {
> +		printf("sprintf failed!\n");
> +		return ret;
> +	}
> +
> +	fd =3D open(buf, O_RDWR);
> +	if (fd < 0)
> +		printf("open %s failed!\n", buf);
> +	return fd;
> +}
> +
> +int dmabuf_heap_alloc(int fd, size_t len, unsigned int flags, int *dmabu=
f_fd)
> +{
> +	struct dma_heap_allocation_data data =3D {
> +		.len =3D len,
> +		.fd_flags =3D O_RDWR | O_CLOEXEC,
> +		.heap_flags =3D flags,
> +	};

Like this :-)

> +	int ret;
> +
> +	if (dmabuf_fd =3D=3D NULL)
> +		return -EINVAL;
> +
> +	ret =3D ioctl(fd, DMA_HEAP_IOC_ALLOC, &data);
> +	if (ret < 0)
> +		return ret;
> +	*dmabuf_fd =3D (int)data.fd;
> +	return ret;
> +}
> +
> +void dmabuf_sync(int fd, int start_stop)
> +{
> +	struct dma_buf_sync sync =3D { 0 };
> +	int ret;
> +
> +	sync.flags =3D start_stop | DMA_BUF_SYNC_RW;
> +	ret =3D ioctl(fd, DMA_BUF_IOCTL_SYNC, &sync);
> +	if (ret)
> +		printf("sync failed %d\n", errno);
> +

newline

> +}
> +
> +#define ONE_MEG (1024*1024)
> +
> +void do_test(char *heap_name)
> +{
> +	int heap_fd =3D -1, dmabuf_fd =3D -1, importer_fd =3D -1;
> +	uint32_t handle =3D 0;
> +	void *p =3D NULL;
> +	int ret;
> +
> +	printf("Testing heap: %s\n", heap_name);
> +
> +	heap_fd =3D dmabuf_heap_open(heap_name);
> +	if (heap_fd < 0)
> +		return;
> +
> +	printf("Allocating 1 MEG\n");
> +	ret =3D dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
> +	if (ret)

It'd be good to print something here so you can easily tell if
allocations are failing.

> +		goto out;
> +
> +	/* mmap and write a simple pattern */
> +	p =3D mmap(NULL,
> +		 ONE_MEG,
> +		 PROT_READ | PROT_WRITE,
> +		 MAP_SHARED,
> +		 dmabuf_fd,
> +		 0);
> +	if (p =3D=3D MAP_FAILED) {
> +		printf("mmap() failed: %m\n");
> +		goto out;
> +	}
> +	printf("mmap passed\n");
> +
> +
> +	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
> +
> +	memset(p, 1, ONE_MEG/2);
> +	memset((char *)p+ONE_MEG/2, 0, ONE_MEG/2);

Are the selftests using the kernel coding style? If so, there's some
spaces missing.

> +	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_END);
> +
> +	importer_fd =3D open_vgem();
> +	if (importer_fd < 0) {
> +		ret =3D importer_fd;
> +		printf("Failed to open vgem\n");
> +		goto out;
> +	}
> +
> +	ret =3D import_vgem_fd(importer_fd, dmabuf_fd, &handle);
> +	if (ret < 0) {
> +		printf("Failed to import buffer\n");
> +		goto out;
> +	}
> +	printf("import passed\n");
> +
> +	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
> +	memset(p, 0xff, ONE_MEG);
> +	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_END);
> +	printf("syncs passed\n");
> +
> +	close_handle(importer_fd, handle);
> +	ret =3D 0;

No need for this

> +
> +out:
> +	if (p)
> +		munmap(p, ONE_MEG);
> +	if (importer_fd >=3D 0)
> +		close(importer_fd);
> +	if (dmabuf_fd >=3D 0)
> +		close(dmabuf_fd);
> +	if (heap_fd >=3D 0)
> +		close(heap_fd);
> +}
> +
> +
> +int main(void)
> +{
> +	DIR *d;
> +	struct dirent *dir;
> +
> +	d =3D opendir(DEVPATH);
> +	if (!d) {
> +		printf("No %s directory?\n", DEVPATH);
> +		return -1;
> +	}
> +
> +	while ((dir =3D readdir(d)) !=3D NULL) {
> +		if (!strncmp(dir->d_name, ".", 2))
> +			continue;
> +		if (!strncmp(dir->d_name, "..", 3))
> +			continue;
> +
> +		do_test(dir->d_name);
> +	}
> +

I know it's only a test, and you're about to exit, but you should
probably still closedir() in case someone copies this code.

Cheers,
-Brian

> +	return 0;
> +}
> --=20
> 2.17.1
>=20
