Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B71C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BE72154A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483285;
	bh=O4H8gKKIofBTYa/ahR2HGrSqNn62ReqrOkWXmkecmG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QKfh+BWoCBHt3pAX/W2SVGilr49qmEqIApUnJIqyeDBeDZ4A1bb4vyimoG9zxDobE
	 Vsm2IrlYHCiv9ui7frhqOlpTEbm9+vppj2Yn/4lGpmYpIS4WoxoVoDuUWzB5wZTcUr
	 axlfFAh0SOr1KpZKi03f3CNg9SPzDgS1/xLTVjic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbfLDSOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:14:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731937AbfLDSOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:14:38 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 274AD206DF;
        Wed,  4 Dec 2019 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483277;
        bh=O4H8gKKIofBTYa/ahR2HGrSqNn62ReqrOkWXmkecmG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xX0HIrKePm037n4YDctYkyFxHL0Wvh1eytcgLSzILWOGADtV9Tswbli/M400/Dcnq
         Wn8cszbxd39tXDm3iOVjmh/LB1PBjZDmzZUGXEdgokt49P7oeHTAw83Q4KqCSRS8TC
         04G8KcuwQSze5nEScCGoWyPlveCgqSdwq6whWMuc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lionel Debieve <lionel.debieve@st.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 4.9 123/125] hwrng: stm32 - fix unbalanced pm_runtime_enable
Date:   Wed,  4 Dec 2019 18:57:08 +0100
Message-Id: <20191204175326.886744435@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lionel Debieve <lionel.debieve@st.com>

commit af0d4442dd6813de6e77309063beb064fa8e89ae upstream.

No remove function implemented yet in the driver.
Without remove function, the pm_runtime implementation
complains when removing and probing again the driver.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/hw_random/stm32-rng.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -166,6 +166,13 @@ static int stm32_rng_probe(struct platfo
 	return devm_hwrng_register(dev, &priv->rng);
 }
 
+static int stm32_rng_remove(struct platform_device *ofdev)
+{
+	pm_runtime_disable(&ofdev->dev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int stm32_rng_runtime_suspend(struct device *dev)
 {
@@ -202,6 +209,7 @@ static struct platform_driver stm32_rng_
 		.of_match_table = stm32_rng_match,
 	},
 	.probe = stm32_rng_probe,
+	.remove = stm32_rng_remove,
 };
 
 module_platform_driver(stm32_rng_driver);


