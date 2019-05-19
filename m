Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED80C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 18:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E2F206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 18:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrPi4dzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfESSes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 14:34:48 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:43346 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfESSes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 14:34:48 -0400
Received: by mail-pg1-f177.google.com with SMTP id t22so5655058pgi.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 11:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=11epPDMxJKikdDuH5v438Dqzhu+8xiuwN8/dlEEPf7w=;
        b=IrPi4dzjuT6IuaUnXQW4C/RlKY8SAQGAI5efWh0a40wMRM8t2LHgHcz1avoKtU3abK
         bFUrCDyneTCImqczkLbYkM6PeugMcl6RjCaBzPHsUMb2p2Qfu+d2cdlSbWEhnOqUdzd4
         2H6Hc9rb8zKSVSzvYcSMEXscOSsySGNNd1unU/69ZUdiwH8CToKoW11BzMulBk5jOYJa
         +H0GbeS85k3CzVc3RfSojyBPlo6/khO7Y7mF0IU6XLofQ4eJlBUFLEtkP0hBnuCAZJyx
         VZwLlivrukrcR2MuFInFQFIZ+SZZZvgRjujyAsXkfkLjoB7fGeVs54Ztp/RiBvut1iUN
         UlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=11epPDMxJKikdDuH5v438Dqzhu+8xiuwN8/dlEEPf7w=;
        b=s23+4aKluYAu7VTXPMBX59DFPT55xyrnLP3eyVtQ1NQdkrXgCy9134dKA8fl1ySl3q
         bjW3wGW9ZTnUjsJqZSR/Jsl+X6v/Wg7bxYiY8eOszMG8DrCrcjjCYO/4d4qyk7Tg2m0H
         aKkMFqA4f1gKY3GLtpWnrQYZOLwVFBhVQOXZV91ntL3bKpxB/+Xk1Krhk9Er4KDThXxA
         f89KUuyw6i+OHQsoSmdB8c2h3dGUUJtawnT5u/HEhtgpMG/U/hY656urD0ZnEWgJ5Cp6
         ojnmHmmVU3nOS5SMvq9WnEzYY6YyQpzy97626tjEyPIwhuDYa2RNVnX+VLR59xconYaf
         /KXQ==
X-Gm-Message-State: APjAAAVNfbI+rSXcbdWfCFsxkjdssDI30ccl+l1AjpPpipPgiI/OUeGT
        ifhRbQnDV1dvvZ3K7rj5cpwPIOAw
X-Google-Smtp-Source: APXvYqxvavbTr5Llg15jkn4mHoaZyPh1phIxnZxhyXOoqbUxbMz6gbjUaChu1TIA3y6jx3n1pcJ2/A==
X-Received: by 2002:a63:7141:: with SMTP id b1mr68253806pgn.331.1558258486280;
        Sun, 19 May 2019 02:34:46 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id w189sm16622660pfw.147.2019.05.19.02.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 02:34:45 -0700 (PDT)
Date:   Sun, 19 May 2019 15:04:40 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v2] staging: erofs: fix Warning Use BUG_ON instead of if
 condition followed by BUG
Message-ID: <20190519093440.GA16838@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warning reported by  coccicheck

drivers/staging/erofs/unzip_pagevec.h:74:2-5: WARNING: Use BUG_ON
instead of if condition followed by BUG.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
-----
Changes in v2:
  - replace BUG_ON with  DBG_BUGON
-----
---
 drivers/staging/erofs/unzip_pagevec.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/unzip_pagevec.h b/drivers/staging/erofs/unzip_pagevec.h
index f37d8fd..7938ee3 100644
--- a/drivers/staging/erofs/unzip_pagevec.h
+++ b/drivers/staging/erofs/unzip_pagevec.h
@@ -70,8 +70,7 @@ z_erofs_pagevec_ctor_next_page(struct z_erofs_pagevec_ctor *ctor,
 			return tagptr_unfold_ptr(t);
 	}
 
-	if (unlikely(nr >= ctor->nr))
-		BUG();
+	DBG_BUGON(nr >= ctor->nr);
 
 	return NULL;
 }
-- 
2.7.4

