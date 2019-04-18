Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B00C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52782218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610970;
	bh=gZChVrJ+cGg/SxkavZOKHqYOzON8o9lR5F24UDVr41g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xbllg3iOa8eGNmgTS08y3VsAXh8Z3sBcmlsQFeGbUdkbyWwEq26ewzrGY0gN0vviZ
	 WxLeyYCqARqwNdiRWWh8ytxabeaW3Uuu+bM+ABElkq/Rszk8UvM62qa4BznwcRtKi5
	 WNovXgdpQeXYGALG9yDiN2t0n3+ntiC1eMf/4RAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403930AbfDRSJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403910AbfDRSJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:09:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43C2F2186A;
        Thu, 18 Apr 2019 18:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610966;
        bh=gZChVrJ+cGg/SxkavZOKHqYOzON8o9lR5F24UDVr41g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ORx0xFSm3PzP1SyY4QZBcpqGbdmCgdZ4ddnvirr33Mbg3MV/mdBeik3LJqlKrKMRR
         S+0NYDyY7UCzOdJbeyPTBQ6g7MUqdoisFHYjIVr7tP2pLiUoWEtBSOMypmIBLwbpJe
         GHp1Kwpq6VnODsKYjXusvZTJX2hDL2+F1AHzpoQw=
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
Subject: [PATCH 4.9 22/50] x86/hpet: Prevent potential NULL pointer dereference
Date:   Thu, 18 Apr 2019 19:57:33 +0200
Message-Id: <20190418160425.382369567@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
References: <20190418160422.455656724@linuxfoundation.org>
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
index 756634f14df6..775c23d4021a 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -914,6 +914,8 @@ int __init hpet_enable(void)
 		return 0;
 
 	hpet_set_mapping();
+	if (!hpet_virt_address)
+		return 0;
 
 	/*
 	 * Read the period and check for a sane value:
-- 
2.19.1



