Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBFEC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66149217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892306;
	bh=cLlmmAGCVwDgnENcAsbB4Ldr9YL25YNv2N8nZLv1Zok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F0gjTXMpAQvM+Co5AAH7k9XwkXGjISoPf7kwnAj6+DHR9UdGwxzMr35EzreFlz2U1
	 Wx1KbtO6CSoAKX/aS0K05h4cL2MGDH6tTmENeGAKwGWhpPXkH1z5WFLTJFntCIUf9B
	 o1/tULpLGpcqMXIjnDJHT8Jxspn4XIvogXHWF+bI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfH0Hvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:51:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfH0Hvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:51:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C55522173E;
        Tue, 27 Aug 2019 07:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892303;
        bh=cLlmmAGCVwDgnENcAsbB4Ldr9YL25YNv2N8nZLv1Zok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BfDcKYQ7fHluCqq4r7dvR4+jC7cpQ9HOEAuHPzQbEjS5rXRrL83u1DPjz2NuOXvP5
         z0OPUSWYIWL6xu00vVHveyie5Hz4HOL09rzFIK4x7zTn5MUw/L7l0jf7g28VdMLCOb
         yihp5TRFflhWF3oBd+ExjFECb1VH6JMMKDaR9X7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 02/62] MIPS: kernel: only use i8253 clocksource with periodic clockevent
Date:   Tue, 27 Aug 2019 09:50:07 +0200
Message-Id: <20190827072700.174800517@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072659.803647352@linuxfoundation.org>
References: <20190827072659.803647352@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a07e3324538a989b7cdbf2c679be6a7f9df2544f ]

i8253 clocksource needs a free running timer. This could only
be used, if i8253 clockevent is set up as periodic.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/i8253.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/i8253.c b/arch/mips/kernel/i8253.c
index 5f209f111e59e..df7ddd246eaac 100644
--- a/arch/mips/kernel/i8253.c
+++ b/arch/mips/kernel/i8253.c
@@ -32,7 +32,8 @@ void __init setup_pit_timer(void)
 
 static int __init init_pit_clocksource(void)
 {
-	if (num_possible_cpus() > 1) /* PIT does not scale! */
+	if (num_possible_cpus() > 1 || /* PIT does not scale! */
+	    !clockevent_state_periodic(&i8253_clockevent))
 		return 0;
 
 	return clocksource_i8253_init();
-- 
2.20.1



