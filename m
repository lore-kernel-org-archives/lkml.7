Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9440C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F19206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbfCFLGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:06:14 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:46255 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbfCFLGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:06:13 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mhl0I-1hWAM01cKe-00dnQT; Wed, 06 Mar 2019 12:06:04 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vhost: silence an unused-variable warning
Date:   Wed,  6 Mar 2019 12:05:49 +0100
Message-Id: <20190306110602.2529137-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:00mDL8GvVd7KPBcJIzQn94nsSHWgxbvnaLDlVUbH50FOrZMdvRO
 QBEa+Zznpu/jFO2HI0BU2n5H0FcCtZ/xjFGPHcAJkwvBQkD4oQFx1skRY1E9sHMKlVLOEkn
 IflLyAsOEH0qyylRUx2yVvUM+b7oQ+bzH6hXmVTkDqISfXn2m4N4pNffR/4LRBrdLgVHbXC
 JrwkOdnAuTwxXAGejKzjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ouIxrelqti4=:zDF4itJL8Nvj2UbKQ0R/Me
 y+O/+E9CHpZ0IBFG2dl8uhyF0oEF7rK+9jIVR+4BRFKWiVu5aRmPB/Bcff4BLDUn19j1sJZhq
 XEWXlD311J6EeTSwwj691chpwdVkFdH5DmwQ35CBOUnmEfHILdagn62PlcLnaB6/MY4r8Cdfg
 uZLfjVI9k4+CH8hgnlxjvzkVnIUomQ8CrK7O8ZDYnLxUW3ODYkb1hfJY8A4062HRL5hLjGvjO
 dJ8AdqMzVEvDwzr7cY8UmqpCO+CR66dlejh24YB83IxiIugUTmhAcNiPUK94VsV6oG7Pw6Dy5
 VL/9pb2BzOeNAtwT0Oks5drBD7xNyLOgbhz5UFeBFVdo5Nm3kI754rV5zUpK7X9csgfW+Ep9e
 pFBKcPkNh+a13HIrLNg2cGnrMAV/prV3fGvO4wa/B09Ilvm7EevAV1i/kOcFlOtgDcoHznuWA
 tjGGSHsttLvN4V6bp2U+b26M84DKTKUqEQKSqWasxtfc3HcaBn8UMLPsNWvFl2vuj29BxsesI
 ISnCckM6Wg/r6Ty2uSIgoITXj0fjNQri0J7s1/zcK5p8MNtc5eKA6HrX9E2BW/HvcpllQ6efu
 +ZnkYrvQiPzAi3u8+KPU815uwzX0UQebLisLyeOxmYITqJKm91aPYIQpdPDgibx46e3PS3W+L
 GiSNYDt3buZWBJhPBLE2pah9xPP3kxn+79QK68ZuoQGW534yds9GmtzU1af/93fWrORz9FkhR
 8E08DArZ0bjWjy6W1lb6LT07jcpKzJqUkgiHYA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some architectures, the MMU can be disabled, leading to access_ok()
becoming an empty macro that does not evaluate its size argument,
which in turn produces an unused-variable warning:

drivers/vhost/vhost.c:1191:9: error: unused variable 's' [-Werror,-Wunused-variable]
        size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;

Mark the variable as __maybe_unused to shut up that warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a2e5dc7716e2..5ace833de746 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1188,7 +1188,7 @@ static bool vq_access_ok(struct vhost_virtqueue *vq, unsigned int num,
 			 struct vring_used __user *used)
 
 {
-	size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
+	size_t s __maybe_unused = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
 
 	return access_ok(desc, num * sizeof *desc) &&
 	       access_ok(avail,
-- 
2.20.0

