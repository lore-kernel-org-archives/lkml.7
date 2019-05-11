Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20356C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 10:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC82221479
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 10:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klfVSy6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfEKKFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 06:05:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33242 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfEKKFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 06:05:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id x132so5847242lfd.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 03:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=S1pzAmLNYPAdy00NLo0+swPi8ZueHy7n/ZkntsATcVI=;
        b=klfVSy6EuBXbSF6HXaXcZqpKz9ArrgWbJLcJ/kiA+mUkTEmlnelyUiy+Ebc8lRDVF4
         oJFOI2e031uG3NFEcMEKQqN7RykJoZr2Llk7h7G65PZNEGmsh50YH7h+bzjhfEYbSESC
         L+zVmygnc8g3W/7S2XAwH5H3NBVSp5uYLPqvSMeBGMLSky47UaopILOd5R36IHeFeZpq
         nYoUOj9cC8O3UbSbyjDMpe7ul4TuR40bYud8BzpaAuD+3LBBYEHVWpGE4Ae+6jFRvtA4
         oIQzEYlOSNZngzIbq0rGpZIisbJeWT0Y+EKhxc5r94Q13Xb8OoilJeC1ngbfLKyom8Le
         wUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S1pzAmLNYPAdy00NLo0+swPi8ZueHy7n/ZkntsATcVI=;
        b=J1Qm6fJ/tmC4AKXWXuFD0l9cTkZl6iAd2M4fljvLnOgU8X1SUIFoB+YDUpztMl4bPx
         JXuc+AxlrCUfvNC/6dvgEs9XWMjsjz2JIXfi+JIiRcQBGZBGxM5oTcxheSJzuwNYPR4c
         ZqmXCiQL6B6qU1JvzxSgYCIkhWDZxBEDK2ScxFZJl1GkPqEpKGFo9z12plQpXmxAsvIk
         O5OQsD666KFnUwgRpv7I7prMqaddRdI6N9heaWL5wBUrSS40QdxWXCQuD9C4Fp4dliNx
         N3WX5R7RmKkKsBwCCKINEd1wXKadr0BQRhyuEmsrRpeqwHadpSL/1CzW4eeAVLZmYUGZ
         P6qw==
X-Gm-Message-State: APjAAAVTaF6eDqWWfs+ZsuG+cIUWvgOKPJI9nHnECMuY6KfGnSkKrBTy
        UeSS2Lxk7ae3c7B5LwOP4MA=
X-Google-Smtp-Source: APXvYqxBlf058XLRLFZsCI5tRDwGeplpimfiuQZEYKJ3VIiqwLjYZ8sn94EHcuKStD9r7wG7384ngw==
X-Received: by 2002:a19:e002:: with SMTP id x2mr9047896lfg.16.1557569118133;
        Sat, 11 May 2019 03:05:18 -0700 (PDT)
Received: from localhost.localdomain (80-167-223-88-cable.dk.customer.tdc.net. [80.167.223.88])
        by smtp.gmail.com with ESMTPSA id v1sm2196313lfa.93.2019.05.11.03.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 May 2019 03:05:17 -0700 (PDT)
From:   Daniel Gomez <dagmcr@gmail.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        alsa-devel@alsa-project.org (moderated list:CIRRUS LOGIC MADERA CODEC
        DRIVERS),
        patches@opensource.cirrus.com (open list:CIRRUS LOGIC MADERA CODEC
        DRIVERS), linux-kernel@vger.kernel.org (open list)
Cc:     dagmcr@gmail.com, javier@dowhile0.org,
        alsa-devel@alsa-project.org (moderated list:CIRRUS LOGIC MADERA CODEC
        DRIVERS),
        patches@opensource.cirrus.com (open list:CIRRUS LOGIC MADERA CODEC
        DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] mfd: madera: Add missing of table registration
Date:   Sat, 11 May 2019 12:03:58 +0200
Message-Id: <1557569038-20340-1-git-send-email-dagmcr@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MODULE_DEVICE_TABLE(of, <of_match_table> should be called to complete DT
OF mathing mechanism and register it.

Before this patch:
modinfo ./drivers/mfd/madera.ko | grep alias

After this patch:
modinfo ./drivers/mfd/madera.ko | grep alias
alias:          of:N*T*Ccirrus,wm1840C*
alias:          of:N*T*Ccirrus,wm1840
alias:          of:N*T*Ccirrus,cs47l91C*
alias:          of:N*T*Ccirrus,cs47l91
alias:          of:N*T*Ccirrus,cs47l90C*
alias:          of:N*T*Ccirrus,cs47l90
alias:          of:N*T*Ccirrus,cs47l85C*
alias:          of:N*T*Ccirrus,cs47l85
alias:          of:N*T*Ccirrus,cs47l35C*
alias:          of:N*T*Ccirrus,cs47l35

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
---
 drivers/mfd/madera-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 2a77988..826b971 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -286,6 +286,7 @@ const struct of_device_id madera_of_match[] = {
 	{ .compatible = "cirrus,wm1840", .data = (void *)WM1840 },
 	{}
 };
+MODULE_DEVICE_TABLE(of, madera_of_match);
 EXPORT_SYMBOL_GPL(madera_of_match);
 
 static int madera_get_reset_gpio(struct madera *madera)
-- 
2.7.4

