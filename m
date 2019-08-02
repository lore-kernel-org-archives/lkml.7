Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFCEC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0652064A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564740072;
	bh=OFxhJOi9sLznw4eEidnuhjd6ksLW7loPCO20MUwXS5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SSZDyDmksvR/eXngvoxSQEkvafkJP9VuUNMhgA4jI6hoLEntGEXByfr8Y68EslHCO
	 tGhT0UnFHfCYScq+X8ACM+NmGJvtYUdb7PnQSiw2T7Cvro+dYItvVTDJF9Htlnnu/p
	 4d2Vf/t2WNX3RHqBD1si8l8fL48nNxF2YgHxRAB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404186AbfHBKBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405240AbfHBJoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:44:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9412F20880;
        Fri,  2 Aug 2019 09:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739065;
        bh=OFxhJOi9sLznw4eEidnuhjd6ksLW7loPCO20MUwXS5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w5qtSmo+iyI6PuMsUyfgYfdyLiXDTPV3G9zj/tNMjt5qgdQTdgWS+YwT1wR3asUMW
         Zt6uFAmc3CPNSgT5VFD96tyAQ+BmyaRquJgsh+qNJ2+jCKWln1DajAhxlxGl+WfDcL
         l/f+0gtwEw5+//qk67lLicvHHX6etCzXM7K8m618=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 084/223] regulator: s2mps11: Fix buck7 and buck8 wrong voltages
Date:   Fri,  2 Aug 2019 11:35:09 +0200
Message-Id: <20190802092244.425016977@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
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
@@ -386,8 +386,8 @@ static const struct regulator_desc s2mps
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


