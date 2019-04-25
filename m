Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859ABC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3ECF20651
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Y9TJttj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfDYQPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:15:04 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44338 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfDYQPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:15:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id i13so359705edf.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KzBLwvgUEpfKbrwmx+pVv3C86NZA90pPtPPyYG4wEh4=;
        b=Y9TJttj94t4E/zPLUzYkpCTuqLqEuYi6+Nv9lJuZXklDg2TYcx0BHk7wfCvvQvKJ6I
         /gdkiyeCl2sCofVCp/UpMPyP99J22lgRtLntk9ZrnO2IQT1FmQ9GT90+Vo3FPA0wd5u5
         Z6+bs651WCoeXqtYYiHsj98alAYqtVX2xUBqkFoJypPVE3dmjCuGg3K6GUcUH1yPMvGK
         KIxPrLkOFzIJOH4isG3BsetbIyQd2jN/GMor45/HO/Jo9oxo+fW0pAudpxtsWRC4esxh
         Rp5tOtC5rKxCqhKy9ukMqZ0xRUQpSE1QxfUGER/dyNQFM6WJWc1e8VY/iBLZo5J5fs7r
         na+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KzBLwvgUEpfKbrwmx+pVv3C86NZA90pPtPPyYG4wEh4=;
        b=cxxBc3r03j3tMzTY8vRm+0wVzkfQQkvs+GuvuS6nMntXYdLFsx6ZzkR6gGRMeC3Iw4
         WlDKv64OKgkHwh2G5tu4MNMU7hK4cEl7zoexNik29AtrICiF6tp9SBmf+RA18sh8S2ve
         jnTu+gD3JPgeI48p/Ymvflj/BlI1BxOvIepYwCK2onQMS6vpwWQhX1JIoLR+dGIeBDER
         thnXvJmJDvkvnkRx0mjtBWbT9fU2gBaGi3OQ4Tno0rJBEAwOq1I7IV2687Wy9012CLUt
         FcEciwl3zX2UuIizTtXdsbbIQI218wH9dGcBwvinawGvRh+UmSZqPMOQfnP6M+04skeE
         91eA==
X-Gm-Message-State: APjAAAWO9xq1oyCFWjXRSEVdklXjg/VROAY5blz/q+rYXpDKhoR7NEKw
        Kh5N/zjyBiUjV1xb5EmYBTOb8D6Z9bc=
X-Google-Smtp-Source: APXvYqwu+lbp9f5xNYTFllUN62mYNMGq6RTzuFsIdjVpHiXgW8vkpz108yfC5OzNeN9SiJhte+RhOw==
X-Received: by 2002:a50:ad5d:: with SMTP id z29mr2184709edc.63.1556208899807;
        Thu, 25 Apr 2019 09:14:59 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:59 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv3 25/27] x86/vdso: Align VDSO functions by CPU L1 cache line
Date:   Thu, 25 Apr 2019 17:14:14 +0100
Message-Id: <20190425161416.26600-26-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425161416.26600-1-dima@arista.com>
References: <20190425161416.26600-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

After performance testing VDSO patches a noticeable 20% regression was
found on gettime_perf selftest with a cold cache.
As it turns to be, before time namespaces introduction, VDSO functions
were quite aligned to cache lines, but adding a new code to adjust
timens offset inside namespace created a small shift and vdso functions
become unaligned on cache lines.

Add align to vdso functions with gcc option to fix performance drop.

Coping the resulting numbers from cover letter:

Hot CPU cache (more gettime_perf.c cycles - the better):
        | before     | CONFIG_TIME_NS=n | host        | inside timens
--------|------------|------------------|-------------|-------------
cycles  | 139887013  | 139453003        | 139899785   | 128792458
diff (%)| 100        | 99.7             | 100         | 92

Cold cache (lesser tsc per gettime_perf_cold.c cycle - the better):
        | before     | CONFIG_TIME_NS=n | host        | inside timens
--------|------------|------------------|-------------|-------------
tsc     | 6748       | 6718             | 6862        | 12682
diff (%)| 100        | 99.6             | 101.7       | 188

Measured on Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz

Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index bc0bdbf49397..9b45aafdfcfe 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -4,6 +4,7 @@
 #
 
 KBUILD_CFLAGS += $(DISABLE_LTO)
+KBUILD_CFLAGS += -falign-functions=$(CONFIG_X86_L1_CACHE_SHIFT)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
-- 
2.21.0

