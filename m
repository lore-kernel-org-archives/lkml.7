Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8756DC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568ED20674
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="mpjePlJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfLSU33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:29:29 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:36256 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfLSU32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:29:28 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 47f3Q01hBQz9vZ2N
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 20:29:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M47UayY1okcF for <linux-kernel@vger.kernel.org>;
        Thu, 19 Dec 2019 14:29:28 -0600 (CST)
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com [209.85.161.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 47f3Q00g9gz9vZ1d
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 14:29:28 -0600 (CST)
Received: by mail-yw1-f69.google.com with SMTP id r189so4914413ywf.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 12:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ku3WkybWuYyol2wbhhnHdNuHA1Lkwj9hheWjbC7/44=;
        b=mpjePlJ9nPLL6pMoZa3NMUzvBxSAij80+5mlgV8hUi54WoJWZLHaB1FG/vLn1EdBgz
         OTQFltozEQxjVG/v/d+TIY4qH29YAaXEY0GdZ2Q4m5H8GdzRVH9Nn8cpJbJQ0qogLXwe
         fRlU+87eCFwqfnjW5fD0j+z3TEeAPkk4uj8j5XOKPhm+A4NS/OFNixKQ9/vIVigktPov
         GqCbDQtgf/KX+CaXiwU/2SxPjeuyl6JKhlV7VAufsEeGYAlMDiMuUVUGGzrMgCuHPMFr
         cvLxMHOQElgXGKMUieRTJXPAD8XZ1CXyKvIrNR7SHpIKHTB8LrehERXROw5KIOlGtLpz
         dcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ku3WkybWuYyol2wbhhnHdNuHA1Lkwj9hheWjbC7/44=;
        b=auZgii8Y++5dFW+SDBO+N1ejCibylyUij4fvZmv1N9jKQ0W35UyjER2SGxZhWWU22x
         i9f1VxSIFqbL4ZpWxcCh5KYLR1SPbTBHf0V0u/pxGwl6vH5Rppxm2qyvz+NQlw2jEZMv
         sEUB9aH7JlFbSWcFxZIEmo5wxjj4W1+7eSWfwFuVg5F4W+4dJ2xX92y3dZ+D3EQfJTEW
         iJfbV9gzk5y2zLEwSbdT0DVDwf0IpoBokI/vzNrrVGLQz7riTyiXe6ia1+QsexhjbjNl
         19KoV8bV+DYo8qj2jmjx7uMtwFW0xLQRMlES1q5df7X8aeyBJi+KZqS+LHHcVAZ9oeik
         Om8g==
X-Gm-Message-State: APjAAAVY81DmeNkjwrGKKwoexo+4N7NBfI2GaYmWCjg6iYSPK5BxsgMW
        /hhJVZBoYb0FkaTdVOTCztlX4O1GcB7hZAXrVE0+Zfw1ImMeZxMl9F4u82badNN98C82cVFVQmb
        IiId2KMjh6Rq7QkRK7bUP0f2VwCFV
X-Received: by 2002:a81:3a0b:: with SMTP id h11mr7820043ywa.217.1576787367604;
        Thu, 19 Dec 2019 12:29:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/xa8tB8qV6esn82AbEH4SgpvqcB9j6GjxQw3qqRE8q4mJtWFsv0+QkciV590Lu76NnF8KkA==
X-Received: by 2002:a81:3a0b:: with SMTP id h11mr7820030ywa.217.1576787367403;
        Thu, 19 Dec 2019 12:29:27 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id w128sm2827126ywf.72.2019.12.19.12.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 12:29:27 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: media/saa7146: fix incorrect assertion in saa7146_buffer_finish
Date:   Thu, 19 Dec 2019 14:29:24 -0600
Message-Id: <20191219202924.24194-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In saa7146_buffer_finish, the code for q->curr to be NULL is
already present and asserting for NULL is unnecessary. This patch
elimiates such a check.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/media/common/saa7146/saa7146_fops.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/common/saa7146/saa7146_fops.c b/drivers/media/common/saa7146/saa7146_fops.c
index aabb830e7468..d7e83b55ddca 100644
--- a/drivers/media/common/saa7146/saa7146_fops.c
+++ b/drivers/media/common/saa7146/saa7146_fops.c
@@ -97,8 +97,6 @@ void saa7146_buffer_finish(struct saa7146_dev *dev,
 	DEB_EE("dev:%p, dmaq:%p, state:%d\n", dev, q, state);
 	DEB_EE("q->curr:%p\n", q->curr);
 
-	BUG_ON(!q->curr);
-
 	/* finish current buffer */
 	if (NULL == q->curr) {
 		DEB_D("aiii. no current buffer\n");
-- 
2.20.1

