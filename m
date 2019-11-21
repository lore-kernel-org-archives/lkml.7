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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22761C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F31206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlgFxYGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKUXmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:42:02 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:42937 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfKUXl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:41:59 -0500
Received: by mail-wr1-f44.google.com with SMTP id a15so6494100wrf.9;
        Thu, 21 Nov 2019 15:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6oeY7DpPshW69+63gKwevMQpm1w/tAqSjCHXI1npb4k=;
        b=nlgFxYGi5Lk776cyRFOvXLUa/SmHYfYYK1ho7lSDHAo7ZcpQPVyuTcn/yyOAati1nE
         WYDXL+zbdavCIz+G3AXQHy1bSUg8th4Rs0tlPzuQYLs7gL5VBLnQbKWoqHlN2ZZTy37x
         O4IF2mJp6SrXPaRi4YAtd+4Sk/HX9i8Cv2q13uxxaqMWZyf791WaWVdnhyGhhjY3XwhU
         0Jko9FZ6LXJXF2W3fQr8Twp0LevRPtm5BZjTRpttKinLjlOhVykB8pCUr+tu+HPsNWtu
         malFEQTB7+qsS0PByeeTACpkKs4kYXiS+05ORH52l12YykF9v6CkHrEyy7zD6j5Egkiy
         YApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6oeY7DpPshW69+63gKwevMQpm1w/tAqSjCHXI1npb4k=;
        b=ibLIJFQ69mcCOSR0ftywG1VnPYLarz2KHx4BBIlX3BbSDXo4jOv+aqFLklo6YXouHF
         yqqLyDtJkRUPAIfe3ktOkQgXfqGu/lYGwDW8ovIrfOXCA5V5ArTxP4e6OTBoRdqMEfh2
         OY3sHinA909Zi4KfDkfJ2hRFbrcmoYjraKI1BsNK8V5urxSNj/mfjESDUtiRX6rT4QVj
         KRKbKwk7X1yqUXrhx/hpR8qljPGvLwybrJE08kptqvVHrUeEVfk0SFc1W2pk2vmDDxJ1
         FNqrVfTzgcOQQL0zFPUoyhYvp/qOHe9J+nMf47Yb0nZKrNghxNV32s1c9FF+zcHl1PQw
         9tJw==
X-Gm-Message-State: APjAAAX8nAdJauvx0FmITfquReQ4z7ERfeBK7bBhX6FUbPL4lZYSQWJr
        2n+CeXC4V7KhWi4GhHHB30LsXvwM
X-Google-Smtp-Source: APXvYqznp7B3fNRzjwpbRHn39cOC2ydrmUsPgTvLlv2Pee+Q9MJLj9BUysAl0myabcV00Xo4gCKmUQ==
X-Received: by 2002:a5d:4c4e:: with SMTP id n14mr15317140wrt.260.1574379715999;
        Thu, 21 Nov 2019 15:41:55 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:5015:4c4c:42e9:e517])
        by smtp.gmail.com with ESMTPSA id l10sm5894420wrg.90.2019.11.21.15.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Nov 2019 15:41:55 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net, will@kernel.org, paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 3/7] docs/memory-barriers.txt/kokr: Fix style, spacing and grammar in I/O section
Date:   Fri, 22 Nov 2019 00:41:21 +0100
Message-Id: <20191121234125.28032-4-sj38.park@gmail.com>
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

  0cde62a46e88 ("docs/memory-barriers.txt: Fix style, spacing and grammar in I/O section")

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 .../translations/ko_KR/memory-barriers.txt    | 112 ++++++++++--------
 1 file changed, 60 insertions(+), 52 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 584bb0bdf2c4..1b9bfe54b3a5 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -2480,75 +2480,83 @@ I/O 액세스를 통한 주변장치와의 통신은 아키텍쳐와 기기에 
 
  (*) readX(), writeX():
 
-     readX() 와 writeX() MMIO 액세스 함수는 접근되는 주변장치로의 포인터를
-     __iomem * 패러미터로 받습니다.  디폴트 I/O 기능으로 매핑되는 포인터 (예:
-     ioremap() 으로 반환되는 것) 의 순서 보장은 다음과 같습니다:
-
-     1. 같은 주변장치로의 모든 readX() 와 writeX() 액세스는 각자에 대해
-	순서지어집니다.  예를 들어, CPU 의 특정 디바이스로의 MMIO 레지스터
-        쓰기는 프로그램 순서대로 도착할 것이 보장됩니다.
-
-     2. CPU 에 의한 특정 주변장치로의 writeX() 는 모든 앞선 CPU 의 메모리
-	쓰기가 완료되기를 먼저 기다립니다.  예를 들어, dma_alloc_coherent() 를
-	통해 할당된 전송용 DMA 버퍼로의 CPU 의 쓰기는 이 전송을 시작시키기 위해
-	CPU 가 MMIO 컨트롤 레지스터에 쓰기를 할 때 DMA 엔진에 보일 것이
-        보장됩니다.
-
-     3. CPU 에 의한 주변장치로의 readX() 는 모든 뒤따르는 CPU 의 메모리
-        읽기가 시작되기 전에 완료됩니다.  예를 들어, dma_alloc_coherent() 를
-        통해 할당된 수신용 DMA 버퍼로부터의 CPU 의 읽기는 이 DMA 수신의 완료를
-        표시하는 DMA 엔진의 MMIO 상태 레지스터 읽기 후에는 오염된 데이터를 읽지
-        않을 것이 보장됩니다.
-
-     4. CPU 에 의한 주변장치로의 readX() 는 모든 뒤따르는 delay() 루프가 수행을
-        시작하기 전에 완료됩니다.  예를 들어, CPU 의 특정 주변장치로의 두개의
-        MMIO 레지스터 쓰기가 행해지는데 첫번째 쓰기가 readX() 를 통해 곧바로
-        읽어졌고 이어 두번째 writeX() 전에 udelay(1) 이 호출되었다면 이 두개의
-        쓰기는 최소 1us 의 간격을 두고 행해질 것이 보장됩니다.
-
-     디폴트가 아닌 기능을 통해 얻어지는 __iomem 포인터 (예: ioremap_wc() 를
-     통해 리턴되는 것) 는 이런 보장사항들 중 다수를 제공하지 않을 수 있습니다.
+	readX() 와 writeX() MMIO 액세스 함수는 접근되는 주변장치로의 포인터를
+	__iomem * 패러미터로 받습니다.  디폴트 I/O 기능으로 매핑되는 포인터
+	(예: ioremap() 으로 반환되는 것) 의 순서 보장은 다음과 같습니다:
+
+	1. 같은 주변장치로의 모든 readX() 와 writeX() 액세스는 각자에 대해
+	   순서지어집니다.  예를 들어, CPU 의 특정 디바이스로의 MMIO 레지스터
+	   쓰기는 프로그램 순서대로 도착할 것이 보장됩니다.
+
+	2. CPU 에 의한 특정 주변장치로의 writeX() 는 모든 앞선 CPU 의 메모리
+	   쓰기가 완료되기를 먼저 기다립니다.  예를 들어, dma_alloc_coherent()
+	   를 통해 할당된 전송용 DMA 버퍼로의 CPU 의 쓰기는 이 전송을
+	   시작시키기 위해 CPU 가 MMIO 컨트롤 레지스터에 쓰기를 할 때 DMA
+	   엔진에 보일 것이 보장됩니다.
+
+	3. CPU 에 의한 주변장치로의 readX() 는 모든 뒤따르는 CPU 의 메모리
+	   읽기가 시작되기 전에 완료됩니다.  예를 들어, dma_alloc_coherent() 를
+	   통해 할당된 수신용 DMA 버퍼로부터의 CPU 의 읽기는 이 DMA 수신의
+	   완료를 표시하는 DMA 엔진의 MMIO 상태 레지스터 읽기 후에는 오염된
+	   데이터를 읽지 않을 것이 보장됩니다.
+
+	4. CPU 에 의한 주변장치로의 readX() 는 모든 뒤따르는 delay() 루프가
+	   수행을 시작하기 전에 완료됩니다.  예를 들어, CPU 의 특정
+	   주변장치로의 두개의 MMIO 레지스터 쓰기가 행해지는데 첫번째 쓰기가
+	   readX() 를 통해 곧바로 읽어졌고 이어 두번째 writeX() 전에 udelay(1)
+	   이 호출되었다면 이 두개의 쓰기는 최소 1us 의 간격을 두고 행해질 것이
+	   보장됩니다:
+
+		writel(42, DEVICE_REGISTER_0); // 디바이스에 도착함...
+		readl(DEVICE_REGISTER_0);
+		udelay(1);
+		writel(42, DEVICE_REGISTER_1); // ...이것보다 최소 1us 전에.
+
+	디폴트가 아닌 기능을 통해 얻어지는 __iomem 포인터 (예: ioremap_wc() 를
+	통해 리턴되는 것) 의 순서 속성은 실제 아키텍쳐에 의존적이어서 이런
+	종류의 매핑으로의 액세스는 앞서 설명된 보장사항에 의존할 수 없습니다.
 
  (*) readX_relaxed(), writeX_relaxed()
 
-     이것들은 readX() 와 writeX() 랑 비슷하지만, 더 완화된 메모리 순서 보장을
-     제공합니다.  구체적으로, 이것들은 일반적 메모리 액세스나 delay() 루프
-     (예:앞의 2-4 항목) 에 대해 순서를 보장하지 않습니다만 디폴트 I/O 기능으로
-     매핑된 __iomem 포인터에 대해 동작할 때 같은 주변장치로의 액세스에는 순서가
-     맞춰질 것이 보장됩니다.
+	이것들은 readX() 와 writeX() 랑 비슷하지만, 더 완화된 메모리 순서
+	보장을 제공합니다.  구체적으로, 이것들은 일반적 메모리 액세스나 delay()
+	루프 (예:앞의 2-4 항목) 에 대해 순서를 보장하지 않습니다만 디폴트 I/O
+	기능으로 매핑된 __iomem 포인터에 대해 동작할 때 같은 주변장치로의
+	액세스에는 순서가 맞춰질 것이 보장됩니다.
 
  (*) readsX(), writesX():
 
-     readsX() 와 writesX() MMIO 액세스 함수는 DMA 를 수행하는데 적절치 않은,
-     주변장치 내의 메모리 매핑된 레지스터 기반 FIFO 로의 액세스를 위해
-     설계되었습니다.  따라서, 이 기능들은 앞서 설명된 readX_relaxed() 와
-     writeX_relaxed() 의 순서 보장만을 제공합니다.
+	readsX() 와 writesX() MMIO 액세스 함수는 DMA 를 수행하는데 적절치 않은,
+	주변장치 내의 메모리 매핑된 레지스터 기반 FIFO 로의 액세스를 위해
+	설계되었습니다.  따라서, 이 기능들은 앞서 설명된 readX_relaxed() 와
+	writeX_relaxed() 의 순서 보장만을 제공합니다.
 
  (*) inX(), outX():
 
-     inX() 와 outX() 액세스 함수는 일부 아키텍쳐 (특히 x86) 에서는 특수한
-     명령어를 필요로 하며 포트에 매핑되는, 과거의 유산인 I/O 주변장치로의
-     접근을 위해 만들어졌습니다.
+	inX() 와 outX() 액세스 함수는 일부 아키텍쳐 (특히 x86) 에서는 특수한
+	명령어를 필요로 하며 포트에 매핑되는, 과거의 유산인 I/O 주변장치로의
+	접근을 위해 만들어졌습니다.
 
-     많은 CPU 아키텍쳐가 결국은 이런 주변장치를 내부의 가상 메모리 매핑을 통해
-     접근하기 때문에, inX() 와 outX() 가 제공하는 이식성 있는 순서 보장은
-     디폴트 I/O 기능을 통한 매핑을 접근할 때의 readX() 와 writeX() 에 의해
-     제공되는 것과 각각 동일합니다.
+	많은 CPU 아키텍쳐가 결국은 이런 주변장치를 내부의 가상 메모리 매핑을
+	통해 접근하기 때문에, inX() 와 outX() 가 제공하는 이식성 있는 순서
+	보장은 디폴트 I/O 기능을 통한 매핑을 접근할 때의 readX() 와 writeX() 에
+	의해 제공되는 것과 각각 동일합니다.
 
-     디바이스 드라이버는 outX() 가 리턴하기 전에 해당 I/O 주변장치로부터의 완료
-     응답을 기다리는 쓰기 트랜잭션을 만들어 낸다고 기대할 수도 있습니다.  이는
-     모든 아키텍쳐에서 보장되지는 않고, 따라서 이식성 있는 순서 규칙의 일부분이
-     아닙니다.
+	디바이스 드라이버는 outX() 가 리턴하기 전에 해당 I/O 주변장치로부터의
+	완료 응답을 기다리는 쓰기 트랜잭션을 만들어 낸다고 기대할 수도
+	있습니다.  이는 모든 아키텍쳐에서 보장되지는 않고, 따라서 이식성 있는
+	순서 규칙의 일부분이 아닙니다.
 
  (*) insX(), outsX():
 
-     앞에서와 같이, insX() 와 outsX() 액세스 함수는 디폴트 I/O 기능을 통한
-     매핑을 접근할 때 각각 readX() 와 writeX() 와 같은 순서 보장을 제공합니다.
+	앞에서와 같이, insX() 와 outsX() 액세스 함수는 디폴트 I/O 기능을 통한
+	매핑을 접근할 때 각각 readX() 와 writeX() 와 같은 순서 보장을
+	제공합니다.
 
  (*) ioreadX(), iowriteX()
 
-     이것들은 inX()/outX() 나 readX()/writeX() 처럼 실제로 수행하는 액세스의
-     종류에 따라 적절하게 수행될 것입니다.
+	이것들은 inX()/outX() 나 readX()/writeX() 처럼 실제로 수행하는 액세스의
+	종류에 따라 적절하게 수행될 것입니다.
 
 이 모든 액세스 함수들은 아랫단의 주변장치가 little-endian 이라 가정하며, 따라서
 big-endian 아키텍쳐에서는 byte-swapping 오퍼레이션을 수행합니다.
-- 
2.17.2

