Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC78C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 20:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FFA2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 20:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bljkmXfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgAEUKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 15:10:25 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37970 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgAEUKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 15:10:25 -0500
Received: by mail-pg1-f196.google.com with SMTP id a33so25879833pgm.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 12:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PRpD2n4zlwukx97QwqwwL5Nrpn0KRR9wzNPg2ILLwjo=;
        b=bljkmXfElHrTWVuiJgbvMqWlZ1RfzX4it52jygfqC75orInqRZE/hvh6fvU62MVutK
         U6FfSlQeAffglaxcZAbsu2kWUFY5t7wxzliND+GYlar9eADluk6/KGmbLfxG6D3Sj1Zv
         cQWFEMCsAurOb+EuELM7F2/vvDRz9GQjYbf0j6gFG7ti7eOyB8NsYcA+ctXWGEZdywRt
         YxglpXobS65FtDE0iyiRaATLqWNsS0esy3jt///Qw+iW9Lf2/Q4mpsqcwhBeJS8n0+Jd
         ktOxHQcijye/6jCckPKlIbuHTVC083OKbXcoIT5dvfBnVRB17T9b64XHaztP/+4VuhmG
         b6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PRpD2n4zlwukx97QwqwwL5Nrpn0KRR9wzNPg2ILLwjo=;
        b=UPrzDsaqy8XS/cLRJjHxCv2whF6hh3TmOcsRU6BBRoccs7Ehnd7WJC4/UFvHNwteSa
         u1xCVdOFTnBppxy1HdcBKGlEMoPZ2GpM30e4HUKMFAVE2h1ThejoJyHVdt0z0Cf3rq4B
         B6t0djtgLD4V2a5zJ1vUqnd3cxmpzqqCa5L/NpNRaf9fEriIOqxYZibmGiARZF5l/KDF
         Zl+QDg2r3CSEZbOFS1GXXWDLPrxb+9evnaE5dh2a6jLD3ExsdfgS1KvfDOF3YLCGGPnu
         b6FNXUOOEZYvLCT86duB9fnIcaICDQhzjA/y78MOIAWR5C4O/eTUnpwFGa7r9u+wIpzk
         M3RQ==
X-Gm-Message-State: APjAAAUGxFJY4GIrom+vRXq3prVztMb28PE2+KOV/ABqcwzWEbXxUhTB
        7HdYhoA7nfR+wvv9lOeBbXgn9ieM
X-Google-Smtp-Source: APXvYqwrGVufAmyBiFk3tO+QS41C72PtEadvDDZBOGaSZMqbaN5UmG/IVLnbl0MmNhCbCrgJx2MpqQ==
X-Received: by 2002:a63:181:: with SMTP id 123mr105423175pgb.36.1578255024335;
        Sun, 05 Jan 2020 12:10:24 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id z29sm74205106pge.21.2020.01.05.12.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 12:10:23 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: Delete CONFIG_SYSFS_SYSCALL from defconfigs
Date:   Sun,  5 Jan 2020 12:10:20 -0800
Message-Id: <20200105201020.13111-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to init/Kconfig:
"sys_sysfs is an obsolete system call no longer supported in libc.
Note that disabling this option is more secure but might break
compatibility with some systems."

This syscall is not required for new architectures. Since the config
defaults to 'y'. Set this to 'n' exlicitly.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 arch/riscv/configs/defconfig      | 1 +
 arch/riscv/configs/rv32_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index e2ff95cb3390..58f97b3cb24c 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -125,3 +125,4 @@ CONFIG_DEBUG_BLOCK_EXT_DEVT=y
 # CONFIG_FTRACE is not set
 # CONFIG_RUNTIME_TESTING_MENU is not set
 CONFIG_MEMTEST=y
+# CONFIG_SYSFS_SYSCALL is not set
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index eb519407c841..f4076b6ac063 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -122,3 +122,4 @@ CONFIG_DEBUG_BLOCK_EXT_DEVT=y
 # CONFIG_FTRACE is not set
 # CONFIG_RUNTIME_TESTING_MENU is not set
 CONFIG_MEMTEST=y
+# CONFIG_SYSFS_SYSCALL is not set
-- 
2.17.1

