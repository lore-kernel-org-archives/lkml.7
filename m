Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB234C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 15:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13832082E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 15:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="C7r7GQYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfK3O6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 09:58:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38000 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfK3O6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 09:58:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so38549372wro.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 06:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TvmFsbPfOa+mv76uPLkgNY/Uv2Lmgpor1GwCekjIwTs=;
        b=C7r7GQYfN+SJUSYh3Qq2WfTdJVSBL3+1F8fd6dbxvbCL2OMYK6GGFJtYy5A6X0s3As
         PumjRIJhiTD9ofDKJl7JKQtr7MvPOH+hWPpKuUO0iV+a9DiDHMYwdONIcyTAJC31YgWN
         XWfmNHosgJwBMCZBuSSWTQrkyc/AfB3J0BFsWww6ofIltCZNr52RfOnynhAcdb8CPhMa
         AR+ePx7YMX9L6BidWDsGNW3HyIExyOtnahzPcd6pD/aMSm8YY1HSxIBFA4DBFfLejPtJ
         xJgfjNO8ST3SZLIy0Hc+aIu42DXB9E1Au8K1/a746phe8NWoFPyvDKxtDLlS6chT6Con
         KLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TvmFsbPfOa+mv76uPLkgNY/Uv2Lmgpor1GwCekjIwTs=;
        b=knlTUvCduHTcOYu6r6UHE/gNh9EwZpHvyasMMH5OOTbe79CCcgb52dnCvoxVK4uK/k
         FK0f7Boez40vWQRNytGadKFR0RD7umzow4Tn8soPXza7Ws8wowl30NIeSFHWhoFMiz1T
         oR48lmUcXJopN1eEAEMPg+9+8Ld61selx/kP+bJpB8p9G5pEAciK32nY+IFoOte7XkUa
         jMrXn6DI5hwKpDUrNZ4fOA9rAoj9nMD4Rrk7OcXq01aX9j/K9AJECYs8a80c1K9WbuiR
         6EDVxs7V1Ysjtf8JduBlkErZjxiith+fx2+sYrchxZw59qVd4OyuE6RnXJoLvjBD2IFK
         G1hA==
X-Gm-Message-State: APjAAAW41iKJnDMe9EdD2IjpyeUqtfW9sKBrZFh75fyBYvy6SrisMYg6
        6CjynjYiJd2ntWUb86SOGCs=
X-Google-Smtp-Source: APXvYqw6q7llKdWIQhnu7cnXnzRzfZlN7B/2ycw5wfSusXp7b3e5xNCvRHA6YlpzLy5NL9+bB3isQw==
X-Received: by 2002:adf:f5c2:: with SMTP id k2mr59575140wrp.118.1575125908498;
        Sat, 30 Nov 2019 06:58:28 -0800 (PST)
Received: from localhost.localdomain (p200300F1371CB100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371c:b100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c9sm3510202wmc.47.2019.11.30.06.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 06:58:27 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RESEND v1 1/2] soc: amlogic: meson-ee-pwrc: propagate PD provider registration errors
Date:   Sat, 30 Nov 2019 15:58:20 +0100
Message-Id: <20191130145821.1490349-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130145821.1490349-1-martin.blumenstingl@googlemail.com>
References: <20191130145821.1490349-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_genpd_add_provider_onecell() can return an error. Propagate the error
so the driver registration fails when of_genpd_add_provider_onecell()
did not work.

Fixes: eef3c2ba0a42a6 ("soc: amlogic: Add support for Everything-Else power domains controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/soc/amlogic/meson-ee-pwrc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index 5823f5b67d16..df734a45da56 100644
--- a/drivers/soc/amlogic/meson-ee-pwrc.c
+++ b/drivers/soc/amlogic/meson-ee-pwrc.c
@@ -441,9 +441,7 @@ static int meson_ee_pwrc_probe(struct platform_device *pdev)
 		pwrc->xlate.domains[i] = &dom->base;
 	}
 
-	of_genpd_add_provider_onecell(pdev->dev.of_node, &pwrc->xlate);
-
-	return 0;
+	return of_genpd_add_provider_onecell(pdev->dev.of_node, &pwrc->xlate);
 }
 
 static void meson_ee_pwrc_shutdown(struct platform_device *pdev)
-- 
2.24.0

