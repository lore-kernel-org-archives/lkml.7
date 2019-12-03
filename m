Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A55C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C652053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413911;
	bh=lBGsPdVqWRIlpSzE9JQT9JoBoAkeI+DuX9UVhFt3syA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y/aeGtjTf/JJHFtoD7adxODAUOTBzhYFzZWdPOGWozJZM+tmOZ+OG7EbrcGtuAWqe
	 EbZf8f7r319NwCBf+VdsnlrKkd2R6iaOgObsTWSDRpp1GK35T5oAuIRBNZPwBg3GEb
	 gg0UIKEyDoi0DGZ0MQBwjVucrB/1uHyy4KRZ51WM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbfLCW6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:58:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730121AbfLCW6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:58:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 904F820863;
        Tue,  3 Dec 2019 22:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413905;
        bh=lBGsPdVqWRIlpSzE9JQT9JoBoAkeI+DuX9UVhFt3syA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bK/l6evGiv5mfJT/elkVJvKpUJcKTcPjvabb4sR2lErXC/Yo31aAcr7bn59GwE19v
         CGZCCPk5PqROHHz9aICKeX1WTRKm7BH3zqjcFXx9NCqiZ1Ie+d2OaJCpjEcHDP1Ct3
         ItcSQX9lp6P6tDeU8exgzDhdMpgNHcB/CFwlgL9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lionel Debieve <lionel.debieve@st.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 4.19 308/321] hwrng: stm32 - fix unbalanced pm_runtime_enable
Date:   Tue,  3 Dec 2019 23:36:14 +0100
Message-Id: <20191203223443.169670189@linuxfoundation.org>
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
@@ -169,6 +169,13 @@ static int stm32_rng_probe(struct platfo
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
@@ -210,6 +217,7 @@ static struct platform_driver stm32_rng_
 		.of_match_table = stm32_rng_match,
 	},
 	.probe = stm32_rng_probe,
+	.remove = stm32_rng_remove,
 };
 
 module_platform_driver(stm32_rng_driver);


