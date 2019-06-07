Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4683EC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD6B20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0So86n8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfFGHaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:30:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33283 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGHaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 03:30:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id k187so205628pga.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 00:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L5Z2jE2hiR8M4s/s+RbNowguHNU4m4jFgbMfAGDtbrs=;
        b=h0So86n8F43BSUeT5JqqEZz6m8os4UsSercQ21Q9ZOsOi7OhR/UDRaKcLrzU5qTgPr
         jUHFSNSkOWtPuqnP9cv2qFk1jx1q03U9/u7ykrP6bq9dS3/vz/iCCF2hlnYBQgEZbkJL
         dOjv/dhBN01b5kAb2k5rxCDRomTrRW/MywohTIxeEEsNTiLMMLShkkD/ujtyuJZ3MfsN
         P+uhvIMJe92oPJR1/PjjuLYQNiTHDVzP7pluT9OfSBbWiy3JHlLEgWwhnE1JU6nPpYVh
         VQQGqeqisSs37hW62kYsoO3NOWizXwvwKnT6SNBcBsorPNFnK1OKgVcna/TR2L7SRG74
         qLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L5Z2jE2hiR8M4s/s+RbNowguHNU4m4jFgbMfAGDtbrs=;
        b=OVfWYxzvzM761R6oAhQgxYSHB4JN59Y2WMocBgYTmTLjU7y/NJ+cDpij6nRQQqElGJ
         O9XMPm4d2YIOlDB++Ljq5BxCX6VzVHtviVQbgGaMstZfbbk55KuNmD68DN9tXiJKiIzH
         rgXCqDaraCGFp9z/TH+cltZrGm2qoFOZWWfDPAGWgAChIeHsNodglLPWGredtXOzqNEJ
         NeVpU8FiBGMBvKgSXxlfJy9YtxU/212MFyaMuiCcMOf4WjfQ57rrVdxcJNdUIhV8gjg2
         QQoBddca/nr7Ha5h/YZy/y9fARwI1nEyniobg5xXJgwO2TzckUN38E/45L6m49S1MjB8
         IYRQ==
X-Gm-Message-State: APjAAAVQpIhyBDfEIhURIRmuAVE29IJtRrd611UGct4BOqGjf5fVq6ud
        dXo24GyZfPgj4HVHB0MR6ko=
X-Google-Smtp-Source: APXvYqw1oUzCSW0QdRUcITg8B26D/16r3u4gVAm/66+wx+nR1sX5il3np25ess0kyjNYWLMOsoDMIQ==
X-Received: by 2002:a63:224c:: with SMTP id t12mr1544454pgm.227.1559892624472;
        Fri, 07 Jun 2019 00:30:24 -0700 (PDT)
Received: from localhost.localdomain ([110.227.95.145])
        by smtp.gmail.com with ESMTPSA id 2sm1297060pfo.41.2019.06.07.00.30.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 00:30:24 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, straube.linux@gmail.com,
        mamtashukla555@gmail.com, hariprasad.kelam@gmail.com,
        benniciemanuel78@gmail.com, christophe.jaillet@wanadoo.fr,
        puranjay12@gmail.com
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: os_dep: ioctl_linux.c: Remove return variables
Date:   Fri,  7 Jun 2019 13:00:08 +0530
Message-Id: <20190607073008.28690-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove return variables and return the values directly, as the functions
all return 0 in all cases.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 236a462a4936..a6fce63ad4db 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2601,9 +2601,7 @@ static int rtw_p2p_set(struct net_device *dev,
                                union iwreq_data *wrqu, char *extra)
 {
 
-	int ret = 0;
-
-	return ret;
+	return 0;
 
 }
 
@@ -2612,9 +2610,7 @@ static int rtw_p2p_get(struct net_device *dev,
                                union iwreq_data *wrqu, char *extra)
 {
 
-	int ret = 0;
-
-	return ret;
+	return 0;
 
 }
 
@@ -2623,9 +2619,7 @@ static int rtw_p2p_get2(struct net_device *dev,
 						union iwreq_data *wrqu, char *extra)
 {
 
-	int ret = 0;
-
-	return ret;
+	return 0;
 
 }
 
-- 
2.19.1

