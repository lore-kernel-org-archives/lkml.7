Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277C8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0736206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ahPan2fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732915AbfDXQvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:51:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38719 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732571AbfDXQvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:51:10 -0400
Received: by mail-ed1-f66.google.com with SMTP id c1so10597350edk.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id;
        bh=iqXJdGaFlfiiJTJLgY9f/HTOvJcH9iD1vYBFNl3Eq7Q=;
        b=ahPan2fb23ZwJK9mMpjdr9I9tFYsGCh6Rybt9NG+QIubaMB4p29seFK7C2udYNBtjL
         wmzLLWDqhntze0GG9Nyxr1nII6YUI695r8neq+IJDQ4XtEi+63HXwaDRcpr9zYLNJp5B
         Am7CW9qqJykuKUHbv/x86wRnMANC8tferNKB5nkR4qKOjLEkvc/Jf/1X/OFjXQwMO33B
         VBIHJwIqKxOOGi3tTmc8aOKAGXFY1T9HWVrbaECBmUoOXUrvrPbhseLPpS5RXxSHG7ZY
         HQznn91+b757e5KuVboTDuQBT3FBn+qaqbhRaD5ShzJJ8ZfMOgVUrQ9NMUffvkQqr1MX
         v9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iqXJdGaFlfiiJTJLgY9f/HTOvJcH9iD1vYBFNl3Eq7Q=;
        b=Vs5Mqu3XPtxkxl8EK4up+gVo3NFFf9rSAFTCn8ZRdymmYCV1MNEtpabL60xan8HR7C
         uEm+XUcav94wh5sG7IyPLX1euAA+DhHFbndYtyzYpG92LPwYzrGdl4ZZ2MlqfEMvBHHW
         nxLXHk3cdIo4McifkQmvMLNsfiOuumn+w9kb8suYETQfZ5qfFtv/JtWXNBIiuzD5bZBV
         ehrqnMtO64YYMx3DcRxx1y+o3wjCgN8OYxlWPK6UXkzOFKZBTqJytstrAcWIVgk9K/rn
         jlir+41mIbw3mAIjqh8dDdg01jzFSTQhMFkfEiyap7XLZzubWIfg7qKV2S5pkFsDXe6H
         ti1w==
X-Gm-Message-State: APjAAAUJYf27osJAybXuL9tJrcmpmdLUgzLWn9rSlrZn6pwtAz5yAE1U
        BrUFUETaMqkjUxIS9LzmpcSd0g==
X-Google-Smtp-Source: APXvYqy5m0cq67m7iQ3AlUUZD6EjbVPpaKzlEqgdd4iUcMjCKGolFHT1tB4EF306EiVey+BlONNTvw==
X-Received: by 2002:a17:906:5855:: with SMTP id h21mr16482031ejs.264.1556124668507;
        Wed, 24 Apr 2019 09:51:08 -0700 (PDT)
Received: from localhost.localdomain ([80.233.44.160])
        by smtp.gmail.com with ESMTPSA id w54sm5800702eda.85.2019.04.24.09.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 09:51:07 -0700 (PDT)
From:   Tom Murphy <tmurphy@arista.com>
To:     iommu@lists.linux-foundation.org
Cc:     murphyt7@tcd.ie, Tom Murphy <tmurphy@arista.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1] iommu/amd: flush not present cache in iommu_map_page
Date:   Wed, 24 Apr 2019 17:50:51 +0100
Message-Id: <20190424165051.13614-1-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check if there is a not-present cache present and flush it if there is.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f7cdd2ab7f11..91fe5cb10f50 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1637,6 +1637,11 @@ static int iommu_map_page(struct protection_domain *dom,
 
 	update_domain(dom);
 
+	if (unlikely(amd_iommu_np_cache && !dom->updated)) {
+		domain_flush_pages(dom, bus_addr, page_size);
+		domain_flush_complete(dom);
+	}
+
 	/* Everything flushed out, free pages now */
 	free_page_list(freelist);
 
-- 
2.17.1

