Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C63EC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372D5206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBuJ/CHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfKUXl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:41:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35320 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKUXl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:41:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id s5so6543226wrw.2;
        Thu, 21 Nov 2019 15:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S16pxGO5O0FuhySoOEBFpjl0mC9P1VojlxA0j8SaV2A=;
        b=lBuJ/CHX8V2c/ohxjIfGd7cjVvXRhnuPCCOVMvzuakmGdVqo/vkIVK9wLz0VpeUBdw
         BEyDDae3fFWNPveMcUDOkWKYqVvHzRRAHBLJWmrTDFSpW7LL6RikykFh55BuXOJ0FQvD
         Vj5Is5B2oCfUu19yOtxwplFu0qMzzA2hoCBvwUuozZ4hKyUKGgUKcKm9e/Wk9UUgb+Wm
         P/rY/W7n7msK5ZEknJYGngwlbPhl6UDfk8P+stwtQdp89nEgPSsavQhuJPwOhMa1S59O
         3XdYboEBetfOERO2YGjzigzpQ5XxE2TuG5ialSJOGGng7F0BjuSAFP5OJVI3i9HQmas9
         s5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S16pxGO5O0FuhySoOEBFpjl0mC9P1VojlxA0j8SaV2A=;
        b=alqxLtTKCRvJSezMn6NnvGHgn7IRMvxLjd3LZGDweyFWC0xCWP9Or2wF8PWmbWwRmv
         ryAlYNAb1TC1nh3Z7s+mJggiV5LidM1EdeP+n8Vy/yI9awRq4tSE7P/KkhcW7Lpe4V9A
         SASd/iE1I+ypemwrg8wTXfCDLUfax7vuGWVzOJqbEqjQj4xpiiv63eq60nMepPn2hSvY
         +Tswf6JVEPt5oVwzG8wDSS/awJjkCSrtSMyD8jGFTRBnNFk+0osWlJ8chKleU5zx01Zz
         5yxq/IYqqMrmc3kO4Yy1Ea4GwDL1RZRhVQ0ZHiIWNOh1hWv0aC2xhV1cCKjNnv8APUsB
         EBfQ==
X-Gm-Message-State: APjAAAUGb1TJ0UO51DaylHvr84UnMS3hXHRJA1mUQKwo21HPcrEgW5x5
        /byddfTG7s+hwvaGJC0jixk=
X-Google-Smtp-Source: APXvYqwR+755TG54wX+aU93gjYwbGXojAAIIilpcFpaRS7TCL065JnKI2eTdOBO92EEyZwbo5Bd17w==
X-Received: by 2002:adf:90d0:: with SMTP id i74mr13670917wri.298.1574379713272;
        Thu, 21 Nov 2019 15:41:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:5015:4c4c:42e9:e517])
        by smtp.gmail.com with ESMTPSA id l10sm5894420wrg.90.2019.11.21.15.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Nov 2019 15:41:52 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net, will@kernel.org, paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 1/7] docs/memory-barriers.txt/kokr: Rewrite "KERNEL I/O BARRIER EFFECTS" section
Date:   Fri, 22 Nov 2019 00:41:19 +0100
Message-Id: <20191121234125.28032-2-sj38.park@gmail.com>
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

  4614bbdee357 ("docs/memory-barriers.txt: Rewrite "KERNEL I/O BARRIER EFFECTS" section")

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 .../translations/ko_KR/memory-barriers.txt    | 105 +++++++++++-------
 1 file changed, 64 insertions(+), 41 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 42509b86542f..11fb7254ba8d 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -2560,68 +2560,91 @@ mmiowb() 가 명시적으로 사용될 필요가 있습니다.
 커널 I/O 배리어의 효과
 ======================
 
-I/O 메모리에 액세스할 때, 드라이버는 적절한 액세스 함수를 사용해야 합니다:
+I/O 액세스를 통한 주변장치와의 통신은 아키텍쳐와 기기에 매우 종속적입니다.
+따라서, 본질적으로 이식성이 없는 드라이버는 가능한 가장 적은 오버헤드로
+동기화를 하기 위해 각자의 타겟 시스템의 특정 동작에 의존할 겁니다.  다양한
+아키텍쳐와 버스 구현에 이식성을 가지려 하는 드라이버를 위해, 커널은 다양한
+정도의 순서 보장을 제공하는 일련의 액세스 함수를 제공합니다.
 
- (*) inX(), outX():
+ (*) readX(), writeX():
 
-     이것들은 메모리 공간보다는 I/O 공간에 이야기를 하려는 의도로
-     만들어졌습니다만, 그건 기본적으로 CPU 마다 다른 컨셉입니다.  i386 과
-     x86_64 프로세서들은 특별한 I/O 공간 액세스 사이클과 명령어를 실제로 가지고
-     있지만, 다른 많은 CPU 들에는 그런 컨셉이 존재하지 않습니다.
+     readX() 와 writeX() MMIO 액세스 함수는 접근되는 주변장치로의 포인터를
+     __iomem * 패러미터로 받습니다.  디폴트 I/O 기능으로 매핑되는 포인터 (예:
+     ioremap() 으로 반환되는 것) 의 순서 보장은 다음과 같습니다:
 
-     다른 것들 중에서도 PCI 버스가 I/O 공간 컨셉을 정의하는데, 이는 - i386 과
-     x86_64 같은 CPU 에서 - CPU 의 I/O 공간 컨셉으로 쉽게 매치됩니다.  하지만,
-     대체할 I/O 공간이 없는 CPU 에서는 CPU 의 메모리 맵의 가상 I/O 공간으로
-     매핑될 수도 있습니다.
+     1. 같은 주변장치로의 모든 readX() 와 writeX() 액세스는 각자에 대해
+	순서지어집니다.  예를 들어, CPU 의 특정 디바이스로의 MMIO 레지스터
+        쓰기는 프로그램 순서대로 도착할 것이 보장됩니다.
 
-     이 공간으로의 액세스는 (i386 등에서는) 완전하게 동기화 됩니다만, 중간의
-     (PCI 호스트 브리지와 같은) 브리지들은 이를 완전히 보장하진 않을수도
-     있습니다.
+     2. CPU 에 의한 특정 주변장치로의 writeX() 는 모든 앞선 CPU 의 메모리
+	쓰기가 완료되기를 먼저 기다립니다.  예를 들어, dma_alloc_coherent() 를
+	통해 할당된 전송용 DMA 버퍼로의 CPU 의 쓰기는 이 전송을 시작시키기 위해
+	CPU 가 MMIO 컨트롤 레지스터에 쓰기를 할 때 DMA 엔진에 보일 것이
+        보장됩니다.
 
-     이것들의 상호간의 순서는 완전하게 보장됩니다.
+     3. CPU 에 의한 주변장치로의 readX() 는 모든 뒤따르는 CPU 의 메모리
+        읽기가 시작되기 전에 완료됩니다.  예를 들어, dma_alloc_coherent() 를
+        통해 할당된 수신용 DMA 버퍼로부터의 CPU 의 읽기는 이 DMA 수신의 완료를
+        표시하는 DMA 엔진의 MMIO 상태 레지스터 읽기 후에는 오염된 데이터를 읽지
+        않을 것이 보장됩니다.
 
-     다른 타입의 메모리 오퍼레이션, I/O 오퍼레이션에 대한 순서는 완전하게
-     보장되지는 않습니다.
+     4. CPU 에 의한 주변장치로의 readX() 는 모든 뒤따르는 delay() 루프가 수행을
+        시작하기 전에 완료됩니다.  예를 들어, CPU 의 특정 주변장치로의 두개의
+        MMIO 레지스터 쓰기가 행해지는데 첫번째 쓰기가 readX() 를 통해 곧바로
+        읽어졌고 이어 두번째 writeX() 전에 udelay(1) 이 호출되었다면 이 두개의
+        쓰기는 최소 1us 의 간격을 두고 행해질 것이 보장됩니다.
 
- (*) readX(), writeX():
+     디폴트가 아닌 기능을 통해 얻어지는 __iomem 포인터 (예: ioremap_wc() 를
+     통해 리턴되는 것) 는 이런 보장사항들 중 다수를 제공하지 않을 수 있습니다.
+
+ (*) readX_relaxed(), writeX_relaxed()
+
+     이것들은 readX() 와 writeX() 랑 비슷하지만, 더 완화된 메모리 순서 보장을
+     제공합니다.  구체적으로, 이것들은 일반적 메모리 액세스나 delay() 루프
+     (예:앞의 2-4 항목) 에 대해 순서를 보장하지 않습니다만 디폴트 I/O 기능으로
+     매핑된 __iomem 포인터에 대해 동작할 때 같은 주변장치로의 액세스에는 순서가
+     맞춰질 것이 보장됩니다.
 
-     이것들이 수행 요청되는 CPU 에서 서로에게 완전히 순서가 맞춰지고 독립적으로
-     수행되는지에 대한 보장 여부는 이들이 액세스 하는 메모리 윈도우에 정의된
-     특성에 의해 결정됩니다.  예를 들어, 최신의 i386 아키텍쳐 머신에서는 MTRR
-     레지스터로 이 특성이 조정됩니다.
+ (*) readsX(), writesX():
 
-     일반적으로는, 프리페치 (prefetch) 가능한 디바이스를 액세스 하는게
-     아니라면, 이것들은 완전히 순서가 맞춰지고 결합되지 않게 보장될 겁니다.
+     readsX() 와 writesX() MMIO 액세스 함수는 DMA 를 수행하는데 적절치 않은,
+     주변장치 내의 메모리 매핑된 레지스터 기반 FIFO 로의 액세스를 위해
+     설계되었습니다.  따라서, 이 기능들은 앞서 설명된 readX_relaxed() 와
+     writeX_relaxed() 의 순서 보장만을 제공합니다.
 
-     하지만, (PCI 브리지와 같은) 중간의 하드웨어는 자신이 원한다면 집행을
-     연기시킬 수 있습니다; 스토어 명령을 실제로 하드웨어로 내려보내기(flush)
-     위해서는 같은 위치로부터 로드를 하는 방법이 있습니다만[*], PCI 의 경우는
-     같은 디바이스나 환경 구성 영역에서의 로드만으로도 충분할 겁니다.
+ (*) inX(), outX():
 
-     [*] 주의! 쓰여진 것과 같은 위치로부터의 로드를 시도하는 것은 오동작을
-	 일으킬 수도 있습니다 - 예로 16650 Rx/Tx 시리얼 레지스터를 생각해
-	 보세요.
+     inX() 와 outX() 액세스 함수는 일부 아키텍쳐 (특히 x86) 에서는 특수한
+     명령어를 필요로 하며 포트에 매핑되는, 과거의 유산인 I/O 주변장치로의
+     접근을 위해 만들어졌습니다.
 
-     프리페치 가능한 I/O 메모리가 사용되면, 스토어 명령들이 순서를 지키도록
-     하기 위해 mmiowb() 배리어가 필요할 수 있습니다.
+     많은 CPU 아키텍쳐가 결국은 이런 주변장치를 내부의 가상 메모리 매핑을 통해
+     접근하기 때문에, inX() 와 outX() 가 제공하는 이식성 있는 순서 보장은
+     디폴트 I/O 기능을 통한 매핑을 접근할 때의 readX() 와 writeX() 에 의해
+     제공되는 것과 각각 동일합니다.
 
-     PCI 트랜잭션 사이의 상호작용에 대해 더 많은 정보를 위해선 PCI 명세서를
-     참고하시기 바랍니다.
+     디바이스 드라이버는 outX() 가 리턴하기 전에 해당 I/O 주변장치로부터의 완료
+     응답을 기다리는 쓰기 트랜잭션을 만들어 낸다고 기대할 수도 있습니다.  이는
+     모든 아키텍쳐에서 보장되지는 않고, 따라서 이식성 있는 순서 규칙의 일부분이
+     아닙니다.
 
- (*) readX_relaxed(), writeX_relaxed()
+ (*) insX(), outsX():
 
-     이것들은 readX() 와 writeX() 랑 비슷하지만, 더 완화된 메모리 순서 보장을
-     제공합니다.  구체적으로, 이것들은 일반적 메모리 액세스 (예: DMA 버퍼) 에도
-     LOCK 이나 UNLOCK 오퍼레이션들에도 순서를 보장하지 않습니다.  LOCK 이나
-     UNLOCK 오퍼레이션들에 맞춰지는 순서가 필요하다면, mmiowb() 배리어가 사용될
-     수 있습니다.  같은 주변 장치에의 완화된 액세스끼리는 순서가 지켜짐을 알아
-     두시기 바랍니다.
+     앞에서와 같이, insX() 와 outsX() 액세스 함수는 디폴트 I/O 기능을 통한
+     매핑을 접근할 때 각각 readX() 와 writeX() 와 같은 순서 보장을 제공합니다.
 
  (*) ioreadX(), iowriteX()
 
      이것들은 inX()/outX() 나 readX()/writeX() 처럼 실제로 수행하는 액세스의
      종류에 따라 적절하게 수행될 것입니다.
 
+이 모든 액세스 함수들은 아랫단의 주변장치가 little-endian 이라 가정하며, 따라서
+big-endian 아키텍쳐에서는 byte-swapping 오퍼레이션을 수행합니다.
+
+I/O 순서 배리어를 SMP 순서 배리어와 LOCK/UNLOCK 오퍼레이션과 섞는 건 mmiowb()
+를 필요로 할 수도 있는 위험한 행위입니다.  더 많은 내용을 위해선 "Acquire vs
+I/O 액세스" 서브섹션을 참고하시기 바랍니다.
+
 
 ===================================
 가정되는 가장 완화된 실행 순서 모델
-- 
2.17.2

