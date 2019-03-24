Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04E4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724B7213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="cDTJSBDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfCXXVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 19:21:18 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:41818 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfCXXVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 19:21:17 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 2CD63909
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 23:21:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4E_PWBab9Grf for <linux-kernel@vger.kernel.org>;
        Sun, 24 Mar 2019 18:21:16 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 020185EC
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 18:21:16 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id s21so7017938ite.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 16:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=41fkJ68HbV1EubuETozIxJ2sQJNbc/APWw+PYFA9ZNg=;
        b=cDTJSBDgz9nITl5fN5sj4xglZ4y0ueJVn0zpvT3JQzSd86oPcDMOAX/Vqj36X3RqA1
         1WDxSsuJyXbNQrtFT+zxa/53/xbIVaeO4allLaWanYH5yt0BClYRqCplWwd5F84wNyDn
         MPTywDihlddPxn+W8FYGsB6ABMKMTlVe/zIjbUolzYTRv+rRmfWf3gmGWHGb/qaooAjE
         mvqS7WP5nePxgnXuVpH3sn+dSq0U5ewf75kMneWLfVy1+PpHGutqxPtmL4swff6IReCy
         ioga6P8XJXqYeJ4pQojC4wSALEDJR+b49/Vxx4+Kz7gZXRgr58Lj9cq9C9CyFwePCWzO
         F83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=41fkJ68HbV1EubuETozIxJ2sQJNbc/APWw+PYFA9ZNg=;
        b=TRaAkpPLUaczPyncyvr2UnGxDMGi0nyphaDXAFmYyBcDPmIJD4p7HgJWWA44TQJGc6
         oVlAPqppqlQvKhdPBq6fijLvRUxzNWDI+udKj39pF8BKZbbZTxwZWYGRRxajsUJ2bvXm
         xFhR7Ce7QcSQh5c2IfEbeakEA4CZUISFQOhUqhNz0Hroqoekl1BkDWnURQZsIykbuEvg
         sT1s0U1R7KkcT4HOD6LywINMrAt7R2+dRrye78Hy2NkCzFur8LmtTqRumT8HhgGwVMbu
         ezoziJVuEql9FUO+rNx3hTYiDBxYPTVLAx2LOFbkHbQkupXoEpQ0xWu7jjWvaPu150Sj
         8RHg==
X-Gm-Message-State: APjAAAUCdc6pTBcE1UHHZm98EHQQEu6XTCI5/ARQvbDrlyMTyIZZHjbw
        Pe3gf8CzSp4G4VNd6GWzfF211aLslxWtWpLfbvIVvdLaimDut/nQBCkmgV4ulXJRsAQR/0+Esep
        OA9sFYuU/cTH/JAQKL/dLl7K+Qbxl
X-Received: by 2002:a05:660c:606:: with SMTP id i6mr5694552itk.154.1553469675670;
        Sun, 24 Mar 2019 16:21:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz1YJkCQQM3iesbxKizyV0etr0E+nnhFQ8vMqnS3C8j93farj+XV2e+HZrLW0fHUeEb95jL4g==
X-Received: by 2002:a05:660c:606:: with SMTP id i6mr5694545itk.154.1553469675429;
        Sun, 24 Mar 2019 16:21:15 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id x79sm4327143ita.17.2019.03.24.16.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 16:21:14 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Olli Salonen <olli.salonen@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: tuners: fix a missing check for regmap_write_bits
Date:   Sun, 24 Mar 2019 18:21:10 -0500
Message-Id: <20190324232110.2804-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap_write_bits could fail and thus deserves a check.

The fix returns its error code upstream in case it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/media/tuners/tda18250.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/tuners/tda18250.c b/drivers/media/tuners/tda18250.c
index 20d10ef45ab6..36ede1b02d23 100644
--- a/drivers/media/tuners/tda18250.c
+++ b/drivers/media/tuners/tda18250.c
@@ -703,6 +703,8 @@ static int tda18250_set_params(struct dvb_frontend *fe)
 
 	/* charge pump */
 	ret = regmap_write_bits(dev->regmap, R46_CPUMP, 0x07, buf[2]);
+	if (ret)
+		goto err;
 
 	return 0;
 err:
-- 
2.17.1

