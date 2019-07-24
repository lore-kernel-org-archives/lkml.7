Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAB0C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD8D214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997016;
	bh=sGgtsJRmQqZ5jJkaapuMU4JFjwFDPXz6yS4GLk58d68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TKhy7P2wGEtI59ZlNzh/oC1lHqdJE4M+IlVaOjBUJBs1LshMpUp+b2uWyLXOLf2Lg
	 59jf8s+zFwUtMW3lngAwnPH8nhCnwBmRJkoTEsKQ67n1sLVSNZC7v5tu+oC2TK6mi3
	 uxz/eWoEJ0MQTz1S++xMAEvVzocs+0p+5rxLUOgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389363AbfGXTgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:36:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389357AbfGXTgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:36:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F262E214AF;
        Wed, 24 Jul 2019 19:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997011;
        bh=sGgtsJRmQqZ5jJkaapuMU4JFjwFDPXz6yS4GLk58d68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fAs9IbOQ2IRkP4z2CLg2RAs0Xw3kvO9ycD3Wgq8mtnRBqFdK5RhtOoHEBI3R4sz1J
         rdWiMtPZatk7Z6z66Q3QLMklE0ZxWvxgK+RsLM7+VB6832GO8JcDL/9nIFfhqhlkOz
         nP1SG1No2AZ7h///4Ly80Uvm5gI7n+6xhNs6au7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.2 291/413] regulator: s2mps11: Fix buck7 and buck8 wrong voltages
Date:   Wed, 24 Jul 2019 21:19:42 +0200
Message-Id: <20190724191757.027824048@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

commit 16da0eb5ab6ef2dd1d33431199126e63db9997cc upstream.

On S2MPS11 device, the buck7 and buck8 regulator voltages start at 750
mV, not 600 mV.  Using wrong minimal value caused shifting of these
regulator values by 150 mV (e.g. buck7 usually configured to v1.35 V was
reported as 1.2 V).

On most of the boards these regulators are left in default state so this
was only affecting reported voltage.  However if any driver wanted to
change them, then effectively it would set voltage 150 mV higher than
intended.

Cc: <stable@vger.kernel.org>
Fixes: cb74685ecb39 ("regulator: s2mps11: Add samsung s2mps11 regulator driver")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/regulator/s2mps11.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -372,8 +372,8 @@ static const struct regulator_desc s2mps
 	regulator_desc_s2mps11_buck1_4(4),
 	regulator_desc_s2mps11_buck5,
 	regulator_desc_s2mps11_buck67810(6, MIN_600_MV, STEP_6_25_MV),
-	regulator_desc_s2mps11_buck67810(7, MIN_600_MV, STEP_12_5_MV),
-	regulator_desc_s2mps11_buck67810(8, MIN_600_MV, STEP_12_5_MV),
+	regulator_desc_s2mps11_buck67810(7, MIN_750_MV, STEP_12_5_MV),
+	regulator_desc_s2mps11_buck67810(8, MIN_750_MV, STEP_12_5_MV),
 	regulator_desc_s2mps11_buck9,
 	regulator_desc_s2mps11_buck67810(10, MIN_750_MV, STEP_12_5_MV),
 };


