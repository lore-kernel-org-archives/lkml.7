Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB301C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818C420854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0s1x8+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfCGAfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:35:17 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35755 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCGAfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:35:17 -0500
Received: by mail-ot1-f65.google.com with SMTP id z19so12559107otm.2;
        Wed, 06 Mar 2019 16:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=YGf5z/1I8Cu2i8LbrxNhN+soNX9B52Mijub6rlc4WZU=;
        b=I0s1x8+fBh9mmhBiUpJfTfq43dSaCCTQNPHBIPvz4UGKBiB1dMI4p+gtQskK8g6UWt
         NvmhiVZVlFOgURFvkGNS5dkA/jbY/aASwhilTiD6oMspkajZL7bH8XtMv4GLUw3xu8Z+
         7I2eXkyb8rZfbc2XXVQyXAOjLyRNQf0FC5mS0Ng1MOsobToLEL8Oa4PBD+KVV4poZdUg
         MW0CrsN+5tVEIIdjLGJvF+eWihDK18nLSJUQrmg07zhvKSRS+lZnXdnwj0qoHBYZEq3G
         LEZic+GWvonEyM3kRws9QqGCpW/mOyaDJJy9o4OGwTOrJV+dUyxigAJLuvcf7LpQ6pFg
         dldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=YGf5z/1I8Cu2i8LbrxNhN+soNX9B52Mijub6rlc4WZU=;
        b=FLhTZr0HgdU5MqVtenOV4HQRnR7V/+IcfHexeaBdrBaTPMJY3gMbZFLRwpmh3zr6ee
         pOulry4FDo0B1GZkLkAtc8cPmKXnpz4M52KKi695nOP9GOtwixL2vwY/cDXCSEo5B82N
         XwQRxlDP+JqbvoD+sE25Inu7/9PT/yA9w/FmQcQwC/wghsONY3TsTC0wmTHB9i7XCTga
         xWnd6t80QYZjOgL9cfoXQyn4TKzmI4MMh1WJmfVDoi4bhe6cXNzjllCbXyzU+SB7QnO7
         9zDY1TaMqmyJPv2DTUz8SFH25TJ1X1aYKVfLbxpJ4k9RBu+qZxDNpmdWg8TXZL+FFU6U
         mEQg==
X-Gm-Message-State: APjAAAWrAZf68IGKqh2IfJO9zrdyN8PzTGrWagrZEjDf7IGeJQXA0yRK
        d/8tcSuhiXsyhn5otdBN6UQ=
X-Google-Smtp-Source: APXvYqxa+KLNBt+1ZOSJVAWjFOCQyK+jvCyFdDoS+Brw+FLkOhiejAsTBNA41dPAcvSqIg7fqZ0E5w==
X-Received: by 2002:a9d:77c7:: with SMTP id w7mr6530870otl.207.1551918916044;
        Wed, 06 Mar 2019 16:35:16 -0800 (PST)
Received: from localhost.localdomain (50-126-100-225.drr01.csby.or.frontiernet.net. [50.126.100.225])
        by smtp.gmail.com with ESMTPSA id g80sm1192115otg.38.2019.03.06.16.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 16:35:15 -0800 (PST)
Subject: Re: [RFC][QEMU Patch] KVM: Enable QEMU to free the pages hinted by
 the guest
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     nitesh@redhat.com
Cc:     yang.zhang.wz@gmail.com, pagupta@redhat.com, kvm@vger.kernel.org,
        riel@surriel.com, david@redhat.com, linux-kernel@vger.kernel.org,
        lcapitulino@redhat.com, linux-mm@kvack.org, wei.w.wang@intel.com,
        aarcange@redhat.com, mst@redhat.com, dhildenb@redhat.com,
        pbonzini@redhat.com, dodgen@google.com, konrad.wilk@oracle.com
Date:   Wed, 06 Mar 2019 16:35:13 -0800
Message-ID: <20190307003207.25058.4638.stgit@localhost.localdomain>
In-Reply-To: <CAKgT0Ue=kGB4D2oV1WUmWHiYhrXa64KWBP2ZhLgHNgvWyOng5A@mail.gmail.com>
References: <CAKgT0Ue=kGB4D2oV1WUmWHiYhrXa64KWBP2ZhLgHNgvWyOng5A@mail.gmail.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some changes I made to your patch in order to address the sizing
issue I called out. You may want to try testing with this patch applied to
your QEMU as I am finding it is making a signficant difference. It has cut
the test time for the 32G memhog test I called out earlier in half.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/virtio/virtio-balloon.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index d2cf66ada3c0..3ca6b1c6d511 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -285,7 +285,7 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
     balloon_stats_change_timer(s, 0);
 }
 
-static void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, Error **errp)
+static void *gpa2hva(MemoryRegion **p_mr, unsigned long *size, hwaddr addr, Error **errp)
 {
     MemoryRegionSection mrs = memory_region_find(get_system_memory(),
                                                  addr, 1);
@@ -302,6 +302,7 @@ static void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, Error **errp)
     }
 
     *p_mr = mrs.mr;
+    *size = mrs.mr->size - mrs.offset_within_region;
     return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region);
 }
 
@@ -313,30 +314,35 @@ void page_hinting_request(uint64_t addr, uint32_t len)
     struct guest_pages *guest_obj;
     int i = 0;
     void *hvaddr_to_free;
-    unsigned long pfn, pfn_end;
     uint64_t gpaddr_to_free;
-    void * temp_addr = gpa2hva(&mr, addr, &local_err);
+    unsigned long madv_size, size;
+    void * temp_addr = gpa2hva(&mr, &madv_size, addr, &local_err);
 
     if (local_err) {
         error_report_err(local_err);
         return;
     }
+    if (madv_size < sizeof(*guest_obj)) {
+	printf("\nBad guest object ptr\n");
+	return;
+    }
     guest_obj = temp_addr;
     while (i < len) {
-        pfn = guest_obj[i].pfn;
-	pfn_end = guest_obj[i].pfn + (1 << guest_obj[i].order) - 1;
-	trace_virtio_balloon_hinting_request(pfn,(1 << guest_obj[i].order));
-	while (pfn <= pfn_end) {
-	        gpaddr_to_free = pfn << VIRTIO_BALLOON_PFN_SHIFT;
-	        hvaddr_to_free = gpa2hva(&mr, gpaddr_to_free, &local_err);
+        gpaddr_to_free = guest_obj[i].pfn << VIRTIO_BALLOON_PFN_SHIFT;
+	size = (1 << VIRTIO_BALLOON_PFN_SHIFT) << guest_obj[i].order;
+	while (size) {
+	        hvaddr_to_free = gpa2hva(&mr, &madv_size, gpaddr_to_free, &local_err);
 	        if (local_err) {
 			error_report_err(local_err);
 		        return;
 		}
-		ret = qemu_madvise((void *)hvaddr_to_free, 4096, QEMU_MADV_DONTNEED);
+		if (size < madv_size)
+			madv_size = size;
+		ret = qemu_madvise((void *)hvaddr_to_free, madv_size, QEMU_MADV_DONTNEED);
 		if (ret == -1)
 		    printf("\n%d:%s Error: Madvise failed with error:%d\n", __LINE__, __func__, ret);
-		pfn++;
+		gpaddr_to_free += madv_size;
+		size -= madv_size;
 	}
 	i++;
     }

