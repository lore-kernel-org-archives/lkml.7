Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8166ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFC821848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tg4CEU2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbfJIOFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:05:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43668 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfJIOFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:05:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id j18so3153102wrq.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 07:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x18qx9JLrk7xXMEFhQwtymWXpXFvSf/vB1abZUNNOK0=;
        b=tg4CEU2cZkb1tuVUQ8D8LbDUwBjlVtCC5lsmO8qvQ8VDTOwNppN85j+Tnb7zdw3KY8
         9eD64hjYKii/cqWwHUmTtSWkBfArSyX3YhbHnYgfLYw465h/eU9SoGz+HK7BKxCG8tGV
         bhzYHHj3aj0G9tSoqeTSK78cmalT2hEKDYhwJtv48OTTK6SE5OU7HPPEQqbYuH+ViSCL
         oq5T0vCoy+vRtX7M1WSDpIPx9HFKIlel3okg+I9KuJFVBAm41NyQBc7c+KUWhKliYu80
         ibDqUHDsWL4BSG9jBbnHfm4oRv57WdmEyk4PvHt5g0VA5CgRXd8eRtnu6TFUJG7BPLWd
         1XCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x18qx9JLrk7xXMEFhQwtymWXpXFvSf/vB1abZUNNOK0=;
        b=pXs+Lpq+e+OW93fufF7DqW0Vvbl+mrlKpGdfFQnm00mQvNwg1XVwHbqwWwxmvXoXx4
         AXD+ySGfTEMcgBFQJz3CoXuT+5+GwS7+FO8vO7sT9ANGfrwclu+Zzi38tPZmA/rpjplr
         hRCmXuO/ZsMyGZj784k9wyVlFyMfnG4lHCW0n4C9+hXLkpNIlNab1WSNE4EAkrDZ6QPW
         WVO/9z2qqOiF8E7idNrHte3DdYjg70fdYGYAcrvL0UKD2zDKr3zlqIiA/wPTXoEV0vxT
         4QISC3gNKzL9qBFv0wJv3oPnrr0PZpkYwwvz02rRYEvFeT8/6hWjhZrhiS8SJIXElN4T
         34eQ==
X-Gm-Message-State: APjAAAUNkxqDMzBpA+sevdiMKGUWuyUip6lwFKm2Yxo/Hk3hGUNG+Cax
        Bpsb66C1RVUWHyCbT1PPHQ==
X-Google-Smtp-Source: APXvYqymhr/+LiNXP+wOnNIJrM7YqPzMfBuMAkebF2saSDvcgaTrtCuZGp2+EY6kBWfNTjd7dEh43Q==
X-Received: by 2002:adf:9101:: with SMTP id j1mr2952067wrj.71.1570629569988;
        Wed, 09 Oct 2019 06:59:29 -0700 (PDT)
Received: from ninjahub.lan (host-2-102-13-201.as13285.net. [2.102.13.201])
        by smtp.googlemail.com with ESMTPSA id t83sm3989555wmt.18.2019.10.09.06.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 06:59:29 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] staging: qlge: fix "alignment should match open parenthesis" check
Date:   Wed,  9 Oct 2019 14:59:09 +0100
Message-Id: <20191009135909.19474-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "alignment should match open parenthesis" check
 issued by checkpatch.pl tool:
"CHECK: Alignment should match open parenthesis".

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/qlge/qlge_dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
index 5599525a19d5..086f067fd899 100644
--- a/drivers/staging/qlge/qlge_dbg.c
+++ b/drivers/staging/qlge/qlge_dbg.c
@@ -7,7 +7,7 @@
 
 /* Read a NIC register from the alternate function. */
 static u32 ql_read_other_func_reg(struct ql_adapter *qdev,
-						u32 reg)
+				  u32 reg)
 {
 	u32 register_to_read;
 	u32 reg_val;
-- 
2.21.0

