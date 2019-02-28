Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189F6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30E72133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YuQBXUQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387937AbfB1XMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:50 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:50342 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387911AbfB1XMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:47 -0500
Received: by mail-io1-f74.google.com with SMTP id d7so16724884ios.17
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lPxhHuM5mKH0BPh+9uIH/O2ZNSFUoc0j+pAFXqN/7ag=;
        b=YuQBXUQbPIWoFplIAUppYybOIHWam8OtfTUAEL8bWFQuH+gK2Lg+nhgjgeyFIg2APu
         TTsAV6Y4XCcERjl0cOTXY3F0VQ2dTEB6bqnuC/JnNexIojSPRlpvVlXsDf0bVCtPRVA7
         yA2PxzrOGbz8bmR43HPwD1Bwp0zb9EagvFpRZS02lKXbannLoupS2Xn7Ze03YF5yOD+s
         UnTk4Q6ltWm5xg8SYuv56VVEqetoFmedWsteo7Yue+vOt3YMnj49JzcOC0xXxyE87ZE0
         LF4vT+KZK9iqZSukgefDut2lWdcm4jIqnlIRtwYZhHrH6/16pJu/FioGP5KT7tQKjwIu
         D+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lPxhHuM5mKH0BPh+9uIH/O2ZNSFUoc0j+pAFXqN/7ag=;
        b=RGswkcYodMVPXUnlZWfRHAmYJG+srzsGFavg/3yQJSmx0vy9ri4yybLbQmYcC0Rv1M
         NDPuxR2Dv+1EQJXYiO+uxPJatwwHoAAwoB+ssjA4OdLYFzXO+/dExH/ZjQiMO1qIIbky
         6FfW1WX/LmAQXM6OEX0bQkUC/fjB4ziHETC005O8X/ak7k/qzjB44XvLYLLFKZh0Z8la
         2NSE+Jn1MUY8CK+tbLIULNvKsMJlFWeHWeFxLcx1beHWyH3pX2wlDtnD2lzqQvaPKjbC
         5Ye8H+4NNk/88JPIT6nLldywiVdnvN6H3CGGkwGBSY1MJwlOhYUj2qq8rxYD8vUJwhd6
         ezOA==
X-Gm-Message-State: APjAAAWVhG8Jdeth5u6eOhiIIz5+UNgQuhjzcRQdLy0U0AC0ytjKFQo7
        exPSeP9Cqx4WzwYKO9JlL4RcxaCN7XFYSeecFfVDHw==
X-Google-Smtp-Source: APXvYqw/dP5WRuat6ZNl267sXVMJqXcQjrhZTwUPtbCyU8pLXCcB0hj52Wg3y81HpdKwFbntVrWw0q+IOZp1vztH68w+oQ==
X-Received: by 2002:a24:1a17:: with SMTP id 23mr1520953iti.9.1551395566409;
 Thu, 28 Feb 2019 15:12:46 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:52 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-16-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 16/27] acpi: Disable ACPI table override if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linn Crosetto <linn@hpe.com>

From the kernel documentation (initrd_table_override.txt):

  If the ACPI_INITRD_TABLE_OVERRIDE compile option is true, it is possible
  to override nearly any ACPI table provided by the BIOS with an
  instrumented, modified one.

When securelevel is set, the kernel should disallow any unauthenticated
changes to kernel space.  ACPI tables contain code invoked by the kernel,
so do not allow ACPI tables to be overridden if the kernel is locked down.

Signed-off-by: Linn Crosetto <linn@hpe.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/tables.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 48eabb6c2d4f..f3b4117cd8f3 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -531,6 +531,11 @@ void __init acpi_table_upgrade(void)
 	if (table_nr == 0)
 		return;
 
+	if (kernel_is_locked_down("ACPI table override")) {
+		pr_notice("kernel is locked down, ignoring table override\n");
+		return;
+	}
+
 	acpi_tables_addr =
 		memblock_find_in_range(0, ACPI_TABLE_UPGRADE_MAX_PHYS,
 				       all_tables_size, PAGE_SIZE);
-- 
2.21.0.352.gf09ad66450-goog

