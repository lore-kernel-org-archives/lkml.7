Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A394C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 09:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C772064A
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 09:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="QvbD271P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfJMJDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 05:03:36 -0400
Received: from mout.web.de ([212.227.15.3]:44311 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728564AbfJMJDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 05:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570957412;
        bh=/JJFbFxFpJrgt1MfB1+HlUCk144HJzeGsZ82FMM6IMw=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:Date;
        b=QvbD271PhVgYqWNLqHU0fg6xi+XVo+jTS/b+UHmTQn+3xBLOShASoEVhKgg8CQCMZ
         JrA0end3XYxHStzGBd+xSCWSf4LeggpnnnWKDX50dFhCFkL9pq4FfexwdisEY6tS5s
         ylE5yKrta/vQnqwZ3tb0PcdVCA0Ky/CgXsmg5a0c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.55.156]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWuiC-1iXnFP3geq-00W1Yx; Sun, 13
 Oct 2019 11:03:31 +0200
From:   Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH] tools/virtio: Fix build
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <4b686914-075b-a0a9-c97b-9def82ee0336@web.de>
Date:   Sun, 13 Oct 2019 11:03:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZUTxknunf3G6Pgr3vAD78vi2eR7WdAXKm8qBbLV5J2t/U4o/4EZ
 TZ6oSJMqVZN1Rm1Xnf4Vwx/O9ojkaI8y5NJmLT1fwtdJtkwS9txiGev7dCd8/2y4ECRTtwQ
 z04XbSrZje/K+9Z0z31XxJub0b6k32mvx6LiSpteJ4IWLEianalNbu8aN5qmPaLh4PvrzZa
 ig6WmprlS1YhpLl3QcjHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7nlS2ZaQecY=:08CSwSG22S349Q6b6tO8u6
 rdaiZ7Q4U9RWlP1P4AdTDwfQVBpkZISmu3BOb+eUDH/TaKaNewNeXTsbuaBJ33t555KTe2Yd5
 veocItfCWbO3siPsFa3C6QBbeuGz7sbaR+IsogHABwlrRswYGlYWHiJTvskJOfkY6Q8BPaNnA
 KfIvgw08/iTnVHXCnBX5wF7+Q6mxb2eJPObAdKLvGyCmizrwYirjJc3SItHJEjehGAOgz8zo2
 OR4sA4gVcW8gWYDy0M/yM/h+3RmgPws0gGF+dq6QkTKrMx/CLWdGXTv2tRLsvBTzCvar1TLtS
 ZgY8Fa03EG1hJXWKZarAiYnPdxMsfzmo/aYVBlukvhwneADSi1pNXsWf4LpMedeMcRx9a+fSi
 f3e/tVcTXwmH5SBvKihON99ZTP9w5E+4wPdz1jqdNkkWFC8bXsLIt14VjcEZS0MiMifqeeDOm
 0m0lS3gMJd7zXfUjAZ1Tl9bloTvv7YaqJdHyA3Qh+8CxnEeinioCxcv9ZhlYHkKvOWnL9ubq7
 wrKXpfFP+p+HJfx4jsSu52Sz9S3sxa9w6ZeB3GBIbcdHuxSJncSsJDHED6MwptZKJTsgNQ//N
 NNBTIXO55iyvd18IYqkiw3Q0skVvqfiFAUCqI9VLnSamjBx+iwIrlopxUNrf8gs4QJmiK5fv4
 yQjre/RtXOqszthoWG84RdhyQm0zQfRbP+t0UqsJv7Aa6bWya9rEMhaySSrqp2UiEHq6g+2fY
 ioWkZZkQv7KcAzaRy42E3MZRMt59ucL4z3PGzqGtNSvdw6aaY6PBwaByo3I00ALQDFTISx+9i
 sFvRksKk5B5XCt3KjcRoSjLlyviJkkiEYZypOXq4OUnOEXwHgu1uvB4b7racTk5PMxVwIb5hq
 TQbicqdvS+5zw0EYw+UGjZUIZjmJX+4zhcAdapmdrfwS9YFbrXG+RBK1aJjl8F1bGqcjl5QfS
 30qtKq3InUyZlAyZdEL/WFN7geUmORPuIuUkEOSr73Sv8p4z1ZEoucHWc2fNQFPILPNxgTCJ+
 3xV3vpYeyqMj3fWuT9S8vgJp/69JbuM1WZ5LW/sN5Yhvvf7GYVRBSgFq++PYxzswIdtCqCWZq
 jt1PDcHmB1g1eLcHD0/Vv5cyqCVUwbkK7pSJVj4/rki3JRi7Ru7U6LHb5zmntyT9Eg7X9nJ/3
 lWNk1Saag3CPODdOf7dMKyuW/UhbNvTuVe49WL8hjEPxPAlDFedtGsme2kNVtkX7sFuA24Txx
 Vzb04B4990YG4zitAZnvFLJFl6NtY7M99aZiC5xYWa8VoDGwLdZsMqNvXA+k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Various changes in the recent kernel versions broke the build due to
missing function and header stubs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 tools/virtio/crypto/hash.h       | 0
 tools/virtio/linux/dma-mapping.h | 2 ++
 tools/virtio/linux/kernel.h      | 2 ++
 3 files changed, 4 insertions(+)
 create mode 100644 tools/virtio/crypto/hash.h

diff --git a/tools/virtio/crypto/hash.h b/tools/virtio/crypto/hash.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-map=
ping.h
index f91aeb5fe571..db96cb4bf877 100644
=2D-- a/tools/virtio/linux/dma-mapping.h
+++ b/tools/virtio/linux/dma-mapping.h
@@ -29,4 +29,6 @@ enum dma_data_direction {
 #define dma_unmap_single(...) do { } while (0)
 #define dma_unmap_page(...) do { } while (0)

+#define dma_max_mapping_size(d)	0
+
 #endif
diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 6683b4a70b05..ccf321173210 100644
=2D-- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -141,4 +141,6 @@ static inline void free_page(unsigned long addr)
 #define list_for_each_entry(a, b, c) while (0)
 /* end of stubs */

+#define xen_domain() 0
+
 #endif /* KERNEL_H */
=2D-
2.16.4

