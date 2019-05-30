Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B978EC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1B3262C8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ug25Zi4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfE3XFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 19:05:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45481 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfE3XFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 19:05:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id f20so11441680edt.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 16:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RMNTEGnjljyZAjriCMOY9IejLkj2W1fVjZma/THgYWM=;
        b=Ug25Zi4io4lNYmvN0FjHQCoGTHi0tfCmeeYI3Nty3xemOLb4nnkC6nb1zjtP1ekZnF
         2ehiYmhQJCb1q766r/PDkBL3cEtv226HPGfusj2FWZz+XJlQKwSUkv9rhKxNQG+Dnntb
         NJM1I19OUoAlMHsnqcNsPXWnzlZ1MWogxq/QZMzEeF+Y+hxK8HJB4n8BELa7eqkK5FfI
         FY3oJB9/MtSk1bKWFJU6zkJ1EQzHZ0TyecM4PVhbIR8wpNON7CwcxaI+1K4I7IBDt2Ko
         25RkGSCtgcKMcyrLnp3/Axn+95ngviupi4EbaPCSC8N/hcR3lzijUjKd8A0MbbRz50PV
         TQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RMNTEGnjljyZAjriCMOY9IejLkj2W1fVjZma/THgYWM=;
        b=E6j51Yhaq5mq0EG/mOcZcTaTlZJFhMqP6avXvaTbiq5Xj9Tk/wvEPbf4526V9efOet
         SzrnTq1RZfbSxbQ7Dy1a7TfcA/EVIabwQIeGuoqxDWRsl5TjXRkrOIK9tP9HkOTX7VDx
         avFldwY+RS0y53e88eqvEv6/wKMPeEvN/9DrJwqpNvk80ntCzwO4wsy/e4SSbhL62ERO
         3Tkts+bPooU2vrwoDAWumS9wJMMD3E9h8ja0Dnra805d04tuTr/H8ZQFQndf1Wv21n4E
         Vl6p1d8wSRm6OkBnDsKUDMflJmw9F503MjP7jiqTlM0yifitXjdVJcrkBn6pNelv40JN
         G1EQ==
X-Gm-Message-State: APjAAAXeDelyz0FyGijA29znrcgSsTy29YfuspN7bmwL56LjwbM5X2Vq
        x9AUYg28JTXLpDdnpexY8kM=
X-Google-Smtp-Source: APXvYqyTfAAv3mftVSrbrGSG+M230SItvNnMHvOHywfs3HzbRf5qS0cWXLFOho9rWKuZyFMblzaPaQ==
X-Received: by 2002:aa7:d617:: with SMTP id c23mr7661762edr.74.1559257530214;
        Thu, 30 May 2019 16:05:30 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d22sm640338ejm.83.2019.05.30.16.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 16:05:29 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     marc.zyngier@arm.com, Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] arm64: smp: Include smp_plat.h from smp.h
Date:   Thu, 30 May 2019 16:05:16 -0700
Message-Id: <20190530230518.4334-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ARM64 maintainers,

This patch series aims at enabling irq-bcm7038-l1.c on
ARM64/ARCH_BRCMSTB, this driver makes use of cpu_logical_map[] and in
order to avoid adding a CONFIG_ARM64 conditional inclusion of
smp_plat.h, instead smp.h includes smp_plat.h, which is in turn included
by linux/smp.h.

If you like the approach, I would suggest to carry that through the
Broadcom ARM64 SoC pull request for 5.3.

Thank you!

Florian Fainelli (2):
  arm64: smp: Include smp_plat.h from smp.h
  arm64: Enable BCM7038_L1_IRQ for ARCH_BRCMSTB

 arch/arm64/Kconfig.platforms      | 1 +
 arch/arm64/include/asm/smp.h      | 1 +
 arch/arm64/include/asm/smp_plat.h | 1 +
 3 files changed, 3 insertions(+)

-- 
2.17.1

