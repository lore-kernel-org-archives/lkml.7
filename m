Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC84CC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FE320854
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHOSjX1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfDPBvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 21:51:08 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35468 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbfDPBvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 21:51:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id h39so21618938qte.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 18:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6RYP1qJxbC12RiDD1OSXg2NWtdncK/Kh06MBDM8RrB4=;
        b=FHOSjX1ztvbz4szczUC43RvkA3wCX/g7M64JaSlKy/RCqTglxRDB1cp4BFl1W8DhqG
         Cr4a6UqBnOPg788nc/QYBAkcC0QiCflovclaXUHrFKJOdJ7GoYplt06HCTbVlQEJrjLc
         SLzs2ed4JLMrBZF8x7D3m7XqKoST4C6NZLHpCHxAz99LR+5t4dYxn46F+c3oS7gMpOAj
         AQsVbZe+03UXv63r0hukt3G8S1zHoNtnWVJi/exqS0pA3lqtyYGMCEskXue3WuoAN9+I
         WzQt7NUo56Eznstf5LRLji05+kSChyXmj5Gwj3E8qjxGVWwTOVa8soD64GM5GmSz09XE
         7YHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6RYP1qJxbC12RiDD1OSXg2NWtdncK/Kh06MBDM8RrB4=;
        b=Q6TEg2BbLxniadJ4u6Cq2DsxwI2KbDB++NU5PmyagifzIkrrC6QJXKUMqhFbqCnbQm
         /GsaWm55js2RV3hFcYahd2nq7nGIxhEdPTUWJ7ih7ArR9J05v408b+XZWe4GgjV6Udfh
         p8eBilIiSx3gnX/k7Q9tIAgcdnmbOjmiiHzHW9/ubaBVjV3L15Ui0rLKkxXKG6Trbc00
         FV7Uv8ByWn5FsXYaPDY8PQA9Zljwk7++W0/C2nkL5OsSzLRUbxMpnGTYIwB0Gtg2HmXD
         wGF/9fjDpABAmXHZzKj2vKJOfGi90Wnqnm25scy8IBdJfyMC5RIwsLfaLHcnoUxNXRxm
         CVng==
X-Gm-Message-State: APjAAAVsgfVYiP1y84l3Os7EB8tgTCHwNwfZ6lB8vWLzQveTPV3iJu0e
        CKL6bNMGECeLeQUIlmdhZhY=
X-Google-Smtp-Source: APXvYqzbRBi7gunIo9uAA3fB8IuOX//qF7IRJau+c2BZumZnfa9Qqlemu4+QZ6gweKMxmF88xmWnqg==
X-Received: by 2002:a0c:91cc:: with SMTP id r12mr61520431qvr.35.1555379466999;
        Mon, 15 Apr 2019 18:51:06 -0700 (PDT)
Received: from debian (hlfxns017vw-142-68-56-253.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.56.253])
        by smtp.gmail.com with ESMTPSA id a188sm21729477qkf.34.2019.04.15.18.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 18:51:06 -0700 (PDT)
From:   Brian Yip <itsbriany@gmail.com>
To:     christian.koenig@amd.com
Cc:     ray.huang@amd.com, Jerry.Zhang@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Brian Yip <itsbriany@gmail.com>
Subject: [PATCH v2 0/2] drm/ttm: Cleanup state in global ttm structures
Date:   Tue, 16 Apr 2019 01:50:33 +0000
Message-Id: <20190416015035.1435-1-itsbriany@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

State in global ttm structures was not properly reset on cleanup.

In the scenario where multiple drm drivers are loaded and the first one 
fails to initialize, there is an attempt to reset the global state in
the ttm structures. However, there were some attributes which were not
properly reset during this process. This resulted in a crash and 
false positive kobj initialization warnings during subsequent initialization
of these global structures.

Fix the crash and false positive kobj initialization warnings.

---
Changes in v2:

State in global ttm structures is reset by means of zeroing memory
in global structure initialization functions rather than checking
reference counters in their corresponding release functions.

Brian Yip (2):
  drm/ttm: Reset ttm_mem_global when initialized
  drm/ttm: Reset ttm_bo_glob when initialized

 drivers/gpu/drm/ttm/ttm_bo.c     | 6 +++++-
 drivers/gpu/drm/ttm/ttm_memory.c | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.20.1

