Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCD8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D212B21904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127426;
	bh=xm9ei95JbKMxxDCtd2eG0BR8le4JJv/5MyDXMBhYaqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oa/zKN6w7OR9rbOYSas8qEAXNJ4cGDFoMpgO9dFUAQOigwmZVrY+5xFR/7wbLlen6
	 Ev8u9lF/kl3kpPeyq4n+3iGXi8rSfWHer09VgFTRz4O1kkzsU3PPTEC8nxADXdUl6P
	 qjm2IQ8HAAjGraPPx4iEfGAUnJ4fMctO1ymAZFSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403967AbfDXRhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403941AbfDXRhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:37:02 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E887121915;
        Wed, 24 Apr 2019 17:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127421;
        bh=xm9ei95JbKMxxDCtd2eG0BR8le4JJv/5MyDXMBhYaqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vpzgsMMQv7nZ0JayvFo7MVfmAf1oStOPvqflATA0Zk0uj2EnR5pTfk+M3H20P8qD3
         LIq7weWBCMjPJOBmbhjGki9RZcMbYI6gTxSdjuookr1LRHBt+C1CfP5JTlyJKz/Re8
         /xDf1F8uIdiYLKO1XIRWy4mxeGiLlmkkQSTQYjRo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 5.0 086/115] arm64: futex: Restore oldval initialization to work around buggy compilers
Date:   Wed, 24 Apr 2019 19:10:22 +0200
Message-Id: <20190424170929.935518675@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit ff8acf929014b7f87315588e0daf8597c8aa9d1c upstream.

Commit 045afc24124d ("arm64: futex: Fix FUTEX_WAKE_OP atomic ops with
non-zero result value") removed oldval's zero initialization in
arch_futex_atomic_op_inuser because it is not necessary. Unfortunately,
Android's arm64 GCC 4.9.4 [1] does not agree:

../kernel/futex.c: In function 'do_futex':
../kernel/futex.c:1658:17: warning: 'oldval' may be used uninitialized
in this function [-Wmaybe-uninitialized]
   return oldval == cmparg;
                 ^
In file included from ../kernel/futex.c:73:0:
../arch/arm64/include/asm/futex.h:53:6: note: 'oldval' was declared here
  int oldval, ret, tmp;
      ^

GCC fails to follow that when ret is non-zero, futex_atomic_op_inuser
returns right away, avoiding the uninitialized use that it claims.
Restoring the zero initialization works around this issue.

[1]: https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/

Cc: stable@vger.kernel.org
Fixes: 045afc24124d ("arm64: futex: Fix FUTEX_WAKE_OP atomic ops with non-zero result value")
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/futex.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -50,7 +50,7 @@ do {									\
 static inline int
 arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *_uaddr)
 {
-	int oldval, ret, tmp;
+	int oldval = 0, ret, tmp;
 	u32 __user *uaddr = __uaccess_mask_ptr(_uaddr);
 
 	pagefault_disable();


