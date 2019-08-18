Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CB9C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 18:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850322184D
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 18:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwjzuuA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfHRSgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 14:36:07 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41720 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRSgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 14:36:07 -0400
Received: by mail-qk1-f196.google.com with SMTP id g17so8831140qkk.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 11:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e7TlGCUf1JSTI6LOCtMDPWUdsew/XXSqNWQ0500csFk=;
        b=VwjzuuA1cEGqSdsoBXdYxZEdXn/gzNCGfoGU4iMtPqvugKpO6f6UYPWFqPJxMvubLr
         Kk3tmqJ0nDztM1w74kpyAqqFtDCtYJGkGeWlrBvXAypJLuzw7hqVURAHHPHMScKQdHF3
         6tDQIfCuz9lzPHoj9AM8AEeg/LcGrh4IiOr6a3x8ZdQo9msPTl8w7JJR8HQScvgWw7WM
         fPv9CKoljAxl0oG56NqFpSkH3qngVh1wkjR2MEYgl03jxq7Vv014+hje7LFzqJtt6kA1
         tJnkLZQnuzKN+Zxb/3wxcXldNvcVFee7zCPZZjMIqFyC3qJ4jdgRdag0moLEItw3b8di
         ii6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e7TlGCUf1JSTI6LOCtMDPWUdsew/XXSqNWQ0500csFk=;
        b=jWKZexkzH+36vvQoHZH08Q+VDb0CAgUM60CioewGmWlo1CYoCjzh6UmbgcH5s73zzr
         swhOmvrpTj06fcvI62LBGPWKyze45thoyXtt4l3ZDtg7sFHSH7veQPUdjQZjWl7z+pKd
         8bo3D7YkMn37C+yHW/iBFwJnoNdyOCY294oAmmKB27sv2gEeo6vWxmMWa61opuORK+c/
         ldj+oDJJd0ZBmldX+LnRhY4GkaCYVi1q8u5qDfY4dcYjDQzNLb7uy6hrFik24UOo3CuU
         pwfPnO9uqU7rYRQNUnyrPnJzHmY3hEPMeaDmsBh6pQ8nbAPKi/RFLPWSj7GUJOQOja/L
         h52w==
X-Gm-Message-State: APjAAAUwNeTO0D2y4JkGCu9v0aP/41l5uCq9p4ReB26ilL/WRoME70pv
        Rl3vvrioA0rDAAp2PfwNvoE=
X-Google-Smtp-Source: APXvYqzjyDFtqHr5NHdj4nZFP5FTz9f9Erl3Y00N3/EznOCzKCnQe0hZk13W8DTSxbNqL01uzjrVHg==
X-Received: by 2002:a37:c206:: with SMTP id i6mr10763120qkm.384.1566153365724;
        Sun, 18 Aug 2019 11:36:05 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7d2:f9b3:a288:b4ff:fe9b:37cc])
        by smtp.gmail.com with ESMTPSA id a6sm5987094qkd.135.2019.08.18.11.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:36:05 -0700 (PDT)
From:   Eduardo Barretto <edusbarretto@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: kpc2000: kpc2000_i2c: Fix different address spaces warnings
Date:   Sun, 18 Aug 2019 15:35:55 -0300
Message-Id: <20190818183555.7167-1-edusbarretto@gmail.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following sparse warnings:

kpc2000_i2c.c:137: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:137:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:137:    got void *
kpc2000_i2c.c:146: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:146:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:146:    got void *
kpc2000_i2c.c:147: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:147:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:147:    got void *
kpc2000_i2c.c:166: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:166:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:166:    got void *
kpc2000_i2c.c:166: warning: incorrect type in argument 2
                                  (different address spaces)
kpc2000_i2c.c:166:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:166:    got void *
kpc2000_i2c.c:168: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:168:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:168:    got void *
kpc2000_i2c.c:168: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:168:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:168:    got void *
kpc2000_i2c.c:171: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:171:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:171:    got void *
kpc2000_i2c.c:174: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:174:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:174:    got void *
kpc2000_i2c.c:193: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:193:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:193:    got void *
kpc2000_i2c.c:194: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:194:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:194:    got void *
kpc2000_i2c.c:214: warning: incorrect type in argument 2
                                  (different address spaces)
kpc2000_i2c.c:214:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:214:    got void *
kpc2000_i2c.c:219: warning: incorrect type in argument 1
                                  (different address spaces)
kpc2000_i2c.c:219:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:219:    got void *
kpc2000_i2c.c:226: warning: incorrect type in argument 2
                                  (different address spaces)
kpc2000_i2c.c:226:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:226:    got void *
kpc2000_i2c.c:238: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:238:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:238:    got void *
kpc2000_i2c.c:244: warning: incorrect type in argument 2
                                  (different address spaces)
kpc2000_i2c.c:244:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:244:    got void *
kpc2000_i2c.c:252: warning: incorrect type in argument 1
                                  (different address spaces)
kpc2000_i2c.c:252:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:252:    got void *
kpc2000_i2c.c:257: warning: incorrect type in argument 2
                                  (different address spaces)
kpc2000_i2c.c:257:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:257:    got void *
kpc2000_i2c.c:259: warning: incorrect type in argument 2
				   (different address spaces)
kpc2000_i2c.c:259:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:259:    got void *
kpc2000_i2c.c:267: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:267:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:267:    got void *
kpc2000_i2c.c:273: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:273:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:273:    got void *
kpc2000_i2c.c:293: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:293:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:293:    got void *
kpc2000_i2c.c:294: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:294:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:294:    got void *
kpc2000_i2c.c:309: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:309:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:309:    got void *
kpc2000_i2c.c:312: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:312:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:312:    got void *
kpc2000_i2c.c:317: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:317:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:317:    got void *
kpc2000_i2c.c:324: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:324:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:324:    got void *
kpc2000_i2c.c:328: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:328:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:328:    got void *
kpc2000_i2c.c:329: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:329:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:329:    got void *
kpc2000_i2c.c:330: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:330:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:330:    got void *
kpc2000_i2c.c:338: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:338:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:338:    got void *
kpc2000_i2c.c:340: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:340:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:340:    got void *
kpc2000_i2c.c:342: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:342:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:342:    got void *
kpc2000_i2c.c:350: warning: incorrect type in argument 1
                                  (different address spaces)
kpc2000_i2c.c:350:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:350:    got void *
kpc2000_i2c.c:350: warning: incorrect type in argument 2
                                  (different address spaces)
kpc2000_i2c.c:350:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:350:    got void *
kpc2000_i2c.c:351: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:351:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:351:    got void *
kpc2000_i2c.c:414: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:414:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:414:    got void *
kpc2000_i2c.c:420: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:420:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:420:    got void *
kpc2000_i2c.c:422: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:422:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:422:    got void *
kpc2000_i2c.c:427: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:427:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:427:    got void *
kpc2000_i2c.c:428: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:428:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:428:    got void *
kpc2000_i2c.c:430: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:430:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:430:    got void *
kpc2000_i2c.c:435: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:435:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:435:    got void *
kpc2000_i2c.c:436: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:436:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:436:    got void *
kpc2000_i2c.c:438: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:438:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:438:    got void *
kpc2000_i2c.c:439: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:439:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:439:    got void *
kpc2000_i2c.c:445: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:445:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:445:    got void *
kpc2000_i2c.c:446: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:446:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:446:    got void *
kpc2000_i2c.c:454: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:454:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:454:    got void *
kpc2000_i2c.c:459: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:459:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:459:    got void *
kpc2000_i2c.c:461: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:461:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:461:    got void *
kpc2000_i2c.c:472: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:472:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:472:    got void *
kpc2000_i2c.c:472: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:472:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:472:    got void *
kpc2000_i2c.c:475: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:475:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:475:    got void *
kpc2000_i2c.c:475: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:475:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:475:    got void *
kpc2000_i2c.c:493: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:493:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:493:    got void *
kpc2000_i2c.c:493: warning: incorrect type in argument 2
                                   (different address spaces)
kpc2000_i2c.c:493:    expected void volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:493:    got void *
kpc2000_i2c.c:512: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:512:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:512:    got void *
kpc2000_i2c.c:516: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:516:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:516:    got void *
kpc2000_i2c.c:516: warning: incorrect type in argument 1
                                   (different address spaces)
kpc2000_i2c.c:516:    expected void const volatile [noderef] <asn:2> *addr
kpc2000_i2c.c:516:    got void *

Signed-off-by: Eduardo Barretto <edusbarretto@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index b108da4ac633..bc02534d8dc3 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -123,9 +123,9 @@ struct i2c_device {
 
 // FIXME!
 #undef inb_p
-#define inb_p(a) readq((void *)a)
+#define inb_p(a) readq((void __iomem *)a)
 #undef outb_p
-#define outb_p(d, a) writeq(d, (void *)a)
+#define outb_p(d, a) writeq(d, (void __iomem *)a)
 
 /* Make sure the SMBus host is ready to start transmitting.
  * Return 0 if it is, -EBUSY if it is not.
-- 
2.22.1

