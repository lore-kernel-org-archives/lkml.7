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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E34C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086902082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9AmDey2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfFRBbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 21:31:46 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41457 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRBbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 21:31:46 -0400
Received: by mail-qk1-f194.google.com with SMTP id c11so7510236qkk.8;
        Mon, 17 Jun 2019 18:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y4Oe6aDf+AlskyPKCzvTecq5PuBGUU4mq9gJELUQIDI=;
        b=l9AmDey2k/6f0Mp5ZAZ4kj5zg6w6qnRDVZp2gQI3a+uXO8VGbVuKdya67Fnp+FHAqs
         qRirV8bNidCDlY8jcd3xHjj+Ap8zVEEi0gRoUSZ/S03P/6cas3BlbT3iOY1YZF7pnz96
         5Z8i38OMrDDpsgjqhc/6j3j02wNp4L5x2LLNnwi0E08X7onLybLxbMFTPws2m74euO9t
         ov9pkAeTUDcvJeq/UoEq2nY25e8zMY5d0cSPLXLCl4Cv8r4IWQ9kIsT1GOXZTeul+oXH
         jXfDXGQH+GBdfrlYu7MCHZ58LqayzIQxf7KA7eDjLtQGc3//gLZ0UV9g3HsxaO8gZNrr
         LwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y4Oe6aDf+AlskyPKCzvTecq5PuBGUU4mq9gJELUQIDI=;
        b=S5rlHS2tGpiKadVrJqTPPUI5kpgDu2y+ubmvQXjFBiPJ9W92mLu/nt3SLQs4UofPAy
         R+MwyNqixiaF8gcJGV1LiexYP9M5cBpqgU7VNMDzI7KiGg/m2lvMybqVwsxDBKB7CLbp
         Xr1965X/GIqaJAkGZKC9DSifii51OkQEKQmooFdoIC4qHPfae5nqdjQ/a0UpjZauCEYx
         lSxr0427RjMFzVsm4JR7f2MYDdvXznP9JlT0xfYfXTTgY6+eaBiNTwMIB+0i3seSAmrG
         sy3EeaUzILJK1RK6sBaxCSnB4kuretpadh3kjITwnd//VGdJjbllNNi2RaWA9K3VYw3+
         ZsTg==
X-Gm-Message-State: APjAAAUgBUfdFPp53zEneYCe2zDFTwaWW0Nx4JoJQgjSbASJlacp4BQl
        y0IiIjv6veUXjPXEq7hZTEYATg5uqPc=
X-Google-Smtp-Source: APXvYqyqEuCkMCR4zUC0q4WwJBgM8pXwaR3KqUEFVAmLxF0I8vrWFqXammIjIu2l7lEGhrqDBj8VKg==
X-Received: by 2002:a37:b0c3:: with SMTP id z186mr24246107qke.178.1560821504848;
        Mon, 17 Jun 2019 18:31:44 -0700 (PDT)
Received: from localhost.localdomain ([186.212.50.252])
        by smtp.gmail.com with ESMTPSA id c30sm8340874qta.25.2019.06.17.18.31.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 18:31:44 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 1/2] scsi: devinfo: BLIST_TRY_VPD_PAGES for SanDisk Cruzer Blade
Date:   Mon, 17 Jun 2019 22:31:45 -0300
Message-Id: <20190618013146.21961-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190618013146.21961-1-marcos.souza.org@gmail.com>
References: <20190618013146.21961-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, all USB devices skip VPD pages, even when the device supports
them (SPC-3 and later), but some of them support VPD, like Cruzer Blade.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 drivers/scsi/scsi_devinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index a08ff3bd6310..df14597752ec 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -239,6 +239,8 @@ static struct {
 	{"LSI", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
 	{"ENGENIO", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
 	{"LENOVO", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
+	{"SanDisk", "Cruzer Blade", NULL, BLIST_TRY_VPD_PAGES |
+		BLIST_INQUIRY_36},
 	{"SMSC", "USB 2 HS-CF", NULL, BLIST_SPARSELUN | BLIST_INQUIRY_36},
 	{"SONY", "CD-ROM CDU-8001", NULL, BLIST_BORKEN},
 	{"SONY", "TSL", NULL, BLIST_FORCELUN},		/* DDS3 & DDS4 autoloaders */
-- 
2.21.0

