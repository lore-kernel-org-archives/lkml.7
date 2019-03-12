Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BED6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490F1206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="fO/4c98e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfCLQeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:34:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35037 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLQeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:34:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id j5so2220835pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OHhJGOJIp4ugcDk8oMNZ0HOX5my0KraGmxIfjYsnEP8=;
        b=fO/4c98e5oE8erxRI0xIAw1G96Rw5qTj/smgPLIVYtEvcFt8TFgti45+CPmkJh/1OK
         u3ummGvFm1Kof8TnZG5OnMZ8AJWFk151IEPlJeuhrs4Q9Y8S1x5fJypdrnFEi0Ng+2Zw
         Vq/hdYxEJtqk4VWdpLDLm8GAq/r9UvRTJhG4C7oRcStIGkMhI9CNfBE7qbJQW3q+q71I
         qySjMIyd0LfWE7D8qt06pSBjp7TIggSb4tj72UNobVmV+s6M5jXEtjJ0Dyt8AiO8viLm
         VbqRrNxEsobc8IHtaYVVuNRrhqvNIunxqY+7Y9KgoVrUnOLkqVJdvtRQ36jIHiHukXBI
         PKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OHhJGOJIp4ugcDk8oMNZ0HOX5my0KraGmxIfjYsnEP8=;
        b=EPM0raz89cFmq4mlA/mFtExeO/FKBBY8enGaJCe+SvLqbM0CCF50HMyXvzj3Lv5ULn
         9esma+HPIyYFU59XF+EsQFfar9YSMU1J1kQaI3tBujfj9iSmEUbChqayBQVqhedfiwcy
         EOAyaWQcS955frgoA8JUjwzLV3uOHk8kVvARI6CHmNWS2ab+KJUMtdzTh4I3lYMRDf4f
         HbQQcJVwuA1L85G132RZiMCMbo/4A+crMH+CzSbAYKsOW9NJHVppeqjAxnJxp5YW7dQj
         7avek8k9uOVjO0iNVh9wLeta+BBH1yqu32Gac65qk2ZyKvDG01QO4CY1RQPp7x+nt33z
         dbQg==
X-Gm-Message-State: APjAAAWqiiaOAs65XBIzWr8PphVf9G6VS5yghim3PR4QNVyO4KfPhGKt
        1sBM/SeA1XexSn1nh94R2ZvN/Q==
X-Google-Smtp-Source: APXvYqxFdhrZEy7fFyoH9h704jccXB+KQAbKs+403dwYfVqavPGSAqH4Zz+FUIrA2H+ApqnwxYkHSg==
X-Received: by 2002:a65:5108:: with SMTP id f8mr851500pgq.441.1552408453940;
        Tue, 12 Mar 2019 09:34:13 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id s79sm17447467pfa.61.2019.03.12.09.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 09:34:13 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/4] regulator: wm8350: Select maximum current in specific range
Date:   Wed, 13 Mar 2019 00:33:55 +0800
Message-Id: <20190312163357.27785-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190312163357.27785-1-axel.lin@ingics.com>
References: <20190312163357.27785-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.set_current_limit callback should select the current closest to max_uA.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/wm8350-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index a1c7dfee5c37..d1758a2bc769 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -99,7 +99,7 @@ static int get_isink_val(int min_uA, int max_uA, u16 *setting)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(isink_cur); i++) {
+	for (i = ARRAY_SIZE(isink_cur) - 1; i >= 0; i--) {
 		if (min_uA <= isink_cur[i] && max_uA >= isink_cur[i]) {
 			*setting = i;
 			return 0;
-- 
2.17.1

