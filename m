Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E414AC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA04624DB4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mVr5fzjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfFDG6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:58:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37259 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfFDG6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 02:58:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id 131so6039843ljf.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 23:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=miy+F0UoMi0lHDhsda5tGypnZkgAe9GPxZhd/GwR4u4=;
        b=mVr5fzjsLR1nkrv+kdyuXyQZYPVgVYh780mkZNBtzql5tdvV6xYIXziep7mAHvlpgr
         wgVyucCn9Q+gRs9xdpx5DDJBkgsWgpVO758qfmyjDY+nq/AGEVHSIj6TD8fqoVO6NuB2
         gmN9XNCHZemMWo7MBLZf9LlwZdrVYmZpT4HX/YhK8tgItVFx1+9PVUn4axVECn2cPbiR
         xaZ9JlI8wU4yhQ5NKlasEhRA9N5TlsYY08c9dTH9lwSnisaGNESI7RSrQuR+URHoqolU
         7sWzDFpg5l+yS+IUyV3P5ZwDTQ9RdxIoM9FShhqodspBm7i0OQ2BQQ+n7YVmD1emI5gi
         c3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=miy+F0UoMi0lHDhsda5tGypnZkgAe9GPxZhd/GwR4u4=;
        b=cYnIHcX3bDD5TB9nbvCaZbJHO/scJvmzjlpx4WHdTlcJcmlH0TjG90atOosmF/vK3r
         uJblnkGl4ACqNqfoJ4BK/4fYy4WeiD5/txhqhZYEEJ0Gv0CWx46MgmXb9kX9ni0ZN1Ju
         uS2ferPFOsZl8zA8E7lGxMa1mbyFw+DKhsQF1FaY9ZaUBUIxsHAnExKGJkyWgq9r6jPk
         SxM7RFbggbmG78aNgipi7gwERLlfJ66KMuim5UuODx0fQhixJeceCJJVl4uQ+Ymrmt0U
         91THeEKSAatFLJ+pUfYXefVuZPHXvXJsmA7LKwvP4e5a0Sh38dXFF0wksNQzzZPrWKxB
         rSog==
X-Gm-Message-State: APjAAAUFiHTnVmepLUJTJHkVLWMwy/38+s6JcI1hTIBrD9lW8XWo6ruM
        ftevDhaI22usT7OAR7CE1SPaqg==
X-Google-Smtp-Source: APXvYqzs6Jwh4UF70YPDT+9ZM8x2yVImFgcqBfuOAwxH86MX/JoTCM2AAKQTK0oKPr9S/2mco/Dh9Q==
X-Received: by 2002:a2e:9654:: with SMTP id z20mr3491108ljh.52.1559631531818;
        Mon, 03 Jun 2019 23:58:51 -0700 (PDT)
Received: from localhost (c-1c3670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.28])
        by smtp.gmail.com with ESMTPSA id r11sm2978344ljh.90.2019.06.03.23.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 23:58:51 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     minchan@kernel.org, ngupta@vflare.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] zsmalloc: remove unused variable
Date:   Tue,  4 Jun 2019 08:58:26 +0200
Message-Id: <20190604065826.26064-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'entry' is no longer used and the compiler rightly
complains that it should be removed.

../mm/zsmalloc.c: In function ‘zs_pool_stat_create’:
../mm/zsmalloc.c:648:17: warning: unused variable ‘entry’ [-Wunused-variable]
  struct dentry *entry;
                 ^~~~~

Rework to remove the unused variable.

Fixes: 4268509a36a7 ("zsmalloc: no need to check return value of debugfs_create functions")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 mm/zsmalloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 1347d7922ea2..db09eb3669c5 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -645,8 +645,6 @@ DEFINE_SHOW_ATTRIBUTE(zs_stats_size);
 
 static void zs_pool_stat_create(struct zs_pool *pool, const char *name)
 {
-	struct dentry *entry;
-
 	if (!zs_stat_root) {
 		pr_warn("no root stat dir, not creating <%s> stat dir\n", name);
 		return;
-- 
2.20.1

