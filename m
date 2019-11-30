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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F378AC43215
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 14:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C874320801
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 14:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="M2OY4GgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfK3O4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 09:56:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42384 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfK3O4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 09:56:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so38457029wrf.9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 06:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TvmFsbPfOa+mv76uPLkgNY/Uv2Lmgpor1GwCekjIwTs=;
        b=M2OY4GgAq/acdIl+mLclGxdW7OPPxsfPVW6tx+1uxT23OQtQ+pBYSHIgH39w4Reb6x
         a/hBY4u4JfiMV+PSPDdI6/tDdeYyb21nQ/Yzehie+IZ50SxNRy3IhcuT87SaJ6ORtylG
         aX2NVXNKAgmzvpFqdjZR2D/aCTwN3yqwsVVmaomo8/MQJZGbjbRf937V0PB/XWHhS7yo
         4te8IW4rw8JkK7CwxZt8AtozOgfmBCDLOLyD3FktNhWtTyEn7YpdhG7l3iqPgT8NvL5y
         v4VofhZEft5rujuTS3aw2ovXWKeU/SDDNQXNmTwEkmwQW8azQDN4QKChGxa7O6j4CYLZ
         AMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TvmFsbPfOa+mv76uPLkgNY/Uv2Lmgpor1GwCekjIwTs=;
        b=jiUHoXu6iP4irqa1XJDnsMe6uaxjoPb58wkFlwVuA56U9EkpHVEnuyIJ8Q4XAXfU+E
         xj1+aRuVfoeR+IsQaCCox3ZxWsa6j2Bf1KAg5Aqj7Wtnii43DiO9y00GWDCkPjoMCtCY
         yYAMXaOfO15cwb43DKKX7Cqnt5h4p05HJCxZo+ICfJcd6Ff/KGkmedLm1WjymHxWMNmU
         qNfpcqFxQZtJEP5gOliihUpMfHvjH2iDJhC45Y6TxGf3EWQ++NoPu9oMykalGDwt5Aip
         ecQOJSWpey0RjFfxvCk8BBP+nRnfhkc6WKr0rxNgliPi6YFs5ThgE/46/vJOk0INdknp
         9qOw==
X-Gm-Message-State: APjAAAV0f8TD10qiOjXJI83J7dRvXey9uAWSLB1Z2RztLkFV1wnaQPTG
        yfKzLOvXCU2/hzhRdDc06hc=
X-Google-Smtp-Source: APXvYqwq7I+JJ+i8EqMxpzPkWUJ0pqcwjJqfhJ6Cg2Qmyw5KvOuUGPnjOjJ66CYi44eYij/VVO0nVw==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr39371160wrv.198.1575125791823;
        Sat, 30 Nov 2019 06:56:31 -0800 (PST)
Received: from localhost.localdomain (p200300F1371CB100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371c:b100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b17sm7163391wrx.15.2019.11.30.06.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 06:56:31 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     khilman@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] soc: amlogic: meson-ee-pwrc: propagate PD provider registration errors
Date:   Sat, 30 Nov 2019 15:56:16 +0100
Message-Id: <20191130145617.1490233-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130145617.1490233-1-martin.blumenstingl@googlemail.com>
References: <20191130145617.1490233-1-martin.blumenstingl@googlemail.com>
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

