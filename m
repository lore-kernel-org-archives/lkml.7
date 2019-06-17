Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220FCC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F2F2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="KCGmXITr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfFQWUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:20:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46824 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfFQWUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:20:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id d4so18401363edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 15:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rPaTHIG8PkSubWJGVxLqZFaKiEXOLQ/LPpN9HdlOEuc=;
        b=KCGmXITreUIcanl7I4reXTJ1OQzDNx3xJ0h3iz+R2HazNzwGtuUumbO9iyo1TZrrSU
         rdhHXeaJi8wC0RYkAg8Hc++SNaoWjj4zEKSejT9EJk5/mlJIM9OgyAUOkoPgYBiYWiop
         JmLMKjvRQNfkNQv1eiLjAK6zAyXhANzQP7Dtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rPaTHIG8PkSubWJGVxLqZFaKiEXOLQ/LPpN9HdlOEuc=;
        b=B79/xmxTeNEtaQ12ahA7DP/hhRuWctaudwJC1e49811arYWgZ12e5QE3g7UqbBLFt/
         VEeDT/XEFbdKP4/qy4endvJTABNegMew7vKbyHy0pRSs/gA337MxCAwvCCx2Mog/Ulj2
         rzyknRrdQR/z65FFlkksMHkzMAIzv8iD87ixOAhIv7En5PgerJyQHCNcTafp8jGLPo8k
         Z/dAp7gvNfWZnFIKXWciCb6S7EJvLR97eaBNgDQSU/TqB/BW4WiYtCtYuvND4hNJG01q
         eYFWfBSZ2P3CBDG7Pr/t15e0rMWNna+ahkN1XKebxv0SrImhOVsogYYzT8Yg2UlYay5/
         uauA==
X-Gm-Message-State: APjAAAWSdKlByTU6dYNz2owhS3eJBFeWQmKVHC9eeT7WcfseSbnrJqeX
        sz+cpk7mEFpO8O2to6cvnNOaow==
X-Google-Smtp-Source: APXvYqz9DMdenjgbZOikQRPpmT9dG+4mcy9LuJw6iyCraF1Ina01pcBN1qCZ/narwamBwFGQ5eWN6A==
X-Received: by 2002:a17:907:2091:: with SMTP id pv17mr54765292ejb.152.1560810042533;
        Mon, 17 Jun 2019 15:20:42 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-113-204.cgn.fibianet.dk. [5.186.113.204])
        by smtp.gmail.com with ESMTPSA id 9sm1034852ejg.49.2019.06.17.15.20.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 15:20:41 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 0/8] implement DYNAMIC_DEBUG_RELATIVE_POINTERS
Date:   Tue, 18 Jun 2019 00:20:26 +0200
Message-Id: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to CONFIG_GENERIC_BUG_RELATIVE_POINTERS that replaces (8 byte)
const char* members by (4 byte) signed offsets from the bug_entry,
this implements the similar thing for struct _ddebug, the descriptors
underlying pr_debug() and friends in a CONFIG_DYNAMIC_DEBUG kernel.

Since struct _ddebug has four string members, we save 16 byte per
instance. The total savings seem to be comparable to what is saved by
an architecture selecting GENERIC_BUG_RELATIVE_POINTERS (see patch 8
for some numbers for a common distro config).

While refreshing these patches, which were orignally just targeted at
x86-64, it occured to me that despite the implementation relying on
inline asm, there's nothing x86 specific about it, and indeed it seems
to work out-of-the-box for ppc64 and arm64 as well, but those have
only been compile-tested.

The first 6 patches are rather pedestrian preparations. The fun stuff
is in patch 7, and the last patch is just the minimal boilerplate to
hook up the asm-generic header and selecting
HAVE_DYNAMIC_DEBUG_RELATIVE_POINTERS on x86-64. Doing arm64 and ppc64
would be similar 2-line patches.

Unfortunately, the "fun stuff" includes some magic that breaks the
build in some corner cases with older gcc (and some not-so-magic that
clang only supports since version 9 for non-x86 targets). So in this
v6, the config option DYNAMIC_DEBUG_RELATIVE_POINTERS has been made
opt-in, depending on the arch-selected
HAVE_DYNAMIC_DEBUG_RELATIVE_POINTERS, instead of the arch selecting it
directly. Also, I've set a lower bound for the gcc and clang versions,
so that hopefully nobody should be able to select the option and have
the build break.


Rasmus Villemoes (8):
  linux/device.h: use unique identifier for each struct _ddebug
  linux/net.h: use unique identifier for each struct _ddebug
  linux/printk.h: use unique identifier for each struct _ddebug
  dynamic_debug: introduce accessors for string members of struct
    _ddebug
  dynamic_debug: drop use of bitfields in struct _ddebug
  dynamic_debug: introduce CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS
  dynamic_debug: add asm-generic implementation for
    DYNAMIC_DEBUG_RELATIVE_POINTERS
  x86-64: select HAVE_DYNAMIC_DEBUG_RELATIVE_POINTERS

 arch/x86/Kconfig                            |   1 +
 arch/x86/entry/vdso/vdso32/vclock_gettime.c |   1 +
 arch/x86/include/asm/Kbuild                 |   1 +
 include/asm-generic/dynamic_debug.h         | 116 ++++++++++++++++++++
 include/linux/device.h                      |   4 +-
 include/linux/dynamic_debug.h               |  26 +++--
 include/linux/jump_label.h                  |   2 +
 include/linux/net.h                         |   4 +-
 include/linux/printk.h                      |   4 +-
 lib/Kconfig.debug                           |  16 +++
 lib/dynamic_debug.c                         | 111 ++++++++++++++-----
 11 files changed, 246 insertions(+), 40 deletions(-)
 create mode 100644 include/asm-generic/dynamic_debug.h

-- 
2.20.1

