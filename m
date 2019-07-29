Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC3CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9A920657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffFc6tWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfG2HnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 03:43:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39997 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfG2HnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 03:43:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so27122222pla.7;
        Mon, 29 Jul 2019 00:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nnU49ZGlcsSheaOkzfD2Dnn639RuY7f9XlHG2GEn5bI=;
        b=ffFc6tWk9qj7Fq9Wu22LdvOiVa39wc+9cIol2ps2vJ4ll3XLVhb34evVYKLnf4ZzWH
         NIgemQw/nJQ0xAMUUQHyo9qJcee90UAtrtKvQr4o2WgGfdSbe5NhUr2Fwi8RsjTX//4H
         cW1lpquEFIRCQNF1seMQGsyzaPcMj7XeKk2WwmN+j+wz1nQWAPXwex2n+R6d+AoiFx95
         fZtuuzVvzzHqMvaysUm9/Uw9oR1QMSOHZ/pE5fnCw2eodGVYucoWDyToSixQtgOIAix4
         aye++y1Lld8Si7PUR2ixhznmYY7LA+R97cWOH7hP5gYmmQAzM/DiRQfZHto+fmaUJ2QN
         994w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nnU49ZGlcsSheaOkzfD2Dnn639RuY7f9XlHG2GEn5bI=;
        b=qnaLNlColuycMh3iUsuZiqLL+rsCbxwoPSZoLYkF65N7eDiA/NAX63Ou6jYrsHRYwY
         kKNGfYWs8YVcBeydUu6Q8gJUMrICKnqTBxWN/lbaRLovr9ZIhXzG4h+xCchwJ9iaRaPs
         IjtKfaoPEp4DTbHgRB2Fn1QZ5wJQdty4zpoLcMiRueKR6VC1IpNaY67gOIhcl9uOV1Fr
         SENqF/wBQ8g8kNUaPuu8mEhCXYdKaUMH4Zvnh51HhoH4yC1RUcBHSyX7cSCr205y83FO
         egr1vA/nG9epIvbLFc9TelFmbtDEU+ChZJR3HPzhhtAEYuJU8bQ0sd95xCyGBQlpHcDW
         kf6g==
X-Gm-Message-State: APjAAAW57l2pFGXS82FOX9A41FkhzJVnOoAoOk17YfTwT6YBjRnDi4Iz
        BE6b4vojv2lgfm7kiOTcY3A=
X-Google-Smtp-Source: APXvYqzQilhw26PmF5kaK0GDbte8LzF5CT00jN5+HX1XV1Qx8VaDVA82xh65Hb8TL47fjmpLO15kJg==
X-Received: by 2002:a17:902:6a85:: with SMTP id n5mr101402401plk.73.1564386191118;
        Mon, 29 Jul 2019 00:43:11 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id d129sm65579837pfc.168.2019.07.29.00.43.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 00:43:10 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     sfr@canb.auug.org.au
Cc:     akpm@linux-foundation.org, jhubbard@nvidia.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: [PATCH] mm/gup: remove unused variable in siw_free_plist()
Date:   Mon, 29 Jul 2019 00:43:06 -0700
Message-Id: <20190729074306.10368-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729134816.605ff6d3@canb.auug.org.au>
References: <20190729134816.605ff6d3@canb.auug.org.au>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Commit 63630f9a8d72 ("mm/gup: add make_dirty arg to
put_user_pages_dirty_lock()") removed the only user of the
local variable p. Finish the job by removing p as well.

Fixes: 63630f9a8d72 ("mm/gup: add make_dirty arg to put_user_pages_dirty_lock()")
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi,

This fixes the warning. Ideally this should be merged with the commit
that it fixes, if that's still possible.

Andrew, would you also like a fixed version of this patch posted
as a new version of the 3-patch set that it came with?

thanks,
John Hubbard
NVIDIA

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
2.22.0

