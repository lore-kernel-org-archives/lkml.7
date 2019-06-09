Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A09C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15AD2067C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100668;
	bh=RraCkwXdzglEq/7vdS33A/72ye87OZQO/agCNTF+Lok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fzzVHh7ST5PsToEf5oAcB94PsE9kv1j0rdlJNRLRrIWvDQHasznRgv3ukulniisP4
	 tYd1jMS38I01l7ffM3PzhYwfX5MxTMvTfWQp9tNmI5k/YH3wdu/F1LMDImS7KATMzT
	 L/y0E4U24ubUicN5+ywmSWKM8/p78Uu8BiMbNlhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbfFIQvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731931AbfFIQv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:51:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAFBF205ED;
        Sun,  9 Jun 2019 16:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099086;
        bh=RraCkwXdzglEq/7vdS33A/72ye87OZQO/agCNTF+Lok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ng24ya3nB0GOPTEqXQNwO8AwRFCw4cHmS6QEN9NpTS9STE//xfMa0ldoSiL7M+QAJ
         7+CvPVetCiYR8tDnoQk3VB6YDcvgsaNDxWZ3fXrFHwxdZxgq0DOQozzCJqEFPCLPIv
         HGOuTvLppaluQ60sIvjmbXGCQMU0EiAgHqJQ8pI8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Kevin Hilman <khilman@baylibre.com>, linux-mips@vger.kernel.org
Subject: [PATCH 4.14 22/35] MIPS: pistachio: Build uImage.gz by default
Date:   Sun,  9 Jun 2019 18:42:28 +0200
Message-Id: <20190609164126.812231250@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164125.377368385@linuxfoundation.org>
References: <20190609164125.377368385@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paul.burton@mips.com>

commit e4f2d1af7163becb181419af9dece9206001e0a6 upstream.

The pistachio platform uses the U-Boot bootloader & generally boots a
kernel in the uImage format. As such it's useful to build one when
building the kernel, but to do so currently requires the user to
manually specify a uImage target on the make command line.

Make uImage.gz the pistachio platform's default build target, so that
the default is to build a kernel image that we can actually boot on a
board such as the MIPS Creator Ci40.

Marked for stable backport as far as v4.1 where pistachio support was
introduced. This is primarily useful for CI systems such as kernelci.org
which will benefit from us building a suitable image which can then be
booted as part of automated testing, extending our test coverage to the
affected stable branches.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
URL: https://groups.io/g/kernelci/message/388
Cc: stable@vger.kernel.org # v4.1+
Cc: linux-mips@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/pistachio/Platform |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/pistachio/Platform
+++ b/arch/mips/pistachio/Platform
@@ -6,3 +6,4 @@ cflags-$(CONFIG_MACH_PISTACHIO)		+=				\
 		-I$(srctree)/arch/mips/include/asm/mach-pistachio
 load-$(CONFIG_MACH_PISTACHIO)		+= 0xffffffff80400000
 zload-$(CONFIG_MACH_PISTACHIO)		+= 0xffffffff81000000
+all-$(CONFIG_MACH_PISTACHIO)		:= uImage.gz


