Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E71CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8D4214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AchD/OIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbfJVA7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:59:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36934 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbfJVA7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:59:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id p1so8872011pgi.4;
        Mon, 21 Oct 2019 17:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Yp6XZv2w7lOfwkyV2MRjUFMwYORElBrNWoBrrUGHJfA=;
        b=AchD/OInf0vgOebOczUZ6B52r1yQlUeGQmFH+t6h55IX9GluxyTRZZyUWKlRL/TCDE
         ylKzZ6b4snYYhqV/Vbn8xVrGHImhMhsH/XKUVqMjv7XaIqFG9j/bLT3gExueqt85d/Ra
         PpyLrFncIROTAjvvbbKh9/3DgyRX6i01cKQFmTPyONfi/2RgkYighKOhzrFNmtN2721d
         TJiM6ycpQAW4Ncm+iwT1tLdn5toY479q2VDm7HmisO1GTUpfro7jEh+4eZRfljsjNkA8
         zpcjARIYsPi7jNeou4hCSQ4paWB0C4e/2uZn3SuHxNnAkmpMG9PksrgzeFafyIzCLETf
         EprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Yp6XZv2w7lOfwkyV2MRjUFMwYORElBrNWoBrrUGHJfA=;
        b=eew2d6W9K0/eUphwqtXwS9W62YI3ixcPhrO6ByqBPxvgNcffQKxqHjgaSQTx/iei3x
         09rGskKivyuBb6pNW8sEr088auhYahe8te/fjasBxn5g3ORry3U5rP8Ma3NiIt/sMTWh
         hbcl8scnGbElesLK92/ilVkOr2d+0gV36bsVP3opt46OSN5Bn2IerwOrS8R9wOKrs2tU
         oYECurpGRsMPb9bwx8oL+TWQ9H37STgyZfFGNlw+OWKIGVC+V2td3ne4OwkCl+m9OOVC
         uqjiPp+R0zkSMrsipNhqNVOhgRvU9Ax6G/BFLQQPBVUbHipBQWU7Pm3HspaNmVyEo7sA
         y0nw==
X-Gm-Message-State: APjAAAXPWEHdU9K4vCUPEJeR5zKtVMR+Ro84BwZjfIvFDYaA3GL7h3Hy
        twW7VSLpA/eXEoMFcnByBnw=
X-Google-Smtp-Source: APXvYqwiSd0HP7osxDuH5e3OIVJPToSg3+b/k5OzNJaNblBWTWoKrPCpHz8uyGB7YI+MC4aHCzu7nQ==
X-Received: by 2002:a63:a54a:: with SMTP id r10mr741548pgu.277.1571705986497;
        Mon, 21 Oct 2019 17:59:46 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id h1sm17542271pfk.124.2019.10.21.17.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 17:59:46 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (ina3221) Fix read timeout issue
Date:   Mon, 21 Oct 2019 17:59:22 -0700
Message-Id: <20191022005922.30239-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After introducing "samples" to the calculation of wait time, the
driver might timeout at the regmap_field_read_poll_timeout call,
because the wait time could be longer than the 100000 usec limit
due to a large "samples" number.

So this patch sets the timeout limit to 2 times of the wait time
in order to fix this issue.

Fixes: 5c090abf945b ("hwmon: (ina3221) Add averaging mode support")
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/hwmon/ina3221.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index ef37479991be..f335d0cb0c77 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -213,7 +213,7 @@ static inline int ina3221_wait_for_data(struct ina3221_data *ina)
 
 	/* Polling the CVRF bit to make sure read data is ready */
 	return regmap_field_read_poll_timeout(ina->fields[F_CVRF],
-					      cvrf, cvrf, wait, 100000);
+					      cvrf, cvrf, wait, wait * 2);
 }
 
 static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
-- 
2.17.1

