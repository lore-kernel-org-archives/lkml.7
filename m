Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79752C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522AA217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560445069;
	bh=8JHFDhli8ydLD7JaFUYsJVhDqU7muNvB8wYx8ebJZjo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=mPCzWK9l3A2aqpjpAylVZtVnNUyAR52qR86Rm9umtSlKH+ePl9340NwRmJmk+YPpi
	 JqCuLpGtjxXxwsyTGyoiUbGg748PZMcL5RaN9tC6bXy4f+BHzQwRjokhEulTjCkQAo
	 odXowtqfjpp3eD6GxSbNkeOQsN1F62o2ULP49fHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393238AbfFMQ5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:57:47 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:50295 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729920AbfFMA4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 20:56:55 -0400
Received: by mail-it1-f193.google.com with SMTP id j194so14052275ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 17:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDoai9FCo61ADmdBZ301WDQL6Wz5//hlF5tMXgOfZE0=;
        b=X/LiudSWZp9Iz25IabKtdWZDyYAscHnEUIFCfxzHs9cUGv1j9qo6qqxWbJfs/+G08i
         Sq7r3p3PIqX0Y2Eos/c9kZaZYXo1fBG+uQw9FUSZVtdAt6vpKKOs1yXFsbp/Kcap4dg7
         eAI0nH2TLtBVVYwfhxxYXwWVepai9QC2cqdBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDoai9FCo61ADmdBZ301WDQL6Wz5//hlF5tMXgOfZE0=;
        b=MthKC0kJ/kCfnitESOWi1XeQuHSms3bLOH2bPO6jcqHdhzDN9i8q3W09Iogi4ktP5X
         iOuHAvJjCeW3cgGGb72QscthzvEgpYJID4RV3xXtlTHMub4Asun73vzqtEMxRAnPXDMw
         U/h2PsCgOd9cmdXygbBULjQDI4LawknZyOO/zbcGssq7ewzEZ1nbDr1D52y3weTtab1W
         q5cY9YbaluQr2bwJGFxQn6rKyYfffX4KwLBo/26W6La2tJFZ7HENLIprRtNEEP91tExo
         OzlRxLggC6sqeQhYdrU1yCySjQv4HkLchODrGmlSw2ZtsqZH21wmB26YUwybCnK3Ky1D
         ySZQ==
X-Gm-Message-State: APjAAAVE/B0+P+9O4BmaI/+hHKVmBG6MM+54d0c9L8TJmZ+376Hy6M6y
        SR8AyMyzBBj2j8UIO+rsE/x7Fuz8zs8=
X-Google-Smtp-Source: APXvYqxWUG4rZuOF4BB6tuA67BAXPogoGWe0YzMR4tUPqlrcc1Ht7bmCaKoHBSC2CaY/YVkfC9LRFw==
X-Received: by 2002:a24:4084:: with SMTP id n126mr1693248ita.16.1560387414768;
        Wed, 12 Jun 2019 17:56:54 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c2sm551310iok.53.2019.06.12.17.56.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 17:56:54 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: videodev2.h: Fix shifting signed 32-bit value by 31 bits problem
Date:   Wed, 12 Jun 2019 18:56:52 -0600
Message-Id: <20190613005652.7423-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix v4l2_fourcc define to use "U" cast to avoid shifting signed 32-bit
value by 31 bits problem. This isn't a problem for kernel builds with
gcc.

This could be problem since this header is part of public API which
could be included for builds using compilers that don't handle this
condition safely resulting in undefined behavior.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 include/uapi/linux/videodev2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 1050a75fb7ef..9d9705ceda76 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -80,7 +80,7 @@
 /*  Four-character-code (FOURCC) */
 #define v4l2_fourcc(a, b, c, d)\
 	((__u32)(a) | ((__u32)(b) << 8) | ((__u32)(c) << 16) | ((__u32)(d) << 24))
-#define v4l2_fourcc_be(a, b, c, d)	(v4l2_fourcc(a, b, c, d) | (1 << 31))
+#define v4l2_fourcc_be(a, b, c, d)	(v4l2_fourcc(a, b, c, d) | (1U << 31))
 
 /*
  *	E N U M S
-- 
2.17.1

