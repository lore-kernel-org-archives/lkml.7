Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A66C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3063218BB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfGEIpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 04:45:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfGEIpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 04:45:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B858356F5;
        Fri,  5 Jul 2019 08:45:44 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DFA68226B;
        Fri,  5 Jul 2019 08:45:44 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 2E56241F53;
        Fri,  5 Jul 2019 08:45:44 +0000 (UTC)
Date:   Fri, 5 Jul 2019 04:45:43 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jakub Staron <jstaron@google.com>,
        Cornelia Huck <cohuck@redhat.com>
Message-ID: <616554090.39241752.1562316343431.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190705172025.46abf71e@canb.auug.org.au>
References: <20190705172025.46abf71e@canb.auug.org.au>
Subject: Re: linux-next: build failure after merge of the nvdimm tree
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.94, 10.4.195.8]
Thread-Topic: linux-next: build failure after merge of the nvdimm tree
Thread-Index: Op/Rg61sZFtHh9tTxUrITohvbGX3Ig==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 05 Jul 2019 08:45:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Stephen,
> 
> Hi all,
> 
> After merging the nvdimm tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> In file included from :32:
> ./usr/include/linux/virtio_pmem.h:19:2: error: unknown type name 'uint64_t'
>   uint64_t start;
>   ^~~~~~~~
> ./usr/include/linux/virtio_pmem.h:20:2: error: unknown type name 'uint64_t'
>   uint64_t size;
>   ^~~~~~~~
> 
> Caused by commit
> 
>   403b7f973855 ("virtio-pmem: Add virtio pmem driver")
> 
> I have used the nvdimm tree from next-20190704 for today.

Thank you for the report.

Can we apply below patch [1] on top to complete linux-next build for today.
I have tested this locally.

Thanks,
Pankaj

========

[1]

diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
index 998efbc7660c..dbc12dfe8067 100644
--- a/drivers/nvdimm/virtio_pmem.h
+++ b/drivers/nvdimm/virtio_pmem.h
@@ -46,8 +46,8 @@ struct virtio_pmem {
        spinlock_t pmem_lock;
 
        /* Memory region information */
-       uint64_t start;
-       uint64_t size;
+       u64 start;
+       u64 size;
 };
 
 void virtio_pmem_host_ack(struct virtqueue *vq);
diff --git a/include/uapi/linux/virtio_pmem.h b/include/uapi/linux/virtio_pmem.h
index 379861f114f1..efcd72f2d20d 100644
--- a/include/uapi/linux/virtio_pmem.h
+++ b/include/uapi/linux/virtio_pmem.h
@@ -11,25 +11,24 @@
 #define _UAPI_LINUX_VIRTIO_PMEM_H
 
 #include <linux/types.h>
-#include <linux/virtio_types.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
 
 struct virtio_pmem_config {
-       uint64_t start;
-       uint64_t size;
+       __u64 start;
+       __u64 size;
 };
 
 #define VIRTIO_PMEM_REQ_TYPE_FLUSH      0
 
 struct virtio_pmem_resp {
        /* Host return status corresponding to flush request */
-       __virtio32 ret;
+       __u32 ret;
 };
 
 struct virtio_pmem_req {
        /* command type */
-       __virtio32 type;
+       __u32 type;
 };
