Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FB4C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 10:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6582F213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 10:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zyw4LQVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfDFK7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 06:59:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36403 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDFK7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 06:59:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so4465192pgc.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 03:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SD8KfYmLbVLOdOYjbfQ2SZnfZ089F/DLA1H7/KP5DEI=;
        b=Zyw4LQVaPbg+jDSwONfarn1K2amlEkRzDJo2Oi4Htg7/s2KcTkyQ5afix/dDrKTLjd
         +LD1Fcp6A5HqDSqKd8fAxs3pDZ59el0WDD4aA4gRIraqlI9iirNPHAJqNW00qdeLZQa4
         /ib00qMKIo0h/paylsWMIcKfNJIARe2I8SMfStzevF+tQKfMZyrE7WsYdLBb4diexA6P
         5Flvt039pZ/qeh5yv9fMS714CBt7dvUMGKDfkcAsNUKA3/QcyVYMOJnhdqcs7G8cdfUE
         uKvLvWHJW5ohezb0kW7DxcvQwaW+dB22NxyARb89HFpMgLeyDb6/XntTV2pmf208ea/H
         2/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SD8KfYmLbVLOdOYjbfQ2SZnfZ089F/DLA1H7/KP5DEI=;
        b=j6A5VQ1btEnNSmkVfVA28F6WGz/1KRO4FCNndC3GLK2Api4OjvT1BLOkwoLM5NiHv1
         sd6QvCCFUVnQJjj3Rzbi6o4LNWOhg/eRfUDvq9YFvmfdr3uRGRpWZ9NLXKZbLkpd2Vnc
         FIw9lPUXR2qajvNQgahnPR4oaKJwNO2/XAOU0BtkSIWCSgO71U0Z0ZJapz8rlj67BIwj
         2dMuZvoHWg05DihuKSKvTI4rFl5ySkxNSI1BDiwR7n0VWQtlQCXFXtxQglB0YyUCwMHU
         uRj/1aEcMnQM2fIZ1atQFP6LgMCmdcNdMAUXExLZRzygWwHC9ki/jyimd9fs58z9DY2W
         JqgQ==
X-Gm-Message-State: APjAAAWJZ+0HKI3EFWWAZ9jnIxmTvVyihU4OLx9E2zxT5teltJOdXCql
        ha5f7OTqXPhz/2wce31659Y=
X-Google-Smtp-Source: APXvYqwq12V3MpXtia11xsrdE8f91EUIHr4OpLzhNT0BOWJXL844Wvz1prqC7U1TZerUNytxnR+Slg==
X-Received: by 2002:a63:e045:: with SMTP id n5mr17451271pgj.230.1554548381913;
        Sat, 06 Apr 2019 03:59:41 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.91.90])
        by smtp.gmail.com with ESMTPSA id o5sm82684138pfa.135.2019.04.06.03.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 03:59:41 -0700 (PDT)
Date:   Sat, 6 Apr 2019 16:29:36 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: data: fix warning Using plain integer as NULL pointer
Message-ID: <20190406105936.GA30585@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changed passing function argument "0 to NULL" to fix below sparse
warning

fs/f2fs/data.c:426:47: warning: Using plain integer as NULL pointer

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 97279441..15a2381 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -423,7 +423,7 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
 
 void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type)
 {
-	__submit_merged_write_cond(sbi, NULL, 0, 0, type, true);
+	__submit_merged_write_cond(sbi, NULL, NULL, 0, type, true);
 }
 
 void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
-- 
2.7.4

