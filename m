Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04707C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC376205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557154050;
	bh=/ZxRE3RAVL8mwAUldM3RlQTp0XqIDm8i6fAL3dQuQdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uKD1xk/Zs2L9bf7kKtSZxRDIJorvD7q0M/BVnxoovwNQBEAI+Xaey+lq3LUIDGcW8
	 EpTUB5S4pFQUH9kMgQoZd8B+T0UzagwptgLjxWXZPeJNWzdTUsilVIL0buMZgcOp/C
	 ZaTJqjwql/IMLa/cHlKvoC6wx7ufLAHzO5tpLA1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfEFOr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbfEFOr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:47:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58A4020578;
        Mon,  6 May 2019 14:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557154045;
        bh=/ZxRE3RAVL8mwAUldM3RlQTp0XqIDm8i6fAL3dQuQdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bPdv6O/u1R/TMq4a4aapQWN9a7rzJz1dPNem7tCbgSbnqas54ERLIecfwuUuhdR/d
         IZvyIksUAVgiBJhxlFYrFuiaOC9Kpc1Fk6plAN4VsovksXVK6F/8uTUTt3rvPS7sK2
         nEX/wgvtu1xyLT0bPfchRAlwEvTog0P4ALAbbGgI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Jeff Layton <jlayton@redhat.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Kostya Serebryany <kcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 18/62] kasan: prevent compiler from optimizing away memset in tests
Date:   Mon,  6 May 2019 16:32:49 +0200
Message-Id: <20190506143052.648187716@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143051.102535767@linuxfoundation.org>
References: <20190506143051.102535767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

commit 69ca372c100fba99c78ef826a1795aa86e4f01a8 upstream.

A compiler can optimize away memset calls by replacing them with mov
instructions.  There are KASAN tests that specifically test that KASAN
correctly handles memset calls so we don't want this optimization to
happen.

The solution is to add -fno-builtin flag to test_kasan.ko

Link: http://lkml.kernel.org/r/105ec9a308b2abedb1a0d1fdced0c22d765e4732.1519924383.git.andreyknvl@google.com
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Nick Terrell <terrelln@fb.com>
Cc: Chris Mason <clm@fb.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Luis R . Rodriguez" <mcgrof@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Jeff Layton <jlayton@redhat.com>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Kostya Serebryany <kcc@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/lib/Makefile
+++ b/lib/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_TEST_BPF) += test_bpf.o
 obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
 obj-$(CONFIG_TEST_HASH) += test_hash.o
 obj-$(CONFIG_TEST_KASAN) += test_kasan.o
+CFLAGS_test_kasan.o += -fno-builtin
 obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
 obj-$(CONFIG_TEST_LKM) += test_module.o
 obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o


