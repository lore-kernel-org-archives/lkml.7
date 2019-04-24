Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D69EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4642E218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127963;
	bh=L2mSAWC5ljIWjHIb+nYlYZ2wxtFA82x18kqn+Klx0hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YBrcBzaFqRpS7GLvq3HytI7da/m6MVbVK/r5I+HqnvoE97Aa1fnjusY3Tn1WMO/l9
	 FQdB2MnhsE47iDpVL2KFgeqNUreOiuQvebKXHoTF1RjEielb7/wHMIXpH9RtrI0vFj
	 /h0pYDXsWvjYFaSTy5ze0/Owv/WTzLCiPYDfFxhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391825AbfDXRqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:46:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391178AbfDXRcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:32:54 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BB9221903;
        Wed, 24 Apr 2019 17:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127173;
        bh=L2mSAWC5ljIWjHIb+nYlYZ2wxtFA82x18kqn+Klx0hM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kKXXaw189BXHaE8bDc5A/OI3FAy+IGj7WMyjXtH+w3He6PhR0HGB5A4SOVZsa/S6s
         bTJ0vC1qnlbCleNFHFNv10f8T5dQWvpckJwpdHeWHy0iWbPnneH6MZ59koXDlPZ+/Z
         WsSiBDKZ21ySCdHUdgKEycdD8HZDuei+2+fu9pT4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 88/96] Revert "kbuild: use -Oz instead of -Os when using clang"
Date:   Wed, 24 Apr 2019 19:10:33 +0200
Message-Id: <20190424170925.772310543@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit a75bb4eb9e565b9f5115e2e8c07377ce32cbe69a upstream.

The clang option -Oz enables *aggressive* optimization for size,
which doesn't necessarily result in smaller images, but can have
negative impact on performance. Switch back to the less aggressive
-Os.

This reverts commit 6748cb3c299de1ffbe56733647b01dbcc398c419.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 3fac08f6a11e..91e265ca0ca5 100644
--- a/Makefile
+++ b/Makefile
@@ -661,8 +661,7 @@ KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
-KBUILD_CFLAGS	+= $(call cc-option,-Oz,-Os)
-KBUILD_CFLAGS	+= $(call cc-disable-warning,maybe-uninitialized,)
+KBUILD_CFLAGS	+= -Os $(call cc-disable-warning,maybe-uninitialized,)
 else
 ifdef CONFIG_PROFILE_ALL_BRANCHES
 KBUILD_CFLAGS	+= -O2 $(call cc-disable-warning,maybe-uninitialized,)
-- 
2.19.1



