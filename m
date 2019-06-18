Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B625C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFB32082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHmJKwG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfFRBbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 21:31:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46140 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRBbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 21:31:49 -0400
Received: by mail-qk1-f194.google.com with SMTP id x18so7498191qkn.13;
        Mon, 17 Jun 2019 18:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yOPVX+YNuHzebz9TKbTGJyOFzAXq8NyXH/xz6xEoeqE=;
        b=PHmJKwG+hP9Ia+ZoDGFpjA4RxW7WVAAKyZ2EEoCAjRmU/4PjLwhBWJK8FzF3H00RlE
         KosBcniqVoux8OHm8j0yXpG8ToR197TNn3KCHFj8vCGdMd6eWwNiZ4hgF4kjQozMNOBQ
         v7YznJzKtz9a04KNbN7WvzUMZNCLYf9K6rf3DYVKvKEuCFDU8igsx+tR4iu8vchQejJJ
         DgrIvmZ067Urzmc0u0y7fMdqXbTByVvTEIccFtEcV4I0Dioo99qJvF28iMyUqwMCYhJl
         2kbqxYxVJl2rCcXNSnPTKUFvXX6/yg6S3DOR4u5SsyUlJ2xRVbOrPeOg6tVtpne7gnn5
         B94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOPVX+YNuHzebz9TKbTGJyOFzAXq8NyXH/xz6xEoeqE=;
        b=rSd849lL3vNJsj1dUlfFeo10wGQaITkQkIdNnEF3xPloxA0l2JwlkZ4o29GOKDv4ul
         It8wtSMzPDLrCJs/8NmT3AxYIyqZvK24/B50dTa6rBLMzdtCEcd/iOHCpNL+RhiyaVu6
         0gid79WOS83P/efjWM3rixeHbBbD/AcT6hcYw/6d7KB56LLZsIDZuc23hwzq9FfxCzBq
         dj+1uEVq3uOE+t1uwAvaE9r1wQPj+uoSllcFYLn1P4F7kqHwgL+fRSNqr7wzrIEOqiFp
         u6VBLX7cIyvZKRjD0yZHqHyeKgny75zRrhfNDvbwUXcEpAOD2ow30LdvrT6NHzY12kro
         PhOQ==
X-Gm-Message-State: APjAAAXS9byc+7QTp6D1mFrEMHeUGNhfw0+5JSmXgcGaT11L6wBQV+mu
        P94e5S3xsOLfts09jEVZBJXB87T+RFI=
X-Google-Smtp-Source: APXvYqzprKKmgpOVkpa79e2Xan3PAe/muioVT5qRItVi/fmrve7AQnQn3ShIdVaKWVvgeZBIQtJuYA==
X-Received: by 2002:a37:660b:: with SMTP id a11mr91438305qkc.342.1560821508002;
        Mon, 17 Jun 2019 18:31:48 -0700 (PDT)
Received: from localhost.localdomain ([186.212.50.252])
        by smtp.gmail.com with ESMTPSA id c30sm8340874qta.25.2019.06.17.18.31.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 18:31:47 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:USB MASS STORAGE DRIVER),
        usb-storage@lists.one-eyed-alien.net (open list:USB MASS STORAGE DRIVER)
Subject: [PATCH 2/2] usb: storage: scsiglue: Do not skip VPD if try_vpd_pages is set
Date:   Mon, 17 Jun 2019 22:31:46 -0300
Message-Id: <20190618013146.21961-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190618013146.21961-1-marcos.souza.org@gmail.com>
References: <20190618013146.21961-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If BLIST_TRY_VPD_PAGES is set for a device, even for an USB, it should
be honored, so only set skip_vpd_pages is try_vpd_pages is not set.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 drivers/usb/storage/scsiglue.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index 59190d88fa9f..0a9520780771 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -195,8 +195,11 @@ static int slave_configure(struct scsi_device *sdev)
 		 */
 		sdev->skip_ms_page_8 = 1;
 
-		/* Some devices don't handle VPD pages correctly */
-		sdev->skip_vpd_pages = 1;
+		/*
+		 * Some devices don't handle VPD pages correctly, so skip vpd
+		 * pages if not forced by SCSI layer.
+		 */
+		sdev->skip_vpd_pages = sdev->try_vpd_pages == 0;
 
 		/* Do not attempt to use REPORT SUPPORTED OPERATION CODES */
 		sdev->no_report_opcodes = 1;
-- 
2.21.0

