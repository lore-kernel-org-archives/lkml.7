Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3924AC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE3B217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560544165;
	bh=oYX7BzfVsv6TRTl87Ld2cp/NrFEYvaMOp/9+1tih2sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aPlx79l92pMMtziJ+xyuRs1S4XJ9UtIQOdckq8Lzp9akBmILNYYXM/FciF7etvb82
	 x6CCp0sjrq/orcewPU3F4hafUw6rUSgdCPGG0vMJ4gCy34aUDjONhUhO5d0nmC39ez
	 rsnQjezrE0oMpakH/m77joZ6NB8lJUSXOSKpCEmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfFNU3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbfFNU3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:29:19 -0400
Received: from sasha-vm.mshome.net (unknown [131.107.159.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4870217F9;
        Fri, 14 Jun 2019 20:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560544158;
        bh=oYX7BzfVsv6TRTl87Ld2cp/NrFEYvaMOp/9+1tih2sY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mkyFtkUv9jSFOyK+Q8LnDhxg2wzEJ9FhXQlTTpIZRiAudkAMJwCPfo20TJVYihJuC
         e9mOjViesBsv0pm72iLpJnWMiV/TI3glHWkzR7eMfpTM+Hm4PhuxxYIFjS0pjLy0EL
         AwzPBdCbU6nS/CDNuSXgLQObnvzhGHzPv2a9t+SE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 32/59] selftests: vm: install test_vmalloc.sh for run_vmtests
Date:   Fri, 14 Jun 2019 16:28:16 -0400
Message-Id: <20190614202843.26941-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614202843.26941-1-sashal@kernel.org>
References: <20190614202843.26941-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naresh Kamboju <naresh.kamboju@linaro.org>

[ Upstream commit bc2cce3f2ebcae02aa4bb29e3436bf75ee674c32 ]

Add test_vmalloc.sh to TEST_FILES to make sure it gets installed for
run_vmtests.

Fixed below error:
./run_vmtests: line 217: ./test_vmalloc.sh: No such file or directory

Tested with: make TARGETS=vm install INSTALL_PATH=$PWD/x

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vm/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index e13eb6cc8901..05306c58ff9f 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -25,6 +25,8 @@ TEST_GEN_FILES += virtual_address_range
 
 TEST_PROGS := run_vmtests
 
+TEST_FILES := test_vmalloc.sh
+
 KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
-- 
2.20.1

