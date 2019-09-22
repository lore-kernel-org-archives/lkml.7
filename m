Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59861C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E29206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569180348;
	bh=eMPlCWxTQpyconOk0Sr//jZgoyEkKBpyv80QPkFVPI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FVkz8sxbBLDUdZcZiOEmoUKyeTFzrLwRt79i9hN6Kr3zQfHBbLzgpQMvIwkX/t2TI
	 jhIcJWefU0LKqzsf3OAgyaR8hJvqMXTRQPbFLuKAsXbKfdiwpb6ylOn4VTjyH8ctjX
	 wZCLERP0Q87wzOkPoDGnaqu+zZZ5nHSwRnwzvq2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393056AbfIVSwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406764AbfIVSwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:52:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57F6C208C2;
        Sun, 22 Sep 2019 18:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178321;
        bh=eMPlCWxTQpyconOk0Sr//jZgoyEkKBpyv80QPkFVPI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IyZgaokE6dYGWUJPlVn5mnMXYBCqXdqLdE+mWzonD/aZJAsD27X127pu3ypo2qd7k
         rKbfacjXc+hs9txe3z1+81EXTeH6NDahPQNxIYnWiWs5QldMRmjtqVqXoiruzybWLX
         Wd6xRfBf/06RNFwQYlOR5koMIelysl2B2iAxddrk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Peter Collingbourne <pcc@google.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.2 087/185] powerpc/Makefile: Always pass --synthetic to nm if supported
Date:   Sun, 22 Sep 2019 14:47:45 -0400
Message-Id: <20190922184924.32534-87-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184924.32534-1-sashal@kernel.org>
References: <20190922184924.32534-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 117acf5c29dd89e4c86761c365b9724dba0d9763 ]

Back in 2004 we added logic to arch/ppc64/Makefile to pass
the --synthetic option to nm, if it was supported by nm.

Then in 2005 when arch/ppc64 and arch/ppc were merged, the logic to
add --synthetic was moved inside an #ifdef CONFIG_PPC64 block within
arch/powerpc/Makefile, and has remained there since.

That was fine, though crufty, until recently when a change to
init/Kconfig added a config time check that uses $(NM). On powerpc
that leads to an infinite loop because Kconfig uses $(NM) to calculate
some values, then the powerpc Makefile changes $(NM), which Kconfig
notices and restarts.

The original commit that added --synthetic simply said:
  On new toolchains we need to use nm --synthetic or we miss code
  symbols.

And the nm man page says that the --synthetic option causes nm to:
  Include synthetic symbols in the output. These are special symbols
  created by the linker for various purposes.

So it seems safe to always pass --synthetic if nm supports it, ie. on
32-bit and 64-bit, it just means 32-bit kernels might have more
symbols reported (and in practice I see no extra symbols). Making it
unconditional avoids the #ifdef CONFIG_PPC64, which in turn avoids the
infinite loop.

Debugged-by: Peter Collingbourne <pcc@google.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index c345b79414a96..403f7e193833a 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -39,13 +39,11 @@ endif
 uname := $(shell uname -m)
 KBUILD_DEFCONFIG := $(if $(filter ppc%,$(uname)),$(uname),ppc64)_defconfig
 
-ifdef CONFIG_PPC64
 new_nm := $(shell if $(NM) --help 2>&1 | grep -- '--synthetic' > /dev/null; then echo y; else echo n; fi)
 
 ifeq ($(new_nm),y)
 NM		:= $(NM) --synthetic
 endif
-endif
 
 # BITS is used as extension for files which are available in a 32 bit
 # and a 64 bit version to simplify shared Makefiles.
-- 
2.20.1

