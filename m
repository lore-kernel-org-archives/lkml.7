Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737B3C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505BA2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="alGd9MvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfGISUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:20:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41329 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbfGISUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:20:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id d17so21200109qtj.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 11:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0AMQxB8fjID6n1nIoBRP/bexLOV4+LcL9MqYB3dLbp0=;
        b=alGd9MvUbfRqM3kWiylqGdR8tXCWntU7urG6O/GicndbUQb45Df3lZ60ss0lN4iTMX
         jILCKJ8XZjIJdyeJ9PcMuePTuVByoJd0pIN6Zvi/4M5oIPlwrKJ9CLBWGL1jSDoRpkf0
         7X2QpEiClR1Sqxlu/X0MWv0BSWiGKT7v524JLl7HEKf6FhOOLIOozehl9Jf+5Bybqzb3
         Yq18ArXRnGQthoo3H5BaaEHVGZOc/wySgb/UPR0PjLwFUdTbZAL5xBFZQi23eAr5VBtf
         IN7pVQ8wypit/IlAEFI+AYFsKgAOblvL17tMEno3+sg80gzfyoxh8k12uI7mGYUEGlMz
         VC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0AMQxB8fjID6n1nIoBRP/bexLOV4+LcL9MqYB3dLbp0=;
        b=YkMWcJRTVzn1VoRGfBRjzwNnNYbHz0MWadwF93Iv/Qm6+3tSZIdzea1Z4CkixnbzCj
         SQ9mEIfh+MU4tpeDIMwS1AAvOJnevEgz9W9oHIU7T0/RCNNJfaPw8bNlbxKkJC8zrc8t
         6KjPcckT3wub1X9Mzb/ssp7bCrx93hSufsbMIj7X+aeRcegik+15yTjY3reH6EBl6jXY
         Sfp+i+ZDLiQFLw+JMZBf9Iim+TDS4AXVYI5oCXcSFcwFdh1aeQRzEN1ESZsVyObq/N2c
         nNV5xitoIn2g0ngrcqMRD0/ykRO3Iz6acJDSArwUgYpTxfjuku+ZU+DMqP9tPf4fhP7z
         QesA==
X-Gm-Message-State: APjAAAVNb+bEExdLjUYidfAaVXbsvMLCQ2AZvKl5ZudWM4CCuaNPVGYC
        1H6nib0K/TuL536qpYKx3UUvFlG6b9g=
X-Google-Smtp-Source: APXvYqw8hj3zXjnTBHv5EU0i1mynT0zTuqlV/Rhh2l9bHQwU9e09NhIl+cnbQoA6x9C2nK4A4lK5kg==
X-Received: by 2002:a0c:81b8:: with SMTP id 53mr19886187qvd.91.1562696421760;
        Tue, 09 Jul 2019 11:20:21 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id k123sm9113056qkf.13.2019.07.09.11.20.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 11:20:21 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [v2 4/5] kexec: use reserved memory for normal kexec reboot
Date:   Tue,  9 Jul 2019 14:20:13 -0400
Message-Id: <20190709182014.16052-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190709182014.16052-1-pasha.tatashin@soleen.com>
References: <20190709182014.16052-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If memory was reserved for the given segment use it directly instead of
allocating on per-page bases. This will avoid relocating this segment to
final destination when machine is rebooted.

This is done on a per segment bases because user might decide to always
load kernel segments at the given address (i.e. non-relocatable kernel),
but load initramfs at reserved address, and thus save reboot time on
copying initramfs if it is large, and reduces reboot performance.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_core.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 932feadbeb3a..2a8d8746e0a1 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -154,6 +154,18 @@ static struct page *kimage_alloc_page(struct kimage *image,
 				       gfp_t gfp_mask,
 				       unsigned long dest);
 
+/* Check whether this segment is fully within the resource */
+static bool segment_is_reserved(struct kexec_segment *seg, struct resource *res)
+{
+	unsigned long mstart = seg->mem;
+	unsigned long mend = mstart + seg->memsz - 1;
+
+	if (mstart < phys_to_boot_phys(res->start) ||
+	    mend > phys_to_boot_phys(res->end))
+		return false;
+	return true;
+}
+
 int sanity_check_segment_list(struct kimage *image)
 {
 	int i;
@@ -246,13 +258,9 @@ int sanity_check_segment_list(struct kimage *image)
 
 	if (image->type == KEXEC_TYPE_CRASH) {
 		for (i = 0; i < nr_segments; i++) {
-			unsigned long mstart, mend;
-
-			mstart = image->segment[i].mem;
-			mend = mstart + image->segment[i].memsz - 1;
 			/* Ensure we are within the crash kernel limits */
-			if ((mstart < phys_to_boot_phys(crashk_res.start)) ||
-			    (mend > phys_to_boot_phys(crashk_res.end)))
+			if (!segment_is_reserved(&image->segment[i],
+						 &crashk_res))
 				return -EADDRNOTAVAIL;
 		}
 	}
@@ -848,12 +856,13 @@ static int kimage_load_normal_segment(struct kimage *image,
 	return result;
 }
 
-static int kimage_load_crash_segment(struct kimage *image,
-					struct kexec_segment *segment)
+static int kimage_load_crash_or_reserved_segment(struct kimage *image,
+						 struct kexec_segment *segment)
 {
-	/* For crash dumps kernels we simply copy the data from
-	 * user space to it's destination.
-	 * We do things a page at a time for the sake of kmap.
+	/*
+	 * For crash dumps and kexec-reserved kernels we simply copy the data
+	 * from user space to it's destination. We do things a page at a time
+	 * for the sake of kmap.
 	 */
 	unsigned long maddr;
 	size_t ubytes, mbytes;
@@ -923,10 +932,14 @@ int kimage_load_segment(struct kimage *image,
 
 	switch (image->type) {
 	case KEXEC_TYPE_DEFAULT:
-		result = kimage_load_normal_segment(image, segment);
+		if (segment_is_reserved(segment, &kexeck_res))
+			result = kimage_load_crash_or_reserved_segment(image,
+								       segment);
+		else
+			result = kimage_load_normal_segment(image, segment);
 		break;
 	case KEXEC_TYPE_CRASH:
-		result = kimage_load_crash_segment(image, segment);
+		result = kimage_load_crash_or_reserved_segment(image, segment);
 		break;
 	}
 
-- 
2.22.0

