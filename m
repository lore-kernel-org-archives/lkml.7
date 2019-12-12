Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E6CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEEA205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="q7DQztUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfLLPRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:17:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36355 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbfLLPRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:17:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id k3so1305242pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 07:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v26BsJHtOrSEIqcupCpn6pVHwbqhLlNjRKE6OChruw8=;
        b=q7DQztUhC2cJBLWp8U64RWDfNoq8AbBYU8MfDcKAjAFGPJpPnE3FAqVtyqVKY+ZAqn
         qMLB/MGQif2yiI3NOW7QGUKPa2TozBJMY2FgfNVz0e4txIKABIoAdygoKGywYQN+O2Vo
         Nkke2edKnZCvy5sqTt3NpxXWt8nNTJADHSHOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v26BsJHtOrSEIqcupCpn6pVHwbqhLlNjRKE6OChruw8=;
        b=ThC31regYWSqSeLZZ9Dp4sLdOShxftVQgWGTV/hNUEKMsMhvC3Non04HkBrkvUFJGp
         /Tr1ZmcWGMKNyHvq7dWXFhPmzRiTjKfMn6f4JE2WFYO7wvzooL+rDJBPbGHbkCQJuwCv
         HRggd5txM6+7uDv//ru5QziHPZD8QFImBgIyJZ+xXH9t9/RJR8/kZ8o3hVr6UvGtCugh
         2/f8l/ciCBqBonXrNE4tT7k2ZJH/rI2rQqFBZ1gemyiUyw5PLoHdDWYOHtsLsX70Ea50
         2L0ux4VmDbF3KWKfJEqPqSYCdv9nMr2b5PzSqXbCsRJJHAXa9C2V+yDJiN3C56TnR9hf
         g3MA==
X-Gm-Message-State: APjAAAVxa31nVtI7mRuBy+HSBTjcTS7wginGtMfAHlhEoGfhwlbtpqRg
        XOFLLyK7eYqal96pYAxc6NH0v4MdUKk=
X-Google-Smtp-Source: APXvYqwZHmuzKnMIkPQu7WYLto/58IR4TZmFj0304fSKWKFda3vIFLGQeA7OjH96Yx4Qnd6rYUHK5g==
X-Received: by 2002:aa7:90c4:: with SMTP id k4mr10406197pfk.216.1576163822527;
        Thu, 12 Dec 2019 07:17:02 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-b116-2689-a4a9-76f8.static.ipv6.internode.on.net. [2001:44b8:1113:6700:b116:2689:a4a9:76f8])
        by smtp.gmail.com with ESMTPSA id 5sm6415205pjc.29.2019.12.12.07.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 07:17:01 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v3 0/3] KASAN for powerpc64 radix
Date:   Fri, 13 Dec 2019 02:16:53 +1100
Message-Id: <20191212151656.26151-1-dja@axtens.net>
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
on the system at compile time. More details in patch 3.

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


Daniel Axtens (3):
  kasan: define and use MAX_PTRS_PER_* for early shadow tables
  kasan: Document support on 32-bit powerpc
  powerpc: Book3S 64-bit "heavyweight" KASAN support

 Documentation/dev-tools/kasan.rst             |   7 +-
 Documentation/powerpc/kasan.txt               | 122 ++++++++++++++++++
 arch/powerpc/Kconfig                          |   3 +
 arch/powerpc/Kconfig.debug                    |  21 +++
 arch/powerpc/Makefile                         |  11 ++
 arch/powerpc/include/asm/book3s/64/hash.h     |   4 +
 arch/powerpc/include/asm/book3s/64/pgtable.h  |   7 +
 arch/powerpc/include/asm/book3s/64/radix.h    |   5 +
 arch/powerpc/include/asm/kasan.h              |  21 ++-
 arch/powerpc/kernel/process.c                 |   8 ++
 arch/powerpc/kernel/prom.c                    |  64 ++++++++-
 arch/powerpc/mm/kasan/Makefile                |   3 +-
 .../mm/kasan/{kasan_init_32.c => init_32.c}   |   0
 arch/powerpc/mm/kasan/init_book3s_64.c        |  72 +++++++++++
 include/linux/kasan.h                         |  18 ++-
 mm/kasan/init.c                               |   6 +-
 16 files changed, 359 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/powerpc/kasan.txt
 rename arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} (100%)
 create mode 100644 arch/powerpc/mm/kasan/init_book3s_64.c

-- 
2.20.1

