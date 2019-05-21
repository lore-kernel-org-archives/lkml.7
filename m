Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09375C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAA920863
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHZwKGdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfEUISn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:18:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41758 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfEUISm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:18:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so8659906pfq.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SADUbUTzsKuL6+0zlFN554wz3Ug1cJN9qaVymCYLya8=;
        b=BHZwKGdYC4YFVaHpm+hBmmJB4lH/Z8+b3huOiHWORXzkHNPTYuyNtkiDxJF1EmPPNj
         wR1iZK+lRonMAXFS/e0oSm2hg8DbC4Yml22Nq3+uqbcyREKic5lq6oneLAe16AYyfvZq
         oH38WCobDveybevfmSYAw6x9UWQyUhB+1qD5YV05tk3vpLLCLHRHk9Z1lAXKnEGO+qiA
         roaV6umSdiHTEI2JiPYtKotOTeYqFXPi8U2cmG32zX6fUfWlkQetemJfG1N8XRhF9Ndx
         zoCrABL1YLB7Wkt3dtZK0u39QGZAWb+HfDKeP7J6Oj8pIC4NqdkDbc4Ad/FHNowt/03U
         g5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SADUbUTzsKuL6+0zlFN554wz3Ug1cJN9qaVymCYLya8=;
        b=pl8R50+w8heBF12OzusQ4jSyzPOdZ6TbTeKO/02LfstfOtKRdiin4Vj2CIi39EcO8T
         H0KySGh48v/SblYWUV+Pf0l1UPN47P6ucJDokuVUYWS4ZIeug3EQ19hTxGSDfveeeQwz
         7OPPOARR5QDCteR8MU/PRifWT+qhXo9PH4bi8kaREqRoOBo19NqOdCxha1EUjXklav59
         PCaN3oc133xijFfhS9DY63Tj3lIU13qCji4BSkEgTpo9EuFEYyHRIQc04OnIV7X/ke8I
         z7BPprSXskDowdECPtQHsM2Lw6bKmEI9o0oKwpdAlY7HYn8PwjfDy6IqXuvyrK2gKsrI
         7PxQ==
X-Gm-Message-State: APjAAAXs3oZweyqUU+aDKiQviHE6s5dEylcCY+4WE7WdI3OvyS5yNRZ0
        CBFYaassmWjWtjKToFhQMIE=
X-Google-Smtp-Source: APXvYqyQwWRpiD54NVNz5FFsmleFugsWgbhNE3P19M8BKlA3Sx/HRu968kWKNtIhiwdLYlmUvoxoPg==
X-Received: by 2002:a65:550b:: with SMTP id f11mr79773821pgr.311.1558426722194;
        Tue, 21 May 2019 01:18:42 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id e24sm30753184pgl.94.2019.05.21.01.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 01:18:41 -0700 (PDT)
Date:   Tue, 21 May 2019 16:18:29 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     agk@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] dm-region-hash: Fix a missing-check bug in
 drivers/md/dm-region-hash.c
Message-ID: <20190521081829.GG5263@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function __rh_alloc(), the pointer nreg is allocated a memory space
via kmalloc(). And it is used in the following codes. However, when 
there is a memory allocation error, kmalloc() fails. Thus null pointer
dereference may happen. And it will cause the kernel to crash. Therefore,
we should check the return value and handle the error.
Further, in __rh_find(), we should also check the return value and
handle the error.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

---
diff --git a/drivers/md/dm-region-hash.c b/drivers/md/dm-region-hash.c
index 1f76045..2fa1641 100644
--- a/drivers/md/dm-region-hash.c
+++ b/drivers/md/dm-region-hash.c
@@ -290,8 +290,11 @@ static struct dm_region *__rh_alloc(struct dm_region_hash *rh, region_t region)
 	struct dm_region *reg, *nreg;
 
 	nreg = mempool_alloc(&rh->region_pool, GFP_ATOMIC);
-	if (unlikely(!nreg))
+	if (unlikely(!nreg)) {
 		nreg = kmalloc(sizeof(*nreg), GFP_NOIO | __GFP_NOFAIL);
+		if (!nreg)
+			return NULL;
+	}
 
 	nreg->state = rh->log->type->in_sync(rh->log, region, 1) ?
 		      DM_RH_CLEAN : DM_RH_NOSYNC;
@@ -329,6 +332,8 @@ static struct dm_region *__rh_find(struct dm_region_hash *rh, region_t region)
 	if (!reg) {
 		read_unlock(&rh->hash_lock);
 		reg = __rh_alloc(rh, region);
+		if (!reg)
+			return NULL;
 		read_lock(&rh->hash_lock);
 	}
 
---
