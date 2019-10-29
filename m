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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010D3CA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA64D21835
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYAEi8NA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfJ2Bnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 21:43:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44005 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfJ2Bng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:43:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id l15so11167965qtr.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 18:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p2YVxbiyZYmfoNFO+GQXGr1xr8s02Ylhj+EKSio98t0=;
        b=kYAEi8NAw7/+sabPybO+4uDVIy7ER+uGxhi6tPjHvuBNyJsXYBC4QKpdhzJj+xTL/M
         9WH6DSidQ2eVrNog3EuOJhfSA5F2a/vyc54x0wOeAEKY/BV2OEbZoxYw/Gs/GI3EPj1Q
         uT4o3uD4Qi6Q8awdskOsbfiiGH/mrVCb8Pnq9+fx97F2LDgo4/l86iu4TLMX79WZ3jPZ
         xhakislTgvvrytbpj1Z4ADwj8ikZ90NPqpSiUSy6GqiEUkS+CR+prXQ9UPpbflbIZ9Bk
         UGP1R1jm+7nnWVAMa46W1oxpO7ziXrRY3L8wUwHUmXcQCN8vRzsQ3I5NA7GzPKZSaJII
         z1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p2YVxbiyZYmfoNFO+GQXGr1xr8s02Ylhj+EKSio98t0=;
        b=Wsyg/4SgG8ftRjbxVOKcElKxxfAYSNSOu3fgUeOVK2W4clvBQ5mKaYZNC1WT0jkzpe
         G9ZJO3OSErm/PbdzzRtLVIcZVu7Cv5y3EpGCE1vkwvOaeMLEXWwrqGQU9LbkTgkqWhrs
         UuicQ4zNGBQ7eqre1LRxFIYxl6b25jlS+z5k9SlEydkJbLwdmXEFV4ggixU2EnvxAm1z
         BDdYHM+w6H/3n21rmgfwbp3Zg6ksl5Fxqp0MY+3v5gslhYZJAS6UVRXHBhIUQ63eraAW
         +oruslM+eqaeXIt+1J8pnIO7iQ4ryzin71ZfqESBJtt2ibx2I7kb2AcSyajgTpRmUA3c
         DcHw==
X-Gm-Message-State: APjAAAW8XfTZvSZyIAJ9+dl5rkobw9YFKeh/Wjm5smeonzthYEbN4cdu
        ML0boL700eVBA9CyHJjq6zw=
X-Google-Smtp-Source: APXvYqxhI5BxAe0ESH1+RMCbq1YrtYYAHSuu+uI2kcJXH4yUc6ePuehRRD7uuahw3jYiJgF0Fz2z6w==
X-Received: by 2002:ac8:8a1:: with SMTP id v30mr1779396qth.44.1572313413612;
        Mon, 28 Oct 2019 18:43:33 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:483:ade:87ad:69fb:5b32:cf88])
        by smtp.gmail.com with ESMTPSA id 197sm6698394qkh.80.2019.10.28.18.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 18:43:33 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        kim.jamie.bradley@gmail.com, nishkadg.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH 3/5] staging: rts5208: Eliminate the use of Camel Case in file xd.c
Date:   Mon, 28 Oct 2019 22:43:14 -0300
Message-Id: <20191029014316.6452-4-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191029014316.6452-1-gabrielabittencourt00@gmail.com>
References: <20191029014316.6452-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Avoid CamelCase" in file xd.c

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/rts5208/xd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rts5208/xd.c b/drivers/staging/rts5208/xd.c
index f3dc96a4c59d..0f369935fb6c 100644
--- a/drivers/staging/rts5208/xd.c
+++ b/drivers/staging/rts5208/xd.c
@@ -630,13 +630,13 @@ static int reset_xd(struct rtsx_chip *chip)
 			xd_card->zone_cnt = 32;
 			xd_card->capacity = 1024000;
 			break;
-		case xD_1G_X8_512:
+		case XD_1G_X8_512:
 			XD_PAGE_512(xd_card);
 			xd_card->addr_cycle = 4;
 			xd_card->zone_cnt = 64;
 			xd_card->capacity = 2048000;
 			break;
-		case xD_2G_X8_512:
+		case XD_2G_X8_512:
 			XD_PAGE_512(xd_card);
 			xd_card->addr_cycle = 4;
 			xd_card->zone_cnt = 128;
@@ -669,10 +669,10 @@ static int reset_xd(struct rtsx_chip *chip)
 		return STATUS_FAIL;
 	}
 
-	retval = xd_read_id(chip, READ_xD_ID, id_buf, 4);
+	retval = xd_read_id(chip, READ_XD_ID, id_buf, 4);
 	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	dev_dbg(rtsx_dev(chip), "READ_xD_ID: 0x%x 0x%x 0x%x 0x%x\n",
+	dev_dbg(rtsx_dev(chip), "READ_XD_ID: 0x%x 0x%x 0x%x 0x%x\n",
 		id_buf[0], id_buf[1], id_buf[2], id_buf[3]);
 	if (id_buf[2] != XD_ID_CODE)
 		return STATUS_FAIL;
-- 
2.20.1

