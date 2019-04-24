Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF075C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E36B2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126668;
	bh=br7TjRO8WiPXSWzY6ZBR/02D2IfN8dP28bJKrnTqa6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Df1vRByfih8dJMgyCtWLasq6LhvP2OAKaahXhk6aQuhHhOyOUENlZwY44PhNwpwX+
	 fN/SFgykL4AVcv0jG6ssZfMrVULE2z2U/4hfoXVqvUqrHW1m8+U64Zx9581RNU78Rc
	 obS4gL7+yL68v+CKDLsdMmQtxpw6pSAZez4T6yig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389871AbfDXRY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:24:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389862AbfDXRYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:24:24 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A87DD2054F;
        Wed, 24 Apr 2019 17:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126663;
        bh=br7TjRO8WiPXSWzY6ZBR/02D2IfN8dP28bJKrnTqa6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QhVLV7IdG3mvbNv6K+YPtYoQvNjdvyCbDjj3FQEhsI91d5BMwQEzWze9piOzmy3yJ
         1z56xSfU4DVFLMNWgL+N8WrzDuW1URfwyl7sdIgTGjSZb/0IFccbvM6I7AnY5dZ4/0
         Q6wv1rHiXQgZtPTjS2EU6hnRzUSNk3QLomQKXHX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.9 18/44] staging: iio: ad7192: Fix ad7193 channel address
Date:   Wed, 24 Apr 2019 19:09:56 +0200
Message-Id: <20190424170853.577624978@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.924291114@linuxfoundation.org>
References: <20190424170839.924291114@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mircea Caprioru <mircea.caprioru@analog.com>

commit 7ce0f216221856a17fc4934b39284678a5fef2e9 upstream.

This patch fixes the differential channels addresses for the ad7193.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/iio/adc/ad7192.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -109,10 +109,10 @@
 #define AD7192_CH_AIN3		BIT(6) /* AIN3 - AINCOM */
 #define AD7192_CH_AIN4		BIT(7) /* AIN4 - AINCOM */
 
-#define AD7193_CH_AIN1P_AIN2M	0x000  /* AIN1(+) - AIN2(-) */
-#define AD7193_CH_AIN3P_AIN4M	0x001  /* AIN3(+) - AIN4(-) */
-#define AD7193_CH_AIN5P_AIN6M	0x002  /* AIN5(+) - AIN6(-) */
-#define AD7193_CH_AIN7P_AIN8M	0x004  /* AIN7(+) - AIN8(-) */
+#define AD7193_CH_AIN1P_AIN2M	0x001  /* AIN1(+) - AIN2(-) */
+#define AD7193_CH_AIN3P_AIN4M	0x002  /* AIN3(+) - AIN4(-) */
+#define AD7193_CH_AIN5P_AIN6M	0x004  /* AIN5(+) - AIN6(-) */
+#define AD7193_CH_AIN7P_AIN8M	0x008  /* AIN7(+) - AIN8(-) */
 #define AD7193_CH_TEMP		0x100 /* Temp senseor */
 #define AD7193_CH_AIN2P_AIN2M	0x200 /* AIN2(+) - AIN2(-) */
 #define AD7193_CH_AIN1		0x401 /* AIN1 - AINCOM */


