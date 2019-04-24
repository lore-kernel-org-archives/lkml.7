Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F91CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653F720652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129455;
	bh=dlWWuIHzE+vnOU7sjAWgrH+mWQA932SE29scRyf9XzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OU9WrcBWb6WwBHxwS1dEh0uL8lZivLiDTvmxTrmzZwFq7W05f5Wz0I9O9Axm9itwB
	 xdZGzlW0NSmxrkzNGG335txXonxXYjEBlUZS4nTpFq4WLIAxjOg//8t2sISKEhpp4s
	 y/lyIMAtYMZ6j6IoiYOrjr1lU0F4EuhVc2QZb4Fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388025AbfDXROM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388006AbfDXROF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:14:05 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 448D421909;
        Wed, 24 Apr 2019 17:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126044;
        bh=dlWWuIHzE+vnOU7sjAWgrH+mWQA932SE29scRyf9XzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O7oo83fdA2A666mOEvGMmKmib6UHTAluLS6j8L99mXcURCwC75vn7uqlieJPVr4+G
         olKMMl7S/0/lyhsV8WYxIclfsIgqYmzt6JLKAHAzrPb4uIcP1JAhNYNTErHSx03ah9
         L/i0HyPCtdWQHYgBLOFbUk5KH4UGxtUPfkJ9MzOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Thomas Gleixner <tglx@linutronix.de>, kjlu@umn.edu,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>,
        Nicolai Stange <nstange@suse.de>,
        Roland Dreier <roland@purestorage.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 072/104] x86/hpet: Prevent potential NULL pointer dereference
Date:   Wed, 24 Apr 2019 19:09:29 +0200
Message-Id: <20190424170905.944521456@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2e84f116afca3719c9d0a1a78b47b48f75fd5724 ]

hpet_virt_address may be NULL when ioremap_nocache fail, but the code lacks
a check.

Add a check to prevent NULL pointer dereference.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: kjlu@umn.edu
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joe Perches <joe@perches.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Roland Dreier <roland@purestorage.com>
Link: https://lkml.kernel.org/r/20190319021958.17275-1-pakki001@umn.edu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/hpet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 319bcb9372fe..3e9c5725732f 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -799,6 +799,8 @@ int __init hpet_enable(void)
 		return 0;
 
 	hpet_set_mapping();
+	if (!hpet_virt_address)
+		return 0;
 
 	/*
 	 * Read the period and check for a sane value:
-- 
2.19.1



