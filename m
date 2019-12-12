Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2E0C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017AE206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbfLLOtG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:49:06 -0500
Received: from mga01.intel.com ([192.55.52.88]:62440 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729640AbfLLOtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:49:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 06:49:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600"; 
   d="scan'208";a="245748962"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga002.fm.intel.com with ESMTP; 12 Dec 2019 06:49:05 -0800
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Dec 2019 06:49:05 -0800
Received: from fmsmsx107.amr.corp.intel.com ([169.254.6.96]) by
 fmsmsx101.amr.corp.intel.com ([169.254.1.124]) with mapi id 14.03.0439.000;
 Thu, 12 Dec 2019 06:49:05 -0800
From:   "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To:     Gerd Hoffmann <kraxel@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        "gurchetansingh@chromium.org" <gurchetansingh@chromium.org>
Subject: RE: [PATCH] drm/virtio: fix mmap page attributes
Thread-Topic: [PATCH] drm/virtio: fix mmap page attributes
Thread-Index: AQHVrzjyVT6cHGbxNE67i4kUKKmNL6e2l33w
Date:   Thu, 12 Dec 2019 14:49:04 +0000
Message-ID: <14063C7AD467DE4B82DEDB5C278E8663EE148E5D@fmsmsx107.amr.corp.intel.com>
References: <20191210085759.14763-1-kraxel@redhat.com>
In-Reply-To: <20191210085759.14763-1-kraxel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTQxNTkzOTMtMDdjOC00MzQ0LTgyNjMtZjk0NDA5MTY0ZGVmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiS3hMREFEWnJxV3FlRmY4RTd2U0JLaDhpeHlwU29CaHhUTVo0TjNCRU1vVksrM1gxR0pnSHhVZXFBUWx5NjdJaiJ9
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
>Gerd Hoffmann
>Sent: Tuesday, December 10, 2019 3:58 AM
>To: dri-devel@lists.freedesktop.org
>Cc: David Airlie <airlied@linux.ie>; open list <linux-kernel@vger.kernel.org>;
>open list:VIRTIO GPU DRIVER <virtualization@lists.linux-foundation.org>;
>Gerd Hoffmann <kraxel@redhat.com>; gurchetansingh@chromium.org
>Subject: [PATCH] drm/virtio: fix mmap page attributes
>
>virtio-gpu uses cached mappings.  shmem helpers use writecombine though.
>So roll our own mmap function, wrapping drm_gem_shmem_mmap(), to
>tweak
>vm_page_prot accordingly.
>
>Reported-by: Gurchetan Singh <gurchetansingh@chromium.org>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> drivers/gpu/drm/virtio/virtgpu_object.c | 18 +++++++++++++++++-
> 1 file changed, 17 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c
>b/drivers/gpu/drm/virtio/virtgpu_object.c
>index 017a9e0fc3bb..158610902054 100644
>--- a/drivers/gpu/drm/virtio/virtgpu_object.c
>+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
>@@ -75,6 +75,22 @@ static void virtio_gpu_free_object(struct
>drm_gem_object *obj)
> 	drm_gem_shmem_free_object(obj);
> }
>
>+static int virtio_gpu_gem_mmap(struct drm_gem_object *obj, struct
>vm_area_struct *vma)
>+{
>+	pgprot_t prot;
>+	int ret;
>+
>+	ret = drm_gem_shmem_mmap(obj, vma);
>+	if (ret < 0)
>+		return ret;
>+
>+	/* virtio-gpu needs normal caching, so clear writecombine */

A minor nit. 

I was looking at this code, trying to see where you were clearing the
writecombine bit.

Maybe a more clear comment would be:

virtio-gpu needs normal caching, re-do protection without writecombine

?

Mike

>+	prot = vm_get_page_prot(vma->vm_flags);
>+	prot = pgprot_decrypted(prot);
>+	vma->vm_page_prot = prot;
>+	return 0;
>+}
>+
> static const struct drm_gem_object_funcs virtio_gpu_gem_funcs = {
> 	.free = virtio_gpu_free_object,
> 	.open = virtio_gpu_gem_object_open,
>@@ -86,7 +102,7 @@ static const struct drm_gem_object_funcs
>virtio_gpu_gem_funcs = {
> 	.get_sg_table = drm_gem_shmem_get_sg_table,
> 	.vmap = drm_gem_shmem_vmap,
> 	.vunmap = drm_gem_shmem_vunmap,
>-	.mmap = &drm_gem_shmem_mmap,
>+	.mmap = &virtio_gpu_gem_mmap,
> };
>
> struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev,
>--
>2.18.1
>
>_______________________________________________
>dri-devel mailing list
>dri-devel@lists.freedesktop.org
>https://lists.freedesktop.org/mailman/listinfo/dri-devel
