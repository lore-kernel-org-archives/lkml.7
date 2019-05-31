Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF0BC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BE626AF0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NqsDcGgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfEaOqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 10:46:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40853 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfEaOqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:46:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id u16so877461wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 07:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HIhSvs2DPNa6pwhyPdTAckU0464fTVxVs7zCZ8vky70=;
        b=NqsDcGgPdxWylte/nrdudw12e2+Lm9TK+16YOs/Xt7XNSRBfKmr1cSde/9z6YrLsqW
         qvy5SdwAE1oNTb2/Aw5EI9qwCXSrgrYHBXY2H3cNvfYX+azTYlDkSH5oOZXLUb7y9vwb
         MLLKoaxvYUsZEtDR5kA4DyRdw64SrVjDBfI23SaBLa+RK9OodhW6geypt3wpvkkq8liW
         VerDWaNO1aoyDCoeChV3PoAsQIg/rFZpZ1Qh7bgRHhz/EyrwIEH6tEG84umRDECnY+b4
         1nAoqj01kBPcL8cHQkfgg0+VF1zGFrnY2yJS5BBi4APh0k0tWijNZyavtlrohOIE9HeB
         0Y9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HIhSvs2DPNa6pwhyPdTAckU0464fTVxVs7zCZ8vky70=;
        b=RgCv0XzgXuADV0rSSOUAm43zLC1nNuUhY75JkIaxr1awnZN+/yDw53sjUa69Yducnm
         KTDcvV6c0SzO075/bEXDxdu9xwKatHD11sNvVST698anbBucs9a1wJuAPCmGefWOq4RK
         6QIIN//wehDFR+dQLru9eZB8tM0c/gJtdqBzJ8Fg/Sa9/nBos+vKUE3/N1tKefE1FzZx
         baCnzfk0ajR7e+0XIrAJSnhOh0onsQK7auQApPo41tqvFxbE+5AKJJrgqoyuFKPtCbjU
         UoTd9OyMhUSdtP+kGBZdpmTUxCiXJ5G2mj9NQq72Fin3S7wDNK7M1acBkPjCFZk9ocWX
         n2XQ==
X-Gm-Message-State: APjAAAU1wqvjzfYDWinNf5bD6LsY5qhpefCsx5MfKZVdCS8WUhrgW1SJ
        T4knxZ7sFcmcDYU2eOpeAwPPeOEVY6w=
X-Google-Smtp-Source: APXvYqwI8n2+PwrOnHJByfCo543Na2TAdtFA/adEgwqWRwyrJZLjkqUNX2TJsQI7YW8gPuN6N0EwFw==
X-Received: by 2002:a1c:a387:: with SMTP id m129mr2075250wme.15.1559314009130;
        Fri, 31 May 2019 07:46:49 -0700 (PDT)
Received: from localhost.localdomain (233.red-79-146-84.dynamicip.rima-tde.net. [79.146.84.233])
        by smtp.gmail.com with ESMTPSA id k185sm12752374wma.3.2019.05.31.07.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 May 2019 07:46:48 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, agross@kernel.org,
        david.brown@linaro.org, broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: qup: remove unnecessary goto
Date:   Fri, 31 May 2019 16:46:36 +0200
Message-Id: <20190531144636.27843-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary condition check and associated goto.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/spi/spi-qup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 974a8ce58b68..314d91b95a16 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -842,10 +842,6 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	else
 		ret = spi_qup_do_pio(spi, xfer, timeout);
 
-	if (ret)
-		goto exit;
-
-exit:
 	spi_qup_set_state(controller, QUP_STATE_RESET);
 	spin_lock_irqsave(&controller->lock, flags);
 	if (!ret)
-- 
2.21.0

