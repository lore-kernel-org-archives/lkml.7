Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF955C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA03320721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OXQL6TqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgAIT1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:27:38 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41311 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbgAIT1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:27:37 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so8380965ioo.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 11:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=hhlS5r0bHcUkFdk5r4BVFKnYQHiudb5I1GHAOOKgB40=;
        b=OXQL6TqOfK9AYq+qp/IIHZ51ORk5NHJuC80QvHGf0eH7391hSSOMhSUVsKxOECZ1Xb
         evk0+LG9ftbTBkXGZ1DD631eY/JjGmSGm7UacSVkcBEbItf5Y4z2EhE+Fi3QEb2i7u/O
         oTOMXPChAEBWTAz4KzB1nt2CpHssKGqQBE+EKGNoi6FyJzDAPa98BfSh6azl9x5uDM+8
         htkiK2DYhbtIajfd0RAh69nNtSctG0QTQYL0Fu2qV3Gkkryn+RkR3dzBtOSBmIqAFovY
         dqn/e3Gga1WudhoNgr3YtuXKhKInwC1f6xyEHKKhT275NFyj2m1enMhI0NeCuuMCYJq4
         O6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=hhlS5r0bHcUkFdk5r4BVFKnYQHiudb5I1GHAOOKgB40=;
        b=nnfdxQJ0+QpYPWVZaRpMik9sG5w911i7X0cfcyvDfhGDZ0wLwmFa6cBDclZ0uBUMMN
         VgQK4U0KM2Zk5OkUFdLCUxcE/6GmmYsuyOmUu3+ieFfmHdxpMrbbNqXYlmrbmhntElbr
         ugD8cGcdLhUBEgLbz5y9VIS8EgyrOvoh4Uqn9/08fkSrRkXJmPU2z53wyXQrgOqdgep3
         Nf3OOsNxhVjQ88gjxCjLZlLRWbByxvtwS70Z0JJhRRlU6tFbkOKYlA0IbV6Ud2g3Zrl6
         ap20gWhqATuDY48H6B23UHlFLfaQw7C85dwdOgH9u4+l/+IMGMsWxMG6McvZ5axZDb2b
         geWw==
X-Gm-Message-State: APjAAAX1EybBSabn42ieHsWl9KOqfb1rFpJbxKKJdBjSWQotc917+Cyd
        mgSf/Hml79TfNhoE/8vbh/DKtw==
X-Google-Smtp-Source: APXvYqxcpU92uMnaGwE2OGRBS2wn+iEnI2X56wCEWoY2GoXzqyILoN6ceTT3kjQAVCD1sHEZ5Np8hQ==
X-Received: by 2002:a5e:860e:: with SMTP id z14mr8850594ioj.10.1578598056639;
        Thu, 09 Jan 2020 11:27:36 -0800 (PST)
Received: from localhost (67-0-46-172.albq.qwest.net. [67.0.46.172])
        by smtp.gmail.com with ESMTPSA id e7sm1641950iot.71.2020.01.09.11.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 11:27:35 -0800 (PST)
Date:   Thu, 9 Jan 2020 11:27:34 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Greentime Hu <greentime.hu@sifive.com>
cc:     green.hu@gmail.com, greentime@kernel.org, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        schwab@suse.de, anup@brainfault.org
Subject: Re: [PATCH v3] riscv: make sure the cores stay looping in
 .Lsecondary_park
In-Reply-To: <20200109031516.29639-1-greentime.hu@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.2001091126480.135239@viisi.sifive.com>
References: <20200109031516.29639-1-greentime.hu@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2020, Greentime Hu wrote:

> The code in secondary_park is currently placed in the .init section.  The
> kernel reclaims and clears this code when it finishes booting.  That
> causes the cores parked in it to go to somewhere unpredictable, so we
> move this function out of init to make sure the cores stay looping there.
> 
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks, the following is what's been queued for v5.5-rc.


- Paul

From: Greentime Hu <greentime.hu@sifive.com>
Date: Thu, 9 Jan 2020 11:15:16 +0800
Subject: [PATCH] riscv: make sure the cores stay looping in .Lsecondary_park

The code in secondary_park is currently placed in the .init section.  The
kernel reclaims and clears this code when it finishes booting.  That
causes the cores parked in it to go to somewhere unpredictable, so we
move this function out of init to make sure the cores stay looping there.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Cc: Andreas Schwab <schwab@suse.de>
Cc: stable@vger.kernel.org
Fixes: 76d2a0493a17d ("RISC-V: Init and Halt Code")
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/kernel/head.S | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 797802c73dee..c9cc44ef7184 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -209,11 +209,6 @@ relocate:
 	tail smp_callin
 #endif
 
-.align 2
-.Lsecondary_park:
-	/* We lack SMP support or have too many harts, so park this hart */
-	wfi
-	j .Lsecondary_park
 END(_start)
 
 #ifdef CONFIG_RISCV_M_MODE
@@ -295,6 +290,13 @@ ENTRY(reset_regs)
 END(reset_regs)
 #endif /* CONFIG_RISCV_M_MODE */
 
+.section ".text", "ax",@progbits
+.align 2
+.Lsecondary_park:
+	/* We lack SMP support or have too many harts, so park this hart */
+	wfi
+	j .Lsecondary_park
+
 __PAGE_ALIGNED_BSS
 	/* Empty zero page */
 	.balign PAGE_SIZE
-- 
2.25.0.rc2

