Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4368AC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1263820820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sO21lW7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfDDAdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:33:19 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:40889 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfDDAdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:16 -0400
Received: by mail-ua1-f73.google.com with SMTP id a10so142952uan.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=F7gwrLqBhitPmGCH3yDZVQC7NL1DApaJvsgcGKz9XZw=;
        b=sO21lW7sz/ns18hN7SlX/zr3jQmDJ3mtD+apq3GlD6ckhlTw4v2i3gXRCDm5Vs5mYJ
         LXfNtWylXdBIxsbGmj49dHEtJRQscclkifyUJzoI6tYiqt9G++U1u0mdT4UXu6GRsZrY
         nO9Xpph8Wlcubg6vFg0+ujbv4AIIyGkcFSBIu6hJLD1aFptXeunfoCHimJHu9ftuCjbj
         fHNRo8lSHZr1QTwAT2mMO1+TGOTMV08gr5UcjRCX0+XynqvJN1D2NJW1jGd2xgp96M7q
         YIOcYbi66upbn2IlI0Jyn8gqpwMLkYSB0ynJh9dN0VNKnzLvf6ke3qxidogrCkgeQbgh
         M0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F7gwrLqBhitPmGCH3yDZVQC7NL1DApaJvsgcGKz9XZw=;
        b=L4ZkU6Hfz+9m0i9as/dr2+85Nu1RR8fAfj8UvcEXYSa75s169fopwQAkKaSOkOd4wP
         S0WOA6fqkaetgsHgyUgRLzeukuPU0H89X3tFNNZv27v+K21BGOE34nIs3WCq80Bs4YCd
         bk4/mggg2cFpdG0/P2FSLDyyq72CxyaB+DeTYPLZ2giHuTb1AR1BmzeTQ9aTvpLBDeMT
         GUxNvgNwcZ4yXquCHvw09K/1WjRaMQlmTqUafRfn1dDKnmlJ5ETKEVSA4oXFm1HROTzK
         pecculwUDRZ1Hrz3jiDknplscK1B6153QmA/pzIOB6WXgOa9QZ7I/2vQwYdSve6meIGW
         DoqQ==
X-Gm-Message-State: APjAAAWFxvwcnTuffDIy87ZLjSAzfLnCT0E7ecw6K6IwEP5kxuy3AXTc
        R8O+T+GQGVZN7xLRr7eRl8oQGqiyE+0zTUv7Mo10vw==
X-Google-Smtp-Source: APXvYqxLmuf70AXpG3iG6EAnmL96VT12fM4bfEXi3TJeEBqfuOYC0uB+zvU9Rtoi5NfBIV0Q26AsocD8JxxzMQZgEMeYHQ==
X-Received: by 2002:ab0:2653:: with SMTP id q19mr418981uao.2.1554337994994;
 Wed, 03 Apr 2019 17:33:14 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:30 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-9-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 08/27] hibernate: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Matthew Garrett <mjg59@google.com>, rjw@rjwysocki.net,
        pavel@ucw.cz, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Boyer <jwboyer@fedoraproject.org>

There is currently no way to verify the resume image when returning
from hibernate.  This might compromise the signed modules trust model,
so until we can work with signed hibernate images we disable it when the
kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: rjw@rjwysocki.net
Cc: pavel@ucw.cz
cc: linux-pm@vger.kernel.org
---
 kernel/power/hibernate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index abef759de7c8..928b198cfa26 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -70,7 +70,8 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 bool hibernation_available(void)
 {
-	return (nohibernate == 0);
+	return nohibernate == 0 && !kernel_is_locked_down("Hibernation",
+							  LOCKDOWN_INTEGRITY);
 }
 
 /**
-- 
2.21.0.392.gf8f6787159e-goog

