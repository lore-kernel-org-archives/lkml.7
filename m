Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0522AC48BE8
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 19:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A3F20656
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 19:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KQ4j5ZKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfFWTSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 15:18:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44379 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfFWTSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 15:18:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so6199459pfe.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 12:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=f9qXptgylHIAEQXQTAuBnq2RBq3dvQEaePaTzKc6t5o=;
        b=KQ4j5ZKmjcMZt3yJiy9ufK2L4dMLjg1mXx6wX7BtxENgmv9ZDdkCUV1I9bSu4M/8ik
         9mnLUHwkqwm3G/cVj/1SUXEbG0XWNrmOyC9l3b1H5cGyncPyiwkUg8tQEEhMFfjLuh82
         jy/is46Fjz/qQixn41IByRhOMz3Bmgb7W3xiLSejYdSh7MJ9y3BA67/GYoDe5eBU1slV
         n/Jr4PdFwyPoc7lqMcMQAyvwzCrhO52Qea7CXiW0tX1Sq4jnVyZ5bMVlHb9NAW8TiEVg
         gGwAukMIfG9ytZ1KpjlWijFFoU70ZTUa9rVf8APnhmyMsv0YX5SriHHYNsgpp+4xCAYp
         1NlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=f9qXptgylHIAEQXQTAuBnq2RBq3dvQEaePaTzKc6t5o=;
        b=HXySyJDGBpz2ax69LYt9MOjzJjsAnkk4B6tnzzY8AFNywuSFFPMkUac4cn7iViiDDi
         51rZPUr+WTOpMuxT9rYoyx2Uwsfe9NT5NUt2JDujEXmw78WXkqEktCpsS5xRagmBnki7
         gNEIvJkeOx1//v3FK191KVSrvZDI+kk/vhPqv49bzxvGZFloPxqjIpiDowPP/yVA4uSu
         Hpol7k9qyrhY/yaEKShsBP4i5F+KcWa1dfTZF46LJeAJ3x/Cj7+GXmP/UdQJvHZ8J9dL
         opWKTV5QxRRs/32b4ZML93lOW0DvyW2EcVyxBHneYxvs/EfYbroGMdienxWO7e7FFNPH
         fd9A==
X-Gm-Message-State: APjAAAWwmV648QYAYnesncjnOLdkI8Yi7qdCyawuSxr8OtJ+PvI0LsTr
        y+i0fmrmtPHqX7DlsQyT2oFw7NBtI4k=
X-Google-Smtp-Source: APXvYqy6th0fKsgTaL4WunOqvuhGKOUKqQYaQw7eAE0Dqj3MtmkeNpMhyAK2c4KAlL1lXEfEpOBw9g==
X-Received: by 2002:a63:4419:: with SMTP id r25mr30247484pga.247.1561317525806;
        Sun, 23 Jun 2019 12:18:45 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id f88sm9808002pjg.5.2019.06.23.12.18.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 12:18:44 -0700 (PDT)
Date:   Sun, 23 Jun 2019 12:18:44 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Cfir Cohen <cfir@google.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [patch] crypto: ccp - Free ccp if initialization fails
Message-ID: <alpine.DEB.2.21.1906231217040.15277@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ccp_dev_init() fails, kfree() the allocated ccp since it will otherwise
be leaked.

Fixes: 720419f01832 ("crypto: ccp - Introduce the AMD Secure Processor
device")

Reported-by: Cfir Cohen <cfir@google.com>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 drivers/crypto/ccp/ccp-dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/ccp/ccp-dev.c b/drivers/crypto/ccp/ccp-dev.c
--- a/drivers/crypto/ccp/ccp-dev.c
+++ b/drivers/crypto/ccp/ccp-dev.c
@@ -609,6 +609,7 @@ int ccp_dev_init(struct sp_device *sp)
 
 e_err:
 	sp->ccp_data = NULL;
+	kfree(ccp);
 
 	dev_notice(dev, "ccp initialization failed\n");
 
