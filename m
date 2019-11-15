Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69346C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C33920733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BoaaaX8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKOWd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:33:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47086 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfKOWd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:33:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id r18so6596813pgu.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Tc+IEmTbMBJCj4EiVIkUr9PV2atSgJthk3up+qVhyOE=;
        b=BoaaaX8RsyTJpotwcaZaTD6Tyhn833MOIIDHMWr3NTNPT5Mmx71uuoUUG3DF6Dup9s
         lAeMeISC4gG/92nA7AyPgTb37ys0iuHbAxbDO3MU0OERSfxWYFUPDT113kahRoqHbacV
         1t2mCpDH0ZffJLXrG8zehsSd086kaA621p1+yYiMxgHdxcG5EAUKq3YCqy6MmqrI/Es/
         jcnzhcv9t4AopOYTO8EQg53V68MNnuwplarZG6y/N4NId2Rw73Yj2+YdKFtJGEvW7J+1
         VuZbzXMxe1W0aqKbfqGyJgz/TEKm+UhMbJtGGZ6czxRqmh5bNfZmhSfjIiVFZ/z7ZgGU
         1VrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tc+IEmTbMBJCj4EiVIkUr9PV2atSgJthk3up+qVhyOE=;
        b=WBjur65KQrBOnTsvZv2cAo2f6lLIpdu/6OUelGIWeW0GKbRDfVL7iB1iezZC97SXvt
         epTq4mDbFcx2Z9v2lEZJgXvCpCctZTAJkqALkKcVA1fp10MUpemfnMRdo3pTfU5edohI
         4V1bcel9rTakCBKXMdrOKfMO9EHFiie7ofs7Z8S3sJVo6Op3YPUmfFW5AaUpSwahi56m
         WhRi76hPxOlewcE1CKLfa2Ei4pLcDxxfQ6AlqETTlYZaZMtWyf0yj39+z0JdmpsVtdFk
         VfcIKdTUZoBgATyXH2J82CpuzYfpxanoWhtrLltkBpr/ECWzBxRCVEYM6yexdd214fRw
         6VRg==
X-Gm-Message-State: APjAAAWUi9wFgxmh7pagXSRq+YA3+Hf5DE57jSb04n9CzDHL4jaeBi3s
        q+2YzRmll2pzRzUVjt1qipPWbt4dBLQ=
X-Google-Smtp-Source: APXvYqzUrFqYWdMgMuMww+ixzlV+FmQouQrALIgHfRTCaefzB7ScRo91nDaA8H/KKozVPoI12PkkMQ==
X-Received: by 2002:aa7:870c:: with SMTP id b12mr20357084pfo.30.1573857238096;
        Fri, 15 Nov 2019 14:33:58 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m15sm11699724pfh.19.2019.11.15.14.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:33:57 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19+][PATCH 01/20] i2c: stm32f7: fix first byte to send in slave mode
Date:   Fri, 15 Nov 2019 15:33:37 -0700
Message-Id: <20191115223356.27675-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

commit 915da2b794ce4fc98b1acf64d64354f22a5e4931 upstream

The slave-interface documentation [1] states "the bus driver should
transmit the first byte" upon I2C_SLAVE_READ_REQUESTED slave event:
- 'val': backend returns first byte to be sent
The driver currently ignores the 1st byte to send on this event.

[1] https://www.kernel.org/doc/Documentation/i2c/slave-interface

Fixes: 60d609f30de2 ("i2c: i2c-stm32f7: Add slave support")
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable <stable@vger.kernel.org> # 4.19+
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/i2c/busses/i2c-stm32f7.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index ac9c9486b834..48521bc8a4d2 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -1177,6 +1177,8 @@ static void stm32f7_i2c_slave_start(struct stm32f7_i2c_dev *i2c_dev)
 			STM32F7_I2C_CR1_TXIE;
 		stm32f7_i2c_set_bits(base + STM32F7_I2C_CR1, mask);
 
+		/* Write 1st data byte */
+		writel_relaxed(value, base + STM32F7_I2C_TXDR);
 	} else {
 		/* Notify i2c slave that new write transfer is starting */
 		i2c_slave_event(slave, I2C_SLAVE_WRITE_REQUESTED, &value);
-- 
2.17.1

