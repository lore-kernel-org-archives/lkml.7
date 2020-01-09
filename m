Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8E7C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CB220661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDpa4XPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbgAIQKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:10:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56414 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731792AbgAIQKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DAmIKVrG0XTaKJJzMfiZimG349dykVofBy5TCpIMs8E=;
        b=ZDpa4XPNBLw32JIErfs1+ui6XRiG9h4veHx8r8OuKrvS44PxOFFPb7oz+mEQAdLeLOs77R
        0mNJXYEjfHcf8BJchPFQ/kZrid9RFB+LFagQLl8ySWfwpGpHk4uKefKgvgawmP0nCX5T3Q
        y/oecZNaM7enHEgWhuE5poQOOUYJcjU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-vD22pYa-OVqk_lPoETbOCw-1; Thu, 09 Jan 2020 11:10:11 -0500
X-MC-Unique: vD22pYa-OVqk_lPoETbOCw-1
Received: by mail-wm1-f71.google.com with SMTP id t16so1104352wmt.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:10:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DAmIKVrG0XTaKJJzMfiZimG349dykVofBy5TCpIMs8E=;
        b=kfTDzNDLisUF32pfLxPnwZIHVogLZajAhWLDAdracUKI6b/PIJVXAOkPTdEgMWkAd0
         GMpChI/KqpZ84t7Dftm7YGWpEumEQ1dVJOyD8vuUB83XStkUex3Q42Zwqb1v5LCK5jKB
         de0yAXTQo2ESxadmGRtJxBsACf5avvaXE5tY4eEq/NP5APbyiIndyzK+iEwoA0gT7uz7
         7Jhd7bXN9Yg66pT02EVv40AGrvXhezI40k8bMTAMRsgo6v30s3d0hAKZfbo6AJGR1f4w
         VhlgitBNEVpfi/jDyqxLSek9MrXVNZK88oQDRI8OoDOnLtCvZiWLhnRehtyjaNSiPh9J
         FKjg==
X-Gm-Message-State: APjAAAU9orPcgTgoucmu/mMDsf1hjN73PwcY+xdl672TWCFj0fzf1bQA
        fJctEWdQMT4QNNBNw+Cg+mQkT/HnB/GM9POdEhJpsGtBjZkTH1rSwIM6Hhl2tt52wCwOxXYhUqh
        f33IThYlzlBE+Nr5RuBIFXPxh
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr5844662wmi.146.1578586210077;
        Thu, 09 Jan 2020 08:10:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyFva8eO8YAHVsY7yqkadvzeSK9FfRmzCmEmBFRtKNIs9P8qgXGmLAvH+I97ylIV2hDbJg/RA==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr5844651wmi.146.1578586209923;
        Thu, 09 Jan 2020 08:10:09 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id y17sm2820948wma.36.2020.01.09.08.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:10:09 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 55/57] arm64: Mark sigreturn32.o as containing non standard code
Date:   Thu,  9 Jan 2020 16:02:58 +0000
Message-Id: <20200109160300.26150-56-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sigreturn32.o contains aarch32 getting copied to the VDSO for
compat user tasks.

This code shouldn't get validated by arm64 objtool.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/kernel/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index f5994679db5f..b978026ea368 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
 					   sys_compat.o
 ifneq ($(CONFIG_COMPAT_VDSO), y)
 obj-$(CONFIG_COMPAT)			+= sigreturn32.o
+OBJECT_FILES_NON_STANDARD_sigreturn32.o := y
 endif
 obj-$(CONFIG_KUSER_HELPERS)		+= kuser32.o
 
-- 
2.21.0

