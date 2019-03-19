Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A513C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CF42146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="FFVs6T5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfCSUPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:15:15 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:47496 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfCSUPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:15:15 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 46BEDCF6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 20:15:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 75rl9K5GPBMk for <linux-kernel@vger.kernel.org>;
        Tue, 19 Mar 2019 15:15:13 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 11339CEF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 15:15:13 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id y6so120483itj.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rTgvYOi0NA2nNhyovhJYwbXYNdmBOXtvCDrrXz0EgAo=;
        b=FFVs6T5bMZZ2OM2W8BfyzO4uV5EUihfA3zC2747chU2l4SPiiaAxOpD5bQmYGPCWhp
         UnyzcLlReVKZT3aOQuehjhmS02vD7x1lAAiNj7x3ijZPRFJuf8s+h0gxSMQXs6BuCBZ/
         wkCJPvVOfbQRbZqsusjXAy3O/OJkR6sRibAoEx3+HO6kNfIRzdiguHS4MyOe3W+BeeSa
         FNPNCfdP4xsEpzcEPByYRwlNN8bNkqcz+jYTv/d6loOW0R+H8iTrhISVcFmoOyYvKhwK
         x4D7tPMwr0F2G1dsslZuoMlRFaUdhVkAUgCdbm0S6fUA1Eh/CyroDmHPHXrdQwcO/s6u
         /BLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rTgvYOi0NA2nNhyovhJYwbXYNdmBOXtvCDrrXz0EgAo=;
        b=Vs8S6o83/cWCG3KS1PDSE1a1yKB/3ugz1+qw/8Dfq93ecL1O4a0aHEs5aYDnArjYeI
         iy3NZkH06EXYjhvC87vlrYA2R6w4EHHZi2aoWMMM072bHwDLrgSjmk4R2OmL68LwvXn4
         z5l4ecr5Ks2tdYnyz7CsL3idjqFQ9OzJesl4Ol9DzMFxf8RnIul6jukxzcSczbKrsqRK
         TqILnJ6dZtxq+ZTP5SnzDYPifhk5hl8RAPpe8E0+y6vD9xV7RqUXgy+XLNqTqoOadNfe
         Bh01f2OiXV7D9VrSMImflNOP7WI8V86njTa8cyk1zOV/GgZRJan6T8k1KFL0qST6tK9m
         qwEw==
X-Gm-Message-State: APjAAAXctRwvygIwgxv/4CGtih/uW9hZ5ConY/yf3Cxj6USMPSyUbnYK
        FSszB+LIOCRP/tFn3PhGTGWAVJfhFG2HU9MwLkelQAfogShOw3iLRgEnlpN3d7Q7VHbni2CKPAW
        Ru2uZ792TR1KJzdkh0NLSnKsAbHpf
X-Received: by 2002:a6b:e202:: with SMTP id z2mr3044872ioc.6.1553026513078;
        Tue, 19 Mar 2019 13:15:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy3EpHmHmwX26eWudYyEOAP1u7WFvuQytZqq2ujJMo8bFAQotduXp9iHSUnUm79+x8P1tAjUg==
X-Received: by 2002:a6b:e202:: with SMTP id z2mr3044862ioc.6.1553026512919;
        Tue, 19 Mar 2019 13:15:12 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id y24sm6205979iol.8.2019.03.19.13.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 13:15:12 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtlwifi: Fix potential NULL pointer dereference of kzalloc
Date:   Tue, 19 Mar 2019 15:15:08 -0500
Message-Id: <20190319201509.16252-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phydm.internal is allocated using kzalloc which is used multiple
times without a check for NULL pointer. This patch avoids such a
scenario.

--
v1: Patch collision with different things, fix as per Greg
Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/staging/rtlwifi/phydm/rtl_phydm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtlwifi/phydm/rtl_phydm.c b/drivers/staging/rtlwifi/phydm/rtl_phydm.c
index 9930ed954abb..a7932706f286 100644
--- a/drivers/staging/rtlwifi/phydm/rtl_phydm.c
+++ b/drivers/staging/rtlwifi/phydm/rtl_phydm.c
@@ -180,6 +180,8 @@ static int rtl_phydm_init_priv(struct rtl_priv *rtlpriv,
 
 	rtlpriv->phydm.internal =
 		kzalloc(sizeof(struct phy_dm_struct), GFP_KERNEL);
+	if (!rtlpriv->phydm.internal)
+		return -ENOMEM;
 
 	_rtl_phydm_init_com_info(rtlpriv, ic, params);
 
-- 
2.17.1

