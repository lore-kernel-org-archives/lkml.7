Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95512C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6C22064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127567;
	bh=8tQUEl8OCTvnblxUx713vRuVFXWXaGnIf/14+VpBJLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lKhdceos3e9vcDDX3ltdkpFJg4tNe/mNGQrnPskpfX70rs9jGCNQaWycLVEYjlVEI
	 ZqjbrrMqfVFJu5AtM4eVdipWjF0vFv3JmN/0+htlizZ5pt8RNOWLsc5YWkusdNgv1M
	 VGxCWT5tYbZlpCBDyk/28n6EzsUiTyzTyxLUPk3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392329AbfDXRiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392305AbfDXRiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:38:00 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3F9221903;
        Wed, 24 Apr 2019 17:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127479;
        bh=8tQUEl8OCTvnblxUx713vRuVFXWXaGnIf/14+VpBJLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a0OWB/OtkatOo+fMU83tgFWkOfpvIHSFZV6TExgv+vNSjfHM5SwUUzMxTqrgJDnBO
         cbmFx5GGjUU4CanRg2zDbJEh1pBBg+nsBIkcznaQ3t+hXjMFYkzVczDhsYAsHqcQPE
         liP4hNoIoZUfBWrHxUoXj92G2xdFmPZb0PmQEhAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 106/115] Revert "kbuild: use -Oz instead of -Os when using clang"
Date:   Wed, 24 Apr 2019 19:10:42 +0200
Message-Id: <20190424170930.895792116@linuxfoundation.org>
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
index ef192ca04330..807ae0e3ff6e 100644
--- a/Makefile
+++ b/Makefile
@@ -678,8 +678,7 @@ KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
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



