Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60CEC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6774A20674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413799;
	bh=Nf0DVFVuptbAyQMUFY7AZ2jp/QtCcsFowue809GM62E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R3Yje6j3Q74Ab2Xwyiwyeyk5Sfu1asEX6RDNwYTKYKq9bPs3FSir1rKsX/tqbjCcQ
	 dXZpjUzQU+7Wl0UiQJrCuS2ewrX/3NgWGMFS8d3knYI8HOIf7huN4DAwvUhSOkvXh2
	 BW3N2N/ikDv0DGkR6Re+d1hA8s6KvwS3yAGyTaL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbfLCW4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:56:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729231AbfLCW4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:56:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42F0C20803;
        Tue,  3 Dec 2019 22:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413795;
        bh=Nf0DVFVuptbAyQMUFY7AZ2jp/QtCcsFowue809GM62E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w37agp0Mv2KRWweaQoYHNNF8HgfnAWbDru6RBPyBk+qrUSPYqcdsu8vHAevLugZYg
         o75x/nijfyYWCO5w+/XNp4PjBO/rnc3TWobiyf34BCExd9QADcb/yZtxi+ESr8z5TY
         6A9v801YMCBdlYxHmeS1saBjpqQZKzdErPreav0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.19 266/321] clk: at91: fix update bit maps on CFG_MOR write
Date:   Tue,  3 Dec 2019 23:35:32 +0100
Message-Id: <20191203223440.964911742@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

commit 263eaf8f172d9f44e15d6aca85fe40ec18d2c477 upstream.

The regmap update bits call was not selecting the proper mask, considering
the bits which was updating.
Update the mask from call to also include OSCBYPASS.
Removed MOSCEN which was not updated.

Fixes: 1bdf02326b71 ("clk: at91: make use of syscon/regmap internally")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Link: https://lkml.kernel.org/r/1568042692-11784-1-git-send-email-eugen.hristev@microchip.com
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/at91/clk-main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -162,7 +162,7 @@ at91_clk_register_main_osc(struct regmap
 	if (bypass)
 		regmap_update_bits(regmap,
 				   AT91_CKGR_MOR, MOR_KEY_MASK |
-				   AT91_PMC_MOSCEN,
+				   AT91_PMC_OSCBYPASS,
 				   AT91_PMC_OSCBYPASS | AT91_PMC_KEY);
 
 	hw = &osc->hw;


