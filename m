Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29D5CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC88720874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRE77B74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfJ2J4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:56:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45793 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfJ2J4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:56:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id y24so7306806plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 02:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ptpy/vJ9nWhyDgwLIzHkRl9+v1e+gk6S6daIsLg9qkw=;
        b=IRE77B74b3UTcN2DESlNJtYZL5cgVxTp9FkSlyL40OAUe2y2yDfKAs5ZjJrQ/Dn1D3
         cF96AKMX4+nWUzV4n+FWAuoatauN+4JBM6Iih9Jav+Zmln/SinAdiOjF2CPSmbPcOQY5
         2O/pAQ7oPNv4ICd1xiDYsA9NHpxrhiodqBSRdSYaFHjIWKmLA71bBCKscxLq7V4qzQ57
         gVQeiba4wLM7OXCohjVV9sBGpj9JhaC3UenidgDtCMZduXCbGrG4ROmC1KQFipoixoLL
         SqFrkhVCnlmFRdLPgJnzHkl3MoTTNlJazZA1/a5PQdeLnyWVfDlRfiNf4Hb1STCoH5I9
         eOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ptpy/vJ9nWhyDgwLIzHkRl9+v1e+gk6S6daIsLg9qkw=;
        b=gAlHZ6v9Lju2Zr36l6tjFhdPzr40Lzg89QU4oBbjxxdeGic0l7yNNaRiSGsHbhFnAs
         oSihzLCYAD9JdbPS2Pdh8m7PB3D43Z/i751coFRE1hdBGXGd8j9mAvio6U3ELULheF05
         4vnUE4LuzTnrMkPa6kzs99Tg+vKHSdOVSy1DwtgHjo2hGZSCJklY2j/1RDJrSzMiQ/hS
         FLxPLfBFLV2vMXLLAQxvY0HF9RTmv0cArd/W4OH2yiuOEp37aJvDKGuUoamDxj42XjHl
         TPGbuC1aSauzMwnlz8xh74peEETOC+dtHp+uQTpWu0DuzCsUCeRgTaHNluJDcCQv6nCa
         Pk5Q==
X-Gm-Message-State: APjAAAV0c5BrbfdOyZ1sJcWmXpPmIaVPneu6mOJ6DYqe+998qihzhIoB
        8y66oAbZabuh4RYongQZYgg=
X-Google-Smtp-Source: APXvYqylIdIbgfFpoNGl8hpyFFcZbk2+XifwhdGCN4d5cZYpXP0hke+9DfdWKAnPmV8s3uwFiswL/g==
X-Received: by 2002:a17:902:a588:: with SMTP id az8mr3127639plb.70.1572342958474;
        Tue, 29 Oct 2019 02:55:58 -0700 (PDT)
Received: from saurav ([27.62.167.137])
        by smtp.gmail.com with ESMTPSA id x190sm14750613pfc.89.2019.10.29.02.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 02:55:57 -0700 (PDT)
Date:   Tue, 29 Oct 2019 15:25:52 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] fs: kernfs: file.c: Drop the condition with no effect.
Message-ID: <20191029095552.GA11561@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the "if" and "else" branch body are identical the condition
has no effect. So drop the if,else condition.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 fs/kernfs/file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e8c792b49616..d8123d8cfdcc 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -663,10 +663,7 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	 * Both paths of the branch look the same.  They're supposed to
 	 * look that way and give @of->mutex different static lockdep keys.
 	 */
-	if (has_mmap)
-		mutex_init(&of->mutex);
-	else
-		mutex_init(&of->mutex);
+	mutex_init(&of->mutex);
 
 	of->kn = kn;
 	of->file = file;
-- 
2.20.1

