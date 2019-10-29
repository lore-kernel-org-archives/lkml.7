Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEE1CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD55D2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nqjytfxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389751AbfJ2Ozs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:55:48 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42012 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389730AbfJ2Ozr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:55:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id z17so13978457qts.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lAvEaeqENeVb/DhAt46H1R5niz9Z9sNvfAe5diIhyRY=;
        b=Nqjytfxo50WBI6vopuCch0cZIF9IsPsdiznwtPJh2upsT2yU5o/cBcYf04skhUd055
         GvTqocNvFeTBJ9f3Zr2g4q+CEk6El1vH0NlgAOXr4iEegmv+/R1aV1rH+AQQ/XslB4FC
         kusVCwCuGJ+JtM1V+EVjp2GX7fj8e4WTuz8bUpi+TwHutxdqtgmlRder7f5gAqDDHgFC
         HsY6tY+hCeRwQ9bdxWkY4pnGY2CtI6tLXPKr1W1ZjUfn/sM15xC2zmgpJnWIuL3a3NUT
         rKl9W+VGcYEBSPaZzNVoXKupSMUse9iE+MVhx41bX/t1gjl0smAwBAJxL0eJS9oI0FlR
         KbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lAvEaeqENeVb/DhAt46H1R5niz9Z9sNvfAe5diIhyRY=;
        b=dY9sf0KYRITrrhrM6zmjx1qY5ETxperVhNt4QU+4hrl6AaFXJf+yijD9mRXaEEpKxP
         LwV17LjcnrsAoSv6JZ19lvWrt1nOR6f31GtlsCga8fD4iGgloC5wDfDBREmMOYl2ZhJy
         fW7PLve35KBxw0IrT9GGpwQY2h/MUQQZvaTD5VHjSza4Qa5lCMET9gad4IeX+3E5SRGh
         39aa5Jt5W6I76RU+CESTNhT6EWIHrAyVRL9WaEbH1L39UjInrJuWj4uUWnT7XflvC9N8
         LNPt0aYeNou+11+HhNcKxhvuGY+PaWHIDBDHRMpFKEVUBuKaVy7YqfGB0zDI0r1L8Lhm
         IHxA==
X-Gm-Message-State: APjAAAUCIwdsOmHq2qapmLfvLe8zj3hexvw5M8Q+W+71CjjmBr/LWvyt
        WxrnMWkmrylHhItVksskE0U=
X-Google-Smtp-Source: APXvYqw6h9hzSvN+uhYWl/U6Ddgy+lF6m6pwWFGLY7DqtzFyWC1EkPwsqXMQgjbNG0NmO9UGlNWMlg==
X-Received: by 2002:a0c:ec0b:: with SMTP id y11mr22443155qvo.123.1572360946108;
        Tue, 29 Oct 2019 07:55:46 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:483:ade:87ad:69fb:5b32:cf88])
        by smtp.gmail.com with ESMTPSA id g17sm5978069qte.89.2019.10.29.07.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 07:55:45 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        kim.jamie.bradley@gmail.com, nishkadg.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH v2 3/3] staging: rts5208: Eliminate the use of Camel Case in file sd.h
Date:   Tue, 29 Oct 2019 11:55:17 -0300
Message-Id: <20191029145517.630-4-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191029145517.630-1-gabrielabittencourt00@gmail.com>
References: <20191029145517.630-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Avoid CamelCase" in file sd.h

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/rts5208/sd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/sd.h b/drivers/staging/rts5208/sd.h
index dc9e8cad7a74..f4ff62653b56 100644
--- a/drivers/staging/rts5208/sd.h
+++ b/drivers/staging/rts5208/sd.h
@@ -232,7 +232,7 @@
 #define DCM_LOW_FREQUENCY_MODE   0x01
 
 #define DCM_HIGH_FREQUENCY_MODE_SET  0x0C
-#define DCM_Low_FREQUENCY_MODE_SET   0x00
+#define DCM_LOW_FREQUENCY_MODE_SET   0x00
 
 #define MULTIPLY_BY_1    0x00
 #define MULTIPLY_BY_2    0x01
-- 
2.20.1

