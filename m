Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AE0C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A74B20721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Is4ax+3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbgAIO6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:58:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43109 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732063AbgAIO6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578581897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+zy2FHQw9KFVxtHaLqa0r2t8FDa4q1KvvQqvnAapvQ=;
        b=Is4ax+3nE1/Zj+uegsHnlJ+F+EMC6DIy/p7yoqjeUU3Mo2+OZ80Kx3YH5WEZV86Lvxd9SY
        qb/11Bt5eBGC18QM89doiBTZpeLmIB+l1vlyh3WufEaBQP+6/A1eGrYJHBWRIWRKNnB3GG
        1w5QjHu8gTDZZnDX2RVlLGEFDiSZi0k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-jBRoWBfdMUqPm4wQPByJZA-1; Thu, 09 Jan 2020 09:58:16 -0500
X-MC-Unique: jBRoWBfdMUqPm4wQPByJZA-1
Received: by mail-qk1-f198.google.com with SMTP id k10so4299968qki.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v+zy2FHQw9KFVxtHaLqa0r2t8FDa4q1KvvQqvnAapvQ=;
        b=Mp2vv3Sevm9bOxqr/A0hcoPuN/d04bPh3rPyzi+kubYuaey0sW0/y9Gn80TbnqQQ6b
         07v4bK1SxsNH8MOPcC+ZBlx+d1A2RHPJt+Zr5nPGSMBSwj3jZkLTvWiTfU/KILf1JKGM
         +kfufm0lkqbFHpYWdRNx3cuorQYHtGcLRjCMqtWsoIGOaEnAeJFr1FqZ5tbGY3dFz728
         v9XMGHd2yFDsMZYowCrChQzQxKVa6W9yRCecddkIc32uOoR2Lp/+ihTAyC1swHHgW2F8
         m70yxpY+97xI6YlgH2NgDrpdUKSHMb5sm2Oc+RgnVNGTrx7JqERWsYxAVNwTDwInjnP4
         ZIuQ==
X-Gm-Message-State: APjAAAU/oHx/ZMGhN9IpAyTwUJ0mKvHjlYMN39QI1k8crU+/YqrAo3Pm
        EA0yQ+RhShvHoFXtkAe9+LlTo69aTsKQfg/XnpB+IYT6/tgJco4UANbrITcLDip/7JkOEMUo57/
        6dbBmr+XHZasB/YLuDBFQ5BB0
X-Received: by 2002:a37:9ace:: with SMTP id c197mr10113189qke.482.1578581895510;
        Thu, 09 Jan 2020 06:58:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqztXceCqR3GxYbBVVwKVyCXfRviIN28zAumlgJGOwqri1GbhE+3hiqmzypgekRZtjwYhslICg==
X-Received: by 2002:a37:9ace:: with SMTP id c197mr10113165qke.482.1578581895289;
        Thu, 09 Jan 2020 06:58:15 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q2sm3124179qkm.5.2020.01.09.06.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:58:14 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, peterx@redhat.com,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v3 15/21] KVM: selftests: Always clear dirty bitmap after iteration
Date:   Thu,  9 Jan 2020 09:57:23 -0500
Message-Id: <20200109145729.32898-16-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109145729.32898-1-peterx@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't clear the dirty bitmap before because KVM_GET_DIRTY_LOG will
clear it for us before copying the dirty log onto it.  However we'd
still better to clear it explicitly instead of assuming the kernel
will always do it for us.

More importantly, in the upcoming dirty ring tests we'll start to
fetch dirty pages from a ring buffer, so no one is going to clear the
dirty bitmap for us.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 5614222a6628..3c0ffd34b3b0 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -197,7 +197,7 @@ static void vm_dirty_log_verify(unsigned long *bmap)
 				    page);
 		}
 
-		if (test_bit_le(page, bmap)) {
+		if (test_and_clear_bit_le(page, bmap)) {
 			host_dirty_count++;
 			/*
 			 * If the bit is set, the value written onto
-- 
2.24.1

