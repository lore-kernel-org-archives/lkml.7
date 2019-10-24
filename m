Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FD4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617FD21655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503440AbfJXPzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:55:06 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54764 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2503416AbfJXPzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:55:04 -0400
Received: from mr5.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFt4Bp027320
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:55:04 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFswjh008979
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:55:03 -0400
Received: by mail-qk1-f200.google.com with SMTP id s14so23828343qkg.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=SyOobOpZYzTvdZYs3cH/N6hV2wYmIbDFbQPOWl3B3yA=;
        b=cYjNvkJrwiuZO0bQc27fmeQTnwWjMg5fFs0aFXULcPC8HIdiBkYIsokk4Jjr3CFAnD
         RO1ixcvals5uxJ0kHxBnRfDXEjFmYofndPEbG0vR1CleptVfGFEnWIsLJzvpIMfxfowi
         7d5K1aYy3/qENnkPMJF7bpbyWHgGLKqnNChd2Frpwi8hsY7ZJAaKxvqEKp5Uuyp/H5VJ
         gGc1wLw5xD+3mDJLl9kJ+XNhC6BGHcZVXnSf+0d+A0oZ6GZ2TBp0YDU8Oe9UOFH+RLYN
         7QRbc05heddooRW0ESPLykjt40yChbXK29Oe7TjCIxTC6XgVyDZALW2dq+34F5OsDpuU
         8PHg==
X-Gm-Message-State: APjAAAUYf+7xRjXIhKNQUZ5Ucpzy5JN608xVL2/Vuq24RQyq2nA3VMoo
        3YTO+RbGtRY5k11pGlRNNLiLLXvlTzN9hOu/x38pSkYyU9/VtonxDAJXIy7DC9aFavCWas7O6R4
        e9aYH9UBF4DlvUCvvYgCZtS9tk7baIr/loro=
X-Received: by 2002:ae9:eb17:: with SMTP id b23mr14409864qkg.260.1571932498718;
        Thu, 24 Oct 2019 08:54:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyGt4F+8h9pUy2WBpBQilCq7fwxiOziIP1Emg5SoFQw6Gfam/UCq8V3j8x1vTs9jK1ywgMmwQ==
X-Received: by 2002:ae9:eb17:: with SMTP id b23mr14409840qkg.260.1571932498453;
        Thu, 24 Oct 2019 08:54:58 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:57 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] staging: exfat: Clean up return codes - remove unused codes
Date:   Thu, 24 Oct 2019 11:53:25 -0400
Message-Id: <20191024155327.1095907-15-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 6 FFS_* error values not used at all. Remove them.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 2ca2710601ae..819a21d72c67 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -210,12 +210,6 @@ static inline u16 get_row_index(u16 i)
 
 /* return values */
 #define FFS_SUCCESS             0
-#define FFS_MOUNTED             3
-#define FFS_NOTMOUNTED          4
-#define FFS_ALIGNMENTERR        5
-#define FFS_SEMAPHOREERR        6
-#define FFS_NOTOPENED           12
-#define FFS_MAXOPENED           13
 
 #define NUM_UPCASE              2918
 
-- 
2.23.0

