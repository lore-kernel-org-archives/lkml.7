Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B844BC2BBE2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 13:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7532253D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 13:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPy+lZJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLGNBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 08:01:16 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38395 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfLGNBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 08:01:15 -0500
Received: by mail-pj1-f68.google.com with SMTP id l4so3920443pjt.5;
        Sat, 07 Dec 2019 05:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5fKjUze8cgTvBYXr/xD7IQCKvwgAbAm/M927SNG2I2I=;
        b=dPy+lZJgFngrRMeT6iOLRHKWYCd3SKLGtIJ5Dd8E3oQlD5jvYo4CMpj+fPb64fHvds
         NbKXaZXnomsPFWKTN+KusvMjCIRQSs1FEdF8oHfyd1OgnCHDVATUKRKlfAPimu+wi4GG
         sdjLJwe2RbHicK0ER5es56Ya4qTmtbn4GTZbzGPrROt3YniibE98mEhEZlOsiMMs+b0b
         9RmspwHUtBVksnvItSwApuz9h8B5dqN37+2cD26TxxDQMwWBROOIvOGssY9Z5lbnRhjc
         QXAX1kIeppmtKFdFlQW21UklLfA1UnZyeUQuOMiR6GypNbUCMbIcaifxAB9LUMMnTUt8
         VW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5fKjUze8cgTvBYXr/xD7IQCKvwgAbAm/M927SNG2I2I=;
        b=DslwK8/5VeQ37Vm8HGSm4IlhYj9Jv77qZHsMqxUrywYckoVgleKwZ9FW5C6i6kNkbL
         OKzsRMDKq8/CnChJAeLqY6t5Zm6ibWc0Hx97AaNG2EU8URe2Xy6nRcMb9oAGmnFdsr1A
         SFez1eM3JcZMscRYHictcuNT7SZ2pFsflcQd3aoAqbvLzxxWDphUkghU2AP/N807JiE+
         Nu78IknPv/g28fH/hVfrLWJCHRQKJtPRarRiJrJpRPuQpJi14LaTTCVaFAnbjerOdrlU
         VYQUsJ0CkTdVmlHE8lYF1pS+htz5AYs1bfdoQayr9yyHsWLSSdZUZ6IKcAz2RvGuufhY
         fdXA==
X-Gm-Message-State: APjAAAXSvNdjGL0KztbHfBTk/23sPKX4p0m0Sw7n02Ss6DnYz73u01TY
        mNv/q9jY9gSggEWGB93htXo=
X-Google-Smtp-Source: APXvYqxZxwm7RvLeAh38k1Gj3cZ7dj0pl76m+2AQ6s0Ras6tURFp580sNwwn4bqwCEvF9f/9Kn4MqA==
X-Received: by 2002:a17:90a:30a4:: with SMTP id h33mr21279555pjb.50.1575723674750;
        Sat, 07 Dec 2019 05:01:14 -0800 (PST)
Received: from localhost.localdomain ([211.243.117.64])
        by smtp.gmail.com with ESMTPSA id f7sm10241246pfk.183.2019.12.07.05.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 05:01:14 -0800 (PST)
From:   Hyunki Koo <hyunki00.koo@gmail.com>
To:     linux@armlinux.org.uk, kgene@kernel.org, krzk@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Hyunki Koo <hyunki00.koo@samsung.com>
Subject: [PATCH 0/2] remove direct dependancy between irq and exynos
Date:   Sat,  7 Dec 2019 22:00:47 +0900
Message-Id: <20191207130049.27533-1-hyunki00.koo@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyunki Koo <hyunki00.koo@samsung.com>

This patch series is written to clean up dependancy of ARCH_EXYNOS
Not all exynos device have IRQ_COMBINER, especially aarch64 EXYNOS
but it is built for all exynos devices.
Thus add the config for EXYNOS_IRQ_COMBINER
remove direct between ARCH_EXYNOS and exynos-combiner.c
and only selected on the aarch32 devices

Hyunki Koo (2):
  irqchip: define EXYNOS_IRQ_COMBINER
  ARM: exynos: add select EXYNOS_IRQ_COMBINER

 arch/arm/mach-exynos/Kconfig | 1 +
 drivers/irqchip/Kconfig      | 7 +++++++
 drivers/irqchip/Makefile     | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.17.1

