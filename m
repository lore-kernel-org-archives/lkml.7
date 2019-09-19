Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68195C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3937221928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568930953;
	bh=P61d7vQAF7kIVJkuTM20VyYtHx9B6Qw/zHAPMhHkpuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UoHRqb4W/+2VFACiMoP/SurAJwY0uQSRqp8rt6jFKhhoboHo0bZ8gLod+Zzzt8wtY
	 ubD3Y+4qlrF4lSd3ygSqO7/qX7r8hCQCm7PUFG8oQwX0DAn5vZs4Pv+mVNxE59uLnq
	 XIEfur+UZkLJxyBDp/b/BqW4NrA51W5LA9n5140g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393525AbfISWJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393510AbfISWJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:09:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3287C218AF;
        Thu, 19 Sep 2019 22:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568930947;
        bh=P61d7vQAF7kIVJkuTM20VyYtHx9B6Qw/zHAPMhHkpuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hzhGWZFtpKByb5jzUwftziyieO8kGU28reDr3hUSiswznAZ4OLDEBGx9ATKR9m8lr
         pG0E1+8KeQkSRc/0B5MRDLJR5CCusyamYr2TrAj6CKm813CX7QxmkYXrhPwlYzOxJ3
         h0zznHx1MK2w3yMocdtD8zNlF3gRJ5/JG866kLxE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 041/124] bus: ti-sysc: Simplify cleanup upon failures in sysc_probe()
Date:   Fri, 20 Sep 2019 00:02:09 +0200
Message-Id: <20190919214820.500895647@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

[ Upstream commit a304f483b6b00d42bde41c45ca52c670945348e2 ]

The clocks are not yet parsed and prepared until after a successful
sysc_get_clocks(), so there is no need to unprepare the clocks upon
any failure of any of the prior functions in sysc_probe(). The current
code path would have been a no-op because of the clock validity checks
within sysc_unprepare(), but let's just simplify the cleanup path by
returning the error directly.

While at this, also fix the cleanup path for a sysc_init_resets()
failure which is executed after the clocks are prepared.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 58b38630171ff..0d122440d1111 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2079,27 +2079,27 @@ static int sysc_probe(struct platform_device *pdev)
 
 	error = sysc_init_dts_quirks(ddata);
 	if (error)
-		goto unprepare;
+		return error;
 
 	error = sysc_map_and_check_registers(ddata);
 	if (error)
-		goto unprepare;
+		return error;
 
 	error = sysc_init_sysc_mask(ddata);
 	if (error)
-		goto unprepare;
+		return error;
 
 	error = sysc_init_idlemodes(ddata);
 	if (error)
-		goto unprepare;
+		return error;
 
 	error = sysc_init_syss_mask(ddata);
 	if (error)
-		goto unprepare;
+		return error;
 
 	error = sysc_init_pdata(ddata);
 	if (error)
-		goto unprepare;
+		return error;
 
 	sysc_init_early_quirks(ddata);
 
@@ -2109,7 +2109,7 @@ static int sysc_probe(struct platform_device *pdev)
 
 	error = sysc_init_resets(ddata);
 	if (error)
-		return error;
+		goto unprepare;
 
 	error = sysc_init_module(ddata);
 	if (error)
-- 
2.20.1



