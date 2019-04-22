Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A15C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AFB20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehY9PW61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfDVStl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:49:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39452 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbfDVStl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 14:49:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so16831133wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 11:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O02w/qPvou1PNbrBp7wY+BGgwS7HeOGpfaENp5+6Q6U=;
        b=ehY9PW61YcSuoLrSg9qzwstMVo1CzH0IQ6UxLAjEaXn3shl892d4YzBMBY5mBnwM8V
         DwGS3uZ/d8ddKorOPpn5ZCSzrYIOpr8of+zPa7trXN9I3ebG0Wpax3+qxY+SG+q+tEN7
         QxW6YBuSzoh95E5acXyLKAarlwY9yNkQ/+RyK0nyqWlqCUIU+SLKNSXdUvhbG2HzetfK
         QfeCvCjCnHyGMYNCRbEznYwMyzNE68Vjw3gh9ItO7XXfD3Jb+SX8x2tdeTwHgGVaQ/fv
         JjJ8vOZKE2CA28pv5mdSXgorbEimtZavIrCqT+FLkl+vACGCby/9mD0GihKkx2sGqdUy
         RBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O02w/qPvou1PNbrBp7wY+BGgwS7HeOGpfaENp5+6Q6U=;
        b=nVKssogALPThKyyadifT6l3YTZnY+mGCRLzd5b4WbhmxJmrxKPNwE2kU1/9LxClCJs
         HBsbK0Kbk2AHPKESCb3JoDGhdCMYu/BPki2L2rWP5EyImUDOS0mezQIKOdZIYAmEOvbd
         058Z3568nfkZztBPzmrTFlZ8PJ3sntF7b0DDFIRQAwGO27Lc5TovqKCnsEo3YgSZx1SF
         eUWSa7iXBGna7kU9OUP82fR421qv+zp+kfLHrTarfP5AlWCcKNd86dHOYJzwhrjlXGJF
         A1++7uTMgEg09dtkOL/4v2HjUFe38quTx6gxzPL0kH/kXMkgW6Aw11+IXCaILUt/ju2p
         zmLw==
X-Gm-Message-State: APjAAAXfIWI1QgNWG3BjmjHAxENRduom9eyQkm+bA4D36rQ72ziwFD95
        X5XJWqbnGjVlPe6D22KW0Cg=
X-Google-Smtp-Source: APXvYqybhYFQSuGjgzO43mwbzoWQoAGQZY7en7XXAlkqEP3Zmxc/HRVjOAtwlb1r4QSVdGvVJPYMpA==
X-Received: by 2002:a05:6000:124a:: with SMTP id j10mr14642007wrx.24.1555958979434;
        Mon, 22 Apr 2019 11:49:39 -0700 (PDT)
Received: from luna.home (2.154.17.217.dyn.user.ono.com. [2.154.17.217])
        by smtp.gmail.com with ESMTPSA id o2sm10926570wrs.89.2019.04.22.11.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Apr 2019 11:49:38 -0700 (PDT)
From:   Oscar Gomez Fuente <oscargomezf@gmail.com>
To:     oscargomezf@gmail.com
Cc:     labbott@redhat.com, sumit.semwal@linaro.org,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: ion: solve warning symbol was not declared
Date:   Mon, 22 Apr 2019 20:49:27 +0200
Message-Id: <1555958967-29149-1-git-send-email-oscargomezf@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes solve warning symbol was not declared in the functions:
ion_carveout_heap_create and ion_chunk_heap_create

Signed-off-by: Oscar Gomez Fuente <oscargomezf@gmail.com>
---
 drivers/staging/android/ion/ion_carveout_heap.c | 2 +-
 drivers/staging/android/ion/ion_chunk_heap.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/android/ion/ion_carveout_heap.c b/drivers/staging/android/ion/ion_carveout_heap.c
index bb9d614..3f359ae 100644
--- a/drivers/staging/android/ion/ion_carveout_heap.c
+++ b/drivers/staging/android/ion/ion_carveout_heap.c
@@ -103,7 +103,7 @@ static struct ion_heap_ops carveout_heap_ops = {
 	.unmap_kernel = ion_heap_unmap_kernel,
 };
 
-struct ion_heap *ion_carveout_heap_create(phys_addr_t base, size_t size)
+static inline struct ion_heap *ion_carveout_heap_create(phys_addr_t base, size_t size)
 {
 	struct ion_carveout_heap *carveout_heap;
 	int ret;
diff --git a/drivers/staging/android/ion/ion_chunk_heap.c b/drivers/staging/android/ion/ion_chunk_heap.c
index 3cdde9c..7e44344 100644
--- a/drivers/staging/android/ion/ion_chunk_heap.c
+++ b/drivers/staging/android/ion/ion_chunk_heap.c
@@ -107,7 +107,7 @@ static struct ion_heap_ops chunk_heap_ops = {
 	.unmap_kernel = ion_heap_unmap_kernel,
 };
 
-struct ion_heap *ion_chunk_heap_create(phys_addr_t base, size_t size, size_t chunk_size)
+static inline struct ion_heap *ion_chunk_heap_create(phys_addr_t base, size_t size, size_t chunk_size)
 {
 	struct ion_chunk_heap *chunk_heap;
 	int ret;
-- 
2.7.4

