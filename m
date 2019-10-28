Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5912CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EEA21479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8t/xfrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfJ1Wt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 18:49:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33537 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJ1Wt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:49:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so6480453plk.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 15:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/WZEAomVjJ+725DnvAAAnSxsbckEzTmInFHoxAcfrVY=;
        b=K8t/xfrUvO54cAT/K46akV/qEnLzS1/uU1SOkpoor14ttRwVYVkbpqoCY5VMK2fNbm
         fLMCv1GpohL5N99sSwz2m9BFR4OMmrhNGzqngucJyfv3KivEQnBBcbsKxtFirSMedw94
         RO/Q8sQN9KQCI0+BEWRQ92EZ7c16k4AS4hxkOPsqg5Yj3IABTTP+HYi+zR8TYVHuSuvz
         NVxJjGctiHx/EsFpxF338Y7LWtbWIcPmX7IwxPtVZBWApBsiJhDWpo2DNZ3PnDVPVEYP
         Ao8h+M0AsX0dyvTE2U3btXDFFGPBg95M55CK2iU+BUAMClOUHAMLI6Gk+46HaRWqiiLF
         ALzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/WZEAomVjJ+725DnvAAAnSxsbckEzTmInFHoxAcfrVY=;
        b=GY1hZ26E//vavbzqid02scWpRB8QGFSonYGwjuT3MxbA/VlJwDnUXaDXX5d4JfWgOE
         +9wOW3n5BUDp0tnbU/oSKdXg4v0zIVyCReC+W+XKdrpiaa1csVBPevy7VsHgSCkj4xyz
         iwNj2YQnfpURcRvb0HTib46gQvmdJdH7eZr0kNdRnE6n2XUfPdIMBiRTtIMl8wRudOrF
         PZ3dZckYMwY3662YTULJLAK53CixFhzf+ikxOLQShRC7yY6U+HXBfSSPkD9wfXYx2R3c
         ooK7eLb50wdFVOK3ir80oPKOsjivSUOHDCFwFLrtuIX0QWfdDVynG5lZc9+h7O1G0Xjp
         5aNA==
X-Gm-Message-State: APjAAAVnB0OfS7KVMZ9DsqpRTtDwSPp08yVu+m+9qsn07oYoUZQvgt+R
        ifYpTf7Z2e1+QPaXLgFkOsA=
X-Google-Smtp-Source: APXvYqxvD/GJ2WH7xzUvuVqaFgUWlHwU3zy1adKIbAVvZLCucTrhXqRqBQTAZu58dPq3TSZFuaAi/Q==
X-Received: by 2002:a17:902:8345:: with SMTP id z5mr492355pln.113.1572302966574;
        Mon, 28 Oct 2019 15:49:26 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:200::2:78fe])
        by smtp.gmail.com with ESMTPSA id y129sm13092345pgb.28.2019.10.28.15.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 15:49:25 -0700 (PDT)
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
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH] ARM: ASPEED: update default ARCH_NR_GPIO for ARCH_ASPEED
Date:   Mon, 28 Oct 2019 15:49:09 -0700
Message-Id: <20191028224909.1069-1-rentao.bupt@gmail.com>
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
---
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

