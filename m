Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E03C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30ACE249DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GowLAStz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfFDMEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:04:52 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:57054 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfFDMEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:04:52 -0400
Received: by mail-vs1-f73.google.com with SMTP id i4so6242709vsi.23
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 05:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jQ4jdowRSjR3urFOBjyFZklSNNoQ/ud0fhl6APbdVCA=;
        b=GowLAStz/2F1T2+1l2LwgSfjTKRmMNBrNNCBZBil5igL4JQyaWlnxhbbmWCoX861Oi
         B/gqgNlu7CEqXMP2+z7kELt1QAkywzQ/4/CBIgoztk4jhPS0IDaW6f2xT62bZyvCkGPW
         ChaaC18egrJWcY5tXKS1tu+1ggnllHfRVAt4dSrOhgYxZTnaC50stPSrxwS8K7gbAyLN
         UjDTA5LQ+N55Gnmek72ZITAekTqyE/lF715JE4SsnddL1vL3d3tMoF9CBM84jFEXZ+Fi
         /tVHki2lXZ2QdEK7Q+gvSqDXWwBEJ/eJ981jOBPiAFjG2vVRecZEHKzlptA4WkyhnZzl
         0RUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jQ4jdowRSjR3urFOBjyFZklSNNoQ/ud0fhl6APbdVCA=;
        b=fe5HhQbu6mIAjY3toVBsHEMaiTdKqoRlkmGhP743e5C7uBDUTdmFJka+PLMH7fX/6J
         nnKp4de0q0wdMTufKkEc3vQ5Amc+tZ9qEmvraBoDGiO2Gs6qIJdDo6VSg8QT0S3cY9Rw
         +qApp2TVnoBV8JvUkSwd+X9VbBcKyK50wSzGtWE8f/lN3cNgLsQ8NVdDPb+xgV8q4o66
         XM354su9KNuIjLzZwThKl9rwA136nMHoNG9XIeVeEz0Nn2kIF06FVtbDxH1HqLs9kn63
         0u6gMtzTO5U2ydJ5Oo7RPpM3oWX32Naj96YgRCUEfClbygWq9k4Hq9Jt17YfLiHF8kXi
         BLlg==
X-Gm-Message-State: APjAAAWbhs1ZKhm5RHyRZCzfTzG/FIDC3ndERedHsgP5lzBlV8bp5TOl
        tOsapTLPy0veXM37B+dYkQv4GuPI6/cvrxR2
X-Google-Smtp-Source: APXvYqzbAGU8OQBoy9uHFFBvYRcfDQrSEKOseigLTkDo7YUO7FMQDDHLZj47ajW7+eNrCdw8uM2m21YgNxpjq+Kq
X-Received: by 2002:ab0:184e:: with SMTP id j14mr15665222uag.91.1559649891290;
 Tue, 04 Jun 2019 05:04:51 -0700 (PDT)
Date:   Tue,  4 Jun 2019 14:04:47 +0200
Message-Id: <c8311f9b759e254308a8e57d9f6eb17728a686a7.1559649879.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v2] uaccess: add noop untagged_addr definition
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

Architectures that support memory tagging have a need to perform untagging
(stripping the tag) in various parts of the kernel. This patch adds an
untagged_addr() macro, which is defined as noop for architectures that do
not support memory tagging. The oncoming patch series will define it at
least for sparc64 and arm64.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/mm.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0e8834ac32b7..dd0b5f4e1e45 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -99,6 +99,17 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 
+/*
+ * Architectures that support memory tagging (assigning tags to memory regions,
+ * embedding these tags into addresses that point to these memory regions, and
+ * checking that the memory and the pointer tags match on memory accesses)
+ * redefine this macro to strip tags from pointers.
+ * It's defined as noop for arcitectures that don't support memory tagging.
+ */
+#ifndef untagged_addr
+#define untagged_addr(addr) (addr)
+#endif
+
 #ifndef __pa_symbol
 #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
 #endif
-- 
2.22.0.rc1.311.g5d7573a151-goog

