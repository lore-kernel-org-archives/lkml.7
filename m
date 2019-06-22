Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652C4C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B2A206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HlqaBFCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFVKRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:17:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55707 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfFVKRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:17:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MAHhYQ2098813
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:17:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MAHhYQ2098813
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561198664;
        bh=zgVpyglInROjudxCEYYGJTa1FJpVm0qGd01pxcrAV3Q=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=HlqaBFCrU5FgLIuQ1WnHOlxNGZQcIlhntLqW1Yk+GPmvkAc2hCw5Bj1EhtjH5tBoH
         KYYeB7ntS9Fq+Qabntk2ikYzTbquL42soY9LKvg3qWKA5aVqo/h9bd3a3Lq3KFHy19
         TB3gaCM1FfKCaxm5Si3WMcUi8YFVwytIMmtA7yVM7opMR/+kXmOHxMlsTkI15HVrPT
         0TwQk9OoeUGKTPNMZElx97BbZ8AzOkbC5ukhQyyykegHQATlcUeG7GVdP8Lk2vRPJc
         MRZcmJ0zQTzU6eOqfkYOL1n5TMgUMO9wv/W37NkVBGAX92HsvvSWpfqSuq6VyciXv8
         RlckHjiArVq/w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MAHgXK2098810;
        Sat, 22 Jun 2019 03:17:42 -0700
Date:   Sat, 22 Jun 2019 03:17:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony W Wang-oc <tipbot@zytor.com>
Message-ID: <tip-773b2f30a3fc026f3ed121a8b945b0ae19b64ec5@git.kernel.org>
Cc:     gregkh@linuxfoundation.org, DavidWang@zhaoxin.com,
        HerryYang@zhaoxin.com, TonyWWang-oc@zhaoxin.com,
        CooperYan@zhaoxin.com, QiyuanWang@zhaoxin.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, rjw@rjwysocki.net,
        lenb@kernel.org, mingo@kernel.org, tglx@linutronix.de
Reply-To: QiyuanWang@zhaoxin.com, gregkh@linuxfoundation.org,
          DavidWang@zhaoxin.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
          HerryYang@zhaoxin.com, mingo@kernel.org, tglx@linutronix.de,
          TonyWWang-oc@zhaoxin.com, CooperYan@zhaoxin.com
In-Reply-To: <d1cfd937dabc44518d42038b55522c53@zhaoxin.com>
References: <d1cfd937dabc44518d42038b55522c53@zhaoxin.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] ACPI, x86: Add Zhaoxin processors support for NONSTOP
 TSC
Git-Commit-ID: 773b2f30a3fc026f3ed121a8b945b0ae19b64ec5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  773b2f30a3fc026f3ed121a8b945b0ae19b64ec5
Gitweb:     https://git.kernel.org/tip/773b2f30a3fc026f3ed121a8b945b0ae19b64ec5
Author:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
AuthorDate: Tue, 18 Jun 2019 08:37:14 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:45:57 +0200

ACPI, x86: Add Zhaoxin processors support for NONSTOP TSC

Zhaoxin CPUs have NONSTOP TSC feature, so enable the ACPI
driver support for it.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "hpa@zytor.com" <hpa@zytor.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "lenb@kernel.org" <lenb@kernel.org>
Cc: David Wang <DavidWang@zhaoxin.com>
Cc: "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>
Cc: "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>
Cc: "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Link: https://lkml.kernel.org/r/d1cfd937dabc44518d42038b55522c53@zhaoxin.com

---
 drivers/acpi/acpi_pad.c       | 1 +
 drivers/acpi/processor_idle.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 6b3f1217a237..e7dc0133f817 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -64,6 +64,7 @@ static void power_saving_mwait_init(void)
 	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 	case X86_VENDOR_INTEL:
+	case X86_VENDOR_ZHAOXIN:
 		/*
 		 * AMD Fam10h TSC will tick in all
 		 * C/P/S0/S1 states when this bit is set.
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index e387a258d649..ed56c6d20b08 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -196,6 +196,7 @@ static void tsc_check_state(int state)
 	case X86_VENDOR_AMD:
 	case X86_VENDOR_INTEL:
 	case X86_VENDOR_CENTAUR:
+	case X86_VENDOR_ZHAOXIN:
 		/*
 		 * AMD Fam10h TSC will tick in all
 		 * C/P/S0/S1 states when this bit is set.
