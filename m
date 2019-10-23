Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD3ACA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873AE21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="K0hKL19q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfJWRSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:18:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35713 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfJWRSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:18:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id v6so3436759wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 10:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=48XDzmeFiM9yOQfqbOoh8NKzWofKTXbdxGBYN62jtKs=;
        b=K0hKL19qHw3J5tEam6YX1YovarKMfA3S6y4cNF77riVmCADwA/pXcYvmY0AeRHQ++Y
         jIRM4zjpusmWcKoGcs1aG+IZEIaqeUcXqXbxWbxyqAXzTYi8q2iFgrUS+HRVCAY45cwA
         OM+2clMI8peNxrDQUz6R18LprsOW4U7o1S9yUo1oU1nnr5EyvGHDwuvvgr2S70OeAlee
         nqzFU5+Qt9bYt1TvxhXxJjm5enxaXLlnBA+hFq9MOiJdtN6VSULqfbftc8LjaUPw3WRR
         JnAQXuWP7Es9gpasa98YAoNwV2rjgVR2XwUo9EYnWUVjRYrTdKrEXsNyY71PrfjfwBEU
         PTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=48XDzmeFiM9yOQfqbOoh8NKzWofKTXbdxGBYN62jtKs=;
        b=runqY74oMLv/h+kGhZP7Zfm0PPtPP0NQ+T496nruX9tQkqne8ThL80RuyUm+s++x0v
         Ja/FUSW2TV+sUVThdZbm042SNmn9YnhVHX1PoehGs2pO1KeIYtTYAT14xLBqS8GeoCsk
         mLqwuC1WeggH7k7azwnveAliU6oR4x9aMVatrTYcJZHM63WVyLEs2hLavWzGy4MlURq7
         hF+DD2fKreO8I9rkP0jwt562n7m5bN62GmBsp6bw9zDvhakBBK6sb1pLp4Rv/s+MZDnI
         G1Ut5vKbZ+//t+8GDa8I2CopLNWB3Fai7NAyVgviLu6s1EM3CYR0tbgZIkR/G8I6v4y+
         ah0w==
X-Gm-Message-State: APjAAAWfUYmRBIJ6ImJpx0WRu0rMOxOwb6RYm9/N/Jm/asNkVGm6Sh33
        usXdrBvGCChZZjtdJcC5BhJ26A==
X-Google-Smtp-Source: APXvYqzNDT5y6csWeVLItVHdqJPlxCEQp3G7g/uwZZKeYuvL1K3rIgc2YTkz8U/QH+j0z4bPJx5fmQ==
X-Received: by 2002:a7b:c049:: with SMTP id u9mr931749wmc.12.1571851094909;
        Wed, 23 Oct 2019 10:18:14 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id r65sm21571740wmr.9.2019.10.23.10.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 10:18:14 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Alessio Balsini <balsini@android.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 4.9 4.14] loop: Add LOOP_SET_DIRECT_IO to compat ioctl
Date:   Wed, 23 Oct 2019 18:17:36 +0100
Message-Id: <20191023171736.161697-1-balsini@android.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20190805115309.GJ2349@hirez.programming.kicks-ass.net>
References: <20190805115309.GJ2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fdbe4eeeb1aac219b14f10c0ed31ae5d1123e9b8 ]

Enabling Direct I/O with loop devices helps reducing memory usage by
avoiding double caching.  32 bit applications running on 64 bits systems
are currently not able to request direct I/O because is missing from the
lo_compat_ioctl.

This patch fixes the compatibility issue mentioned above by exporting
LOOP_SET_DIRECT_IO as additional lo_compat_ioctl() entry.
The input argument for this ioctl is a single long converted to a 1-bit
boolean, so compatibility is preserved.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Alessio Balsini <balsini@android.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index da3902ac16c86..8aadd4d0c3a88 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1557,6 +1557,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 		arg = (unsigned long) compat_ptr(arg);
 	case LOOP_SET_FD:
 	case LOOP_CHANGE_FD:
+	case LOOP_SET_DIRECT_IO:
 		err = lo_ioctl(bdev, mode, cmd, arg);
 		break;
 	default:
-- 
2.23.0.866.gb869b98d4c-goog

