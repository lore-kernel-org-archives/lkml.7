Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD09C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C17D2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AD05EAfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfDIPYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:24:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54793 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfDIPYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:24:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so2628026wml.4;
        Tue, 09 Apr 2019 08:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LJnJC2dM2Rq50GBWJOZT3JBgG6J5HNGDJZeT6eQx91Q=;
        b=AD05EAfwOCIiKEw6G3n7I0BksXuWuPWpZP862oYAMQlJggTIR23LUJq+GQw0qbY4vI
         Hrf7DIv5hUQvlqhvRxZdxteVS3Ylinr8EGnywjLEsAIpgqei94Q8/SIqwRbU8WMdc5W8
         PBCkvhhI/i53r2bBewdQqEmO9Ku3ge/5UOSsVd+pEdmxryZuupJLlxURORkVbmj7VLF6
         7lkyGeDFg0+KsU+0Lj911dkMzP1H+6PUxfsxD4QRUNCzDD9qiGZmdnlH7RKWiR+Pr0Be
         K6mlrcRVGYDGra5CBeXsWlo2syrG57WwmGqSV2n0/Kni0Ly2ZRzz5Lx+0GJs/0r47aOQ
         FBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LJnJC2dM2Rq50GBWJOZT3JBgG6J5HNGDJZeT6eQx91Q=;
        b=YZ5SQoExoyuuFXhI1hT2+zu8IwQlgf4XkuIGyUpTTfZajqSSTq/O6kip7csAGE6cae
         tvxOn5T2TJ9ZDUGmnfBFNbv7S/5omPsxSM5ygCWV1htKBJXG0MW2KksEtFgSdG6DTRmX
         puuzh1pCzl1n3CNlK1mIVP5QU2xvnRLliETCQ2tuo+l1TBc96oxm0nAtNEBJAN+5XkKR
         1yhE0JOpLoBDY+f/02qVLjYUAvZZtqCXskjparBcWdKFafOFehcDfDVVyohcbXL5hQgp
         mFHBsra2qfaeeFDI0dkuww2t6sU92KYyD9uZ0rkWzusN+YFaICHhMNu0lQyOxN0h2Mzn
         /q/A==
X-Gm-Message-State: APjAAAWrlp1FvURVlf13mff+rVJ9Np2sO3VYNeaSJX63iAkhr4ib+TR4
        aoq5GylObr7HUwa4XrHbJTg=
X-Google-Smtp-Source: APXvYqyQEk7QbjlPn6BQjvhpPshNVv2zryGSIu7jb2rtJ848d82uJKqdUAeNnT2Uv62ErHn6laTcbA==
X-Received: by 2002:a05:600c:219:: with SMTP id 25mr23120728wmi.7.1554823441949;
        Tue, 09 Apr 2019 08:24:01 -0700 (PDT)
Received: from laptop.criteois.lan ([91.199.242.236])
        by smtp.gmail.com with ESMTPSA id l23sm13066008wmj.10.2019.04.09.08.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 08:24:00 -0700 (PDT)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
Cc:     Erwan Velu <e.velu@criteo.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com (open list:MEGARAID SCSI/SAS DRIVERS),
        linux-scsi@vger.kernel.org (open list:MEGARAID SCSI/SAS DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scsi: megaraid_sas: Reporting evt_detail->code in megasas_decode_evt
Date:   Tue,  9 Apr 2019 17:23:38 +0200
Message-Id: <20190409152338.27874-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When printing a megasas_decode_evt() message, the code member of the evt_detail is not reported.
This make the debugging more complicated as some code paths depends on this value.

Reporting the code member makes the context more explicit.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 293f5cf524d7..222166c659bb 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -392,8 +392,9 @@ megasas_decode_evt(struct megasas_instance *instance)
 	class_locale.word = le32_to_cpu(evt_detail->cl.word);
 
 	if (class_locale.members.class >= MFI_EVT_CLASS_CRITICAL)
-		dev_info(&instance->pdev->dev, "%d (%s/0x%04x/%s) - %s\n",
+		dev_info(&instance->pdev->dev, "%d code:%d (%s/0x%04x/%s) - %s\n",
 			le32_to_cpu(evt_detail->seq_num),
+			le32_to_cpu(instance->evt_detail->code),
 			format_timestamp(le32_to_cpu(evt_detail->time_stamp)),
 			(class_locale.members.locale),
 			format_class(class_locale.members.class),
-- 
2.21.0

