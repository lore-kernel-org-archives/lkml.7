Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D1FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9312339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBcsbaFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbfHUO77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:59:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36812 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729532AbfHUO76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:59:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id w2so1610962pfi.3;
        Wed, 21 Aug 2019 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=N1FHoD6ZMNB/7wrUWG2IW6DScPoWU0//Swe9DNcA3ZM=;
        b=UBcsbaFs+RkamY++8TTiRe++zLe7yNVTPnIrDAYWzm6LUQbTSQ74QNJHEBRItO96HB
         02SZZHn9Htsz1WlaSdRZfvGuzTxKHGWc2BTRrG8pa42ToRFl/TqsOmC4vTT2ZLpLzij6
         J03iEvoiOsR8FEVWAeupmVSAapKUBh+nHpBJ+cYMBiQSo8sRE0exQ70QK2hX8qWFxFm+
         FHNs2+2u0OaVKL3V6vwnYYxHpMBclxb2LKiSbnwwHx9uizE+23ZTc/CC4/wjWPSTQIBA
         pIP+Jl8MJKuDfuNXSD5LHaK9Xckdi2zuiNxbYAPI6XYQpJdxTTG4nezco0WyqReMiODE
         W2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=N1FHoD6ZMNB/7wrUWG2IW6DScPoWU0//Swe9DNcA3ZM=;
        b=pRPvKXZ2nClleDYmwUwma6oxDJtWkeMq8pel/fxQ5NzMLvaFSpAgyWCA4ZlcRq62Rf
         Wy4GMg8g2v08VRoGTNTsb9zIkfTCG6jwkkXsXatSb66SUm+iFlPCoGOwP5vs/zznHUI+
         U3414LXYNFo3KO8QciD3K3CKAfQe8Q4USkt/EuHmwumP6ZrU0i/u5lTWHjTza8gmi9FO
         k82HST1Ri3a3gtLkVFPmlbB4EjsEPCKQ1cXu8Y64AO1XrFkCBum4swIG7qLbO9fJ5cD2
         8hKYBmukKKTWOiYSeYcXnOXfglbxHIDZftn04tRzyoy4xlr7WRlD+6J/HTI6SLCy4a28
         Q3WQ==
X-Gm-Message-State: APjAAAXT6qnRZEomaSRCMvtfPfRsJWJS/vXES3tK7n6xK2XtUR1MKyYE
        ZyCE+N53lP1//wQxVZJZxqs=
X-Google-Smtp-Source: APXvYqw/9ikn+1SlMs8YrpbK4yn240xMzQLoTRxSmZztXZbUiHNDLxVPWA0XUeakX5XWBDpVrXLuOQ==
X-Received: by 2002:a17:90a:8d86:: with SMTP id d6mr430067pjo.94.1566399597619;
        Wed, 21 Aug 2019 07:59:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id y16sm25491605pfn.173.2019.08.21.07.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 07:59:57 -0700 (PDT)
Subject: [PATCH v6 5/6] virtio-balloon: Pull page poisoning config out of
 free page hinting
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     nitesh@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
        david@redhat.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        mhocko@kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        virtio-dev@lists.oasis-open.org, osalvador@suse.de
Cc:     yang.zhang.wz@gmail.com, pagupta@redhat.com, riel@surriel.com,
        konrad.wilk@oracle.com, lcapitulino@redhat.com,
        wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com,
        dan.j.williams@intel.com, alexander.h.duyck@linux.intel.com
Date:   Wed, 21 Aug 2019 07:59:56 -0700
Message-ID: <20190821145956.20926.7187.stgit@localhost.localdomain>
In-Reply-To: <20190821145806.20926.22448.stgit@localhost.localdomain>
References: <20190821145806.20926.22448.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Currently the page poisoning setting wasn't being enabled unless free page
hinting was enabled. However we will need the page poisoning tracking logic
as well for unused page reporting. As such pull it out and make it a
separate bit of config in the probe function.

In addition we can actually wrap the code in a check for NO_SANITY. If we
don't care what is actually in the page we can just default to 0 and leave
it there.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/virtio/virtio_balloon.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 226fbb995fb0..2c19457ab573 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -842,7 +842,6 @@ static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
 static int virtballoon_probe(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb;
-	__u32 poison_val;
 	int err;
 
 	if (!vdev->config->get) {
@@ -909,11 +908,19 @@ static int virtballoon_probe(struct virtio_device *vdev)
 						  VIRTIO_BALLOON_CMD_ID_STOP);
 		spin_lock_init(&vb->free_page_list_lock);
 		INIT_LIST_HEAD(&vb->free_page_list);
-		if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
-			memset(&poison_val, PAGE_POISON, sizeof(poison_val));
-			virtio_cwrite(vb->vdev, struct virtio_balloon_config,
-				      poison_val, &poison_val);
-		}
+	}
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
+		__u32 poison_val = 0;
+
+#if !defined(CONFIG_PAGE_POISONING_NO_SANITY)
+		/*
+		 * Let hypervisor know that we are expecting a specific
+		 * value to be written back in unused pages.
+		 */
+		memset(&poison_val, PAGE_POISON, sizeof(poison_val));
+#endif
+		virtio_cwrite(vb->vdev, struct virtio_balloon_config,
+			      poison_val, &poison_val);
 	}
 	/*
 	 * We continue to use VIRTIO_BALLOON_F_DEFLATE_ON_OOM to decide if a

