Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BFFC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7E720637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575988640;
	bh=0o81+/DwQ1E9CQg0+86DRp/+qNeIsAJJL/aYZVvQR90=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=gHftkW3IRE484AfQNYI3JDMDpRAWcDFM1JJBIeLyi/w2Ucdbm3OjRU5kCTy6imJGQ
	 +upv7nPThO5tOda8OVnYmuLF97jp5f5TytMDCx1sPGl7DMsoNveK5l6z/FoZ7a+r8p
	 Nl5FVJQGimEx87OpIkW4UFdxMaNetxfB++dCN/Lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfLJOhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:37:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfLJOhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:37:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A249E24655;
        Tue, 10 Dec 2019 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575988638;
        bh=0o81+/DwQ1E9CQg0+86DRp/+qNeIsAJJL/aYZVvQR90=;
        h=From:To:Cc:Subject:Date:From;
        b=AQZnhfymLwdRXIbRGLlp1aZ4/1FZ59IQ1AwK0a1KFKH4u4RhmLIF4CnGMMfaFlg9l
         mXi6J/2MFp5Fo7ETLxWKfb972aQN4OJxEWBec/V8rS8wwqJv4S8VsQbQVucitaWe/t
         zUOGpauZ7Ng677xq7WmNvSRgeR8PkR71Kqz/xg+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] tty: serial: samsung: allow driver to be built by anyone
Date:   Tue, 10 Dec 2019 15:36:57 +0100
Message-Id: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to tie this driver to only the OMAP platform,
especially for build testing.  So add COMPILE_TEST as an option allowing
it to be built on any platform.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hyunki Koo <kkoos00@naver.com>
Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
Cc: Shinbeom Choi <sbeom.choi@samsung.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 99f5da3bf913..c835e10bd97e 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -237,7 +237,7 @@ config SERIAL_CLPS711X_CONSOLE
 
 config SERIAL_SAMSUNG
 	tristate "Samsung SoC serial support"
-	depends on PLAT_SAMSUNG || ARCH_EXYNOS
+	depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
-- 
2.24.0

