Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25995C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E990820674
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DByxo4tw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbfDQSPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:15:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38320 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQSPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:15:35 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so23348300ljg.5;
        Wed, 17 Apr 2019 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PSGrEQsMYrNFGknh2BSQZwqp4P6yAdE1w9wT0OTQrzk=;
        b=DByxo4tw77sfVEGN1TfMQSmhu3J7cspjWtdlnte4s9Xt0wV+cI7OCDeLsENiqw2bT5
         1GImgCgV+GFauYNmx5wVXcmmRK5Eh3CudRfmyxzA8Wdh+ncuXedK15OdXtViJDkQMWfN
         ZrBbxolZKfZoSNEISfwRXMkZ3f+t5TLEPvgg2tEeErKb0tE7LkeXuy/OP2V0Qg2PR4jT
         hHWTKoWvuYi/KBFtuGvlmp/TIa5S6CXmq2e0upEYQqJnhE7WCOMumFtvfn9Qx+Y1qve+
         CZidH88fgZ/TSZoqGUWvS5/9w9NXlcv1K7owE/YMVFZXJiH0H22SUREaQeSy7IRJ8zUO
         vHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PSGrEQsMYrNFGknh2BSQZwqp4P6yAdE1w9wT0OTQrzk=;
        b=FanyyYdQgbRUJre5oF9vn8IuBXbyGwh6ZHs87uKEK7bUu0l2fPP3IxvVhLHtCPaRs8
         Xfw4Dicgi7GAiZS8RROFtcRIyTqFmHe7ICaB2wOlXFU69dPz54NMv96SdwWijOflWJ3M
         4TSxtKQiME4UIZJIr2ECPNLuR+xIa8h4pjaVsLXKxgoKVxl4Z1fciE899ECT0ABOLJVt
         rfQW5gNgXhds7a6I6tSydwqUVphFKPyZhh1aSzNAC4JM0Xxk5kLwNrFf1gUouIIaMsL4
         6/vuYQtGb7AmVpwbpjzl5sFQ413LHFQYnztM2W0fXzCNJ/2F1FStZzGRCUI46v4XwqGP
         YxzQ==
X-Gm-Message-State: APjAAAXSg96OlBdgc0Ht0W0f97PyT85+QYI+gapWm6lHoSJ41W00pgYG
        TLAZqdk58OYPDL5qvpxGxzw=
X-Google-Smtp-Source: APXvYqw8nYlbiW3T6lah3JRI/8z7igYxzG325TPQ1cdFNVO3WUHMzxwxyj+puiik/MoLezT1sl93HQ==
X-Received: by 2002:a2e:8507:: with SMTP id j7mr8505087lji.85.1555524932736;
        Wed, 17 Apr 2019 11:15:32 -0700 (PDT)
Received: from localhost.localdomain (62-167-31.netrun.cytanet.com.cy. [62.228.167.31])
        by smtp.gmail.com with ESMTPSA id x71sm4763243lff.82.2019.04.17.11.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Apr 2019 11:15:31 -0700 (PDT)
From:   Mohan Kumar <mohankumar718@gmail.com>
To:     ak@it-klinger.de
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: iio: proximity: This patch fix the following checkpatch warning.
Date:   Wed, 17 Apr 2019 21:15:25 +0300
Message-Id: <1555524925-15450-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Documentation/timers/timers-howto.txt Msleep < 20ms can sleep for
up to 20ms. so use usleep_range.

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/iio/proximity/mb1232.c | 2 +-
 drivers/iio/proximity/srf08.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
index 166b3e6..74f7eae 100644
--- a/drivers/iio/proximity/mb1232.c
+++ b/drivers/iio/proximity/mb1232.c
@@ -81,7 +81,7 @@ static s16 mb1232_read_distance(struct mb1232_data *data)
 		}
 	} else {
 		/* use simple sleep if announce irq is not connected */
-		msleep(15);
+		usleep_range(15000, 20000);
 	}
 
 	ret = i2c_master_recv(client, (char *)&buf, sizeof(buf));
diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index f2bf783..605a582 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -150,7 +150,7 @@ static int srf08_read_ranging(struct srf08_data *data)
 	 * polling for not more than 20 ms should be enough
 	 */
 	waittime = 1 + data->range_mm / 172;
-	msleep(waittime);
+	usleep_range(waittime * 1000, (waittime * 1000) + 2000);
 	for (i = 0; i < 4; i++) {
 		ret = i2c_smbus_read_byte_data(data->client,
 						SRF08_READ_SW_REVISION);
@@ -158,7 +158,7 @@ static int srf08_read_ranging(struct srf08_data *data)
 		/* check if a valid version number is read */
 		if (ret < 255 && ret > 0)
 			break;
-		msleep(5);
+		usleep_range(5000, 15000);
 	}
 
 	if (ret >= 255 || ret <= 0) {
-- 
2.7.4

