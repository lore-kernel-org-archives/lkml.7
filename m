Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497DFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177272133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ageJCM95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387908AbfB1XMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:46 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:39679 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733102AbfB1XMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:44 -0500
Received: by mail-qk1-f201.google.com with SMTP id w134so17297441qka.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Wqh1XdjrR2tvM3s7JD9p7Uz2t1LkZeFbYNWqPw8a2Aw=;
        b=ageJCM95rFFnT+xvmUfxE0iJAoV+n+N8mVj52V+6FViQT9B9gThHA1Dux7SYXzh757
         vW07/zc36SNBzPb7yLPanIUYV4txRFnWY0HPa7vFyNMXwygb4ma3/2VaqKtguwXLB31c
         y06GyPMa0kjPa0dfBTGkO9WB9kGU17MGsLsGAikRv9+zuPf6l0bwgJteKFBghHOSdTSa
         Cg1u9+NdHPJs5Dn7cbi8GBKy6ZVzmXduON7YW2/CgSjFUDVFeGCDQGM8IYb5cvXHY2sL
         Ov+LWR6ufzXIr7NqMCosbz/hUJc8Glr4TF325/gs0oBJI6BvEmgB/3gxy+DCW95Tg4/2
         TtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Wqh1XdjrR2tvM3s7JD9p7Uz2t1LkZeFbYNWqPw8a2Aw=;
        b=XYsCrP7jD13AmjcrooiapfRjWdb8D+BkzANTjK3jzPUgZg2/1s2PDgQbRlrmzDPQ2P
         Ao9Gyv7dgsDbwZ8KdkHEA8nPxR1kLad8YfanDjX3syo37f7FF3LpN2cXiTEWMfHnCt7+
         yewc5Rkvl9AJWILOQbP9DwliappFHysVJJLyeUX/i5Bgr9y1prO2O66UIwuCXoL6TkO/
         xKZ7jSS33PBUXn0yioILdKKBDHp7gMd9iDKY/dxiag3tNHq5Hw2D0dh1LjqdK/iAOxtS
         lWO4H+EJgV05niQxczVUhmbnQXfjyR7iduGRk7naAHJJtjQxoOc5HJGwHF1tUUdk+BTQ
         TliA==
X-Gm-Message-State: APjAAAV9BSMLOyqAxPS2tFX3cy1NIFuMp/kFO0QzuoCF8eUKxAlWG6vs
        xlMCeXi6jNimTtAXs4SAs+9onETpP+KGKlzdOz01ng==
X-Google-Smtp-Source: APXvYqzMYtXMIbPpyBJ53LzazIQ0J3J476+ftoTfkkRnqsTBZKh5DwMy7w3f+Yq4e1XEX0j8l3KXmtYFbsoIiTcS9h7BtA==
X-Received: by 2002:a0c:869d:: with SMTP id 29mr1097176qvf.34.1551395564025;
 Thu, 28 Feb 2019 15:12:44 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:51 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-15-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 15/27] acpi: Ignore acpi_rsdp kernel param when the kernel has
 been locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Boyer <jwboyer@redhat.com>

This option allows userspace to pass the RSDP address to the kernel, which
makes it possible for a user to modify the workings of hardware .  Reject
the option when the kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: Dave Young <dyoung@redhat.com>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/osl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f29e427d0d1d..3e44cef7a0cd 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -194,7 +194,7 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	acpi_physical_address pa;
 
 #ifdef CONFIG_KEXEC
-	if (acpi_rsdp)
+	if (acpi_rsdp && !kernel_is_locked_down("ACPI RSDP specification"))
 		return acpi_rsdp;
 #endif
 	pa = acpi_arch_get_root_pointer();
-- 
2.21.0.352.gf09ad66450-goog

