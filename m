Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56322C742BB
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310A3216C8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934860;
	bh=bMDBISCFA1Y9UGDCNYOasL4S4+ir75q8XGtLoIPGPmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bO4jgKV9a2YPhHuYWyfMqQeB1M/igJtyr4yM4UPcOfX3mssUD8GJnruSqWIjF6oU6
	 gTVmegO1DthAlrd0oB7BIOkObiINDy+QoVoYC/5pYhzF3w7orc3AXFbBBcHEMOcxBk
	 v5VAJ5nkRnX+1JF11rsBOMiSzr16K5rf6fX48XxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbfGLMeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:34:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729350AbfGLMeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:34:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F8B220645;
        Fri, 12 Jul 2019 12:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934854;
        bh=bMDBISCFA1Y9UGDCNYOasL4S4+ir75q8XGtLoIPGPmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A8ggqw8d2oUON48KII1lgClrFCP78RHyIM5XYjf0X4T6fmSndrGN4yRt5BBFiQkYX
         PU6QFgmHChCgLnJPjXbJomVuj/e9+QyX6H4c8jkvWqE8dgOYzh+sTCkLsBvWgFKkD2
         J+gWI80KCwd2hUDdMIpTvHFFpwK1ssDnlnR4Mtlo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 5.2 53/61] staging: vchiq_2835_arm: revert "quit using custom down_interruptible()"
Date:   Fri, 12 Jul 2019 14:20:06 +0200
Message-Id: <20190712121623.580255307@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121620.632595223@linuxfoundation.org>
References: <20190712121620.632595223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

commit 061ca1401f96c254e7f179bf97a1fc5c7f47e1e1 upstream.

The killable version of down() is meant to be used on situations where
it should not fail at all costs, but still have the convenience of being
able to kill it if really necessary. VCHIQ doesn't fit this criteria, as
it's mainly used as an interface to V4L2 and ALSA devices.

Fixes: ff5979ad8636 ("staging: vchiq_2835_arm: quit using custom down_interruptible()")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -523,7 +523,7 @@ create_pagelist(char __user *buf, size_t
 		(g_cache_line_size - 1)))) {
 		char *fragments;
 
-		if (down_killable(&g_free_fragments_sema)) {
+		if (down_interruptible(&g_free_fragments_sema) != 0) {
 			cleanup_pagelistinfo(pagelistinfo);
 			return NULL;
 		}


