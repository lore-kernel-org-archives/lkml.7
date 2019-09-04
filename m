Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A90C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6854F21726
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuJDFXTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfIDUcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 16:32:19 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46180 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfIDUcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:32:19 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so11437709qkd.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 13:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rw3ZlxgGIlK+n0HAnKhsvEmsMU3R5cAn/CwZ2JWWhG4=;
        b=cuJDFXTTZEXFCqa+LyPIyYaxHaZLo4kLvB6vIAHbUwn9KUNFvDRAXFlUP8jIULhz1r
         lvu31AJaNcpgitNRyKB+rnkabl+AMGvOFQvq6sm81Q3UnXfAnrIvX9I+KZA7/C9DBHkK
         JpvhREtiDJXu1jxKiK1LfnP+N+mHxSQwqAHYs0233fBaPFAhz94YRuU6gxu3L7w/78pk
         o3qlv3Us5Ge10D+IVe4ZwRFP6Wt1XJs9jmXSLmlVqQCCiNIZNcAIkOn4FtcWnbLnYRCo
         GKpAWG5wkvpWcdAQ7u1Jut8QlZhQYLnAFjXjsp6NK82IY/Mi1rC2RDzUReUfIRd0iFyn
         h/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rw3ZlxgGIlK+n0HAnKhsvEmsMU3R5cAn/CwZ2JWWhG4=;
        b=nwQ9lHzylyXp3XnqtQC91CHX8q6P6ogY0dZF4/sle4fhQg5MDMKG0EhtpIpPesQLD4
         YYlZUObrXdpiQhX5Y1zjtqQFrVvYbsHqdmiZBo6yOwb2Rcxd47OSvmskYcXIqng8/Eys
         0eo/ynqf9nAQOQQfeoT9nw37tcNgKXxfaKZC7y3FJ7eP+tu4veg7IKQFDIv1YEGhEMSJ
         gOyeGRgHwVmwguZLK7JQkqjbp04Q6SqBfxSKq6ZIW8Nf+7gyY77C8LS/TGQS7Z8DRhn1
         7Ls7pSDzs1PUZvGwkU++/fzTVgB/g7UkS8OGKxwXbjUw4/ApU4M39GUL7Yw09OdueD8O
         BQ+w==
X-Gm-Message-State: APjAAAXWNFG60jyJ8aW4hQE1cxdi5bsd6uxJZMhWREGp+mbbvZFWWzxc
        /tKzN7qiRDMKUmLDgVyqH3A=
X-Google-Smtp-Source: APXvYqzqLCpHOCjA/B41dTkGeqI8xn4qIc6C7vCcbLfRSxUJDQ3GEP1X23zoT22+OaG1es1zzOO5/w==
X-Received: by 2002:a05:620a:7cc:: with SMTP id 12mr42022383qkb.64.1567629138024;
        Wed, 04 Sep 2019 13:32:18 -0700 (PDT)
Received: from localhost.localdomain (179-193-232-238.user3g.veloxzone.com.br. [179.193.232.238])
        by smtp.gmail.com with ESMTPSA id 21sm54602qkj.11.2019.09.04.13.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 13:32:17 -0700 (PDT)
From:   Julio Faracco <jcfaracco@gmail.com>
To:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     elder@kernel.org, johan@kernel.org, lkcamp@lists.libreplanetbr.org
Subject: [PATCH] staging: greybus: Adding missing brackets into if..else block.
Date:   Wed,  4 Sep 2019 20:32:09 +0000
Message-Id: <20190904203209.8669-1-jcfaracco@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside a block of if..else conditional, else structure does not contain
brackets. This is not following regular policies of good coding style.
All parts of this conditional blocks should respect brackets inclusion.

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
 drivers/staging/greybus/tools/loopback_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
index ba6f905f2..d46721502 100644
--- a/drivers/staging/greybus/tools/loopback_test.c
+++ b/drivers/staging/greybus/tools/loopback_test.c
@@ -801,8 +801,9 @@ static void prepare_devices(struct loopback_test *t)
 			write_sysfs_val(t->devices[i].sysfs_entry,
 					"outstanding_operations_max",
 					t->async_outstanding_operations);
-		} else
+		} else {
 			write_sysfs_val(t->devices[i].sysfs_entry, "async", 0);
+		}
 	}
 }
 
-- 
2.20.1

