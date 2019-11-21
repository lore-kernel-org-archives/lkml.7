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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A60C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C315206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtjK74xn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfKUXl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:41:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33959 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfKUXl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:41:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id j18so8908161wmk.1;
        Thu, 21 Nov 2019 15:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNobpEzToldqWZBzVnixvSSnBc7lGFpsFA4TQ8LWu8Q=;
        b=XtjK74xnxemuPHB/roJrc/NDznDUqdmq5xumEkwvemDZHlz6AGZVnlwRu/zS0aGJJM
         pdL80gZKPVsU8qW2+A2QazQoI3hvwq/8pEq11XQWG1O2wd2NPPVGs9byeVN0IaOqibBN
         qQHOTjN4JNfBBriD6KbwzyKiDKkvy20MnxNO7zk1BuPpOxNx0eiVxgNILF5rohMTIUsV
         HLtpI33hpjzsiVJi6Pqfv6sR32JpMC5Ft07NEjxFABnTH2kAgeuUSUNJFv1bEaS8EYXU
         lYO7eh9m+3+Kt+pI3bSarPgDEvnEwXaHcgWSi6s/iUlQ7LIHfbMUWhva31x5vnOCqxuF
         ik6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNobpEzToldqWZBzVnixvSSnBc7lGFpsFA4TQ8LWu8Q=;
        b=Du7N27Rl6FaJlDuNWnWGnKn6utj/D0zbf8kKmRvuuuARcSLmS0e9zdPHIhIglEMOSw
         vpntP3AS3gq3m8b93WwugYdQphCHB9hqfPeZFVfV4PVdaUzFARtoPhOZ/aWpJOD2sxiZ
         tLailTAzeDsxUSwed6fTa876SAbCD9w4/svRKC+wBqcs7olazFBFDM8j3FCIrJCjSp9M
         3AgP2MGUOaexcr9z321sQYKK5HnO8x9/Su+58E6Tpm5jNcH/KClCPYjsP0XfNHQK0cYw
         e/wjXrh8vj7xQuFxLSiWdPGzemvqFre6DMmBSNfT58fa8TePYv0efl2sEuWkBloC8aK/
         AVwA==
X-Gm-Message-State: APjAAAXy67hc5hk9DRKnZOM6ZlUfFECr2sWoDfFrJm59FiNAOntcIUTw
        M/xesWGNGpwKoWSzBF4nOjA=
X-Google-Smtp-Source: APXvYqwx7zdcWL7gDLBVZqd/I68LxFYSmIwHZNBugZVWnKpa6tC+vF/kU3U2WLns2npWF3KGB5VIUQ==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr1423381wmc.81.1574379714712;
        Thu, 21 Nov 2019 15:41:54 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:5015:4c4c:42e9:e517])
        by smtp.gmail.com with ESMTPSA id l10sm5894420wrg.90.2019.11.21.15.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Nov 2019 15:41:53 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net, will@kernel.org, paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 2/7] Documentation/kokr: Kill all references to mmiowb()
Date:   Fri, 22 Nov 2019 00:41:20 +0100
Message-Id: <20191121234125.28032-3-sj38.park@gmail.com>
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

  915530396c78 ("Documentation: Kill all references to mmiowb()")

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 .../translations/ko_KR/memory-barriers.txt    | 104 +-----------------
 1 file changed, 6 insertions(+), 98 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 11fb7254ba8d..584bb0bdf2c4 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -1907,21 +1907,6 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
      위해선 Documentation/DMA-API.txt 문서를 참고하세요.
 
 
-MMIO 쓰기 배리어
-----------------
-
-리눅스 커널은 또한 memory-mapped I/O 쓰기를 위한 특별한 배리어도 가지고
-있습니다:
-
-	mmiowb();
-
-이것은 mandatory 쓰기 배리어의 변종으로, 완화된 순서 규칙의 I/O 영역에으로의
-쓰기가 부분적으로 순서를 맞추도록 해줍니다.  이 함수는 CPU->하드웨어 사이를
-넘어서 실제 하드웨어에까지 일부 수준의 영향을 끼칩니다.
-
-더 많은 정보를 위해선 "Acquire vs I/O 액세스" 서브섹션을 참고하세요.
-
-
 =========================
 암묵적 커널 메모리 배리어
 =========================
@@ -2283,73 +2268,6 @@ ACQUIRE VS 메모리 액세스
 	*E, *F or *G following RELEASE Q
 
 
-
-ACQUIRE VS I/O 액세스
-----------------------
-
-특정한 (특히 NUMA 가 관련된) 환경 하에서 두개의 CPU 에서 동일한 스핀락으로
-보호되는 두개의 크리티컬 섹션 안의 I/O 액세스는 PCI 브릿지에 겹쳐진 I/O
-액세스로 보일 수 있는데, PCI 브릿지는 캐시 일관성 프로토콜과 합을 맞춰야 할
-의무가 없으므로, 필요한 읽기 메모리 배리어가 요청되지 않기 때문입니다.
-
-예를 들어서:
-
-	CPU 1				CPU 2
-	===============================	===============================
-	spin_lock(Q)
-	writel(0, ADDR)
-	writel(1, DATA);
-	spin_unlock(Q);
-					spin_lock(Q);
-					writel(4, ADDR);
-					writel(5, DATA);
-					spin_unlock(Q);
-
-는 PCI 브릿지에 다음과 같이 보일 수 있습니다:
-
-	STORE *ADDR = 0, STORE *ADDR = 4, STORE *DATA = 1, STORE *DATA = 5
-
-이렇게 되면 하드웨어의 오동작을 일으킬 수 있습니다.
-
-
-이런 경우엔 잡아둔 스핀락을 내려놓기 전에 mmiowb() 를 수행해야 하는데, 예를
-들면 다음과 같습니다:
-
-	CPU 1				CPU 2
-	===============================	===============================
-	spin_lock(Q)
-	writel(0, ADDR)
-	writel(1, DATA);
-	mmiowb();
-	spin_unlock(Q);
-					spin_lock(Q);
-					writel(4, ADDR);
-					writel(5, DATA);
-					mmiowb();
-					spin_unlock(Q);
-
-이 코드는 CPU 1 에서 요청된 두개의 스토어가 PCI 브릿지에 CPU 2 에서 요청된
-스토어들보다 먼저 보여짐을 보장합니다.
-
-
-또한, 같은 디바이스에서 스토어를 이어 로드가 수행되면 이 로드는 로드가 수행되기
-전에 스토어가 완료되기를 강제하므로 mmiowb() 의 필요가 없어집니다:
-
-	CPU 1				CPU 2
-	===============================	===============================
-	spin_lock(Q)
-	writel(0, ADDR)
-	a = readl(DATA);
-	spin_unlock(Q);
-					spin_lock(Q);
-					writel(4, ADDR);
-					b = readl(DATA);
-					spin_unlock(Q);
-
-
-더 많은 정보를 위해선 Documentation/driver-api/device-io.rst 를 참고하세요.
-
-
 =========================
 메모리 배리어가 필요한 곳
 =========================
@@ -2494,14 +2412,9 @@ _않습니다_.
 리눅스 커널 내부에서, I/O 는 어떻게 액세스들을 적절히 순차적이게 만들 수 있는지
 알고 있는, - inb() 나 writel() 과 같은 - 적절한 액세스 루틴을 통해 이루어져야만
 합니다.  이것들은 대부분의 경우에는 명시적 메모리 배리어 와 함께 사용될 필요가
-없습니다만, 다음의 두가지 상황에서는 명시적 메모리 배리어가 필요할 수 있습니다:
-
- (1) 일부 시스템에서 I/O 스토어는 모든 CPU 에 일관되게 순서 맞춰지지 않는데,
-     따라서 _모든_ 일반적인 드라이버들에 락이 사용되어야만 하고 이 크리티컬
-     섹션을 빠져나오기 전에 mmiowb() 가 꼭 호출되어야 합니다.
-
- (2) 만약 액세스 함수들이 완화된 메모리 액세스 속성을 갖는 I/O 메모리 윈도우를
-     사용한다면, 순서를 강제하기 위해선 _mandatory_ 메모리 배리어가 필요합니다.
+없습니다만, 완화된 메모리 액세스 속성으로 I/O 메모리 윈도우로의 참조를 위해
+액세스 함수가 사용된다면 순서를 강제하기 위해 _madatory_ 메모리 배리어가
+필요합니다.
 
 더 많은 정보를 위해선 Documentation/driver-api/device-io.rst 를 참고하십시오.
 
@@ -2545,10 +2458,9 @@ _않습니다_.
 인터럽트 내에서 일어난 액세스와 섞일 수 있다고 - 그리고 그 반대도 - 가정해야만
 합니다.
 
-그런 영역 안에서 일어나는 I/O 액세스들은 엄격한 순서 규칙의 I/O 레지스터에
-묵시적 I/O 배리어를 형성하는 동기적 (synchronous) 로드 오퍼레이션을 포함하기
-때문에 일반적으로는 이런게 문제가 되지 않습니다.  만약 이걸로는 충분치 않다면
-mmiowb() 가 명시적으로 사용될 필요가 있습니다.
+그런 영역 안에서 일어나는 I/O 액세스는 묵시적 I/O 배리어를 형성하는, 엄격한
+순서 규칙의 I/O 레지스터로의 로드 오퍼레이션을 포함하기 때문에 일반적으로는
+문제가 되지 않습니다.
 
 
 하나의 인터럽트 루틴과 별도의 CPU 에서 수행중이며 서로 통신을 하는 두 루틴
@@ -2641,10 +2553,6 @@ I/O 액세스를 통한 주변장치와의 통신은 아키텍쳐와 기기에 
 이 모든 액세스 함수들은 아랫단의 주변장치가 little-endian 이라 가정하며, 따라서
 big-endian 아키텍쳐에서는 byte-swapping 오퍼레이션을 수행합니다.
 
-I/O 순서 배리어를 SMP 순서 배리어와 LOCK/UNLOCK 오퍼레이션과 섞는 건 mmiowb()
-를 필요로 할 수도 있는 위험한 행위입니다.  더 많은 내용을 위해선 "Acquire vs
-I/O 액세스" 서브섹션을 참고하시기 바랍니다.
-
 
 ===================================
 가정되는 가장 완화된 실행 순서 모델
-- 
2.17.2

