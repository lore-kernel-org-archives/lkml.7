Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8931EC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589B52187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbfKGKKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:10:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfKGKKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:10:38 -0500
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 88CD43D15
        for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2019 10:10:38 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id v6so702874wrm.18
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 02:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OCIqyJJdOW00bPyctKLkzxNP0EVAczBbs1eO7W8t2tM=;
        b=O2W4E9qpC+kKphSx43wA7mdMbl5fsZAg/Ai12K1x6VAGMn+OtJqKlOhRYzGHGGOEtv
         CzKHURNq5K6vbDvY2zQud0cwGT2youYquE9yUnYn7ag087wk8ZVsECLnS0lCssJ6xvfX
         j8jwRRYMsNuInTRiOIBlKUKak4AyUryhslWA7N/1uF4H+j1fXySCdAK2U9eeQzF8uUKU
         tglpCIcHpZzXRqOjiU7d71QADxeM0aFhZH1ZljkHqCnc9iNCHR1d5zViwaIOpUCau/SA
         AGlcK5qI11ONrrAKKoYgs3uZUyYkKNuxPxWDXxNWzlGn1T12iT04er4KWvV9unumHXj1
         3tJA==
X-Gm-Message-State: APjAAAUEOqWe3G8E33gu/EbalmzK3OHMfID1Sr+/bhy4PMPKcjP0m53w
        gMWxBLBOWfdHeo3Is+s2k+eoIfF/OEh7hsF5n6BiLcO1HwwsFhMsp57CalOKb0V//4WsHb947bw
        BZHi6WPsP/opES3DwUQWDGuCi
X-Received: by 2002:a5d:6789:: with SMTP id v9mr2001968wru.344.1573121436853;
        Thu, 07 Nov 2019 02:10:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqwVrO1kZIfHP7MQ5tgPYumXgK/TKMlvQ8AyGBFuR4+U8dCNxxCN3OTkTO6xgcYkWl6NDneBuw==
X-Received: by 2002:a5d:6789:: with SMTP id v9mr2001944wru.344.1573121436558;
        Thu, 07 Nov 2019 02:10:36 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y17sm1836077wrs.58.2019.11.07.02.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 02:10:35 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: coalesced_mmio: cleanup kvm_coalesced_mmio_init()
Date:   Thu,  7 Nov 2019 11:10:34 +0100
Message-Id: <20191107101034.29675-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither 'ret' variable nor 'out_err' label is really needed.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 virt/kvm/coalesced_mmio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
index 8ffd07e2a160..00c747dbc82e 100644
--- a/virt/kvm/coalesced_mmio.c
+++ b/virt/kvm/coalesced_mmio.c
@@ -110,14 +110,11 @@ static const struct kvm_io_device_ops coalesced_mmio_ops = {
 int kvm_coalesced_mmio_init(struct kvm *kvm)
 {
 	struct page *page;
-	int ret;
 
-	ret = -ENOMEM;
 	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 	if (!page)
-		goto out_err;
+		return -ENOMEM;
 
-	ret = 0;
 	kvm->coalesced_mmio_ring = page_address(page);
 
 	/*
@@ -128,8 +125,7 @@ int kvm_coalesced_mmio_init(struct kvm *kvm)
 	spin_lock_init(&kvm->ring_lock);
 	INIT_LIST_HEAD(&kvm->coalesced_zones);
 
-out_err:
-	return ret;
+	return 0;
 }
 
 void kvm_coalesced_mmio_free(struct kvm *kvm)
-- 
2.20.1

