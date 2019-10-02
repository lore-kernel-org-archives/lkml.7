Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5D3C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204FE218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="bNDdQgB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfJBVXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 17:23:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35859 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbfJBVXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 17:23:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so296412pfr.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 14:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gkWD3FKbpCaOmlNmSaWAbFMYVFKw7GUZL8P7zrFBNqw=;
        b=bNDdQgB1uj+hDptnsbMFd59gnpNWR4vY0/rGDWxRSZe+7SPnTYVU83wv2B3aAW15Hq
         StO8G/DST6AQmmlP5rEye2vkKzHCaLS+rDDb6yQ8CxwYyxjBWOCt8nE2Mg96EVRcXHK1
         qcoxrjXlUKY5CkT20yAWGWdCXiJLSy6+nErDCRr6rmNH6R7XHvAx0hs6z4RLkuQHE5GW
         HBXbnNdUz62+Y4QBAI0DpToAg8/WmZsdEdsSFalCXR/OpmZYg06AL0bxURTAYWJQJYDu
         TczibJyc4uxD47jqI7+iWcK23IlUcyBxO5VaSMCcm28yZVml06jXRAaZ4VOnWl1aVQ3P
         Z9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gkWD3FKbpCaOmlNmSaWAbFMYVFKw7GUZL8P7zrFBNqw=;
        b=Y7i42KgmA/iZfX0j7gp6MU6XNcYAOJ0H1BF/zBv5djDmFvCbD+nnbTHoL7FaL20hwi
         hsfuYV2DD4ekmsBImdeHT5Kt7qY1SsNXnET361dRQcLwcBXnVC/zWFp5e23k8SzbEuKx
         das+ARW7QDM6EqO2sRnTArfq5opG1fNvkJAAYVXZ5ygXKUxHhjGwvizd90unhu9QS0re
         86ZmDxcV8S0H5NMKwwR9nKPanKtRWknct0O+ZaNZje2bYpGeeFlPGtwmAxodu22JSvyd
         lvssjbjMO/bIdqU06d712mzqM0zddVYjb3NXonrHegkRXJ+GuAaaFra4sNOKWdSCdL3X
         1YYQ==
X-Gm-Message-State: APjAAAXyGLmQOdR2VfGEkOksKGizjsZWa1GHqtLP0xGv6teB48Qwi+Le
        lFju5qPadnA2LAaF4QmA7iqsrEcehDSOhg==
X-Google-Smtp-Source: APXvYqzO0DSoowzhXSE00O5GdA1VH41PU6/vpYojcKIASrsGipsud0fd1iiHtjmW/PZKRsSyOaET9g==
X-Received: by 2002:a63:1e1e:: with SMTP id e30mr5528008pge.405.1570051388864;
        Wed, 02 Oct 2019 14:23:08 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id j22sm297855pgg.16.2019.10.02.14.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 14:23:08 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yue Hu <huyue2@yulong.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ryohei Suzuki <ryh.szk.cmnty@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peng Fan <peng.fan@nxp.com>, linux-mm@kvack.org
Subject: [PATCH] mm: export cma alloc and release
Date:   Wed,  2 Oct 2019 14:22:48 -0700
Message-Id: <20191002212257.196849-1-salyzyn@android.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers can not be turned into a module without cma_alloc and
cma_release exported.  Examples include ion, and we also found some
out of tree infiniband and camera drivers.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: kernel-team@android.com
Cc: linux-kernel@vger.kernel.org
---
 mm/cma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index 7fe0b8356775..65d830eea3b1 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -500,6 +500,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	pr_debug("%s(): returned %p\n", __func__, page);
 	return page;
 }
+EXPORT_SYMBOL_GPL(cma_alloc);
 
 /**
  * cma_release() - release allocated pages
@@ -533,6 +534,7 @@ bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(cma_release);
 
 int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
 {
-- 
2.23.0.581.g78d2f28ef7-goog

