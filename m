Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6FFC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070CE20854
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNK47jx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfDPBvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 21:51:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40987 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbfDPBvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 21:51:12 -0400
Received: by mail-qt1-f193.google.com with SMTP id w30so21561650qta.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 18:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iEqK/Uere5YVpob1bLVTLrTKBhiWryemr+qiDgp/Rrk=;
        b=kNK47jx/YNFA6rMJKCrifdOeVPbth+hFKMmdfbZ1jAWcm0ZFkGZMBUEuJhuO/iH3oh
         g0GJeG90OWf4z3YliJOoIhrbrxNxYIlTdf+7VroGhjN3l1Pa3IVaRsupoyOE9hGmA6y4
         kpkzG3A04Ucwsn4WgueoQTxTMFYEHHxJ8bgS11uG3H7+NnxR5Vwfeh2NZD1uCyzQm854
         423/tyd8JEgwiLRlmV6r89oPgiYq74mwtoJ6poaMm64y++yJvGOo7Z9b9tf/ayariMQp
         8HGF+BEx9si+QHhUYVfcibOGZ7pJNbpi9KWguKh79g+Xw9sgKlHa21UL7p1Ln+TpVbFH
         NO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iEqK/Uere5YVpob1bLVTLrTKBhiWryemr+qiDgp/Rrk=;
        b=chRRKTWhvjDeppRED4ZjMCd2g/axz9EjzzyKou/eqGN8LRddt60OjjNKxoLNx7Qdsg
         3EcwrQf7s1S2OZBwLQL+ecjICvQEgNnTF/KIFQao+QRzxHZ3UcxEBpvZLQtmugezvGkD
         kMFkODBdtDNqgzepzR9Drmp2wSaanxLOBwySBJbpK9UlCnzIGW7dV1387FODxmpN3zY9
         Kg7KwBdhusI3Kx72WB1fEmulBuqgy6naVXYR/t5U0kDEYG/RmSS/XUZpmZm31vgvBzB7
         O49dA1Ef9wJ6SEREwAFD5Ag5WkVMS+Qa0qNaaRdQ5Q/6Az5Sa0hoOE4eXk6kxfv4cune
         elUw==
X-Gm-Message-State: APjAAAXdP/+z6AWuf+Rir2z8W375PMQK5jQyzl2RJQIjDsIBDfRvJ4CK
        A835dVqaGBaesAhyIsp7rkk=
X-Google-Smtp-Source: APXvYqxug9XDQ78RuQejXarhB0WYk3ATSsLUm5xhIUpe5rvuCT3z0oiNaNJWGMb34iAbveK1Id8rvA==
X-Received: by 2002:a0c:94d0:: with SMTP id k16mr62541658qvk.158.1555379471399;
        Mon, 15 Apr 2019 18:51:11 -0700 (PDT)
Received: from debian (hlfxns017vw-142-68-56-253.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.56.253])
        by smtp.gmail.com with ESMTPSA id u15sm36286465qth.54.2019.04.15.18.51.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 18:51:10 -0700 (PDT)
From:   Brian Yip <itsbriany@gmail.com>
To:     christian.koenig@amd.com
Cc:     ray.huang@amd.com, Jerry.Zhang@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Brian Yip <itsbriany@gmail.com>
Subject: [PATCH v2 2/2] drm/ttm: Reset ttm_bo_glob when initialized
Date:   Tue, 16 Apr 2019 01:50:35 +0000
Message-Id: <20190416015035.1435-3-itsbriany@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416015035.1435-1-itsbriany@gmail.com>
References: <20190416015035.1435-1-itsbriany@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always initialize ttm_bo_glob from a pristine state when its use_count
is 0. Persist use_count so that ttm_bo_glob can later be released.

Signed-off-by: Brian Yip <itsbriany@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 988416fb8a0b..d95762a90654 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1543,12 +1543,16 @@ static int ttm_bo_global_init(void)
 {
 	struct ttm_bo_global *glob = &ttm_bo_glob;
 	int ret = 0;
-	unsigned i;
+	unsigned i, uc;
 
 	mutex_lock(&ttm_global_mutex);
 	if (++glob->use_count > 1)
 		goto out;
 
+	uc = glob->use_count;
+	memset(glob, 0, sizeof(struct ttm_bo_global));
+	glob->use_count = uc;
+
 	ret = ttm_mem_global_init(&ttm_mem_glob);
 	if (ret)
 		goto out;
-- 
2.20.1

