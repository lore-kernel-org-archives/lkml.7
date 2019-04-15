Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23534C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE39218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355611;
	bh=pv241a+ODD2P1UubVRuCI2ziXw96Wt9oin+ScagxhSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k7KEtRgpPi+XZoA+GlX046vsQ9QL+ha1QNK+78tiKo7ggg3K5fBAvJrqg/zBWY5RE
	 J1w0t0TjYQQCREeRQGVOaRrnBr/91uGSb4ne6xxV7mHx74fDMOUnmzKn4Bv9JzO+Uo
	 CKc9nf0t7sdykKZ5BLnXVobKnFh+rVaClYM/RCFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbfDOTNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731567AbfDOTN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:13:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CB5520880;
        Mon, 15 Apr 2019 19:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355607;
        bh=pv241a+ODD2P1UubVRuCI2ziXw96Wt9oin+ScagxhSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EZ6xrgUUnfDWbx+4D5T5s0kRklg1hnRoX2aMYIdon9lj5jt1NOXGE4++HC1aYhIvh
         8ZcNTy4D4twtcQCURtHEkcFYnJp/zxqMOW1P68ULuwfIuzOSOlJ4uSY/9V7uP24zN7
         NvLGPN0a/AjQN262hlVJsKEpLSgP0n/QhPjr9f18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5.0 085/117] ARM: OMAP1: ams-delta: Fix broken GPIO ID allocation
Date:   Mon, 15 Apr 2019 21:00:55 +0200
Message-Id: <20190415183749.239839757@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janusz Krzysztofik <jmkrzyszt@gmail.com>

commit 3e2cf62efec52fb49daed437cc486c3cb9a0afa2 upstream.

In order to request dynamic allocationn of GPIO IDs, a negative number
should be passed as a base GPIO ID via platform data.  Unfortuntely,
commit 771e53c4d1a1 ("ARM: OMAP1: ams-delta: Drop board specific global
GPIO numbers") didn't follow that rule while switching to dynamically
allocated GPIO IDs for Amstrad Delta latches, making their IDs
overlapping with those already assigned to OMAP GPIO devices.  Fix it.

Fixes: 771e53c4d1a1 ("ARM: OMAP1: ams-delta: Drop board specific global GPIO numbers")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: stable@vger.kernel.org
Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-omap1/board-ams-delta.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -182,6 +182,7 @@ static struct resource latch1_resources[
 
 static struct bgpio_pdata latch1_pdata = {
 	.label	= LATCH1_LABEL,
+	.base	= -1,
 	.ngpio	= LATCH1_NGPIO,
 };
 
@@ -219,6 +220,7 @@ static struct resource latch2_resources[
 
 static struct bgpio_pdata latch2_pdata = {
 	.label	= LATCH2_LABEL,
+	.base	= -1,
 	.ngpio	= LATCH2_NGPIO,
 };
 


