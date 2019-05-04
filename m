Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439F6C04AAA
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 03:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1574420859
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 03:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="btBo14Ov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfEDDeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 23:34:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43903 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfEDDeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 23:34:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id n8so3617611plp.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 20:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RifsY1ohdVN3X35sTb/8UoY4aiaOn18e2ejfI6dtxPU=;
        b=btBo14OvzglNKLkHKJ9zBuHdS9xf9LE2e98Xif/2jtcF0CxFlrGp/v7QRFeRAXkwxo
         9dNsCcsX++rcwfQtgjWVBePX8zi10WhkgBW1Z8z4TvEgkb7SekUlhQ0cc1a+BXRwQ+7n
         eohGAc8UjXJKt+YDJiXTdvIJ7khVamZ84CyeVCg7J4YwP/T2J/EMnRtZd+gO4YG2qGAl
         5XtEfmPgZ6PKcJBOY1xlUdDSg/bRN0NuuegWhjlZD8TdxeeXNx1AuhaQqxKILIBN8waX
         3XiAtcbhkDt6jzyB0u2XwuEsrYG3o7UttZzF18MzJ+M2KOvHaDS9y02Rywh/hezE4MG/
         SuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RifsY1ohdVN3X35sTb/8UoY4aiaOn18e2ejfI6dtxPU=;
        b=CeA/MLPPdGDX3kCM+mguz4dnuct2et1k7nROc/06KpMhWzJrys6io25zAr5b7uLooF
         nEL8ldhVa1opX70lTrgkjhwI4NliVqNvQGh11dE07F+w9CbjylhqSN8Lc8285OKgIzsg
         SOFUslNImu++xdjRpa94TauyJuF2mla2vi6/9ix5C1dNZa+ij1xp1inEOehK2QlE5OqX
         vBBnF0CbJpVpQL8XHM8Sy1h9hXBRDwM62PCWuszvzi82cLJTvpxGBskHLXniq11s6epn
         usbOVWh2qvCpgvlHQurzw6ok7G+bv2Dp8ZFH7lCuZriB8+fsJ53/MF/KW80ew3doMqLG
         DR/w==
X-Gm-Message-State: APjAAAUSFBI2P8/AfdxFCLrsC24Rrmk4UcIGrHlvBn2QKt+bPDZjEvED
        YrMwzLGQ8/CbhA3cuxDjnfh+7w==
X-Google-Smtp-Source: APXvYqwJ7ubXrEK5F0yQ6ow+c7Ke05Z6xCuQlpmtO0TAao4JxTcmIcRPtlNqmJdK1OhsZdKkUo87qw==
X-Received: by 2002:a17:902:fa2:: with SMTP id 31mr15829830plz.128.1556940840429;
        Fri, 03 May 2019 20:34:00 -0700 (PDT)
Received: from localhost.localdomain (36-239-225-241.dynamic-ip.hinet.net. [36.239.225.241])
        by smtp.gmail.com with ESMTPSA id f5sm3994618pgo.75.2019.05.03.20.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 20:33:59 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: core: Slightly improve readability of _regulator_get_enable_time
Date:   Sat,  4 May 2019 11:33:36 +0800
Message-Id: <20190504033336.11582-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic is equivalent, but it looks more straightforward this way:
If rdev->desc->ops->enable_time is set, call it.
Otherwise fallback to return rdev->desc->enable_time.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7f467a0ca8f7..5a5f5ed064b2 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1650,9 +1650,9 @@ static int _regulator_get_enable_time(struct regulator_dev *rdev)
 {
 	if (rdev->constraints && rdev->constraints->enable_time)
 		return rdev->constraints->enable_time;
-	if (!rdev->desc->ops->enable_time)
-		return rdev->desc->enable_time;
-	return rdev->desc->ops->enable_time(rdev);
+	if (rdev->desc->ops->enable_time)
+		return rdev->desc->ops->enable_time(rdev);
+	return rdev->desc->enable_time;
 }
 
 static struct regulator_supply_alias *regulator_find_supply_alias(
-- 
2.20.1

