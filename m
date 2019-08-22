Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3E7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E8D233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566496140;
	bh=zQr/OS7hgJPdZdMVbsb05k6WtMaWvYev5JYNHwhQ6PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LnJLElPz7F7+i9xO8+upSe3xjK/20ho5cHHQergbRka6INV0FP3eAAlZozdHM1b9P
	 INTrL5KByM87ZJbh4EuYnf8mHFdRZ7Nz6cVTQerFw3REpNz1yzbHbjq5uMxmGoQyVV
	 jHtZfwXYX/daygdNO4vbPYwrKFOFnPBhsb2A+oXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393337AbfHVRs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389867AbfHVRWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:22:19 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EDB6233FE;
        Thu, 22 Aug 2019 17:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494539;
        bh=zQr/OS7hgJPdZdMVbsb05k6WtMaWvYev5JYNHwhQ6PA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lCgOGHm9D/H6iwwznwJ27MGNHMDY3VzkHcF4p1dM2njWAPqEQW3Nn8bgzU6byOQAR
         QrahYNVyEpKLc76+/eCVSZ9pcWVzddnTCj307Q4GDFire7Vhxq6mbQ+xf6IDRY0cG5
         pxgsYrkxj3VzgvvRTvzliUSME9ut0FVRlt6mwn0U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 19/78] ARM: davinci: fix sleep.S build error on ARMv4
Date:   Thu, 22 Aug 2019 10:18:23 -0700
Message-Id: <20190822171832.601635831@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171832.012773482@linuxfoundation.org>
References: <20190822171832.012773482@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d64b212ea960db4276a1d8372bd98cb861dfcbb0 ]

When building a multiplatform kernel that includes armv4 support,
the default target CPU does not support the blx instruction,
which leads to a build failure:

arch/arm/mach-davinci/sleep.S: Assembler messages:
arch/arm/mach-davinci/sleep.S:56: Error: selected processor does not support `blx ip' in ARM mode

Add a .arch statement in the sources to make this file build.

Link: https://lore.kernel.org/r/20190722145211.1154785-1-arnd@arndb.de
Acked-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-davinci/sleep.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.S
index a5336a5e27395..459d081caf79b 100644
--- a/arch/arm/mach-davinci/sleep.S
+++ b/arch/arm/mach-davinci/sleep.S
@@ -37,6 +37,7 @@
 #define DEEPSLEEP_SLEEPENABLE_BIT	BIT(31)
 
 	.text
+	.arch	armv5te
 /*
  * Move DaVinci into deep sleep state
  *
-- 
2.20.1



