Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B72C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF46229F9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dbYOmz3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfGZJZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:25:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36755 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfGZJZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:25:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id i21so50834972ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 02:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+PIbmOU2L0JKXtCkLpSiyF+YIeyaYLwnS78i5Iju9M=;
        b=dbYOmz3UopyNMm7b+ZL7OYeHZdKMjC8uKvQEM6zd4xeZieU1Gi9gvjgH3EC1AIvYE7
         duuZwTh1H+R8KFptKI/jmo5gs6vbyo1Hn4Yvszu+PAhMscpBeKE0NUDIEylJzsG9RQXx
         O2eO72Dl+2cezfYqquobSJ95toySzW4VpudQ7IDc/a/BCdxaZULQMFGSNR1MEkaqRfzu
         yw4myOKYtau9cDEFTvOv9lQXp+tPo3R7FgKpCKwXTLMufDI4BbufB6HK0z6U+rlKB8h6
         Txn8SJkVcvNbYm8TbvLQK9gHymzUcOxdcaMUAG9qs1HWphbaCs1bXctY+Umltlf2xL9w
         VbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+PIbmOU2L0JKXtCkLpSiyF+YIeyaYLwnS78i5Iju9M=;
        b=lLn8rcYYTn1B+/uNiI4dtnEWPyJO52wsQMmjWavrnqDnlKM/ynx3zt6AjVaBA7wSQ0
         YBi8INIUU+hV1u+b2wciayic7NJmuVtMTztvi6qAYX7TljZpO3zOarz9nBaLknlPWSYX
         nAutxoP1PLOrs297CBJS4yEkAINk3ciRWOZR1aG7iajejJYV02yCTrAF/bMiDSS5yXR8
         amCdFxTFhMD022ISvQ5HK0gG9OyAq9UMbo5aqCJFdFJIpvXC3oVKH+mOOvl5cMJDBWLh
         z3RsI96TMMVxQovL3uz0prAa6P00TcU8QEWiff01jICvmAyPl6VCUqqg1bTs5rPI460l
         zjaQ==
X-Gm-Message-State: APjAAAWB6k6zAlmqUCUYLbEZzHSW/ZZTtxgdzskKUxYfscgbzIBXTZQY
        BbCkJqVhlaa4Q8b2zrHyPIXSag==
X-Google-Smtp-Source: APXvYqx3uN2nE7n6qS05F8mg8lPbGXuEEWpcKrx2U8qn9xYeIoCbLmf2xLHai/CRWcn88ThrbBoiNw==
X-Received: by 2002:a2e:a16c:: with SMTP id u12mr46776497ljl.59.1564133151828;
        Fri, 26 Jul 2019 02:25:51 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id m17sm9919308lji.16.2019.07.26.02.25.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 02:25:51 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     bmt@zurich.ibm.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] rdma: siw: remove unused variable
Date:   Fri, 26 Jul 2019 11:25:40 +0200
Message-Id: <20190726092540.22467-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'p' si no longer used and the compiler rightly complains
that it should be removed.

../drivers/infiniband/sw/siw/siw_mem.c: In function ‘siw_free_plist’:
../drivers/infiniband/sw/siw/siw_mem.c:66:16: warning: unused variable
 ‘p’ [-Wunused-variable]
  struct page **p = chunk->plist;
                ^

Rework to remove unused variable.

Fixes: 8288d030447f ("mm/gup: add make_dirty arg to put_user_pages_dirty_lock()")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/infiniband/sw/siw/siw_mem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index 358d440efa11..ab83a9cec562 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -63,8 +63,6 @@ struct siw_mem *siw_mem_id2obj(struct siw_device *sdev, int stag_index)
 static void siw_free_plist(struct siw_page_chunk *chunk, int num_pages,
 			   bool dirty)
 {
-	struct page **p = chunk->plist;
-
 	put_user_pages_dirty_lock(chunk->plist, num_pages, dirty);
 }
 
-- 
2.20.1

