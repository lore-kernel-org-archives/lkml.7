Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771DDC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4495420C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CbTDaybx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfEFQcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:32:01 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:53893 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfEFQb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:31:57 -0400
Received: by mail-yw1-f73.google.com with SMTP id v127so26083765ywb.20
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=40kxRsKyA2BTdfRG/8ycbW9cjWXHDWQTNAmN4QMp2Tc=;
        b=CbTDaybxwiO68FYaqEU987JbmTIWC/O/zmn5u4LAT2NjIg4zrx3ZZpTdEat2IZI7Zr
         UMjh3JrD6tSSJSHiA2J1SvwKqxkOFH9jD5t4pSSsFkT8XO0YzO5s2D93y2Fvv558QDT8
         PC2RKfy08bb/yMf67M9jkhQd5jNijh0tU+IEPR6RStdwOkRtKLjro1177XiqKVVA8CKn
         7nvBlr71nBnQ+GeGRfOaL9uXIjXsWpEFZPxFZ6iufv0v5siPwgW5vA64wYvStilJ/+ml
         T4dkOygYLm3ryZPhfxVQJsF9+4XGOGyyv3U3USZs8bMzVBnZRwvcMGmsqol00hqY8fWp
         TxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=40kxRsKyA2BTdfRG/8ycbW9cjWXHDWQTNAmN4QMp2Tc=;
        b=fFalUz0rpN4F0aXOK3KXlnTa9MBKj6d/Rqx6oUAQOqnl3hRzYeIvYH1hJ/UPCEizM8
         Ts9xvcOuGPWFOMWegIYo1OPpENbeutTwxUfc22AwvqEv2oAajKz6WfdplMHLXCQkfWJj
         dvrm+F/TWmNHCqctbzbb3PP0MqpD0uDVhu1SD6oU1/5pdARkuH5kJ3uEtFE7C4gTGs2n
         d6TxhNcSEWNMCFM3xwNyxXuUzgYNcugdI704alAXnvbIQAAxuyHy0+gje1YVXjvm3Uae
         gtdG80GNbg+9Fx9oJIr+VcAxfqzewf8GMsBJghe7HYeBrstol9Dg92iZ11c+/VU6gnV2
         9NRw==
X-Gm-Message-State: APjAAAXji8PxeSe5FtPS3vkMTahX1eecGdmBChLx2eifuULcj95c9WIM
        CDNABMll8Y4xeubAB98E17+0/n/wjcp5yiQd
X-Google-Smtp-Source: APXvYqy7sMh67zqP2gW9MSWmQP0vNhHkuufaU8XQ9cxxJZb1a1Qrmr7t2Ui4wSymuQ40ovJdWXqcMvlrm4Ub8jqq
X-Received: by 2002:a25:c5c8:: with SMTP id v191mr18795942ybe.52.1557160316771;
 Mon, 06 May 2019 09:31:56 -0700 (PDT)
Date:   Mon,  6 May 2019 18:31:02 +0200
In-Reply-To: <cover.1557160186.git.andreyknvl@google.com>
Message-Id: <69a675a5c48fa2572162338c51a1bfa2a3ced27d.1557160186.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v15 16/17] vfio/type1, arm64: untag user pointers in vaddr_get_pfn
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

vaddr_get_pfn() uses provided user pointers for vma lookups, which can
only by done with untagged pointers.

Untag user pointers in this function.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/vfio/vfio_iommu_type1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index d0f731c9920a..5daa966d799e 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -382,6 +382,8 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
 
 	down_read(&mm->mmap_sem);
 
+	vaddr = untagged_addr(vaddr);
+
 	vma = find_vma_intersection(mm, vaddr, vaddr + 1);
 
 	if (vma && vma->vm_flags & VM_PFNMAP) {
-- 
2.21.0.1020.gf2820cf01a-goog

