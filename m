Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7D0C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DE220665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442461;
	bh=EBdM+xYkn1wZU7C8dtQzzjr5qG+cyR7BfkJ6Nr4mO6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ggz/aL0R5SYJ8zA483I0PXssjo4CyxhA/D2mlLUdbmcOpEPpO1annwbTr3kX48RyE
	 tLBTA0aCIjk4vqDyWuDbaGDnHxC0bbVdgagT0kxvLuGWicEdIoiiH88M5njGxxbaHp
	 piwBfwcWuF+qf782G2VEMrsaMHQeiSN9tLjwqO3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391655AbfFMQOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:14:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731193AbfFMIm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:42:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EACA72063F;
        Thu, 13 Jun 2019 08:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415347;
        bh=EBdM+xYkn1wZU7C8dtQzzjr5qG+cyR7BfkJ6Nr4mO6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u+GXWYH9ZujW0J7ZNiFqpj392HhDW09bqCPlGBcdwMnTyEb0zspZLwsFWwsCDFkYC
         n5RiioCRqdVFRovbR/Q/AbeJzZdMnTo2BBx6/muVm/6C+0yVTsrnA0IEvOaUa0zu+Y
         mPzkWK9LX0dJ9C7UpwoV9RW290H0No5lZ8n7GM0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kabir Sahane <x0153567@ti.com>,
        "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 092/118] ARM: OMAP2+: pm33xx-core: Do not Turn OFF CEFUSE as PPA may be using it
Date:   Thu, 13 Jun 2019 10:33:50 +0200
Message-Id: <20190613075649.240969830@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075643.642092651@linuxfoundation.org>
References: <20190613075643.642092651@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 72aff4ecf1cb85a3c6e6b42ccbda0bc631b090b3 ]

This area is used to store keys by HSPPA in case of AM438x SOC. Leave it
active.

Signed-off-by: Kabir Sahane <x0153567@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/pm33xx-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index f4971e4a86b2..ca7026958d42 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -51,10 +51,12 @@ static int amx3_common_init(void)
 
 	/* CEFUSE domain can be turned off post bootup */
 	cefuse_pwrdm = pwrdm_lookup("cefuse_pwrdm");
-	if (cefuse_pwrdm)
-		omap_set_pwrdm_state(cefuse_pwrdm, PWRDM_POWER_OFF);
-	else
+	if (!cefuse_pwrdm)
 		pr_err("PM: Failed to get cefuse_pwrdm\n");
+	else if (omap_type() != OMAP2_DEVICE_TYPE_GP)
+		pr_info("PM: Leaving EFUSE power domain active\n");
+	else
+		omap_set_pwrdm_state(cefuse_pwrdm, PWRDM_POWER_OFF);
 
 	return 0;
 }
-- 
2.20.1



