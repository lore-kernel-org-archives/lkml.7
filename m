Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CD5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532AD206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="xpQd86sw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfCLQeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:34:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40963 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLQeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:34:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id k11so2215563pgb.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=AU7FJCFZhMzWP3kHeCNtolB/QqYfsLbqkkIzrMqN9K4=;
        b=xpQd86swoP6wEGLCClTmPd2b4UBityL96qAwwMgbmBtcaRN0NKGX248v45t9HWEewn
         A3wqcImQLN3Bhwgj/VXv4wKZKeRZYWQkpUf/hbexQU2DrGbbjwyLdf6vhkxCF1HThqSA
         p3xa0TbsLZmLkV14n5jo1wbivJRHYrb9Swm+tYTyMtxWbA0Qr3N3S9Cq7PIusfGl2VIM
         0/88Y6wINLv/6VzwlLbCAHtrL8SV2wCE34gBMYXQpk1NF6NsaovBFOAJV7u02yZFuhx3
         PZLtITDInK0iHeNZEpyzXOx00Wi+nSI5CML4KbNjGC1Sjey+h2uOnpL2poOhOXuKrv65
         9qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AU7FJCFZhMzWP3kHeCNtolB/QqYfsLbqkkIzrMqN9K4=;
        b=JaZJYpPi66LNpTdG/AEIHRT9W4MpY1Is4ykqD5MdD6JaVdJcnfyhWwWNBQnYQ81q9m
         LnMAtGrOnuwlkh5HAG2xEIiZ/y48yP0Ng48XT2bDOAS6Jr70ixHXPHCCxJ9dW0pAt7Es
         9vlnh/zgKV+q9UrUG5Z8ZRIwZztTW7OhzxoBSum3hVv180VtxjqthSIvCd93PGx5/a4X
         jKIc3RyUGV/io6A7VN05iZ9k5zjujp5kRlRMJoia6+A3HWnN8DFMlKvJHeKF7X956zu8
         oGc/alygqFlbONv7FZsraEfbTcbLza65jV/hr61IgoPB1JX8BH+tAG0KF09icUNKkPq2
         s9hA==
X-Gm-Message-State: APjAAAW/A4jbj+KXkdcb0u3iDjQJktleba+xraEegsYsfHFQ23pz0gK/
        /iYvnhh5jwFckcReVCIkPNUj7g==
X-Google-Smtp-Source: APXvYqydzAJUIobuL8LQ6H/Vgzx359Mkkhk9keZdUiYpQWI8y80F488HZecoBbZDYIiZ9BIODC2lDw==
X-Received: by 2002:a65:44cb:: with SMTP id g11mr36264129pgs.29.1552408451550;
        Tue, 12 Mar 2019 09:34:11 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id s79sm17447467pfa.61.2019.03.12.09.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 09:34:10 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/4] regulator: wm831x-isink: Select maximum current in specific range
Date:   Wed, 13 Mar 2019 00:33:54 +0800
Message-Id: <20190312163357.27785-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.set_current_limit callback should select the current closest to max_uA.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/wm831x-isink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/wm831x-isink.c b/drivers/regulator/wm831x-isink.c
index 6dd891d7eee3..676a4701c986 100644
--- a/drivers/regulator/wm831x-isink.c
+++ b/drivers/regulator/wm831x-isink.c
@@ -99,7 +99,7 @@ static int wm831x_isink_set_current(struct regulator_dev *rdev,
 	struct wm831x *wm831x = isink->wm831x;
 	int ret, i;
 
-	for (i = 0; i < ARRAY_SIZE(wm831x_isinkv_values); i++) {
+	for (i = ARRAY_SIZE(wm831x_isinkv_values) - 1; i >= 0; i--) {
 		int val = wm831x_isinkv_values[i];
 		if (min_uA <= val && val <= max_uA) {
 			ret = wm831x_set_bits(wm831x, isink->reg,
-- 
2.17.1

