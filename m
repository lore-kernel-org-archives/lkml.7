Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FDAC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C139E206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pY44upv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKUXmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:42:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51226 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfKUXmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:42:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id g206so5338234wme.1;
        Thu, 21 Nov 2019 15:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ng0CkAcLI8/C1WbV1IgQWOKy71D4tmAYtv785jWQWOo=;
        b=pY44upv8tMammFTSIoO2OKJ8B3UwkGlvrNvGDYbnQmrPt2iXE8y6ovDIqzmFLqPgjn
         0sTVauFwFxT9J1W3334U9vScMWFHm80/P9ellJDsjEcjRkQz1TKFtR/hczbmaNasLFNH
         lNTrVLxTCsSw7L0rToH8vSIvIqKv6Apu2oRA/aoNr/Zs9U64KmrlxxiR4n7o9qPRbkoB
         TKMfSzf64zO6j/payjJHd5BjzG6Ig0rtKqmSfR98m1hjWi9tRknNfMY/MjP+9f3rlIee
         jsLP7kzoKQmi00bLqnFsOtTBnbBkPPRyJ4L+AE2dpcu8CoUn5LICn3edFg3zAMq/ZlXP
         gTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ng0CkAcLI8/C1WbV1IgQWOKy71D4tmAYtv785jWQWOo=;
        b=XW8soUibPGpoPZGyoUT5BqHhwe9LDKQlWS5E7784O3oYZqMk9EbSBEuRiZHXYhAxYH
         /OKtiDVvsST64dOdvUDzJ/kws8F5cjvN6mfBAMTbqdRwyPiXt+CpC73AnaCbcHrMrshT
         0DKdHLMUQQR65JOdMWeszQmh3S0V3kOE9Q4vH44n+2lGNHbaCRxkjPNmClyGM5vyZNZ1
         /YbjqM4xKWTZUeOPjvs48kyNUSYdji+XIDiMTAFTj83OttwInb5mP2rYxPfE4M7Y0HSm
         IVsqtwkPFp7LXD/SeG80c9WPQDdGxcLU8YVvYHONwJHfNHZDkceMi0qf73GgA8TS4nT2
         Ys5A==
X-Gm-Message-State: APjAAAU7C1jACQ7VKGig0XSWWqEXxS3N4+0wjkWeNP99x1jvQaHyNBBx
        o0GD35GwzFAut0lMAIaasNw=
X-Google-Smtp-Source: APXvYqxleI/6p2+d0m45Ob45BzIxptarep+VvtC3FCUcUOIqJnNW0+HTvEdYSD4L6eXKpmht8DptUw==
X-Received: by 2002:a1c:7704:: with SMTP id t4mr12499233wmi.4.1574379720869;
        Thu, 21 Nov 2019 15:42:00 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:5015:4c4c:42e9:e517])
        by smtp.gmail.com with ESMTPSA id l10sm5894420wrg.90.2019.11.21.15.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Nov 2019 15:42:00 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net, will@kernel.org, paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 7/7] Documentation/process/howto/kokr: Update for 4.x -> 5.x versioning
Date:   Fri, 22 Nov 2019 00:41:25 +0100
Message-Id: <20191121234125.28032-8-sj38.park@gmail.com>
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

  d2b008f134b7 ("Documentation/process/howto: Update for 4.x -> 5.x versioning")

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 Documentation/translations/ko_KR/howto.rst | 56 +++++++++++-----------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index b3f51b19de7c..ae3ad897d2ae 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -240,21 +240,21 @@ ReST 마크업을 사용하는 문서들은 Documentation/output 에 생성된
 서브시스템에 특화된 커널 브랜치들로 구성된다. 몇몇 다른 메인
 브랜치들은 다음과 같다.
 
-  - main 4.x 커널 트리
-  - 4.x.y - 안정된 커널 트리
-  - 서브시스템을 위한 커널 트리들과 패치들
-  - 4.x - 통합 테스트를 위한 next 커널 트리
+  - 리누스의 메인라인 트리
+  - 여러 메이저 넘버를 갖는 다양한 안정된 커널 트리들
+  - 서브시스템을 위한 커널 트리들
+  - 통합 테스트를 위한 linux-next 커널 트리
 
-4.x 커널 트리
+메인라인 트리
 ~~~~~~~~~~~~~
 
-4.x 커널들은 Linus Torvalds가 관리하며 https://kernel.org 의
-pub/linux/kernel/v4.x/ 디렉토리에서 참조될 수 있다.개발 프로세스는 다음과 같다.
+메인라인 트리는 Linus Torvalds가 관리하며 https://kernel.org  또는 소스
+저장소에서 참조될 수 있다.개발 프로세스는 다음과 같다.
 
   - 새로운 커널이 배포되자마자 2주의 시간이 주어진다. 이 기간동은
     메인테이너들은 큰 diff들을 Linus에게 제출할 수 있다. 대개 이 패치들은
-    몇 주 동안 -next 커널내에 이미 있었던 것들이다. 큰 변경들을 제출하는 데
-    선호되는 방법은  git(커널의 소스 관리 툴, 더 많은 정보들은
+    몇 주 동안 linux-next 커널내에 이미 있었던 것들이다. 큰 변경들을 제출하는
+    데 선호되는 방법은  git(커널의 소스 관리 툴, 더 많은 정보들은
     https://git-scm.com/ 에서 참조할 수 있다)를 사용하는 것이지만 순수한
     패치파일의 형식으로 보내는 것도 무관하다.
   - 2주 후에 -rc1 커널이 릴리즈되며 여기서부터의 주안점은 새로운 커널을
@@ -281,28 +281,25 @@ Andrew Morton의 글이 있다.
         버그의 상황에 따라 배포되는 것이지 미리정해 놓은 시간에 따라
         배포되는 것은 아니기 때문이다."*
 
-4.x.y - 안정 커널 트리
-~~~~~~~~~~~~~~~~~~~~~~
+여러 메이저 넘버를 갖는 다양한 안정된 커널 트리들
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-3 자리 숫자로 이루어진 버젼의 커널들은 -stable 커널들이다. 그것들은 4.x
-커널에서 발견된 큰 회귀들이나 보안 문제들 중 비교적 작고 중요한 수정들을
-포함한다.
+3 자리 숫자로 이루어진 버젼의 커널들은 -stable 커널들이다. 그것들은 해당 메이저
+메인라인 릴리즈에서 발견된 큰 회귀들이나 보안 문제들 중 비교적 작고 중요한
+수정들을 포함하며, 앞의 두 버전 넘버는 같은 기반 버전을 의미한다.
 
 이것은 가장 최근의 안정적인 커널을 원하는 사용자에게 추천되는 브랜치이며,
 개발/실험적 버젼을 테스트하는 것을 돕고자 하는 사용자들과는 별로 관련이 없다.
 
-어떤 4.x.y 커널도 사용할 수 없다면 그때는 가장 높은 숫자의 4.x
-커널이 현재의 안정 커널이다.
-
-4.x.y는 "stable" 팀<stable@vger.kernel.org>에 의해 관리되며 거의 매번 격주로
-배포된다.
+-stable 트리들은 "stable" 팀<stable@vger.kernel.org>에 의해 관리되며 거의 매번
+격주로 배포된다.
 
 커널 트리 문서들 내의 :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
 파일은 어떤 종류의 변경들이 -stable 트리로 들어왔는지와
 배포 프로세스가 어떻게 진행되는지를 설명한다.
 
-서브시스템 커널 트리들과 패치들
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+서브시스템 커널 트리들
+~~~~~~~~~~~~~~~~~~~~~~
 
 다양한 커널 서브시스템의 메인테이너들 --- 그리고 많은 커널 서브시스템 개발자들
 --- 은 그들의 현재 개발 상태를 소스 저장소로 노출한다. 이를 통해 다른 사람들도
@@ -324,17 +321,18 @@ Andrew Morton의 글이 있다.
 대부분의 이러한 patchwork 사이트는 https://patchwork.kernel.org/ 또는
 http://patchwork.ozlabs.org/ 에 나열되어 있다.
 
-4.x - 통합 테스트를 위한 next 커널 트리
----------------------------------------
-서브시스템 트리들의 변경사항들은 mainline 4.x 트리로 들어오기 전에 통합
-테스트를 거쳐야 한다. 이런 목적으로, 모든 서브시스템 트리의 변경사항을 거의
-매일 받아가는 특수한 테스트 저장소가 존재한다:
+통합 테스트를 위한 linux-next 커널 트리
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+서브시스템 트리들의 변경사항들은 mainline 트리로 들어오기 전에 통합 테스트를
+거쳐야 한다. 이런 목적으로, 모든 서브시스템 트리의 변경사항을 거의 매일
+받아가는 특수한 테스트 저장소가 존재한다:
 
        https://git.kernel.org/?p=linux/kernel/git/sfr/linux-next.git
 
-이런 식으로, -next 커널을 통해 다음 머지 기간에 메인라인 커널에 어떤 변경이
-가해질 것인지 간략히 알 수 있다. 모험심 강한 테스터라면 -next 커널에서 테스트를
-수행하는 것도 좋을 것이다.
+이런 식으로, linux-next 커널을 통해 다음 머지 기간에 메인라인 커널에 어떤
+변경이 가해질 것인지 간략히 알 수 있다. 모험심 강한 테스터라면 linux-next
+커널에서 테스트를 수행하는 것도 좋을 것이다.
 
 
 버그 보고
-- 
2.17.2

