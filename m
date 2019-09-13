Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DD5C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBDE2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xEXgWcAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391502AbfIMPZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 11:25:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39623 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391346AbfIMPZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:25:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so2371876wrj.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V4nZUxO6Mm4xe18R5imoxVeMnq5wn7Jg/kL+/NyaL6M=;
        b=xEXgWcAmcjCbnlv2PZIcl4tioAQPW+pRHXZ+DDwIDcwrrtMgr3qzqom11PVXxCxWLM
         rpnWqp2cCPzw2MsLejDa1mjJrJeVnJoa2V29h4sJ1or6BjmehFfFbLaIIBzr63oTwD/U
         cWLVUpgY77Pykty1tSlJIZvHnZCrr95m6o6xxcyVVZkj9+8Kg+iKiOuzEkXkSDldyaqN
         jeSmbyKztRbCEANeQIPtJtx+a58FqrFnDfGaj3aEmWGVGO508KlSm1Vu01TC58fMZbiQ
         8BlWyVnqIWBWynUp7gEFp0VVLUIdjzAzTLL4V57uqnQNh5NcAWTIEPEmufn8WsImKum3
         V2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V4nZUxO6Mm4xe18R5imoxVeMnq5wn7Jg/kL+/NyaL6M=;
        b=ffFhWpFly3g+qA/KToTE88py49DQcE2/bQPpWRv0pIh7e/LUe5XkDgYc5/2KpXdCEA
         Zb4F+AX1rs5P8gcbtFtJSDmF2EeZqU279ujIKj5Gk6NFJFSJHNivq+GX+Yczj77+woLJ
         4MHzUtSGkBQHEDi0Ykripd1g5as3A4l5giKagsHTCeFugBoGqllwNs1y6J1Pj6H/DA70
         rzHPMlx6MaYIra3xWA+pp+3GUomnu6hsKbV6sqjoQ4X1W/ycaNtou5iXbKdIFWkzgOnU
         PYEyk0OaWvphsfr7DkgcjFFgpepLqRgpRmuJoxvbnxZNO4OKvhs6wWNxfEQsmKBL6k3x
         IPBA==
X-Gm-Message-State: APjAAAU7x/oddj2b06sMJmxG0/ZyOr8lIoJ1X7zeRb41KFY6HOT/4W6X
        KaUMckJKNHOmpZwrl7CG4xja9g==
X-Google-Smtp-Source: APXvYqwA3VTpB0q2QY8NDVr2s8pDU+/EkIkLndJoIsfZjwVdEU3xg3y4NwKkcBGnZl5SVniCYfTI5g==
X-Received: by 2002:a5d:4a05:: with SMTP id m5mr11622678wrq.265.1568388339932;
        Fri, 13 Sep 2019 08:25:39 -0700 (PDT)
Received: from localhost.localdomain (69.red-83-35-113.dynamicip.rima-tde.net. [83.35.113.69])
        by smtp.gmail.com with ESMTPSA id d9sm48717728wrc.44.2019.09.13.08.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Sep 2019 08:25:39 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, gregkh@linuxfoundation.org,
        arnd@arndb.de, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 3/5] misc: fastrpc: do not interrupt kernel calls
Date:   Fri, 13 Sep 2019 17:25:30 +0200
Message-Id: <20190913152532.24484-4-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913152532.24484-1-jorge.ramirez-ortiz@linaro.org>
References: <20190913152532.24484-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the DSP firmware requires some calls to be held until processing has
completed: this is to guarantee that memory continues to be
accessible.

Nevertheless, the fastrpc driver chooses not support the case were
requests need to be held for unbounded amounts of time. If such a
use-case becomes necessary, this timeout will need to be revisited.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index bc03500bfe60..d2b639dfc461 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -927,8 +927,13 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (err)
 		goto bail;
 
-	/* Wait for remote dsp to respond or time out */
-	err = wait_for_completion_interruptible(&ctx->work);
+	if (kernel) {
+		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
+			err = -ETIMEDOUT;
+	} else {
+		err = wait_for_completion_interruptible(&ctx->work);
+	}
+
 	if (err)
 		goto bail;
 
-- 
2.23.0

