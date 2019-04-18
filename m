Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37933C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86DD2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611100;
	bh=LhcowETXqCJjPfg+8BoraNfngeOLBDItV9NMMOH5dwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1/i3STGoRxUXaKoxDD8ZtvsSzDJDM35/rmZkhDREeYzUmZlTO2HBR6EDAEzR7Ej9F
	 g9f//zutW8K60804MhwNVrJpBCWThvlndtHF+Erxn5GP6NercZkXNdiWypKDmaFucg
	 SoXgflwo52CbM7OXdNEp4UzY/fT3Z2j0NXOA8ETE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391932AbfDRSLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404254AbfDRSLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:11:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0617E20675;
        Thu, 18 Apr 2019 18:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611095;
        bh=LhcowETXqCJjPfg+8BoraNfngeOLBDItV9NMMOH5dwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u91+xiIJ4+xaUrtpuODkjXA9yKpzWY4eKjoEhhPCrbhfcGUBOrdj98AC+mvmE/mmP
         Huw/fDbwsfsKpvM5FzDai6rU3vAVtq0S+pOG0Rj+pMSA5IijfAbW6Qwpfkh8OSM1gN
         D/zWMJdXY4xdUdNJT6tKJksYY/RAIqj7SR1QMVx8=
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
Subject: [PATCH 5.0 56/93] x86/hpet: Prevent potential NULL pointer dereference
Date:   Thu, 18 Apr 2019 19:57:34 +0200
Message-Id: <20190418160443.244038533@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
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
index dfd3aca82c61..fb32925a2e62 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -905,6 +905,8 @@ int __init hpet_enable(void)
 		return 0;
 
 	hpet_set_mapping();
+	if (!hpet_virt_address)
+		return 0;
 
 	/*
 	 * Read the period and check for a sane value:
-- 
2.19.1



