Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C518DC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5F027479
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ew82e7Nz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfFCQzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:55:39 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:51947 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbfFCQzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:55:37 -0400
Received: by mail-qt1-f202.google.com with SMTP id a18so5979935qtj.18
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 09:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=luHVeQDtsejNe05MbpEHIJ5FAOspLsm1rW4+f3IOXdc=;
        b=ew82e7NzIq+8fpVjdyGeAl2NjSKK4p0nGZ5QsTZKvqtsLjuuAXvE063KXb+pD0cHy3
         33+cPut/htgPr27GTzwOcJ20GBX2Ux9NssttTzwHChq9HvO45Yd1WsNH+qMaKhyQDDTc
         D+9zMoo5SrYePAGdOkXZXmMQhF2t0ypsOVpok1EOYB7sNktF/Rh9uldB40uKjOJapI1g
         axLdF69gRV4YSFbj/UQdIsHxS2aGe/kJaiIGVBIH5qRmQS2qsSWYGny0rQfE2+NQmVfF
         bjXTeOgusRer2Jz6pFuYk/PEgndLJQ02z9T1gNTKOM3uuFHRlwHl2aCc1w3EkCHnhf6g
         ZiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=luHVeQDtsejNe05MbpEHIJ5FAOspLsm1rW4+f3IOXdc=;
        b=jTtaB0neRU3S1nnv0xIaCXveW74BTXFbK9zlv6RpvLMfQkyR0mYaP3izo/t8du1uXO
         8xVmOoWt2dzrmaNLxx8GnZPnTAIDPCvR6Hw5LLUej8E6OWhVk4ljKRNieweNlfOqudrm
         kfnJb1lshjJrx+3o+3eVj8ZLW//5PTfpadtusBxmlmhMbxTfpFRFJjh3GodztzUVR1nT
         kxNtjmNZGskduDwV9bzfxzhpARwEsuGygT4jm564XGxshh2AQvdKrqDF9aGW32rWbnWB
         Tb3oNrf5lzZq28lUz6tCbtqiYovK7LkFfwrYj+TN2DS1IqtnnjX9D5zovB3d3qEMZ1fR
         mubw==
X-Gm-Message-State: APjAAAX7rAaZ0DSL8o5ujhUS9IMgji35RHCXKEJaTIxjvjXdVqATSoyG
        GMmXA6fgC+xteWm3O1MB6VAGWkuDxy2RDMw3
X-Google-Smtp-Source: APXvYqxWajnT2+NV3xTud3R56ZNhfS6I5UrUDe55n3y1jJe3OWUToUGKN+BmVqJ0YCPX/M4xXQWJhyPq+bf/72n5
X-Received: by 2002:a0c:ad23:: with SMTP id u32mr3896810qvc.39.1559580936412;
 Mon, 03 Jun 2019 09:55:36 -0700 (PDT)
Date:   Mon,  3 Jun 2019 18:55:06 +0200
In-Reply-To: <cover.1559580831.git.andreyknvl@google.com>
Message-Id: <e410843d00a4ecd7e525a7a949e605ffc6c394c4.1559580831.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v16 04/16] mm: untag user pointers in do_pages_move
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
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
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

do_pages_move() is used in the implementation of the move_pages syscall.

Untag user pointers in this function.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/migrate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index f2ecc2855a12..3930bb6fa656 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1617,6 +1617,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		if (get_user(node, nodes + i))
 			goto out_flush;
 		addr = (unsigned long)p;
+		addr = untagged_addr(addr);
 
 		err = -ENODEV;
 		if (node < 0 || node >= MAX_NUMNODES)
-- 
2.22.0.rc1.311.g5d7573a151-goog

