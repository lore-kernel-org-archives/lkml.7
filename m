Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817B4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E5020882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6urs1On"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfDDUYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:24:19 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:54965 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730847AbfDDUYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:24:07 -0400
Received: by mail-qk1-f201.google.com with SMTP id v2so3148310qkf.21
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 13:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xCLL7LcnK/EfAdZPNNEYIgclrtC6A/GQfyjKs9KqXfk=;
        b=R6urs1OnBmpgDtETpgp5lhwN1bbIvjyh0T0PxRNx8AMkjoOKTYS9L6pfHJyaINvgN7
         6b/xo1AdfuHQtR/rADaYjHn9OD+lUYOKAjswnTZk1i9hmpJZmN85/ye6cFy847HPXBxV
         KIw+51PUdGPSAn1SfUVM8fOpwqx1xk9zRzuv8ifLhbp4jrRVYgPQrmV9yeDdBehA9UYC
         UoV5bJn1NAF3i7HknTXqzXSXjATIV+iVOKdzFGZyHbJ1BIXZJJeGa5RBrtpecLdXwSjo
         17lzlrVHY0ubvY9k6NzTm/HPm5ua31iKV43twrPTLhHdyuBXjn1gycxqgcA6kEMROM63
         w4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xCLL7LcnK/EfAdZPNNEYIgclrtC6A/GQfyjKs9KqXfk=;
        b=OYNRjqt6ZU8qRaEY78K49OfsuJfvAFjVwZjbHL4/8BCtIfW+5uc/Ir1Q9y4lnm0XpP
         P2tkJDsj+rccRX1tz8+YeeNwngazfBZu5Bmrbkt4+GQZRoQjf/g8MiU1V1y+ZwJ8p4vF
         QixPQ8YpsuxXFHM/M0Jk8Pl1G6nMMBNA0Apa2Qrd7aHLtYYOS4OzoZvrtnAq4eBT6aES
         K+koKtKhxAg/OCpUlt7qh37wD4sYrDLYKCg3pBa4FIKrD0U/Cw1zmaGB4Oqwgi7Lw4z/
         MfAbWjJZL5gyw3bFMTLf/kfXK76vVXZal2CBJqSHSnP4nF+t8umKW6cye61hUrgmdpCu
         +WNg==
X-Gm-Message-State: APjAAAWcEuPzZHhTpATHgaIGkqsm4f7UWTc6viuMSfuhVs8RTCYaDTsD
        BaTdkb4u0/yGbqW+aDMJpaN4NpdW
X-Google-Smtp-Source: APXvYqznMxtqI38l39KsNnxVYhuotW8fBQzlZRNiusEEq702paDjnOTBVACaULock+UYMm0yj6YtKIA1
X-Received: by 2002:ac8:24d2:: with SMTP id t18mr1266663qtt.1.1554409446885;
 Thu, 04 Apr 2019 13:24:06 -0700 (PDT)
Date:   Thu,  4 Apr 2019 16:23:45 -0400
In-Reply-To: <20190404202345.133553-1-brho@google.com>
Message-Id: <20190404202345.133553-4-brho@google.com>
Mime-Version: 1.0
References: <20190404202345.133553-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v3 3/3] kvm: remove redundant PageReserved() check
From:   Barret Rhoden <brho@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, yu.c.zhang@intel.com,
        yi.z.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_is_reserved_pfn() already checks PageReserved().

Signed-off-by: Barret Rhoden <brho@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 virt/kvm/kvm_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 55fe8e20d8fd..c44985375e7f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1782,12 +1782,8 @@ EXPORT_SYMBOL_GPL(kvm_release_pfn_dirty);
 
 void kvm_set_pfn_dirty(kvm_pfn_t pfn)
 {
-	if (!kvm_is_reserved_pfn(pfn)) {
-		struct page *page = pfn_to_page(pfn);
-
-		if (!PageReserved(page))
-			SetPageDirty(page);
-	}
+	if (!kvm_is_reserved_pfn(pfn))
+		SetPageDirty(pfn_to_page(pfn));
 }
 EXPORT_SYMBOL_GPL(kvm_set_pfn_dirty);
 
-- 
2.21.0.392.gf8f6787159e-goog

