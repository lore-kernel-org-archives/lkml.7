Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A49C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353092082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="VywnFieo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbfDBJIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:08:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:34703 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729891AbfDBJIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:08:42 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44YNfw286Fz9v0Zh;
        Tue,  2 Apr 2019 11:08:40 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=VywnFieo; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8LpclvzCYQI2; Tue,  2 Apr 2019 11:08:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44YNfw13Q1z9v0ZY;
        Tue,  2 Apr 2019 11:08:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1554196120; bh=AzVUINW1pHnpBCWDawAI2SVoEUpzzOXoBPgFojhPawQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=VywnFieoWyrjl+ZL/WDhF9RVWk4L0eUMusXPOHDZqVutcseHtUWTGzAI9kZeEGNz1
         H46+35KcyCGT/5oZ6dkQSCWC5nz+Pqpxw6PjsvODze3yJDrAKO1lE8X0ubCRnpzINx
         4YJiFH/dpYWpJw/Utb6YYrsjJZQ27aSog8jpV1nw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3FA9A8B8C4;
        Tue,  2 Apr 2019 11:08:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GwB73V1amiSE; Tue,  2 Apr 2019 11:08:41 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C26A8B8C3;
        Tue,  2 Apr 2019 11:08:41 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id F3232661D9; Tue,  2 Apr 2019 09:08:40 +0000 (UTC)
Message-Id: <cbd5b58e286d891cded00eb46f279d0e9d86f819.1554195798.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554195798.git.christophe.leroy@c-s.fr>
References: <cover.1554195798.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 6/9] Add capability to prepend the command line
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org
Date:   Tue,  2 Apr 2019 09:08:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchs adds an option of prepend a text to the command
line instead of appending it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 include/linux/cmdline.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
index afcc00d7628d..5caf3724c1ab 100644
--- a/include/linux/cmdline.h
+++ b/include/linux/cmdline.h
@@ -3,7 +3,7 @@
 #define _LINUX_CMDLINE_H
 
 /*
- * This function will append a builtin command line to the command
+ * This function will append or prepend a builtin command line to the command
  * line provided by the bootloader. Kconfig options can be used to alter
  * the behavior of this builtin command line.
  * @dest: The destination of the final appended/prepended string.
@@ -22,6 +22,9 @@ static __always_inline void cmdline_build(char *dest, const char *src, size_t le
 		strlcat(dest, CONFIG_CMDLINE, length);
 		return;
 	}
+
+	if (IS_ENABLED(CONFIG_CMDLINE_PREPEND) && sizeof(CONFIG_CMDLINE) > 1)
+		strlcat(dest, CONFIG_CMDLINE " ", length);
 #endif
 	if (dest != src)
 		strlcat(dest, src, length);
-- 
2.13.3

