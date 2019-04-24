Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ED8C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801192190A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126606;
	bh=Vx3vSiKIRIkOOkxy5gNdBUTJe6pwOfL+aAMDiZtyvIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RqFGHQhqsDVfTsQpNdY6qmcP4n9zJTEc2QYqKBzmdTBRhKCN3D8zM/G1N63oJGyJp
	 GBGoiMGFYE75y8Y8mBj0Q5hC51bf1CIDtet3/ZK0ZpVuvcZXfUV7MqeAPFRezhZNn4
	 mj7291R3gVHNGosl+zeTnyHKeUk8epjElCQognZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389694AbfDXRXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389682AbfDXRXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:23:21 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBCA7205ED;
        Wed, 24 Apr 2019 17:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126600;
        bh=Vx3vSiKIRIkOOkxy5gNdBUTJe6pwOfL+aAMDiZtyvIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhwdlrFxrhI5l5sm7invU1XZ450b/YgVBWbfFYS8VhZjILWin34wSLC/6YuFaKw/i
         K0e6TFv4JayZtBmUqlBvV5o/NAx7+QGb2s7H8EJwWef2LdVQV6ENEoRv698wvepUed
         wUmyjznzqr9N0n5Nw12kAPQDKjxUm52l/nbpGnlI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 164/168] Revert "kbuild: use -Oz instead of -Os when using clang"
Date:   Wed, 24 Apr 2019 19:10:08 +0200
Message-Id: <20190424170933.006766948@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
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
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7bf3fb717921..cc621fbe6c62 100644
--- a/Makefile
+++ b/Makefile
@@ -639,7 +639,7 @@ KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, attribute-alias)
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
-KBUILD_CFLAGS	+= $(call cc-option,-Oz,-Os)
+KBUILD_CFLAGS	+= -Os
 else
 ifdef CONFIG_PROFILE_ALL_BRANCHES
 KBUILD_CFLAGS	+= -O2
-- 
2.19.1



