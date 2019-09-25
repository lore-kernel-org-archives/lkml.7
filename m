Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD964C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAE621D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMTpS00F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389268AbfIYKSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 06:18:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41721 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfIYKSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 06:18:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so3113747pfh.8;
        Wed, 25 Sep 2019 03:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o4d0o53cCEWw8MDiILt2e59EfvuGBA1CGeiN1Rs0ygQ=;
        b=IMTpS00FPdkfiTjFlhRXSWjBLS4MUtD5J5dAEmDJp7N8wSUGtThFUoIS5MiNScPMH0
         julLRWAkpCi2b9zDDJC3g8pdX4f2IPm5O8hZ24o/a6BMHF13k2NkjvMB+ibCPJLYP2hm
         IQN9t7NAW5rmCkh1n+pqPPlNEw3EDSqF17ZS3O4Cx+Fh7ZH4Op40umqATrbs78412ROR
         HahoAEWFzLlawU9oqurxgO9V+yw0HxTO5NYheLhv2xxE5ABRy2jbAHAIr8e9g6Ll5WCU
         XB6w4TT8Oa7QMCY/l3IuGJyCl1jTDDyWPG3ydmEtuEcduUVnqvUsRQmnpq5qKd0mydxH
         H1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o4d0o53cCEWw8MDiILt2e59EfvuGBA1CGeiN1Rs0ygQ=;
        b=XkniOFHtGvk3KB68lmvkXa5BoNL/GzaPGFgSls6e1WmaRkaMHXHNanWyPJArAq61uS
         d95DUhSHNmNTVdoa+iVFcdTguJK0mI/eyDPW63xrIZt8ySnnGN4pM3lYoIeOLe8f3Q2P
         2j/JidZH15pVl6g6OlvhHO/OI3ZRJxMxQLIXHas23e/hFSLzH+NnSQBGfUIYYmkHUE5r
         aBmR0hdvMCvhuhnloUCRH3ThdnQw9ZzlC9hcPa9761bJGElsgupmwm2MBXS9IiaZYxyR
         4F0GG0Wpp7byck4Af6BgafqXHPI/eQS/K07WaH5d0rio4CWXwoHyUcg7tBUZ7F8ap0Ut
         tlgQ==
X-Gm-Message-State: APjAAAXF6NXslnsx44vlwYaw8MB7/3gT+UkQuH9zea34fIaSjId8zL9n
        mOgNNAQk8zfswrf0/uR6ikJJq3O9WV8=
X-Google-Smtp-Source: APXvYqw5jltGT0twAYKrRDzP/Y7sHtzkPNKv/fBzb5l2nTm8ljpUEwlUQtPiQvDgrge5hrwSVJguoQ==
X-Received: by 2002:a63:4102:: with SMTP id o2mr8192538pga.382.1569406681716;
        Wed, 25 Sep 2019 03:18:01 -0700 (PDT)
Received: from localhost.localdomain ([118.70.72.223])
        by smtp.gmail.com with ESMTPSA id i7sm2493107pjs.1.2019.09.25.03.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 03:18:00 -0700 (PDT)
From:   bhenryj0117@gmail.com
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Brendan Jackman <bhenryj0117@gmail.com>
Subject: [PATCH 1/2] docs: security: fix section hyperlink
Date:   Wed, 25 Sep 2019 17:17:44 +0700
Message-Id: <20190925101745.3645-1-bhenryj0117@gmail.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brendan Jackman <bhenryj0117@gmail.com>

The reStructuredText syntax is wrong here; not sure how it was
intended but we can just use the section header as an implicit
hyperlink target, with a single "outward" underscore.

Signed-off-by: Brendan Jackman <bhenryj0117@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/security/lsm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
index ad4dfd020e0d..aadf47c808c0 100644
--- a/Documentation/security/lsm.rst
+++ b/Documentation/security/lsm.rst
@@ -56,7 +56,7 @@ the infrastructure to support security modules. The LSM kernel patch
 also moves most of the capabilities logic into an optional security
 module, with the system defaulting to the traditional superuser logic.
 This capabilities module is discussed further in
-`LSM Capabilities Module <#cap>`__.
+`LSM Capabilities Module`_.
 
 The LSM kernel patch adds security fields to kernel data structures and
 inserts calls to hook functions at critical points in the kernel code to
-- 
2.22.1

