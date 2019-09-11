Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D29C49ED9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 00:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CC22085B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 00:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBm4mmF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfIKAiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 20:38:10 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43702 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfIKAiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 20:38:09 -0400
Received: by mail-io1-f67.google.com with SMTP id r8so16916240iol.10;
        Tue, 10 Sep 2019 17:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dRI+UdAuaAbnPtCUSwMls+vSMICgBec5wWc6vxh4hkk=;
        b=OBm4mmF1te/FWhD/LX89H9UprVV9vS9/H2Np6nhNmwprVCnmDCcbySPjxXw4clpFPp
         g7IniQTiq4FgQPuztxxZjPuzChPi9IND59ptii0SCMHs7dyRHBKzLhxxa/CVbinoj8fc
         OoMlRTXgQQcD8M2ajqUiY7ECsGiApYfCIoAJqLNW44rpYVJ17S6KWEOmGz04Lei/159U
         B1NOCZFLKdX9b6wt7wXNJ7XB7upIPjm59+grmrdCWFJXtptKZCY6g7COllw44qXqaYWw
         yGWDj3gq0s548XMqOkpYybiorQAvmIbiDsZr3Gaxn3WdDZlQuEkIb0L7BqrkgUcC8EW3
         euZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dRI+UdAuaAbnPtCUSwMls+vSMICgBec5wWc6vxh4hkk=;
        b=fzq7zyQbHJjngSc/03P76LBCYEvFfgARX6uvKOuzCnri6JlrJ3E15ANu0pqtB/dkPM
         WX7ak06+SXRooWvk+oU3QSlWQl31wOOQk9urPQBS2BiMVMpSGkJljT1vkgbYapYcf5eN
         4OTg28zAn+UJmJUwxD/YrrUHmyS6lqM+w/pQ9l3sBmerXDbj0U2cg7Q9fj/WWMw9tbls
         And4LACtoYb1gQxcT6m5jOZB+a+HSb2ZyVKmORCpcKhjGTbByfc7sO1tjAK2BHYyp5ZR
         j+goAQ4LPLRw3KqGOjdb6PhA0iEQhR2EqDRpyluD5QA5BqpYdcNLxk9cAY+sPmTnvhz/
         Jf8Q==
X-Gm-Message-State: APjAAAXxQTNc/Q8aMLEgwNnoagvYuEabsQC5YW0grsymIeg7HRiJqPM1
        l0//+o8eejap6iergxX6b3A=
X-Google-Smtp-Source: APXvYqwp9FZpJ5cxlCa56IMz05LQ68eyqQTkw8sXV1jbfhzeViymUH1fmKgEyuj7eYkyl7WCVDII2A==
X-Received: by 2002:a6b:acc5:: with SMTP id v188mr39248679ioe.268.1568162288759;
        Tue, 10 Sep 2019 17:38:08 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id s201sm48548116ios.83.2019.09.10.17.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 17:38:08 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: qrtr: fix memort leak in qrtr_tun_write_iter
Date:   Tue, 10 Sep 2019 19:37:45 -0500
Message-Id: <20190911003748.26841-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In qrtr_tun_write_iter the allocated kbuf should be release in case of
error happening.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 net/qrtr/tun.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/qrtr/tun.c b/net/qrtr/tun.c
index ccff1e544c21..1dba8b92560e 100644
--- a/net/qrtr/tun.c
+++ b/net/qrtr/tun.c
@@ -84,12 +84,18 @@ static ssize_t qrtr_tun_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (!kbuf)
 		return -ENOMEM;
 
-	if (!copy_from_iter_full(kbuf, len, from))
+	if (!copy_from_iter_full(kbuf, len, from)) {
+		kfree(kbuf);
 		return -EFAULT;
+	}
 
 	ret = qrtr_endpoint_post(&tun->ep, kbuf, len);
+	if (ret < 0) {
+		kfree(kbuf);
+		return ret;
+	}
 
-	return ret < 0 ? ret : len;
+	return len;
 }
 
 static __poll_t qrtr_tun_poll(struct file *filp, poll_table *wait)
-- 
2.17.1

