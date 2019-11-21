Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B2BC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD20D206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvQfFQPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKUXmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:42:05 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:46746 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKUXmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:42:00 -0500
Received: by mail-wr1-f43.google.com with SMTP id z7so3091902wrl.13;
        Thu, 21 Nov 2019 15:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QL2Ppbpy+C6cbbH9vkX+SCbAPApwn61sXCHXMSXaHsU=;
        b=GvQfFQPitikiPhXK4xeeqPLjXgCYlkc2PIcMnzqDiCc4t/8HudKSKvK53QD9vlvJX4
         qq5mWXKMdQkj3ZYwpG7KXk+iebXzilK/iCWjBlBS2zFqAhWdiFKvzYemDYJmNhV2dVL3
         e79IletC/sfg2J5vhfqAMH/X95BgWTM5+zabqymJ/oE5QlFQ94JpBO7XlazwRiUC/a0c
         FvHxzMcwx/Pkxw671oWo5HWPPxv/jJ+eVqNm/LOckT8Htrx3t5D7/wdC0ZLUYGLTnAie
         9BMMprqQUcLp7xb+FJDKcl6ngvHDQ1uXo2HqIHdEQM5/e7RwHBRD2obAgPUUKo6cghqP
         1hDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QL2Ppbpy+C6cbbH9vkX+SCbAPApwn61sXCHXMSXaHsU=;
        b=NHa9D3K6nlaoW/Be63OvqwclNin3TsRBlSJbaUMERt3aEbuf2sQJHN6b3ZnFlIav/y
         PLKZid59VsZGvlVi2ajxOiKmisEiOYgHelFcyL1vg8birI6ACR3FiZZKOS4F0mAd6VWQ
         VhzIZ70Bs0kuyJ3FCn+Ex8x2tOHnipsczWMVAh1e2GFmt1Mmc7YK5MfgK53PpnErIcut
         rkSW6DoxxYQJHE+Q1NfmccrZfRRiH3seAhuDgPjFlKrfKMBC54SZQAXf+kj74HQakDs0
         cqVM0nAgfGNLVMLE9luyZimw0GXgnr0T0g+hm4u/BvXAfg43q4/CMc4UlCg1LQmgsrAe
         d8ug==
X-Gm-Message-State: APjAAAVin5LIgFxFpcJstYNxwe4y0kv6USih9WruXI5sHbQGTW5q9R7c
        ukDW4i84E6VSILNUoNqrFR8=
X-Google-Smtp-Source: APXvYqwdMW6UIKE+YK5Ht7bMAytnQ7BdNOL8FrYL4lbxR3krsQs5PNpPmXOykJCO/V/XUJG+n/+Bbg==
X-Received: by 2002:a5d:4645:: with SMTP id j5mr14894019wrs.329.1574379717345;
        Thu, 21 Nov 2019 15:41:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:5015:4c4c:42e9:e517])
        by smtp.gmail.com with ESMTPSA id l10sm5894420wrg.90.2019.11.21.15.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Nov 2019 15:41:56 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net, will@kernel.org, paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 4/7] docs/memory-barriers.txt/kokr: Update I/O section to be clearer about CPU vs thread
Date:   Fri, 22 Nov 2019 00:41:22 +0100
Message-Id: <20191121234125.28032-5-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191121234125.28032-1-sj38.park@gmail.com>
References: <20191121234125.28032-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate this commit to Korean:

  9726840d9cf0 ("docs/memory-barriers.txt: Update I/O section to be clearer about CPU vs thread")

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 .../translations/ko_KR/memory-barriers.txt    | 56 +++++++++++--------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 1b9bfe54b3a5..a8d26df9360b 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -2485,27 +2485,34 @@ I/O 액세스를 통한 주변장치와의 통신은 아키텍쳐와 기기에 
 	(예: ioremap() 으로 반환되는 것) 의 순서 보장은 다음과 같습니다:
 
 	1. 같은 주변장치로의 모든 readX() 와 writeX() 액세스는 각자에 대해
-	   순서지어집니다.  예를 들어, CPU 의 특정 디바이스로의 MMIO 레지스터
-	   쓰기는 프로그램 순서대로 도착할 것이 보장됩니다.
-
-	2. CPU 에 의한 특정 주변장치로의 writeX() 는 모든 앞선 CPU 의 메모리
-	   쓰기가 완료되기를 먼저 기다립니다.  예를 들어, dma_alloc_coherent()
-	   를 통해 할당된 전송용 DMA 버퍼로의 CPU 의 쓰기는 이 전송을
-	   시작시키기 위해 CPU 가 MMIO 컨트롤 레지스터에 쓰기를 할 때 DMA
-	   엔진에 보일 것이 보장됩니다.
-
-	3. CPU 에 의한 주변장치로의 readX() 는 모든 뒤따르는 CPU 의 메모리
-	   읽기가 시작되기 전에 완료됩니다.  예를 들어, dma_alloc_coherent() 를
-	   통해 할당된 수신용 DMA 버퍼로부터의 CPU 의 읽기는 이 DMA 수신의
-	   완료를 표시하는 DMA 엔진의 MMIO 상태 레지스터 읽기 후에는 오염된
-	   데이터를 읽지 않을 것이 보장됩니다.
-
-	4. CPU 에 의한 주변장치로의 readX() 는 모든 뒤따르는 delay() 루프가
-	   수행을 시작하기 전에 완료됩니다.  예를 들어, CPU 의 특정
+	   순서지어집니다.  이는 같은 CPU 쓰레드에 의한 특정 디바이스로의 MMIO
+	   레지스터 액세스가 프로그램 순서대로 도착할 것을 보장합니다.
+
+	2. 한 스핀락을 잡은 CPU 쓰레드에 의한 writeX() 는 같은 스핀락을 나중에
+	   잡은 다른 CPU 쓰레드에 의해 같은 주변장치를 향해 호출된 writeX()
+	   앞으로 순서지어집니다.  이는 스핀락을 잡은 채 특정 디바이스를 향해
+	   호출된 MMIO 레지스터 쓰기는 해당 락의 획득에 일관적인 순서로 도달할
+	   것을 보장합니다.
+
+	3. 특정 주변장치를 향한 특정 CPU 쓰레드의 writeX() 는 먼저 해당
+	   쓰레드로 전파되는, 또는 해당 쓰레드에 의해 요청된 모든 앞선 메모리
+	   쓰기가 완료되기 전까지 먼저 기다립니다.  이는 dma_alloc_coherent()
+	   를 통해 할당된 전송용 DMA 버퍼로의 해당 CPU 의 쓰기가 이 CPU 가 이
+	   전송을 시작시키기 위해 MMIO 컨트롤 레지스터에 쓰기를 할 때 DMA
+	   엔진에 보여질 것을 보장합니다.
+
+	4. 특정 CPU 쓰레드에 의한 주변장치로의 readX() 는 같은 쓰레드에 의한
+	   모든 뒤따르는 메모리 읽기가 시작되기 전에 완료됩니다.  이는
+	   dma_alloc_coherent() 를 통해 할당된 수신용 DMA 버퍼로부터의 CPU 의
+	   읽기는 이 DMA 수신의 완료를 표시하는 DMA 엔진의 MMIO 상태 레지스터
+	   읽기 후에는 오염된 데이터를 읽지 않을 것을 보장합니다.
+
+	5. CPU 에 의한 주변장치로의 readX() 는 모든 뒤따르는 delay() 루프가
+	   수행을 시작하기 전에 완료됩니다.  이는 CPU 의 특정
 	   주변장치로의 두개의 MMIO 레지스터 쓰기가 행해지는데 첫번째 쓰기가
 	   readX() 를 통해 곧바로 읽어졌고 이어 두번째 writeX() 전에 udelay(1)
-	   이 호출되었다면 이 두개의 쓰기는 최소 1us 의 간격을 두고 행해질 것이
-	   보장됩니다:
+	   이 호출되었다면 이 두개의 쓰기는 최소 1us 의 간격을 두고 행해질 것을
+	   보장합니다:
 
 		writel(42, DEVICE_REGISTER_0); // 디바이스에 도착함...
 		readl(DEVICE_REGISTER_0);
@@ -2520,9 +2527,9 @@ I/O 액세스를 통한 주변장치와의 통신은 아키텍쳐와 기기에 
 
 	이것들은 readX() 와 writeX() 랑 비슷하지만, 더 완화된 메모리 순서
 	보장을 제공합니다.  구체적으로, 이것들은 일반적 메모리 액세스나 delay()
-	루프 (예:앞의 2-4 항목) 에 대해 순서를 보장하지 않습니다만 디폴트 I/O
-	기능으로 매핑된 __iomem 포인터에 대해 동작할 때 같은 주변장치로의
-	액세스에는 순서가 맞춰질 것이 보장됩니다.
+	루프 (예:앞의 2-5 항목) 에 대해 순서를 보장하지 않습니다만 디폴트 I/O
+	기능으로 매핑된 __iomem 포인터에 대해 동작할 때, 같은 CPU 쓰레드에 의해
+	같은 주변장치로의 액세스에는 순서가 맞춰질 것이 보장됩니다.
 
  (*) readsX(), writesX():
 
@@ -2558,8 +2565,9 @@ I/O 액세스를 통한 주변장치와의 통신은 아키텍쳐와 기기에 
 	이것들은 inX()/outX() 나 readX()/writeX() 처럼 실제로 수행하는 액세스의
 	종류에 따라 적절하게 수행될 것입니다.
 
-이 모든 액세스 함수들은 아랫단의 주변장치가 little-endian 이라 가정하며, 따라서
-big-endian 아키텍쳐에서는 byte-swapping 오퍼레이션을 수행합니다.
+String 액세스 함수 (insX(), outsX(), readsX() 그리고 writesX()) 의 예외를
+제외하고는, 앞의 모든 것이 아랫단의 주변장치가 little-endian 이라 가정하며,
+따라서 big-endian 아키텍쳐에서는 byte-swapping 오퍼레이션을 수행합니다.
 
 
 ===================================
-- 
2.17.2

