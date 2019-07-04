Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2992FC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A09E2189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfGDM53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:57:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45889 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfGDM50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:57:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so6519434wre.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 05:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kZ8O9igfNu2jDct8fmpQWqIo3ibbuDI4N9jrgAm5kO0=;
        b=CxY0Y5JWPQHNIcxIAWi/VNOXRSsPZxOxZfFdflFrErMrJJsNCsN+WJqlhdB2CtbWOA
         gzQdPn8e6dsNWc59EFzJUcLiPDbR3C1AZ2pMaqBZHM5odLC0Ev2C3+fovL+4MyMhzw3g
         bpsO0g81fywBy3QD6ittzPOCzeE1AUlYghO0QRsSpYbTWgxO/fHgTdubpXg6Wqyq+IrU
         KUrpfwG9QHqg5iBMOlPxFoj6mgW+HmZhkIhyVm+A4v88vxFKEvQNgJr2bHz7xMl6yvdp
         gCZrajaD4AvDDeqtffTNLf4qGHvrUqnXe67Fnltz4P8KkiFPX6A/3MLGEb/E4VX1B9A2
         MSVw==
X-Gm-Message-State: APjAAAXL5CxTl8ox/SGDICApivN4fpxpzOJ5yCgnGxe2YaAWXHo+U5hu
        OqKmjgTPUeNbfsl48yNKER666p5x
X-Google-Smtp-Source: APXvYqwpJnzCn5prCMUYIhFMheW8aSnygRt0kL5A7Ld7D82m8n+d7HK+a1iZfW4aQbOf2Jcg3o7zLw==
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr27864346wrk.229.1562245044728;
        Thu, 04 Jul 2019 05:57:24 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id a64sm9819712wmf.1.2019.07.04.05.57.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 05:57:24 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] torture: remove exporting of internal functions
Date:   Thu,  4 Jul 2019 15:57:19 +0300
Message-Id: <20190704125719.31290-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions torture_onoff_cleanup, torture_shuffle_cleanup are declared
as static and marked as EXPORT_SYMBOL. It's a bit confusing for an
internal function to be exported. The area of visibility for such function
is its .c file and all other modules. Other *.c files of the same module
can't use it, despite all other modules can. Relying on the fact that these
are the internal functions and they are not a crucial part of the API, the
patch removes the EXPORT_SYMBOL marking of the torture_onoff_cleanup and
torture_shuffle_cleanup. The patch complements commit cc47ae083026
("rcutorture: Abstract torture-test cleanup").

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 kernel/torture.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 17b2be9bde12..fbbcc4abe426 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -263,7 +263,6 @@ static void torture_onoff_cleanup(void)
 	onoff_task = NULL;
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
 }
-EXPORT_SYMBOL_GPL(torture_onoff_cleanup);
 
 /*
  * Print online/offline testing statistics.
@@ -449,7 +448,6 @@ static void torture_shuffle_cleanup(void)
 	}
 	shuffler_task = NULL;
 }
-EXPORT_SYMBOL_GPL(torture_shuffle_cleanup);
 
 /*
  * Variables for auto-shutdown.  This allows "lights out" torture runs
-- 
2.21.0

