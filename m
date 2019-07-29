Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DC9C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 03:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990F7214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 03:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+ytlk7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfG2DI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 23:08:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39566 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfG2DI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 23:08:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so23230857pfn.6;
        Sun, 28 Jul 2019 20:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pLFtk/7F5eVVtua+aE9FkwIBwxxf0EwZRWJyAn6pvVI=;
        b=a+ytlk7ZHUWsS6Nb5eTXltj46JbqaavLLOpVr/emP+ST4FTqxcMXUyc2fUMtA7NZIi
         O1unhUmP0Ul72y/reBqbxEa8g7KKUOjxDyr1pz3vY4lLBTpBEu3ExwIndr0osARri6Dk
         fVubLbS96lpk47DRJKj68yDzc7Fw+BrSywy5pM49HIxxizynfZiZY7YZXgDxcSqC03ul
         Hdrn+EP4gacUEQPIizZi65k8xiD1UFUe/OG9brph2q30DMFNk4K6Rl5EoSWWU4nleT2u
         AemndnpMYnHpTl2qEBYPfGTDuwBg56yRp3muDuMw4/K7QCRg4L2iAnriSJ6DP4Lpi8t5
         ZU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pLFtk/7F5eVVtua+aE9FkwIBwxxf0EwZRWJyAn6pvVI=;
        b=cNeegUtchAtOHGz68bih9+y7c8FWKtnv6nC3c0cbt9jVn/FTSb6R5UPMtOr4oP6Xrq
         Ww2NQ8C8DMg7o+C+PkE06zX2QX66aAp3ku4vuFDI9zJcvnE3AhkADyhwPqA9jngC0itM
         jmCrl8LGr7Dl4lYfPXbNpBJVAGd0lx9zHgnK1E8T5cWD1fcWSBU8zv4yJVIpvrgmsK07
         cZOs8to6Yzo9kNsWKdFBD6aaHeumVgR2GZeB0zqFTU6LYXA20Z/9KniJMkR8jGgGdwJm
         XXw/2SDtCxSujoSC+14+DchOQJxGlVTM6sUt6YA4YqCU8OCTgSP2EWotd3QNwWdz6S7R
         vW4A==
X-Gm-Message-State: APjAAAXJXBgKxungXxoEfDZqkgafJ5I5krIN2EI00ntSzD6E4l9iFaOw
        eDsYNnjBisfuAC/cOK4eo/WUof+R
X-Google-Smtp-Source: APXvYqxgCqmFuPGIHttjS+TJKFAVU/hNp91yKBQmAf8sXxGSP+gVRMvroPIwsPBIJxbjVlg8Db2A5Q==
X-Received: by 2002:a65:4786:: with SMTP id e6mr99800479pgs.448.1564369738236;
        Sun, 28 Jul 2019 20:08:58 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id z20sm94807865pfk.72.2019.07.28.20.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 20:08:57 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     sathya.prakash@broadcom.com, chaitra.basappa@broadcom.com,
        suganath-prabu.subramani@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] scsi: mpt3sas: Fix a possible null-pointer dereference in mpt3sas_transport_update_links()
Date:   Mon, 29 Jul 2019 11:08:51 +0800
Message-Id: <20190729030851.22059-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mpt3sas_transport_update_links(), there is an if statement 
on line 994 to check whether mpt3sas_phy->phy is NULL:
    if (mpt3sas_phy->phy)

When mpt3sas_phy->phy is NULL, it is used on line 999:
    dev_printk(KERN_INFO, &mpt3sas_phy->phy->dev, ...)

Thus, a possible null-pointer dereference may occur.

To fix this bug, mpt3sas_phy->phy is checked before being used.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index 5324662751bf..df790a9877a0 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -995,7 +995,8 @@ mpt3sas_transport_update_links(struct MPT3SAS_ADAPTER *ioc,
 		mpt3sas_phy->phy->negotiated_linkrate =
 		    _transport_convert_phy_link_rate(link_rate);
 
-	if ((ioc->logging_level & MPT_DEBUG_TRANSPORT))
+	if ((ioc->logging_level & MPT_DEBUG_TRANSPORT) && 
+			mpt3sas_phy->phy)
 		dev_printk(KERN_INFO, &mpt3sas_phy->phy->dev,
 		    "refresh: parent sas_addr(0x%016llx),\n"
 		    "\tlink_rate(0x%02x), phy(%d)\n"
-- 
2.17.0

