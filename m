Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9850BC4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DAE21929
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YB0tuTef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389336AbfISK0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:26:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36492 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389324AbfISK0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:26:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so1970393pfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 03:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=mnEF80Cj0avGcfU/sygW7T/gXJMX2lJ6zkkt/vTIMyI=;
        b=YB0tuTefaGv02QDr6Sg5BxVVNsof10kIEk72yvm7p0HfjmE58x6l/XAKTIUQWScheZ
         Uw6cFKrbQr6DzqeItJIDiUmz2OjNh6Azy8+EkWVr9FqrYv+RkUMFX7TMkJqvlZY7Hfwr
         uw2AczIMYTKzvm1FbE4d7CJdzRo5GrZaU8pRunYIKCub1cYhKgn/C1f8NRIr9nA1DtVj
         hFthuwhmfjlOqBMdomdQxX5nKkdLz0/v/UiFs7yvMfAiBTcxG0O00FmSX8au4zNimsxG
         gPQQbXzyTmky1VahM3qmTiaTIvnWO9/NYjMBEWxwWt93kHaeoIpqnSk2V/sIY8D+PDDR
         yrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=mnEF80Cj0avGcfU/sygW7T/gXJMX2lJ6zkkt/vTIMyI=;
        b=o7eANW7alVP1xLg0weWQUhxjrtrUxKSrwH6I8VYoobyfme2Ih4QmmeQo2TCAia4Gvc
         mg2sVsfJsk5cpxTN372HaiFFTIeYvhxGniyRT0RdwcCwLLpsTuiBYyzNEpcYsvHpfVmu
         tG1T6evY//PzyPMPLFOWHrDwSTSlVObXrakGbZGaAOJS+WyFt6pIMvG8ct3w71z/1zil
         t+Gp5+gRByMR6lZ5EhFPJHUjrSUz0iPo5EplDcupPXGMs3zIne7AK7AVWFuBMDmJSV8+
         lEWEweXl7o28N2hZ39V6QW3AlDRFZTK3bDmliRRW/YySA0DuxtDkA+RSPxid+sjxWapm
         R2Rw==
X-Gm-Message-State: APjAAAXzqe0nx39hVF+D0KqTTImyW/sTJdbYqBesHWUCETzI6UDzR2Yn
        v9GzwsbeqtsjU8EbSy8Xd8Hu0w==
X-Google-Smtp-Source: APXvYqxrUtAf3k9NErxJRv/sppCM0Ns2pA/LVX7vRrE17N/8oiw/TMte0IovIlHoz7tdtSRDZVfVYg==
X-Received: by 2002:a63:2363:: with SMTP id u35mr8651955pgm.208.1568888761648;
        Thu, 19 Sep 2019 03:26:01 -0700 (PDT)
Received: from localhost (57.sub-174-194-139.myvzw.com. [174.194.139.57])
        by smtp.gmail.com with ESMTPSA id c16sm13834574pja.2.2019.09.19.03.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 03:26:00 -0700 (PDT)
Date:   Thu, 19 Sep 2019 03:25:56 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Xiang Wang <merle@hardenedlinux.org>
cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "citypw@hardenedlinux.org" <citypw@hardenedlinux.org>
Subject: Re: [PATCH] arch/riscv: disable too many harts before pick main boot
 hart
In-Reply-To: <AMJe39pHTcb4gsI-_Dv-wmR8_x9EbCCN9LKI47j34_8vBKRqzFxPrjmZvBtwV5OU_HcOiRkKUG66xVaNQ8VAXw7Ws0CCK74gpA8pKaYN5wM=@hardenedlinux.org>
Message-ID: <alpine.DEB.2.21.9999.1909190324250.10826@viisi.sifive.com>
References: <AMJe39pHTcb4gsI-_Dv-wmR8_x9EbCCN9LKI47j34_8vBKRqzFxPrjmZvBtwV5OU_HcOiRkKUG66xVaNQ8VAXw7Ws0CCK74gpA8pKaYN5wM=@hardenedlinux.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2019, Xiang Wang wrote:

> From 12300865d1103618c9d4c375f7d7fbe601b6618c Mon Sep 17 00:00:00 2001
> From: Xiang Wang <merle@hardenedlinux.org>
> Date: Fri, 6 Sep 2019 11:56:09 +0800
> Subject: [PATCH] arch/riscv: disable too many harts before pick main boot hart
> 
> These harts with id greater than or equal to CONFIG_NR_CPUS need to be disabled.
> But pick the main Hart can choose any one. So, before pick the main hart, you
> need to disable the hart with id greater than or equal to CONFIG_NR_CPUS.
> 
> Signed-off-by: Xiang Wang <merle@hardenedlinux.org>

Thanks, here's what I'm planning to queue for v5.4-rc1.  Please let me 
know ASAP if you want to change the patch description.


- Paul

From: Xiang Wang <merle@hardenedlinux.org>
Date: Fri, 6 Sep 2019 11:56:09 +0800
Subject: [PATCH] arch/riscv: disable excess harts before picking main boot hart

Harts with id greater than or equal to CONFIG_NR_CPUS need to be
disabled.  But the kernel can pick any hart as the main hart.  So,
before picking the main hart, the kernel must disable harts with ids
greater than or equal to CONFIG_NR_CPUS.

Signed-off-by: Xiang Wang <merle@hardenedlinux.org>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
[paul.walmsley@sifive.com: updated to apply; cleaned up patch
 description]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/kernel/head.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 15a9189f91ad..72f89b7590dd 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -63,6 +63,11 @@ _start_kernel:
 	li t0, SR_FS
 	csrc CSR_SSTATUS, t0
 
+#ifdef CONFIG_SMP
+	li t0, CONFIG_NR_CPUS
+	bgeu a0, t0, .Lsecondary_park
+#endif
+
 	/* Pick one hart to run the main boot sequence */
 	la a3, hart_lottery
 	li a2, 1
@@ -154,9 +159,6 @@ relocate:
 
 .Lsecondary_start:
 #ifdef CONFIG_SMP
-	li a1, CONFIG_NR_CPUS
-	bgeu a0, a1, .Lsecondary_park
-
 	/* Set trap vector to spin forever to help debug */
 	la a3, .Lsecondary_park
 	csrw CSR_STVEC, a3
-- 
2.23.0

