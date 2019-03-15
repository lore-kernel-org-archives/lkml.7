Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C7CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5356218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="E7R6v/U+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfCOHML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:12:11 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:56568 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbfCOHMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:12:10 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 0B405645
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 07:12:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gcA48KzyKufI for <linux-kernel@vger.kernel.org>;
        Fri, 15 Mar 2019 02:12:08 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id B7424629
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 02:12:08 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id a7so3462367ioq.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 00:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=17W7n2bCWmlwTSpVZcXn97DFxdwzQ+dBaO0OQ4OoLWo=;
        b=E7R6v/U+sRV30CPT76jhsao26xQ8hZDsYbdDj+DeApIKnr5IWe54vSckXbfsljhzHD
         MKci0iIR78FK9+mYkyWzLX///BXTDatoZwcHXhwjH3CyRkicoBNEhWjbWbyOComuS6si
         AkV7m/E99kBWvltkh4t1oFKEjkrkJtXGKV3HavDLWQLMB6YgdT/OWnG3Uz/+aMz569C6
         1FeJd2PTlRPQV29YqOFh7wqlFFntCzeZtwUjL1aNT00ZPhma0VqQiSDeA39O+zkqmAAq
         9Zc4VRtoMYGG6wikOXhXBZFOb+Cj4hIfGnzAiuP4Kqg58hDUZv+GzRLP3AE2qp+8AAYC
         jfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=17W7n2bCWmlwTSpVZcXn97DFxdwzQ+dBaO0OQ4OoLWo=;
        b=Iq9IATLKWwuWnQl2ND3SevkQpeL/K6i5rDF//+Bfxdzd8kQ4vRW8zuFsU1e2E7UVLh
         hn3tHjYTAPrYBh4cL85mLIkb03gs80zh4/X1MIYsl9ouqJTLYe+FNmCCVkbhUP/hVx8E
         5x9asSYKIO3S/5Dx60bWvRsJOSjGuhr4LOnQlcelC+8E7hjMD/8gtTN/PT1e0qRVPEic
         Quq894xtDLFmD14hOo8mUnWewQgow8uCrxUskqsenAgN8yTJVF+2jRFuqH0sY230vtve
         Q3QEzCwpMnuUZR16bE98iPMKoF4eEPgZxkOC4dtat8GeKV8pYy2rVQATcCE3y7O70vsX
         d24g==
X-Gm-Message-State: APjAAAVL/SewYv7vOXQfOitzSd1b5q7dG0PnUZ2lBK47yLk0K046FOo5
        1+XccpWAbcQf+a5p+Pb9KnhxGDC2En0wpyvqDk1DvB3fqKICMR31ic8I6OB6Hps3zblHWeUUgm0
        GDsFQzQwNORl2wDBGIwJZb/W4GsZ4
X-Received: by 2002:a24:d4c1:: with SMTP id x184mr1021568itg.174.1552633927415;
        Fri, 15 Mar 2019 00:12:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyM9RMBOK+DXr3alwY4ksDzI08XpzPR7e/MvZ/rhitGerDyX/N/zQVqhy4OHbVvDjZ0HrCPBQ==
X-Received: by 2002:a24:d4c1:: with SMTP id x184mr1021557itg.174.1552633927201;
        Fri, 15 Mar 2019 00:12:07 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id e73sm645199itc.39.2019.03.15.00.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 00:12:06 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: ufs: fix a missing check of devm_reset_control_get
Date:   Fri, 15 Mar 2019 02:11:56 -0500
Message-Id: <20190315071156.21588-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <SN6PR04MB4925DB2652FAED5F3AED27CCFC4B0@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <SN6PR04MB4925DB2652FAED5F3AED27CCFC4B0@SN6PR04MB4925.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_reset_control_get could fail, so the fix checks its
return value and passes the error code upstream in case it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Acked-by: Avri Altman <avri.altman@wdc.com>

---
V2: Use full line please
---
 drivers/scsi/ufs/ufs-hisi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
index 452e19f8fb47..c2cee73a8560 100644
--- a/drivers/scsi/ufs/ufs-hisi.c
+++ b/drivers/scsi/ufs/ufs-hisi.c
@@ -544,6 +544,10 @@ static int ufs_hisi_init_common(struct ufs_hba *hba)
 	ufshcd_set_variant(hba, host);
 
 	host->rst  = devm_reset_control_get(dev, "rst");
+	if (IS_ERR(host->rst)) {
+		dev_err(dev, "%s: failed to get reset control\n", __func__);
+		return PTR_ERR(host->rst);
+	}
 
 	ufs_hisi_set_pm_lvl(hba);
 
-- 
2.17.1

