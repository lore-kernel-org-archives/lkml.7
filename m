Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED06C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F840229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tr1coZsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfGYNUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:20:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33374 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYNUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:20:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so50865127wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J5s3N85M9ajD/urZFm5P9YAai+R4ucnPihB3UAQSabI=;
        b=tr1coZsTvMfvRar6herRh/Wc2zp5wCgiRIjYDHYlrYoW2EcVtkoWaSrYBBxU6UmWj+
         TNqkCYXH4+gdbK+EXPYJpQzisO6k5q9QXm0XuFrL7rLmfs7gSnVx9gnvMHFmcSe5mdup
         iYBvtVasBieDcGz+jDGrmItNb34TcQh5OoOW9lIFMKORlPixWZCR1YmsCUbFS+LMiR+M
         4+qhpOggSQurUfwusBWvK69/ut64/VS2SiFg0yKbCedE7SKxenCCLkJO2JgcAXCuYqco
         h+BsCgbKYph0buKQnFjztstk2Q15uHzJoxIcFv5UOXJBD1Q21UcZKIciFA2xSgsvMsJs
         gjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5s3N85M9ajD/urZFm5P9YAai+R4ucnPihB3UAQSabI=;
        b=FGPE0UAujM3TLDWSLGs1r0VuHG0Om4kB6LJYte0XWGOiA39RJ9NF3bi3oIZWLGcbHu
         sd8EO6Jcg7YJAg5O8D7slJsdnL3MLeC2sRTgRgzi68m88lSvbLUhuB5U4jGdsZW4HIRP
         sXIafK8VdgnduCzT3+KJth0EkMPbRvcXV4LowO2f+iUmUFfKjeFLhoJV7nUsBGEbj6aZ
         cfkblxImU7k28yfLjq8gBxvXQNdYaQm1JOtCijhX36c5ei1rXqf/fD98G+LVJSnBuUkZ
         JYCCEDMnempzA2Maig1MLeedIKRQvGu+rCU9CbPk1L5hUDv61BJqtBv+kjG6Dsfu8BbL
         nusg==
X-Gm-Message-State: APjAAAVwb0th14DVh5MD4EjrBrLEfc3D4qWDvsVs4tC0HcF1jBCZFKsH
        WxSmq8Sh2SnBkD9/+1R1fmOLZUEF
X-Google-Smtp-Source: APXvYqwyJAeQAkUdSaoWLc4JL7+dV4O4TRza3CWK++OFI6pcP8xs52IFKl8D+EOxx5Qh4MPLVJl0sA==
X-Received: by 2002:a5d:63c9:: with SMTP id c9mr59005945wrw.15.1564060385843;
        Thu, 25 Jul 2019 06:13:05 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id z7sm47119735wrh.67.2019.07.25.06.13.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 06:13:05 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 3/5] davinci: fix sleep.S build error on ARMv4
Date:   Thu, 25 Jul 2019 15:12:55 +0200
Message-Id: <20190725131257.6142-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725131257.6142-1-brgl@bgdev.pl>
References: <20190725131257.6142-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When building a multiplatform kernel that includes armv4 support,
the default target CPU does not support the blx instruction,
which leads to a build failure:

arch/arm/mach-davinci/sleep.S: Assembler messages:
arch/arm/mach-davinci/sleep.S:56: Error: selected processor does
not support `blx ip' in ARM mode

Add a .arch statement in the sources to make this file build.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/sleep.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.S
index 05d03f09ff54..50c180acc680 100644
--- a/arch/arm/mach-davinci/sleep.S
+++ b/arch/arm/mach-davinci/sleep.S
@@ -24,6 +24,7 @@
 #define DEEPSLEEP_SLEEPENABLE_BIT	BIT(31)
 
 	.text
+	.arch   armv5te
 /*
  * Move DaVinci into deep sleep state
  *
-- 
2.21.0

