Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C3DC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC0421871
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595883;
	bh=9XqVUcdIb7q56IsKIhs7Pus1VDDfsQccebNKK1Few+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dfnXdA6ZyTTAYplSjnllwNmcPTDpE9/5XmaGsFkQzKElf+wFZGq8r6dI7/p2sRaBS
	 YRxTnoz203XFkRSd2eRSggfdMYM0k9eaK16VSPAikMJUsqRP2lAOrLIJWSf7lF63si
	 oDRLxkXwPQzbyLcY9JgaP8MuaBrpO3j/wuzmcDQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfF0AiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbfF0Ahu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:37:50 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F49B2080C;
        Thu, 27 Jun 2019 00:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595869;
        bh=9XqVUcdIb7q56IsKIhs7Pus1VDDfsQccebNKK1Few+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xt6DtsZo67y5PPHOfnTYUYgO/iVfFJjK/fu7FvFSN10VC2UthauyqDDTxZcQrr36n
         IxbkBnp2upCvv7s0Jv3g+2RcocVdGL18Yjn0vQktnFlQXv7O53/SLt793tp+b3utHe
         Gt5S7HGoHDUHgzO09DvoDM9cRh/s3YF0hVneujYY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 30/60] s390/boot: disable address-of-packed-member warning
Date:   Wed, 26 Jun 2019 20:35:45 -0400
Message-Id: <20190627003616.20767-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003616.20767-1-sashal@kernel.org>
References: <20190627003616.20767-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[ Upstream commit f9364df30420987e77599c4789ec0065c609a507 ]

Get rid of gcc9 warnings like this:

arch/s390/boot/ipl_report.c: In function 'find_bootdata_space':
arch/s390/boot/ipl_report.c:42:26: warning: taking address of packed member of 'struct ipl_rb_components' may result in an unaligned pointer value [-Waddress-of-packed-member]
   42 |  for_each_rb_entry(comp, comps)
      |                          ^~~~~

This is effectively the s390 variant of commit 20c6c1890455
("x86/boot: Disable the address-of-packed-member compiler warning").

Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index ee65185bbc80..e6c2e8925fef 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -24,6 +24,7 @@ KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-option,-ffreestanding)
+KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
 UTS_MACHINE	:= s390x
-- 
2.20.1

