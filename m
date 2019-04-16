Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F11C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320C52064A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3NZiWFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbfDPSit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:38:49 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:38095 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPSis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:38:48 -0400
Received: by mail-wm1-f42.google.com with SMTP id w15so290671wmc.3;
        Tue, 16 Apr 2019 11:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aY34jbKMvKXwJq0QH5UMNn6Is3Xuqx1ETNhcjeMB2M8=;
        b=V3NZiWFNkLwUXO4C+ITIDTipqhwCQmUSoZAI5ZL1aIwX3ps1jbWoZZU0SnBrngRq0l
         93N9KtLJJziCs/VyxPs7Ydeo20khj+eNN65y0UOcPfAU8cH82bWCLVohfmBjwp/AC2w2
         EN4HyhI8ZJq1Q1HGIv/fbIK/ITtj4mQSL+0kD92Kx+QdU22oWHkh/GoyDZxAQv236xVJ
         /y21ikDm3FnemGwIDxULpqpnKGtgtQxyIx0psX8Vn9OlUbVNMzojD1BlJvwycDfRosbD
         bAx5IVt2d0XLQ54s6s9hmA+IhIagSWQS4cg5b0dhZ/IR8MFpBf4UwHcsuRGb7LrmvsES
         9qFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aY34jbKMvKXwJq0QH5UMNn6Is3Xuqx1ETNhcjeMB2M8=;
        b=WIgwyEeu+xqljF7lTdktZ6Nlt8suZEMunJYiYQ9z/4sboV8omdya+BERKcslyADDp1
         DUxvE/oqAdZYM2VisPcNntPaGdPEMwEhhlIHQTRN0nUyg5RifXhPyDJQ3hGldfM8t3zL
         6l3veKvMb+VJXVgkTluhEm6MzoRAjnhbG74kFam4knFBBorS5dj+ybavqWjTZDhGzqFt
         xyTqCuTT7UvHu5iih7KWYSEgIFcdOus9P1HevklrvD1Fw5jNNt/dOMFNJb2zetzdRI79
         0P2vFIr4BCAAAzLvR6shTsSPRJVR/1V69Y/VhjjGCBCxqaKIRn+s3epLb+GWcdUqFKgh
         9AvA==
X-Gm-Message-State: APjAAAWFFRLtJTOHCmtqGtuDkXqczF/H7gOu8IlWT5WWIWhAF68k8w0V
        pO4jmLgIbiswZWZcZzmnFzGGq8Zh
X-Google-Smtp-Source: APXvYqzi0R5AdofszaHEIuWejJF9Gexx5H/wXrALOcBcRNSLSNnkP6WDlm6QBoh9FeZXapxhVASt+w==
X-Received: by 2002:a1c:43c2:: with SMTP id q185mr26532146wma.53.1555439926718;
        Tue, 16 Apr 2019 11:38:46 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:fcfa:e34f:82c0:3f66])
        by smtp.gmail.com with ESMTPSA id m13sm128823wmg.42.2019.04.16.11.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:38:46 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: dynamic DMA-buf sharing between devices
Date:   Tue, 16 Apr 2019 20:38:29 +0200
Message-Id: <20190416183841.1577-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

core idea in this patch set is that DMA-buf importers can now provide an optional invalidate callback. Using this callback and the reservation object exporters can now avoid pinning DMA-buf memory for a long time while sharing it between devices.

I've already send out an older version roughly a year ago, but didn't had time to further look into cleaning this up.

The last time a major problem was that we would had to fix up all drivers implementing DMA-buf at once.

Now I avoid this by allowing mappings to be cached in the DMA-buf attachment and so driver can optionally move over to the new interface one by one.

This is also a prerequisite to my patchset enabling sharing of device memory with DMA-buf.

Please review and/or comment,
Christian. 


