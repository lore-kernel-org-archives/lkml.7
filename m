Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDBCC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE913245BB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQowASfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfFDLov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:44:51 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:55117 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfFDLou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:44:50 -0400
Received: by mail-ot1-f74.google.com with SMTP id a22so10482402otr.21
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 04:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XCrbwdAiEJS3sao46jIToUSxgqStqSIKmjosXIycN10=;
        b=OQowASfC1DkZBD6ZzOOewK6YqgU2ZfNgbzHcLMXLm94xATdoL7pRsYoq0Ca983wUlW
         1AzHjVsjPZzLOSw/EYwBC5zTDiT3rRisFVr0otD4kGjI5Q1J+eBrFP3oWQBc3R8o7rZS
         +nEENWNe0lpacPo8kwRr2Cz7TDEttnz9npQcNVZJmeIO9eL9YROdUfyY9G7dPjCT5G4S
         n3vggAvgZl5bnPFVyY5V8gpZBFjsU9LmOWcovr1/jb8oFePv4CCtwEGaE9uoVlfJANln
         MTN/BlGEha/hwcouVsL2ZU5SkLr7wvck5RykyLLoKj5+diBYr1ixXCNWeLnwmH0fmyZF
         THpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XCrbwdAiEJS3sao46jIToUSxgqStqSIKmjosXIycN10=;
        b=c+gOKMVHqF2hkh/t7yWHXImAzvucqwGYTNwRTjYDsYHOl76w41z2A3QGa9c1zMVNVT
         abG9gIZLZJAQfLP+aKQWNqV/yK1TcqqdHokbzs6lZSCt2/VZkCsRP5yWiA5g179avv6h
         t3nwQp2PttEO3troUYJ0la0+AP7ReZ9b/0VJ562pDFmm240X/q1m9jCv/BCcExbFnWsJ
         9nzJ2t97x1oR2M+E7ebku9m52Unk55KGP4AvKztoh+lU6lSZrDaK0Xl8jMdohzdrItzq
         POF7LsUz5Z7hjhMS4r9eUSWQV5ht64eO8fyBA7VOt8MxF5CyMGp10oSU0zcOK/lZ8aYU
         O/Iw==
X-Gm-Message-State: APjAAAXbeH92+sqdHKRuvvhK3ZbCZcMS6YI5oPEWBzG5h3eW2RDOzcE8
        uvj55UUUE8e+qGzPWMyaakws4eZpQFraRei0
X-Google-Smtp-Source: APXvYqwXsyeZ/z4p68zy0w3OgwmszH6BSy/5gFuyx/JVk90VXHjFqwFwXGlvbDPhexYH3Gb/pFc8t/if0dU8diyp
X-Received: by 2002:aca:b108:: with SMTP id a8mr4013564oif.81.1559648689594;
 Tue, 04 Jun 2019 04:44:49 -0700 (PDT)
Date:   Tue,  4 Jun 2019 13:44:45 +0200
Message-Id: <8ab5cd1813b0890f8780018e9784838456ace49e.1559648669.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH] uaccess: add noop untagged_addr definition
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
 include/linux/mm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0e8834ac32b7..949d43e9c0b6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -99,6 +99,10 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 
+#ifndef untagged_addr
+#define untagged_addr(addr) (addr)
+#endif
+
 #ifndef __pa_symbol
 #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
 #endif
-- 
2.22.0.rc1.311.g5d7573a151-goog

