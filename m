Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399DDC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE926206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="X0mwyBro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgAIHIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 02:08:18 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54986 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgAIHIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:08:18 -0500
Received: by mail-pj1-f65.google.com with SMTP id kx11so741775pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 23:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T66c+Moc6bo3p93sqP0BtCTOoS4UuskhqiuSGC0rhF8=;
        b=X0mwyBronhFAvsmlzbsKHNTgZEAlq+hZMT0u/m/S4Ga/TZgU/CFDxsjZZ3Sb7W55KC
         CdkUz5Dg0Rm3zAxOestRih3sAYV0lUc8gsaw9ERRphopmY3ahW9F7n7rj8luEwH0+y67
         wtXFs2N+rq3CmbwLg9VRq/leG03nLJfNUz9uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T66c+Moc6bo3p93sqP0BtCTOoS4UuskhqiuSGC0rhF8=;
        b=V509/R/1UUtnZTFcH4Zoc/MuGb/dnwUyQGVEWPxYbIt/GFWAorQUkLFYXmSuSHuLVt
         E4UeFloarIudLAW9diNINFkzcbJCAe6k8UkoBxU4rMgy2MqkyJyhnzxqWM3x9XarZg25
         qk/LI6xAH/OA17Xbj36nL2NXJDlsi9PMPa8UTZyqczb+jsV3HeLuxteaSImGJsttWnmx
         N4hdgP+NUwnZA9QtFhq4mZCae7Ki4goTVu5PlzhxAvOrL5HwiMicRWI3f0SuY11RWncK
         LAJeO3AwSejAJBucTY47+WohR9661RX0DOqKhR7TSWQesrtmffjW9RkODrT/B+gddhOH
         LCQg==
X-Gm-Message-State: APjAAAWStVlcfQr3SqO0RRibBvx5izYk5MvoIRO8cb+lhLLy44WzcbS4
        XnjigSVTjwwSo5qxg7s7vbjWoX/fpS0=
X-Google-Smtp-Source: APXvYqwzwS6C8pCrRttWQJOjzO+q0lE36tEIXD7GIldhthPyaszfHYJdYFpvK3Y8vgvuZ304JF1PRA==
X-Received: by 2002:a17:90a:cb83:: with SMTP id a3mr3531968pju.80.1578553697170;
        Wed, 08 Jan 2020 23:08:17 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-5cb3-ebc3-7dc6-a17b.static.ipv6.internode.on.net. [2001:44b8:1113:6700:5cb3:ebc3:7dc6:a17b])
        by smtp.gmail.com with ESMTPSA id i23sm6139143pfo.11.2020.01.08.23.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 23:08:16 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v5 0/4] KASAN for powerpc64 radix
Date:   Thu,  9 Jan 2020 18:08:07 +1100
Message-Id: <20200109070811.31169-1-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building on the work of Christophe, Aneesh and Balbir, I've ported
KASAN to 64-bit Book3S kernels running on the Radix MMU.

This provides full inline instrumentation on radix, but does require
that you be able to specify the amount of physically contiguous memory
on the system at compile time. More details in patch 4.

v5: ptdump support. More cleanups, tweaks and fixes, thanks
    Christophe. Details in patch 4.

    I have seen another stack walk splat, but I don't think it's
    related to the patch set, I think there's a bug somewhere else,
    probably in stack frame manipulation in the kernel or (more
    unlikely) in the compiler.

v4: More cleanups, split renaming out, clarify bits and bobs.
    Drop the stack walk disablement, that isn't needed. No other
    functional change.

v3: Reduce the overly ambitious scope of the MAX_PTRS change.
    Document more things, including around why some of the
    restrictions apply.
    Clean up the code more, thanks Christophe.

v2: The big change is the introduction of tree-wide(ish)
    MAX_PTRS_PER_{PTE,PMD,PUD} macros in preference to the previous
    approach, which was for the arch to override the page table array
    definitions with their own. (And I squashed the annoying
    intermittent crash!)

    Apart from that there's just a lot of cleanup. Christophe, I've
    addressed most of what you asked for and I will reply to your v1
    emails to clarify what remains unchanged.

Daniel Axtens (4):
  kasan: define and use MAX_PTRS_PER_* for early shadow tables
  kasan: Document support on 32-bit powerpc
  powerpc/mm/kasan: rename kasan_init_32.c to init_32.c
  powerpc: Book3S 64-bit "heavyweight" KASAN support

 Documentation/dev-tools/kasan.rst             |   7 +-
 Documentation/powerpc/kasan.txt               | 122 ++++++++++++++++++
 arch/powerpc/Kconfig                          |   2 +
 arch/powerpc/Kconfig.debug                    |  23 +++-
 arch/powerpc/Makefile                         |  11 ++
 arch/powerpc/include/asm/book3s/64/hash.h     |   4 +
 arch/powerpc/include/asm/book3s/64/pgtable.h  |   7 +
 arch/powerpc/include/asm/book3s/64/radix.h    |   5 +
 arch/powerpc/include/asm/kasan.h              |  15 ++-
 arch/powerpc/kernel/prom.c                    |  61 ++++++++-
 arch/powerpc/mm/kasan/Makefile                |   3 +-
 .../mm/kasan/{kasan_init_32.c => init_32.c}   |   0
 arch/powerpc/mm/kasan/init_book3s_64.c        |  71 ++++++++++
 arch/powerpc/mm/ptdump/ptdump.c               |  10 +-
 arch/powerpc/platforms/Kconfig.cputype        |   1 +
 include/linux/kasan.h                         |  18 ++-
 mm/kasan/init.c                               |   6 +-
 17 files changed, 350 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/powerpc/kasan.txt
 rename arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} (100%)
 create mode 100644 arch/powerpc/mm/kasan/init_book3s_64.c

-- 
2.20.1

