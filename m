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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CC7CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E192083E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iyhf2LDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfJ2XWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 19:22:25 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34795 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfJ2XWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 19:22:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id c25so757457qkk.1;
        Tue, 29 Oct 2019 16:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3hCkAbcriS9RlIsXdXAS7BOo4yVJsRg6vFvTMkZt0zA=;
        b=Iyhf2LDwrJ7hlSqQSnW+N75bzt41kj0wuqTEQk9se2IajbQTHLaDrxokn885sBN/SG
         QDs82ykMG2hcooPX+0+ClpV4v1Ckjo55y7ad0Nb457PVcWBoxsnCaL+hsHY+Nw3mgEXr
         jMx1I0D+pYVWIxa1C7cyLlfvHslI05QVnR+tnEjLlg4E3pybl3tLLoSecAboypaGK8fB
         K90T5UU6H2/71o1vDPdKH6AOR6BD9TFqGT88AWiPU9C8Qk2XwxC3oU5EjMhQtztPIlFq
         R7sSGwM9Z7gqLUxhL/OBEt3OcC88zSqQj23cH4185GKtF5GmX5FPgTgvIB1hC2fpNg3H
         Y6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3hCkAbcriS9RlIsXdXAS7BOo4yVJsRg6vFvTMkZt0zA=;
        b=bi2wI+ToJuriqoApu1pkyiy8IdnJRkvha6CjmPh50UKqgKf/oMD3OdtAzBLHVGEYeF
         zszq8jfMHjN5rB9cgov70g+nHUbO2fkC8w6tpO8qKwwoPHPSo7PQf5INJgBhBLCDU+Wa
         Z6mbbbFdlQL4tw50XqbeT8QBUeu2jdTBcbYjvOAwIVaeMrb5UP0RarU6uXL8R0mb6Rp0
         O6R5mAa4FGMdbD5EPjCHSoEVgxSP7NXaXPbkBNZMjf3e+zWK49WH5inMr9FSiCY1Guf2
         hu12uCMQMnz9VBaW+mWqLIsmkfRNLxBGDsj1YYXsMV73TtFsTS18kBPUvzwOeIjRcGst
         9Y9w==
X-Gm-Message-State: APjAAAXQT/gY+eUGlCBjjr2jcY8/2qLvt2fqx6SHKLi+zY/l4Ne5RR/w
        bwr2WguKqnlsaaOYv/+OKVI=
X-Google-Smtp-Source: APXvYqydRj+JqzSe1lo8kT/qY5ObG6pT9Xzay4uNdB8RCD9jFojCS6cRXQU0KLWJdH2LeYyf9N/rwA==
X-Received: by 2002:a37:6891:: with SMTP id d139mr24311946qkc.213.1572391342722;
        Tue, 29 Oct 2019 16:22:22 -0700 (PDT)
Received: from GBdebian.ic.unicamp.br (wifi-177-220-85-136.wifi.ic.unicamp.br. [177.220.85.136])
        by smtp.gmail.com with ESMTPSA id a18sm633940qkc.2.2019.10.29.16.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 16:22:22 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH 1/2] staging: sm750fb: Fix typo in comment
Date:   Tue, 29 Oct 2019 20:22:06 -0300
Message-Id: <20191029232207.4113-2-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191029232207.4113-1-gabrielabittencourt00@gmail.com>
References: <20191029232207.4113-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing typo in word 'and'.

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 645813a87490..5925d7c7d464 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -224,7 +224,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 
 	/*
 	 * Note:
-	 * DE_FOREGROUND are DE_BACKGROUND are don't care.
+	 * DE_FOREGROUND and DE_BACKGROUND are don't care.
 	 * DE_COLOR_COMPARE and DE_COLOR_COMPARE_MAKS
 	 * are set by set deSetTransparency().
 	 */
-- 
2.20.1

