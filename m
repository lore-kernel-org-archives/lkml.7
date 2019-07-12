Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8567C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1EC21019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934407;
	bh=ohvH335AArOEC79sETN6ABZrs+hK4BnqYdeYO6lCMj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aWgWBhB4W8gPvSWnnQZrKbAJD2nEWbEysKj1FGaEj+Ln9cQ5V9rSvcLWepbyCyGjo
	 hq1rgi2z46DLIs+MH/et/kre1Lli+75IHXVyHZUdGejl7aT9SFsKxjiXeYWfAjP64D
	 Uh6g/WsWrqhgwZo8jQ6sQFglabjXeFZ4YRRR9zk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfGLM0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfGLM0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:26:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A8BE2084B;
        Fri, 12 Jul 2019 12:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934401;
        bh=ohvH335AArOEC79sETN6ABZrs+hK4BnqYdeYO6lCMj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n+20V3qHZ5sctwP8N44T7vLnuJNLKCQrryFinQ23ySSI7TJ3bDcaa5vY6PtWPtL4W
         AktM6cei6bzg5j12/q8lGLSHPZU+BC2ayI1P2fmDsUkwbXD9OGwqBvRqnh0OMSLgiu
         jrnu+GnPBP8fqx7b6oo7eFon/h1pYJ1I2zhEPhk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 044/138] s390/boot: disable address-of-packed-member warning
Date:   Fri, 12 Jul 2019 14:18:28 +0200
Message-Id: <20190712121630.363021045@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index e21053e5e0da..bbd2dab6730e 100644
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



