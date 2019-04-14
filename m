Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892DAC282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 23:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C3F2084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 23:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmYsfntZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfDNXhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 19:37:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42441 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfDNXhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 19:37:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id p20so17184660qtc.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 16:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dnth6uGgsbjRRo9enDv6JQm86+Z1MHmnq1viaVNx2Zw=;
        b=gmYsfntZcp/0Uy/WHKZgxee9+Br0FTlIHGGW59GATK3o+NitAEpbVunIzopCxZtQfC
         kqdv9bx2dh3VKD7rVkxD7pYpxGnD5LoQHdfijwQYSkZrOiMP0n0C2J9JkIsYkgnrzd7a
         nfZCMKTAaj+ss69MBe4MKRtQPc3Nrs2OZqH1YDIgRhy+QTR8jokMVj38tn3pKQ7Lh6wf
         m57u7cXepwlWj0OFoY+TYpW7fi4DbwrDDely/ffbU1FrUlBhwkYUZVNZMfFp2QsqadfK
         K7A8rzRdSJH88zNSVL0OgskwMQVJxsJT6FL/VLwuIYT9cBnXmvyF66G6WYgQ7GbncWo8
         pPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dnth6uGgsbjRRo9enDv6JQm86+Z1MHmnq1viaVNx2Zw=;
        b=Lbc3oABwLjIPyyI72kM7HsDVevhIUJ7z80vL5kypGNuuTRXoRnMgcFFxI8YNGFPlOQ
         hmgtTTbGuIF/iisJUeSxFtldrqCdEVAmtFjLHB9GubCeytpWVz04gMJgGHhi2VnZnzPt
         lykzLBinkkyi5V25r4c6nAcP0VJLw7us8KowtT9GfOsvDCpcM7URSkf0Snh5+dNn9Im9
         IHscfr8qc0QfVJHnq2tp+kJeV04Emq2B2yKJ8LgmhrM9zO2umBsQ8RYupRNYjX8gPciX
         BJF27klE95BU70DZ4kBOj12DF/AvcNiaoixtWjjYASliiSo4Tiqj9VXE8+s8pZZJAA85
         RAUA==
X-Gm-Message-State: APjAAAUyRXwZPLws7kuhsqBV+wtkVbPvCyeunkxQ0Eu2ERyvCrIC06Fb
        d7l3uHmgA3qhPzsvnwqlC0A=
X-Google-Smtp-Source: APXvYqyP12/iqhpuAztqZ7V32+Z/Hn1Q5IgkLKD/wSqSQbhf+xm4rUdD7qE+VzwchRHRoKw/oDSphg==
X-Received: by 2002:ac8:1a34:: with SMTP id v49mr57500304qtj.236.1555285070723;
        Sun, 14 Apr 2019 16:37:50 -0700 (PDT)
Received: from debian (hlfxns017vw-142-68-56-253.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.56.253])
        by smtp.gmail.com with ESMTPSA id c9sm28159291qkb.86.2019.04.14.16.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 16:37:50 -0700 (PDT)
From:   Brian Yip <itsbriany@gmail.com>
To:     christian.koenig@amd.com
Cc:     ray.huang@amd.com, Jerry.Zhang@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Brian Yip <itsbriany@gmail.com>
Subject: [PATCH 1/3] drm/ttm: Reset num_zones on ttm_mem_global cleanup
Date:   Sun, 14 Apr 2019 23:37:27 +0000
Message-Id: <20190414233729.17956-2-itsbriany@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190414233729.17956-1-itsbriany@gmail.com>
References: <20190414233729.17956-1-itsbriany@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

num_zones in the ttm_mem_global structure was never reset after calling
ttm_mem_global_release(). Consequently, when multiple GPU drivers
are loaded, and the first one fails to load its firmware, the second
driver will attempt to load its own firmware. Initializing the
second driver invokes ttm_mem_global_init where ttm_mem_global.num_zones
is eventually incremented beyond TTM_MEM_MAX_ZONES.
ttm_mem_global.num_zones is then used to dereference a ttm_mem_zone beyond
the amount of ttm_mem_zones allocated, resulting in a crash.

Signed-off-by: Brian Yip <itsbriany@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_memory.c b/drivers/gpu/drm/ttm/ttm_memory.c
index 699fed9e08ee..55ccb9800893 100644
--- a/drivers/gpu/drm/ttm/ttm_memory.c
+++ b/drivers/gpu/drm/ttm/ttm_memory.c
@@ -478,6 +478,9 @@ void ttm_mem_global_release(struct ttm_mem_global *glob)
 			}
 	kobject_del(&glob->kobj);
 	kobject_put(&glob->kobj);
+
+	if (!kref_read(&glob->kobj.kref))
+		glob->num_zones = 0;
 }
 
 static void ttm_check_swapping(struct ttm_mem_global *glob)
-- 
2.20.1

