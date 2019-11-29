Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CF5C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 18:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9955A2158A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 18:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8dnCrIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfK2S3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 13:29:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34348 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfK2S3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 13:29:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so36258410wrr.1;
        Fri, 29 Nov 2019 10:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C3KfNuH6ESWMwxOrZCFeiuYHPVmRWYheHmjuP/hADcs=;
        b=B8dnCrICSGnebT+nshVDS2X98zLN+QT67/1/fzWL5YpENExBLRImOqMeHUPe+7s0d3
         PFT/ZwL9PlVzUV5z52Y6Jm8/1j7wGUNXAzoPJhXazKoLciuULMn/EgN29ghGA1wCW9P9
         T0y8LOqfUO71sVz23Sw/RSd+YcHg1JpF4k17Z9rbCpylR/NOPoaVObbPHuiNBYooDmOZ
         hvbzfa8bZOFf1Q+6dw0e8QmwDM8M0QVtNCspDJAHGCVxjJWkcA5H3vvxf4njDb4BId+7
         e8U0ggVbw+w5iQqpCa864gcYB86M1kAuubvPD9mqiHafHadKtXGRgqfsWeyh+K0i+Q28
         vnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C3KfNuH6ESWMwxOrZCFeiuYHPVmRWYheHmjuP/hADcs=;
        b=Vs8GFpLuYswrY/nRVwkfMmCaqaxRJ7Iq23bE4a9enGQgR9ExNVG2m8/Cx/kM35q1Yx
         uLQuDjGqnLXiwA2Qem2iPyDFiW7844wJoCdoTCW8WEAqR6N8Ng1QJLCaAtGUDEJdZTJt
         VYg7e+blWZr2ReKxsM2ujcCM0OCmU1PWNNxX3FvnUZMUvtUQ+Br0vd4cSIyKG8izFGq7
         PNoK9MK+xUvBWpH9RuVFFnga4XMvFZ63e70ZQQzdgKJPcvMDJ+qJ8f1WCycRfh+HExWH
         71z9J1RPKJaTjtbYqmIebINo/OXGcwM3dmosvG8wr5f16P645H7lbiqMfEPOlhjAOU58
         QDKg==
X-Gm-Message-State: APjAAAXECub0Z4sQNFp/r9tnghhEaZzpv3bATOSUtR6YkhxPFuOf3BGh
        vdE1MSi6SFmp6jP1xA9bzyU=
X-Google-Smtp-Source: APXvYqyANB5u8HLuLr3Q6/X8nByzLLTf6SStMFESB7d63DSXsxbCxhYoAdVJ5Fh3oPW9hHrVw6KA1w==
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr4895976wrt.339.1575052147438;
        Fri, 29 Nov 2019 10:29:07 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:5015:4c4c:42e9:e517])
        by smtp.gmail.com with ESMTPSA id c9sm13871296wmb.42.2019.11.29.10.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Nov 2019 10:29:06 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     corbet@lwn.net, paulmck@kernel.org
Cc:     will@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH] docs/memory-barriers.txt.kokr: Minor wordsmith
Date:   Fri, 29 Nov 2019 19:28:23 +0100
Message-Id: <20191129182823.8710-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191127142707.GB2889@paulmck-ThinkPad-P72>
References: <20191127142707.GB2889@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Paul, I got a review from another Korean hacker Yunjae.
 From the review, I got not only 'Reviewed-by:' tags, but also found a
few minor nits.  So I made a second version of the patchset but just
realized that the first version has already sent to Linus.  I therefore
send only the nit fixes as another patch.

----------------------------- >8 ----------------------------------------
docs/memory-barriers.txt.kokr: Minor wordsmith

This commit fixes a couple of minor nits in the Korean translation of
'memory-barriers.txt'.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Yunjae Lee <lyj7694@gmail.com>
---
 Documentation/translations/ko_KR/memory-barriers.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index a8d26df9360b..29e76a73ae59 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -2413,7 +2413,7 @@ _않습니다_.
 알고 있는, - inb() 나 writel() 과 같은 - 적절한 액세스 루틴을 통해 이루어져야만
 합니다.  이것들은 대부분의 경우에는 명시적 메모리 배리어 와 함께 사용될 필요가
 없습니다만, 완화된 메모리 액세스 속성으로 I/O 메모리 윈도우로의 참조를 위해
-액세스 함수가 사용된다면 순서를 강제하기 위해 _madatory_ 메모리 배리어가
+액세스 함수가 사용된다면 순서를 강제하기 위해 _mandatory_ 메모리 배리어가
 필요합니다.
 
 더 많은 정보를 위해선 Documentation/driver-api/device-io.rst 를 참고하십시오.
@@ -2528,7 +2528,7 @@ I/O 액세스를 통한 주변장치와의 통신은 아키텍쳐와 기기에 
 	이것들은 readX() 와 writeX() 랑 비슷하지만, 더 완화된 메모리 순서
 	보장을 제공합니다.  구체적으로, 이것들은 일반적 메모리 액세스나 delay()
 	루프 (예:앞의 2-5 항목) 에 대해 순서를 보장하지 않습니다만 디폴트 I/O
-	기능으로 매핑된 __iomem 포인터에 대해 동작할 때, 같은 CPU 쓰레드에 의해
+	기능으로 매핑된 __iomem 포인터에 대해 동작할 때, 같은 CPU 쓰레드에 의한
 	같은 주변장치로의 액세스에는 순서가 맞춰질 것이 보장됩니다.
 
  (*) readsX(), writesX():
-- 
2.17.2

