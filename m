Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6743BCA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3974920659
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aUeePDR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfKDVq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:46:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33544 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbfKDVq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:46:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id u23so12404048pgo.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 13:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=RKxr/z5Z+XCc3j/WLz6LF458INM7dnLvQiGuRgdea6I=;
        b=aUeePDR4M3K0hR7Q/iY4hBk2QT31NbRREwi99q6z/u/H7pYqS80kMgv8cfnvtshvAv
         VkJMotphwEiRP9kA7IZ4WieHSR5kijvuyO7V0Wq4QIfiPjshpuOvK8o2ZrydNAwfQdfE
         OinYsra052NUoIMic9pUp++YgcScLmujdziWX1C+Al6yNoWfEZ4SKAmpuwGIyP95/E2O
         vsMq9BacQ3oZyG9cCe2xyk2VvnpF/cqSuIZydpVueZTsqCkDC0jVqWq/MNxmHWgtxQ1x
         oXk0ys7HrLlD+ZF3R3qe3p7Bsdyvw+gNuuzAEUdV+2SGbShHAqHGkM/vkCF6XzCa+mlL
         Ndkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=RKxr/z5Z+XCc3j/WLz6LF458INM7dnLvQiGuRgdea6I=;
        b=G1bASubdytdtHuOdjuc4ifw0c3uOZbZ6yQU7Cum0dfmInYU7tNaFXqCa6lY5h7lno3
         YY3NKHJ6+O+0LFJLqhD1507++CifGhZu43zOwSSsuzSG1id8kZ4/RSzZU4eWXdCk9Au9
         M732gmuo00R6mN81G/UIe+7GZb2aceala755o2UPoa/xL61S7NM4GfHzSnXS3KdbPKhY
         tasNzVD8AK04vbm2am/Rfmy+k0Emo0yT1DTAF96vUaCTtcnG9F2WelHQ2XEGq0ztguYC
         ZIi3yq3n2QZgG7Biq50RascJd0w+EIuHVbaduvij7HwRQRu4ABXvCX69wHKWG3pB97x7
         Z+0g==
X-Gm-Message-State: APjAAAU10XUC8oQdRs9yXdF1KCT72/TXvI5XBR5TQlUCm9Wd5trpuyxA
        GV/+AJ5HXaELLbYwPbzpPIDLwV6boCwEpQ==
X-Google-Smtp-Source: APXvYqwuRMT5lNvuPuITVIvesrzmLt7bbeQv2zTddIBYVppkD8brZ4Ux1AopMTxEtLhaeVJ3FtMRQQ==
X-Received: by 2002:aa7:980c:: with SMTP id e12mr33717564pfl.165.1572903985750;
        Mon, 04 Nov 2019 13:46:25 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id i126sm18547901pfc.29.2019.11.04.13.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 13:46:25 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     io-uring@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] MAINTAINERS: update io_uring entry
Message-ID: <efa17e7d-b33a-c032-1a90-c150d1632ab8@kernel.dk>
Date:   Mon, 4 Nov 2019 14:46:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have a list that's appropriate for both kernel and userspace
discussions on io_uring usage and development, add that to the
MAINTAINERS entry.

Also add the io-wq files.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/MAINTAINERS b/MAINTAINERS
index c6c34d04ce95..7afb25707098 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8562,12 +8562,13 @@ F:	include/linux/iova.h
 
 IO_URING
 M:	Jens Axboe <axboe@kernel.dk>
-L:	linux-block@vger.kernel.org
-L:	linux-fsdevel@vger.kernel.org
+L:	io-uring@vger.kernel.org
 T:	git git://git.kernel.dk/linux-block
 T:	git git://git.kernel.dk/liburing
 S:	Maintained
 F:	fs/io_uring.c
+F:	fs/io-wq.c
+F:	fs/io-wq.h
 F:	include/uapi/linux/io_uring.h
 
 IPMI SUBSYSTEM

-- 
Jens Axboe

