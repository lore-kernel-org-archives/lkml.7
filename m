Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54BEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01AF20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTZfOCZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfCRPcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:32:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38803 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfCRPcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:32:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id n125so11501688pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 08:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+9zt60K093esvtZZtsA9kTSLmDXawvTkygGyefLtMGw=;
        b=cTZfOCZ7M06MfnT8VBQl6KgKOXn73ZD/jLg2lb0Mt3cuhlGeefWe51vPz1HU/Shslx
         Mijtv/TZeujHrg8E9g3uPo80LfQ8Nx/N1vEc5B+wNQdOU+b/gf6375KgfGJOG827tzlf
         n+Hzy2CsXph4oPrjWQdy4xcNbbKAiBkKfzAUlMFIVtjqk4j4O66+T3ANVO3UZrBLMj+P
         YmuGLcxf039i5TRfMBO0bAnRwvZ3UFYRgn/KTHe9tpY3EmJI/QoQ1Vz1qPFtg6t3X1hc
         6wT5deQom+jU3sBidbPFzSTN7IGYYDa96CyNK4a5aK0ie+K4WDiq3p7xGhS1kTGTkqCE
         1GLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+9zt60K093esvtZZtsA9kTSLmDXawvTkygGyefLtMGw=;
        b=VG33u08NctA4XKppOhClujFnoP8MSkib3sD2cusXRLeGcVAt2AQLqx8qEy0Am8kmPP
         adHAMxqZhB7Y3X3X4aEVTR9wbtVfLfXp/fvxJL5Yt1Q4cvGoGtuGyW2MZ/5pYk6mFsGX
         BWkZ9dud2yDyTdhueL6kniGSLZeKbBOhJuMGIUV8GiGRWiVbZjgdjvb0K1kj/MdXJg6o
         k1cZ8OxQZglmLbGniuAfWFedmYs9FjOKGxLNr8aPIn5hRhZKrNXINGxGnfxk+lh2m5Bb
         bQ5bXmU+ZaUmfhUHas96gBA+GcGe7WixUnq9k6UfzzCMv/wJWIdeI8J7de85d2tNBY4X
         XcPQ==
X-Gm-Message-State: APjAAAXEMBoUjo2XcIR+9DqR+RxwC9Pizk/mb+bWS8ei+oMtyqKDenTq
        5Gr3hveUHj1q9kCNsYL6tnA=
X-Google-Smtp-Source: APXvYqyavAQfWVFFCoBN3doTywWm8oGl5IGXLQsxXckfAFI/tCRpQ02cqsazsqXgxncN401dDQWtSA==
X-Received: by 2002:a17:902:6b49:: with SMTP id g9mr20670209plt.291.1552923152781;
        Mon, 18 Mar 2019 08:32:32 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id m20sm35617427pfj.142.2019.03.18.08.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 08:32:32 -0700 (PDT)
Date:   Mon, 18 Mar 2019 21:02:24 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        gregkh@linuxfoundation.org
Cc:     linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: erofs: Add whitespace after declaration
Message-ID: <20190318153224.GA3596@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add whitespace after declaration. Fixed the checkpatch.pl warning.

---
changes since v2
	- mutt gave me a lot of problems. Hence 3 patches for a really
	  small problem.
	- Fixed the extra missing line.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/staging/erofs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 924b8df..e09d29f 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -270,8 +270,8 @@ struct inode *erofs_iget(struct super_block *sb,
 	if (inode->i_state & I_NEW) {
 		int err;
 		struct erofs_vnode *vi = EROFS_V(inode);
-		vi->nid = nid;
 
+		vi->nid = nid;
 		err = fill_inode(inode, isdir);
 		if (likely(!err))
 			unlock_new_inode(inode);
-- 
2.7.4

