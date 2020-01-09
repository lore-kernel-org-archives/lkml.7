Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514ACC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 03:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F2A2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 03:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ult0k0kk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgAIDP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 22:15:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46639 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAIDPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 22:15:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id n9so2610798pff.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 19:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YAVuBvxPDj3I0LzDLXvbDmZHEsCRtjT+zj2tEj4Y5o0=;
        b=Ult0k0kkJTdzTW7MQ2GB1DtZ/BwbBoQJYZnFMeFwRUdhno2QaZhDYehMBi4l8xQ4R3
         f6Vm5nmIaDNm2WpxS01DOacFz49NiURBiTnRtRa+yeg5dnQNWUf2FuxbkUVqOtSd4xWI
         8oYfnQBDKuN71FVKXC8P7Ad67YejehhO17v91J1MSZLvwLXVOi312WrVuCLyIodAyJnM
         R2LMkT2jpu5hhkItShDv5+G7pP0T+bZ3EYaVj+sy1D4l84JAKBZaa3xTIBbr1ukakADH
         DE5CQcL73WKZeyKjOePXBsAKa5KTu1mgMuEeCtRxxpW/l/NOda8Sy15FWQj75h3NqC1h
         Ovjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YAVuBvxPDj3I0LzDLXvbDmZHEsCRtjT+zj2tEj4Y5o0=;
        b=b5kf5m9MQSs75A9dPs9wA/C+MvyXSkKA8FDobNC2RVUCjhf0mSOd3u5mfbZt6a9GRQ
         Q+1U46w309jkW1nSIylNPhlhqOInw1/yxDfCNK1EsQZmGMo6YORmaXwVV66dtKwirX53
         cjytF3F9F73me0eeIjOlKsAKheMlbC+mTqLhtfgabXKJ1TPHipUavOWp3bC4z6fNhldk
         pxn3zotHZL5tVpIVg0B9bUGULul/7ukS+5jmNBIVx3afeMR8NUOLCdlbzYH/MxVKJskc
         pcNCu+IkbiV7JmS4Lkx2mPVOzC1Z3SWnFIgxtmNnll+qXq4Z8tTe+qOCRCbNgdShEqxB
         shZg==
X-Gm-Message-State: APjAAAWFxAhoukD9ApdbVwK0EHDJ0FJFdiUSShsD6szk7tYWRQAGE2Mt
        m+9cFFZEu1g/vVUnLejll/FSqw==
X-Google-Smtp-Source: APXvYqydsNvZZ+4d04dshB0xKPGYJ0NHxQ8mRvKUVS/48HKHAQTkdf6GZAGY5kr62oy7BxMXc+WPig==
X-Received: by 2002:a63:ea4c:: with SMTP id l12mr8592315pgk.174.1578539724837;
        Wed, 08 Jan 2020 19:15:24 -0800 (PST)
Received: from greentime-VirtualBox.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id 11sm5473527pfz.25.2020.01.08.19.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 19:15:24 -0800 (PST)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     green.hu@gmail.com, greentime@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, schwab@suse.de, anup@brainfault.org
Cc:     Greentime Hu <greentime.hu@sifive.com>
Subject: [PATCH v3] riscv: make sure the cores stay looping in .Lsecondary_park
Date:   Thu,  9 Jan 2020 11:15:16 +0800
Message-Id: <20200109031516.29639-1-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in secondary_park is currently placed in the .init section.  The
kernel reclaims and clears this code when it finishes booting.  That
causes the cores parked in it to go to somewhere unpredictable, so we
move this function out of init to make sure the cores stay looping there.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kernel/head.S | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index f8f996916c5b..276b98f9d0bd 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -217,11 +217,6 @@ relocate:
 	tail smp_callin
 #endif
 
-.align 2
-.Lsecondary_park:
-	/* We lack SMP support or have too many harts, so park this hart */
-	wfi
-	j .Lsecondary_park
 END(_start)
 
 #ifdef CONFIG_RISCV_M_MODE
@@ -303,6 +298,13 @@ ENTRY(reset_regs)
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
2.17.1

