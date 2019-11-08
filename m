Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8125EC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5697221D6C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4Uy3yD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfKHFUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 00:20:11 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40515 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfKHFUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 00:20:10 -0500
Received: by mail-pl1-f194.google.com with SMTP id e3so3267295plt.7;
        Thu, 07 Nov 2019 21:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VminkHZjPJEfcePoxrblVvTvuZD1weWd1AQS3sguLYY=;
        b=F4Uy3yD+3BM4e+yIRyLCZ6rTAtOy0OQPlCK/2TUXc4gKNGRYxG2Mt1jMMXy4po+n0s
         4hkPi1wqrR3vk8JWcA9cWgkd7Wmsv2NzhYyKsbAYQeUzbDVoqA5gloJY9E+R/tT5PSSc
         GeZzJmm4sfUzbDZcexDaZsru6xBlLuZPo7T16Z06TRBKx3mhnbjoROjGxkfvj6NWqZO3
         hqIDpRJEQMO8cGXgVWL95wU9Ow3Gfr9ZGtzeT/rdTNAfpYd58csKrfjWoITfQYxABx9l
         SqhYsoIJ9V0JURmQdQGQXRm8mjpQ1XVR2JYFONopnXHaHECrnSKBgvQulzJnF8CcHSeW
         84bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VminkHZjPJEfcePoxrblVvTvuZD1weWd1AQS3sguLYY=;
        b=Oy+ShMU5M/flUMA3Z9/jb8I4gkHstj7ESKnZ3ooaoODLKm7wwklhwLbde7cGDEX0os
         dxDlx0lj1AwTZYphta/Y10Z31TtDAHsciBFWmu0akixlO36llwzosZp/YFM4KDc/bK74
         ZKW5oA4ezSSJA45NmZQMrC1XTCLSf+qoDjEyVh+jn80/M+I6IwayGNUXLy24G6D0rgpp
         s4AE/bMfx00jYmAHWWmjY1y5K3P5e+WbWJeiEefQiDDyv++x77g8vRN8/TMI5y/Fw7sJ
         ky6DnQKTNZhCiHjwL1yBcjc/f7X1lXL8roisecQpkZSolemiHj4JexXNPRkNSKYgBNwz
         XxaQ==
X-Gm-Message-State: APjAAAX+Dvf4Ma9Lklvb0m4ph33GG99kKgaOnKmm0lMyXzmfZ2czVROp
        WPtjgFhVjZYgjlJqR8iPgok=
X-Google-Smtp-Source: APXvYqzk0ra5T3owJQ1Q9jaItHfMMjYMbyQPOGakYEt8GcLGEu417ZLj3vsIs20HPLE54o4W8y49+Q==
X-Received: by 2002:a17:90a:c68f:: with SMTP id n15mr3170444pjt.20.1573190409931;
        Thu, 07 Nov 2019 21:20:09 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
        by smtp.gmail.com with ESMTPSA id v19sm3798443pjr.14.2019.11.07.21.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 21:20:09 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>
Cc:     Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsi@lists.ozlabs.org
Subject: [PATCH v2 02/11] fsi: Move master attributes to fsi-master class
Date:   Fri,  8 Nov 2019 15:49:36 +1030
Message-Id: <20191108051945.7109-3-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191108051945.7109-1-joel@jms.id.au>
References: <20191108051945.7109-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Kerr <jk@ozlabs.org>

Populate fsi_master_class->dev_attrs with the existing attribute
definitions, so we don't need to explicitly register.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-core.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 0861f6097b33..c773c65a5058 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1241,8 +1241,17 @@ static ssize_t master_break_store(struct device *dev,
 
 static DEVICE_ATTR(break, 0200, NULL, master_break_store);
 
+static struct attribute *master_attrs[] = {
+	&dev_attr_break.attr,
+	&dev_attr_rescan.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(master);
+
 struct class fsi_master_class = {
 	.name = "fsi-master",
+	.dev_groups = master_groups,
 };
 
 int fsi_master_register(struct fsi_master *master)
@@ -1261,20 +1270,6 @@ int fsi_master_register(struct fsi_master *master)
 		return rc;
 	}
 
-	rc = device_create_file(&master->dev, &dev_attr_rescan);
-	if (rc) {
-		device_del(&master->dev);
-		ida_simple_remove(&master_ida, master->idx);
-		return rc;
-	}
-
-	rc = device_create_file(&master->dev, &dev_attr_break);
-	if (rc) {
-		device_del(&master->dev);
-		ida_simple_remove(&master_ida, master->idx);
-		return rc;
-	}
-
 	np = dev_of_node(&master->dev);
 	if (!of_property_read_bool(np, "no-scan-on-init")) {
 		mutex_lock(&master->scan_lock);
-- 
2.24.0.rc1

