Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85930C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5259120578
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYb0F+L8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437803AbfIWOzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:55:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40880 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfIWOzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:55:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id v38so13133735edm.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SlUYkwpj6yu5lfNnzsV0ggIvbULgs9iiQHnWd1Afxa0=;
        b=HYb0F+L8Uu70AC2b7u/vm9E/UTCUBNxWVvqGtZojbim+5mMU74lFioo671pSDz9P2L
         W+nJL0RP82Xr2FDuvZimleCdEWnExfBYatWkPRtrlhOCSTl8VeZkgOlu/qwF7YoROd5D
         P9uqdhVdBlNRlUmMX0mjCx2pQyHbkZgdqDq7bj/9V4K8TxOUB6ReswkEPWhSZ6lhY7pp
         8NRA9YLsV0jEazqSmB89y3bzvAFp+0X8fxwsWucNCxNcSFOitHYQKRW9yl8BiWVv79QH
         EM9Tw4iWZoWXUqI5Q2GpWkV2CYg0GtBk1eha7V2ZCTavuhulrKLfSpTn4HX941Scutf2
         ZyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SlUYkwpj6yu5lfNnzsV0ggIvbULgs9iiQHnWd1Afxa0=;
        b=GphANIpjDahxXEpoJO3CD0B1OhFoMm/2zRJtgGWCeR3Q+Y4nzCzrpP4RrKkH4OCrp6
         LKcUUPpY/Ex7bylkUGH6XEvRaqjSZ+2BHGX+dAupCCIau3nqZ+Mz8rYMHJWry6r1cgpV
         wV1EQ2Qk8KAIEHMxwrKlXmUKvK78mPIVaq/Ls+b4PkRtDdpriTndxNZWvD0tAeKkVq8C
         x+eHIhP9jrQpmVskqGYdum9ABReWWhmUW4iEY1svOR7E8lEAcbY70sU/F45ewHwhvHzZ
         27+yJXxw2+WNwIXWa+XBe9Ao1RDAG7ov+m7bTMsE+2kAe4MjpvSQAWW7TvYrUW3UkvWZ
         4FaQ==
X-Gm-Message-State: APjAAAU8GqxNz5h5fhLchnaZFCYHB4k8XXV2sw41I7LoAvluNmfGJQ7B
        B/AmPYtpVrkCwRIWBvlHtRE=
X-Google-Smtp-Source: APXvYqxdsHr1OP7HdBc78VihnThRuQ0b2LN5hfAfeWkJmkwSi8pr/cq+zIEZpMtI27Sa3oIeCrc5cg==
X-Received: by 2002:a17:906:5c16:: with SMTP id e22mr256576ejq.105.1569250498627;
        Mon, 23 Sep 2019 07:54:58 -0700 (PDT)
Received: from linux.fritz.box (200116b864096d0082c6903ef0ca246b.dip.versatel-1u1.de. [2001:16b8:6409:6d00:82c6:903e:f0ca:246b])
        by smtp.googlemail.com with ESMTPSA id n6sm2418866edr.27.2019.09.23.07.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 07:54:58 -0700 (PDT)
From:   "Christopher N. Hesse" <raymanfx@gmail.com>
Cc:     penguin-kernel@I-love.SAKURA.ne.jp,
        "Christopher N. Hesse" <raymanfx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: android: ashmem: Fix zero area size return code
Date:   Mon, 23 Sep 2019 16:54:51 +0200
Message-Id: <20190923145451.13341-1-raymanfx@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous inline comment stated that a size of zero would make the
ashmem_read_iter function return EOF, but it returned 0 instead.

Looking at other functions, such as ashmem_llseek or ashmem_mmap, it
appears the convention is to return -EINVAL if the region size is unset or
zero.

To be consistent with the checks, I changed the one occurrence that used
the ! operator to compare the size to check against equal-to-zero instead.

Signed-off-by: Christopher N. Hesse <raymanfx@gmail.com>
---
 drivers/staging/android/ashmem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 74d497d39c5a..6af8130db0d7 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -291,9 +291,11 @@ static ssize_t ashmem_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	mutex_lock(&ashmem_mutex);
 
-	/* If size is not set, or set to 0, always return EOF. */
-	if (asma->size == 0)
+	/* If size is not set, or set to 0, always return EINVAL. */
+	if (asma->size == 0) {
+		ret = -EINVAL;
 		goto out_unlock;
+	}
 
 	if (!asma->file) {
 		ret = -EBADF;
@@ -359,7 +361,7 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 	mutex_lock(&ashmem_mutex);
 
 	/* user needs to SET_SIZE before mapping */
-	if (!asma->size) {
+	if (asma->size == 0) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.23.0

