Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F11C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3793420B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+k/fFju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733237AbfJJIdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:33:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38288 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732034AbfJJIdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:33:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id x10so3201299pgi.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 01:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O7p2fEqyW0bVC4UiR9HAc7G+W6mndKZsFPSQmUHXQOs=;
        b=p+k/fFjus2iMXsQjgstcB4b4WB5zfA5cT2pFdCVTwodhFve3rnj0UyAS5/TrK1l+jP
         Fj7BYq+UOpDkTiiEO5IcxazfG2x62D6mOyvV0FnceC+RI+6DfXSzU2H4F3O53nv+s2JZ
         xWNfPfeM50wEalTJWvI9F4g9prWz5oD9I0T7XXjDHmR5x2i1Aitn5igvDn+DYkF52KaM
         O//BciCy9oW8PFP3JE024ZAi7gA+M+OtXMBIzKEHNy55LQOuRw71pOdmQ1sTHTMJhHcW
         10fFyTCm8Ejc6Q+NBW5+INiPAJhxWy21NMbeRNAIhoAyDoyOqu7TMRmEHRP1Sl1n8uzT
         jMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O7p2fEqyW0bVC4UiR9HAc7G+W6mndKZsFPSQmUHXQOs=;
        b=cdZWcktThmnF2WA5cGL5DBciCWdky8/eGpIKkXzvZuBlyyaMZW76c1ly2OoKA17Fl1
         rmGI+mXfLwc25H9q79G8tI5NOriT5sXZWriDWLsVBO4RmTy6kzIuFAm2+5novuVe8QGI
         33eZNwtS6yILQ+yBFzlHir1ACvKt4DPcDEHblMFW24owz9isp1LzhiFeRIU5lVaikaMN
         L6NQbAT6/TGRlGhJ7K6skjHvg5r3SFbA1kPaRYUDZQPE509dBY0B6GGFUobgutTOLsAm
         xxyNiX9HKb6sPKgxUNaB3y79F5Vv83gbE//KIhkmy2nLc7zNzJ/SF/HB6PLzaZuRP7uE
         lsiQ==
X-Gm-Message-State: APjAAAU3BE2oV5LYXBAPMF6O63XpZ7FskhOv9MuPr4KW/oCYMFoNE48U
        61edi+renAPTIUi0hKwCfvku5UixdAI=
X-Google-Smtp-Source: APXvYqzyutGAVXNM/PD1VvisCGv1p9QsixR+cchjogvT0/HSuilUbh8huFSd3rnak94fGCQcEmBq0w==
X-Received: by 2002:a62:d402:: with SMTP id a2mr9184721pfh.115.1570696382444;
        Thu, 10 Oct 2019 01:33:02 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id m34sm7028036pgb.91.2019.10.10.01.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 01:33:01 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH] xen/grant-table: remove unnecessary printing
Date:   Thu, 10 Oct 2019 16:32:09 +0800
Message-Id: <20191010083209.4702-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xen_auto_xlat_grant_frames.vaddr is definitely NULL in this case.
So the address printing is unnecessary.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/xen/grant-table.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 7ea6fb6a2e5d..49b381e104ef 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -1363,8 +1363,7 @@ static int gnttab_setup(void)
 	if (xen_feature(XENFEAT_auto_translated_physmap) && gnttab_shared.addr == NULL) {
 		gnttab_shared.addr = xen_auto_xlat_grant_frames.vaddr;
 		if (gnttab_shared.addr == NULL) {
-			pr_warn("gnttab share frames (addr=0x%08lx) is not mapped!\n",
-				(unsigned long)xen_auto_xlat_grant_frames.vaddr);
+			pr_warn("gnttab share frames is not mapped!\n");
 			return -ENOMEM;
 		}
 	}
-- 
2.11.0

