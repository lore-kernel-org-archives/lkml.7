Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C0AC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 04:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7A5214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 04:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3nPu8RM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfIHEgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 00:36:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46280 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfIHEgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 00:36:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id m3so5780049pgv.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 21:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RtKloxjFpA2t5GP1ywopBt0f8T0oeF2HbZwg4ACNdgA=;
        b=I3nPu8RMFPAOjfzb+RUf8Mi5gIkb+Cu56HHzE+93Xw25Xn1IgtLQblsyCgVYhfhfaf
         1wh7RGmFtbt1LbBcG3sqfpAPGJbV4nKGpXkvHL7W1Jbz2JCHvacL1js3Kny6IWT6lF4X
         NNzQTygYqAYbriWrmvEwl2KqraJ9weRhQPeFhi1fOX53BVG0lgCjV3NLg2kzug4TEQRc
         KPZkGTbYLEXreZrYkpPuPNKZ94ZYHNSnUPsDWfqqAnic7ePQAjjQKft1Yf1xiSyqMJQa
         AmkJJ52qBm1rLO3hF/659y3XDTahKd7azIvAmZcOR7EHtWc2vboqgjx9vq7FZRLZH5Md
         kV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RtKloxjFpA2t5GP1ywopBt0f8T0oeF2HbZwg4ACNdgA=;
        b=Zp8/13XOZMKdh60q9NUF5vfrbAUQ+2Zsv5N51shNBfV6RRlyYbjwq2YjPpGMN51YsC
         O87Gw8+faGwhQpnnLutqav2BJlHT/zadkh2hR3QvJhm7Z+cf/ylcFtVOKxIXUAZFMFvT
         7tty9UaMA4WJlhOz654Vb+czrAclQPLGfXUTMv7p4kydg+3C3jRfFuKS9aWSa/BhqOEV
         xog4FV7fzP7xeEIjFpPH6dBSyiIoYcd11tKVcrzPkpNbdYoCxFyxsaFl3/a3+i/nblfR
         9prPDnIzuW+uPLTppn9DHy5CUGHzwKyd6WdwzG/8xHKuIWEI+Sr2uWKpQbUIHR2anQvT
         vFLA==
X-Gm-Message-State: APjAAAUe9g0yycG6vKXI2vjhXmJVaH9qRW7rQNtQlgo0NYwPzt1ZQr/2
        6mD/4lMfRHSbH7YG3YzDDSxhubQSzMLejA==
X-Google-Smtp-Source: APXvYqyw3tU05UDMXdb6AFEITR7kgX4+Eq37oNhLv/4hoo+Qf91BgNisp1ZeprOqEnZ4Y7w2V8QLTQ==
X-Received: by 2002:a63:2349:: with SMTP id u9mr12722661pgm.214.1567917395763;
        Sat, 07 Sep 2019 21:36:35 -0700 (PDT)
Received: from localhost.localdomain (ip-103-85-38-221.syd.xi.com.au. [103.85.38.221])
        by smtp.gmail.com with ESMTPSA id v184sm8435643pgd.34.2019.09.07.21.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 21:36:34 -0700 (PDT)
From:   Adam Zerella <adam.zerella@gmail.com>
To:     labbott@redhat.com, sumit.semwal@linaro.org
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, Adam Zerella <adam.zerella@gmail.com>
Subject: [PATCH] staging: android: ion: Replace strncpy() for stracpy()
Date:   Sun,  8 Sep 2019 14:34:50 +1000
Message-Id: <20190908043450.1078-1-adam.zerella@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using strncpy() does not always terminate the destination string.
stracpy() is a alternative function that does, by using this new
function we will no longer need to insert a null separator.

Signed-off-by: Adam Zerella <adam.zerella@gmail.com>
---
 drivers/staging/android/ion/ion.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index e6b1ca141b93..17901bd626be 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -433,8 +433,7 @@ static int ion_query_heaps(struct ion_heap_query *query)
 	max_cnt = query->cnt;
 
 	plist_for_each_entry(heap, &dev->heaps, node) {
-		strncpy(hdata.name, heap->name, MAX_HEAP_NAME);
-		hdata.name[sizeof(hdata.name) - 1] = '\0';
+		stracpy(hdata.name, heap->name, MAX_HEAP_NAME);
 		hdata.type = heap->type;
 		hdata.heap_id = heap->id;
 
-- 
2.21.0

