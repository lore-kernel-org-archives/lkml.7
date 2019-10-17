Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276C5FA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C7020854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e18t10U4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733006AbfJQBqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 21:46:39 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43614 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfJQBqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 21:46:39 -0400
Received: by mail-il1-f195.google.com with SMTP id t5so420609ilh.10;
        Wed, 16 Oct 2019 18:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C2efsFizgVT25garqduHjyuFt9iWInxP4xT7VjbjnDk=;
        b=e18t10U4nw9RnbPkZAOn3y7deMeJ+ww9/LymVula1j/TQgPm8NheGWHHwSh4f3AI53
         QTjaan4HF7ZUS4sqFWT7JB+dqwwQ8SUoQXL4Fce1xAHW9TO5Iwx+giUj0y1jqEqBBenb
         d2bI3yKILEcIk8UcbX+dw2Us9mtXCgMTcpQBGt0XFqPtexa5sCjH/ZxGDvlg94KdfLU+
         kX9kTcHcQJXuaOyrdFORey72399cEkOT+Tl0eSwxFpB6O+HEMuydXB/iNlspoYqvAD4L
         tUE238iVnwa4grrnnrdI1KaHAaoAqB8Q0hqQx1tnobpXlWSwT+85N/y/SA+3QFu7QQB2
         ++8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C2efsFizgVT25garqduHjyuFt9iWInxP4xT7VjbjnDk=;
        b=VqSkj++DELEL6gtkMGJCeNsLAOwCO+B7FiKhHRQUo5oFdqLnAB8QML6tu2aY2xPo9B
         bKXypyEAYxxVdVEbvMlaYuUYLeAeNu/XIAXvLWVelklQjci+GnNmc+vtZey4biQ57hPB
         D7jMlzi8rnL4A/A82dcWmwOz7X2hEgdfEtHWwiVSAZ7P7k7N8ybVusc//b8eCLnAIF/R
         Tgue1+dXI9ZpErSrzdMd6ok9PEm4xFGYWXAlBMgAR/am+jP4bQozNfyb9Dblpl5KsHQi
         XgzDzIV/5Qt3Q4So/e16lAYtvNX0Ni3AbEvr81OMm9EBYtNoZDi+7euBVWNCCvIVNZmA
         G4Lg==
X-Gm-Message-State: APjAAAUkMpgNmjfZpEwEGln3X77U9CsTLiRITYXolk3zaCQ+vr+lgV7C
        zrygoOe4CwZDpCFxh5iDUKQ=
X-Google-Smtp-Source: APXvYqyRMab6Jz+a+ZJ9RUdCBHIpko2ylTHktOoajg+JrW1s14BeuKaUXgetFur+DkmRgTL4Xkb0vQ==
X-Received: by 2002:a92:4144:: with SMTP id o65mr1068182ila.206.1571276796906;
        Wed, 16 Oct 2019 18:46:36 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id h17sm254867ilq.66.2019.10.16.18.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 18:46:35 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: Fix use-after-free in aa_audit_rule_init
Date:   Wed, 16 Oct 2019 20:46:18 -0500
Message-Id: <20191017014619.26708-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of aa_audit_rule_init(), when aa_label_parse()
fails the allocated memory for rule is released using
aa_audit_rule_free(). But after this release the the return statement
tries to access the label field of the rule which results in
use-after-free. Before releaseing the rule, copy errNo and return it
after releasing rule.

Fixes: 52e8c38001d8 ("apparmor: Fix memory leak of rule on error exit path")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 security/apparmor/audit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index 5a98661a8b46..48c15fb0aafe 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -178,6 +178,7 @@ void aa_audit_rule_free(void *vrule)
 int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 {
 	struct aa_audit_rule *rule;
+	int err;
 
 	switch (field) {
 	case AUDIT_SUBJ_ROLE:
@@ -197,8 +198,9 @@ int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	rule->label = aa_label_parse(&root_ns->unconfined->label, rulestr,
 				     GFP_KERNEL, true, false);
 	if (IS_ERR(rule->label)) {
+		err = rule->label;
 		aa_audit_rule_free(rule);
-		return PTR_ERR(rule->label);
+		return PTR_ERR(err);
 	}
 
 	*vrule = rule;
-- 
2.17.1

