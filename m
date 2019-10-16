Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BDEECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6E3207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263758;
	bh=pSKK78qYuM/oMF/AE9JGU3jGCsV2zPg3W1Gx2TVmpoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YyBHmYLDTetRDLPED2IBNuFAclQrkTMaut7a/pNZoMi9dxQ0IId46uUWPyc6IGCHc
	 gs4lsKaBVOnS/imafDeZzBtWpHsCaQehN4LGHUByxhLYTYhQcgMR8XFEBqz+hEnTjP
	 lc/2UNwiqGdnx/Dg3SwHgANOWX4eJ7o/gwXGKpmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407105AbfJPWJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406681AbfJPV5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:57:35 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA40A21928;
        Wed, 16 Oct 2019 21:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263055;
        bh=pSKK78qYuM/oMF/AE9JGU3jGCsV2zPg3W1Gx2TVmpoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2mwEGlf/5dbK1L8IkRxYSaVP4SLALSIxf3PDMpMBEU9Ioj8A52+xyPrq1A+isRNY
         gIh5Z0TSDby3KeXQ093qsIzoWaYSfZbXz2wPBe5A3yJ06r0Ae88MG0XU9MYU48Y6BS
         alx2ntKPQnT3Vh7JJFbf440X2R2Hik1t7qxe4WUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 57/81] mm/vmpressure.c: fix a signedness bug in vmpressure_register_event()
Date:   Wed, 16 Oct 2019 14:51:08 -0700
Message-Id: <20191016214842.957825220@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214805.727399379@linuxfoundation.org>
References: <20191016214805.727399379@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 518a86713078168acd67cf50bc0b45d54b4cce6c upstream.

The "mode" and "level" variables are enums and in this context GCC will
treat them as unsigned ints so the error handling is never triggered.

I also removed the bogus initializer because it isn't required any more
and it's sort of confusing.

[akpm@linux-foundation.org: reduce implicit and explicit typecasting]
[akpm@linux-foundation.org: fix return value, add comment, per Matthew]
Link: http://lkml.kernel.org/r/20190925110449.GO3264@mwanda
Fixes: 3cadfa2b9497 ("mm/vmpressure.c: convert to use match_string() helper")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: David Rientjes <rientjes@google.com>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Enrico Weigelt <info@metux.net>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/vmpressure.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -358,6 +358,9 @@ void vmpressure_prio(gfp_t gfp, struct m
  * "hierarchy" or "local").
  *
  * To be used as memcg event method.
+ *
+ * Return: 0 on success, -ENOMEM on memory failure or -EINVAL if @args could
+ * not be parsed.
  */
 int vmpressure_register_event(struct mem_cgroup *memcg,
 			      struct eventfd_ctx *eventfd, const char *args)
@@ -365,7 +368,7 @@ int vmpressure_register_event(struct mem
 	struct vmpressure *vmpr = memcg_to_vmpressure(memcg);
 	struct vmpressure_event *ev;
 	enum vmpressure_modes mode = VMPRESSURE_NO_PASSTHROUGH;
-	enum vmpressure_levels level = -1;
+	enum vmpressure_levels level;
 	char *spec, *spec_orig;
 	char *token;
 	int ret = 0;
@@ -378,20 +381,18 @@ int vmpressure_register_event(struct mem
 
 	/* Find required level */
 	token = strsep(&spec, ",");
-	level = match_string(vmpressure_str_levels, VMPRESSURE_NUM_LEVELS, token);
-	if (level < 0) {
-		ret = level;
+	ret = match_string(vmpressure_str_levels, VMPRESSURE_NUM_LEVELS, token);
+	if (ret < 0)
 		goto out;
-	}
+	level = ret;
 
 	/* Find optional mode */
 	token = strsep(&spec, ",");
 	if (token) {
-		mode = match_string(vmpressure_str_modes, VMPRESSURE_NUM_MODES, token);
-		if (mode < 0) {
-			ret = mode;
+		ret = match_string(vmpressure_str_modes, VMPRESSURE_NUM_MODES, token);
+		if (ret < 0)
 			goto out;
-		}
+		mode = ret;
 	}
 
 	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
@@ -407,6 +408,7 @@ int vmpressure_register_event(struct mem
 	mutex_lock(&vmpr->events_lock);
 	list_add(&ev->node, &vmpr->events);
 	mutex_unlock(&vmpr->events_lock);
+	ret = 0;
 out:
 	kfree(spec_orig);
 	return ret;


