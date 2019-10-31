Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3257BCA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F395A20856
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2dIOgZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfJaBk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 21:40:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45395 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfJaBk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 21:40:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1so2805071pgj.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 18:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=THm33sey/F8tpDHX1qubvNAiBD6mm2zUX4cg4vLd7dI=;
        b=o2dIOgZ7+lrcRu01IRgjF317J2s/ys08d+KlzGOc2rpbAn+U6OLC1C30Ea8ZTaDfoE
         xxPZYszouo/8gDSk0vgl92TBm4esyFtuEihG41LCQ4HmtXJFQBQeIN2goqfliVb2s+5e
         U7r2pPvF8AhBLm3h8R2m6mwiJeHVepdQCR1lOePl7k+rpI617iIlvRymhYr0iSRaa6NF
         VyhVcYPrWyoY8MsndkbiCmQta31LA6p+n0OhCxrOZ1Wcw8Exuq8fqJS4tkVNifX92DPH
         lEIASj3sBYw3iP0THYEkZs1GgTc8MgWCYCz37blqQI2/5/Jrjfj3qQ4ARv7Dux9v/dbG
         12Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=THm33sey/F8tpDHX1qubvNAiBD6mm2zUX4cg4vLd7dI=;
        b=b6bCEC5PjcSqvpwg3z184ObodcNl3Tmn8p3p30sTFKWqcsoBHSWWWQ2vKvW96RqtU0
         3pYg49il0LC55Noj+GW9NuRLZ8ipvKtlCipolJRk7T1FRv+N9e/E0ely4OO84lxyBiN0
         URcMtSZgrEmZ+yH3iEdkGJzVubBpS05uhH3TM5hNRJMN9ozBeuk6GYQLUsKbhFQPL/nD
         VqcVx46iBFXjh1evk2TSg3ijgKvlyeSnoDvJrbPp2AdGMCMWUlndHlQkPB9kyPyUCUwL
         DliKykT9IdZt+mKcKNV9Yaw7BqrlWssIGJcQN0B00hSqOeF1NS9YkV1HCkhv41arQZH1
         AR6Q==
X-Gm-Message-State: APjAAAXj+L6qjD3KMGiVBbO4xG85ltSf9PSB4cwxMLUN5AamCtVrVjsw
        p/bToucdXBlQXJUEfQSSKR4=
X-Google-Smtp-Source: APXvYqyiiRYmWih5L7Km/8PhYX+xDLNb0WRqCF0+D79eVEcUhmNcBHqLVY85E0aeQ3LEWB8Yel6ujA==
X-Received: by 2002:aa7:9687:: with SMTP id f7mr2805612pfk.230.1572486055591;
        Wed, 30 Oct 2019 18:40:55 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:200::1:e375])
        by smtp.gmail.com with ESMTPSA id b9sm1287811pfp.77.2019.10.30.18.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 18:40:55 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Burton <paulburton@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, arm@kernel.org,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2] ARM: ASPEED: update default ARCH_NR_GPIO for ARCH_ASPEED
Date:   Wed, 30 Oct 2019 18:40:40 -0700
Message-Id: <20191031014040.12898-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Increase the max number of GPIOs from default 512 to 1024 for ASPEED
platforms, because Facebook Yamp (AST2500) BMC platform has total 594
GPIO pins (232 provided by ASPEED SoC, and 362 by I/O Expanders).

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 Changes in v2:
   - updated Reviewed-by and added ARM SoC and SoC maintainers to
     reviewers' list.

 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b7dbeb652cb1..57504f3365c7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1359,7 +1359,7 @@ config ARCH_NR_GPIO
 	int
 	default 2048 if ARCH_SOCFPGA
 	default 1024 if ARCH_BRCMSTB || ARCH_RENESAS || ARCH_TEGRA || \
-		ARCH_ZYNQ
+		ARCH_ZYNQ || ARCH_ASPEED
 	default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5 || \
 		SOC_DRA7XX || ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
 	default 416 if ARCH_SUNXI
-- 
2.17.1

