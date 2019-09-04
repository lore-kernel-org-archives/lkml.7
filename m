Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7E1C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4173220870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567621442;
	bh=r3hHmwvr5gwac8HXyAhPmaX+ldpvoyfb/3IuCoowTQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NMPY1ag7r/Xf3bFG+/IlZcW8qtKL6Szu6FHQn5i37H5vSxuzD6cq25Cf8ENTDUyKG
	 yH0J0djHajwrKy2G6AlC4cWoHDJ71WbN6vbnEWjVMgK1685+zhqfSOceknAoKGz4AX
	 U6qCS4BrsyPiJV3azAfGh1f0wMJRNqr0OYQS4LQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388764AbfIDSYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:24:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388696AbfIDSCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:02:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E3C521883;
        Wed,  4 Sep 2019 18:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620132;
        bh=r3hHmwvr5gwac8HXyAhPmaX+ldpvoyfb/3IuCoowTQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXqzTzgcQdP/PiOm2IAoMHKqBUt9VqEaktH+4bWr4xaznTecqAw3lkE9nXYD3Pjf4
         wOrxPV/53pWnJwmjQjgno/WKyDJLn1B1amacE/PEx38MhfYnmGfBPfpNU/X3rGkn7N
         Idx5Nz2NoyOJtPVzQ1zp9XZIZf9EcHosqcPoAb0Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 4.9 76/83] stm class: Fix a double free of stm_source_device
Date:   Wed,  4 Sep 2019 19:54:08 +0200
Message-Id: <20190904175310.312768172@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175303.488266791@linuxfoundation.org>
References: <20190904175303.488266791@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ding Xiang <dingxiang@cmss.chinamobile.com>

commit 961b6ffe0e2c403b09a8efe4a2e986b3c415391a upstream.

In the error path of stm_source_register_device(), the kfree is
unnecessary, as the put_device() before it ends up calling
stm_source_device_release() to free stm_source_device, leading to
a double free at the outer kfree() call. Remove it.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: 7bd1d4093c2fa ("stm class: Introduce an abstraction for System Trace Module devices")
Link: https://lore.kernel.org/linux-arm-kernel/1563354988-23826-1-git-send-email-dingxiang@cmss.chinamobile.com/
Cc: stable@vger.kernel.org # v4.4+
Link: https://lore.kernel.org/r/20190821074955.3925-2-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/stm/core.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -1107,7 +1107,6 @@ int stm_source_register_device(struct de
 
 err:
 	put_device(&src->dev);
-	kfree(src);
 
 	return err;
 }


