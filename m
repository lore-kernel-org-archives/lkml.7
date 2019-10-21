Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918A6CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622FA2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inbN/c7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfJUPYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:24:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37833 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbfJUPYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:24:16 -0400
Received: by mail-io1-f65.google.com with SMTP id 1so5047085iou.4;
        Mon, 21 Oct 2019 08:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3P+aBDo0ELSsFt8nCKFHScePQc27b2VSrL87S+QPBsU=;
        b=inbN/c7buo+FoE6Dk6EAnrg8ORKRrFdixSmEroAn9vkrHOGV2OF7X+KnCKCLDz1FBo
         Op0aI8hSOoy5A7ciprqD8+Ss8WrJY15q5EQ/YuoWkA96CyKkwV3AwVzPX3k0UDTvj/Vx
         oMhkhmTj1RTF9zzZwALy4yLUi/N0u+/l+weT/H81oKL2vSYCpjep5E25XQW2rbvC/qXH
         bI2WnZ2KrzBkf68EBgJEH6LLC5o44cfZf6a2wFWFNhs7tN5XMHPPWSzAeOa8Ltr4yl/7
         DTChh4sLLiEZvmjbG/2hv0inoeTsnvW3W9acY5hFc7wyH+eyfg7P6gcQNH6ths7h1dxr
         ydFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3P+aBDo0ELSsFt8nCKFHScePQc27b2VSrL87S+QPBsU=;
        b=KNSkd3pZIPsSs0k7RERiy8QiTozoQ+rXzUMgfk/YOfw+JUJNMNTRASHZtMiASzs+QE
         jIiLDF1Q/kZeiRa2GUoygAxG0SRtJcgfbJ+551OA3ZMCcUnjtMLkKzNJlhEcm9QjTXtB
         ss3eMrStTKPnN/kizNx32ty6OTz23aH6dwKWPq8fW1nHLcmsiwqyT5ftY2M19hxvERVf
         qHJCTVwi4ilOQwCsO3RjWLwooT69gP1KhqhIKswfSHGlSVcWrI1vSlhDcDW47+WHsv+o
         00St0aiEIcRYad3mm1nPsHheyUpzpaaC7D+pDd4eLBqKMhDK3oW/3HAGiB6CnM35mYZc
         no4w==
X-Gm-Message-State: APjAAAXxUOBg4fNBemXT3Zl5q/uXAwIy6Te2AyOgWEsG8lYn3VLixWPC
        U6weM3HZwbcartC91HJYUrE=
X-Google-Smtp-Source: APXvYqwqC3FNN0SgZe4VhLQX6Z6RdX7ParI/Or2Bl+4oBAvPlu2BndYD4qtUpntFEl3ejY72uMnUPg==
X-Received: by 2002:a5d:8185:: with SMTP id u5mr15715116ion.147.1571671453827;
        Mon, 21 Oct 2019 08:24:13 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id n123sm3872105iod.62.2019.10.21.08.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 08:24:13 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     john.johansen@canonical.com
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] apparmor: Fix use-after-free in aa_audit_rule_init
Date:   Mon, 21 Oct 2019 10:23:47 -0500
Message-Id: <20191021152348.3906-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <57b61298-cbeb-f0ff-c6ba-b8f64d5d0287@canonical.com>
References: <57b61298-cbeb-f0ff-c6ba-b8f64d5d0287@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of aa_audit_rule_init(), when aa_label_parse()
fails the allocated memory for rule is released using
aa_audit_rule_free(). But after this release, the return statement
tries to access the label field of the rule which results in
use-after-free. Before releasing the rule, copy errNo and return it
after release.

Fixes: 52e8c38001d8 ("apparmor: Fix memory leak of rule on error exit path")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
Changes in v2:
	-- Fix typo in description
	-- move err definition inside the if statement.

 security/apparmor/audit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index 5a98661a8b46..334065302fb6 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -197,8 +197,9 @@ int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	rule->label = aa_label_parse(&root_ns->unconfined->label, rulestr,
 				     GFP_KERNEL, true, false);
 	if (IS_ERR(rule->label)) {
+		int err = rule->label;
 		aa_audit_rule_free(rule);
-		return PTR_ERR(rule->label);
+		return PTR_ERR(err);
 	}
 
 	*vrule = rule;
-- 
2.17.1

