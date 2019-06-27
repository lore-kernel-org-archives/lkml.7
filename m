Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4F3C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0795C214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqixCxNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfF0ReS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:34:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43783 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0ReR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:34:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so1325436pgv.10;
        Thu, 27 Jun 2019 10:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iaS11w2aoxySZ/aow9W/tKYepsJlUMZ7J3WhgDV2Q4U=;
        b=qqixCxNApiEkK9W+caOpxmCoaPNvn7PXP0+ODxArrIALSvKHWeQVB6zZQcOe3wDSYK
         OK6OgHsJWJeiRa9oOUJQlBCcQY10VVGr3vJM2Yr+31PQpLEjXo7wi1KlwQKwByirUqCQ
         RjIPhk8Su1CA+D/TB10f/Y+s2j7g80aeouHpZ3UlVjD6RzD4yWV/Tma56eYPDs3pgken
         KzvXKUd4PD57Q3AhNUi3H4GIQEYdN7u+k0hFht4pwFUiDXaip802DI+dKwmGDzKj1Vco
         l4YuYXND7dJBsWSTHCR8LmcrC/COzJor0Z4K3j2ZmybW5D3+F2nuNinDmh/f3qsy3R5G
         Xokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iaS11w2aoxySZ/aow9W/tKYepsJlUMZ7J3WhgDV2Q4U=;
        b=AHilfe2OiUSgxLxAgpChFG9R6rZ0EwPSqpxwOQOEXvTimtOFIwCWP0zUSxwB8hQcyc
         Ui5B9MMgYN38a53/3iRscvHOgbeEhsWY5fH6vDqfLyY4kGQBntqVp0+jdWy+lGya+RKw
         txtP1i9pkd/NM3glqJZgKADzFSpJ4V5Zb+ZL/tHd6EzAdLabp08+63SCOGyOBRi48q3C
         w7C0B0tcNMhBFqvrFqyhYE5duiTMe01iosvBT5n+Lg4Rf+fxCTIp+qzxDjMaSIzs+bJA
         zy4/O4JhssiDyK13CZxau23s6Hn0tj+grw6X7ZVl8Nf0xZfDyA34ajFNMITJm+RSgVQT
         Tprw==
X-Gm-Message-State: APjAAAXCEQQY1xp8Kfe6Tvz0r22sJGHGsdnMh/Yk3VcLl+bTfPl+iKAx
        6346FYQpBEs76NuMoYSmd90=
X-Google-Smtp-Source: APXvYqztCYVtfsx4BiD6jS742kVLvuQ4A+eFPYBFB5pXScCAMpgnkv5zCPRyVNuhK0Ucg4tiEf0Sog==
X-Received: by 2002:a63:61cb:: with SMTP id v194mr4532614pgb.95.1561656857128;
        Thu, 27 Jun 2019 10:34:17 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id y12sm2981713pgi.10.2019.06.27.10.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:34:16 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/87] ata: pdc_adma: Remove call to memset after dmam_alloc_coherent
Date:   Fri, 28 Jun 2019 01:34:10 +0800
Message-Id: <20190627173410.2037-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dmam_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/ata/pdc_adma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 52fa8606a25f..c5bbb07aa7d9 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -550,7 +550,6 @@ static int adma_port_start(struct ata_port *ap)
 						(u32)pp->pkt_dma);
 		return -ENOMEM;
 	}
-	memset(pp->pkt, 0, ADMA_PKT_BYTES);
 	ap->private_data = pp;
 	adma_reinit_engine(ap);
 	return 0;
-- 
2.11.0

