Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888E6C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577342087C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TwYXtqg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfCFX7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:59:54 -0500
Received: from mail-ua1-f73.google.com ([209.85.222.73]:36665 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfCFX7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:59:50 -0500
Received: by mail-ua1-f73.google.com with SMTP id r12so2007347uao.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 15:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7CZJafxJx5K8s0KTAGx/cb0COJjD1VsMHrphX4q9xHc=;
        b=TwYXtqg92i8rtVNs3UFbQo0S5dqxiJRdLg7OmvpgqdBn2thEpiMDx7+y3OiyBCyVIK
         5bQ5Zlyojb7UvS7jwwD1ssl42j3Z4qHdQQ0UsmCC5Q43XsxM/W8h9yY3LeXnRnx5tTG3
         vgxfRjf0bpwIaBBiUmESuUDGqk2QcWgC759lLgs+CAryqFzz3Wpf9NA5dfw2NFyyeKR0
         YhQpCufdemS8shSLjEqi9Ak9Wp3laaLwEpjJs9AuK6biLJuyh19Pm60FHWCNSA/D17Z+
         N38omPB+Twprj9bOBJGuWP09sRitBmX8+4c0LNb+Yx6osYSt5Zv+q2moX06QpkVc33kW
         U5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7CZJafxJx5K8s0KTAGx/cb0COJjD1VsMHrphX4q9xHc=;
        b=N6JLut3UMLZqxywotcbdphgnyzFV9yz2r7kRR0rFUypGvwGm0yIspCmPIclKSPdrdb
         g+Tk9l/jAIxel1niXznpLU6LvzJbII9e1aVqAcr5g69XrYaYx7vLmKv0T1unJDStoCfd
         dcY7d5AeI9yzuFPsk9Y856FulzN5X91SmMcZpo+HUS9hTPzdKigduycel3NWF4cap/Y5
         WSkR8HeMOlETxfqf3LPlqCdiAuTdfs9DzyVcpoWyzqYQGHYtCrmvY2EpI/9guh6zp9SR
         2Ih52my/VgeA99WaOncotrj/RTkBaCixTJsrqjEBELdiqD/lPAFAh2olWBrnd43zu+AN
         iMAw==
X-Gm-Message-State: APjAAAVSj+/cEg0f6z5asLyizE/E8K/J66Xd6iC5l7BsCTUjI0Z2U+8G
        EtjK214KiHmU1cFDCXp2e+MTmVmG+p2iF7ZTokQECQ==
X-Google-Smtp-Source: APXvYqyEyqxCfr/0CcoThrN8sYnOFddoPmHNo3SSBCt3q9qooH4LMAn+PUgqnonjxmvruYh7L6YbUj4snzJoNfX2IuxTAA==
X-Received: by 2002:a9f:2d84:: with SMTP id v4mr6876735uaj.22.1551916789062;
 Wed, 06 Mar 2019 15:59:49 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:58:55 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-10-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 09/27] hibernate: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
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
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: linux-pm@vger.kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index abef759de7c8..802795becb88 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -70,7 +70,7 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 bool hibernation_available(void)
 {
-	return (nohibernate == 0);
+	return nohibernate == 0 && !kernel_is_locked_down("Hibernation");
 }
 
 /**
-- 
2.21.0.352.gf09ad66450-goog

