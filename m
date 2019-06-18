Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B09C31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F77206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfFRIhV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:37:21 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:28486 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729205AbfFRIhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:37:18 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 18 Jun
 2019 16:37:15 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 18 Jun
 2019 16:37:15 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Tue, 18 Jun 2019 16:37:15 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>
CC:     David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: [PATCH v2 2/3] ACPI, x86: add Zhaoxin processors support for NONSTOP
 TSC
Thread-Topic: [PATCH v2 2/3] ACPI, x86: add Zhaoxin processors support for
 NONSTOP TSC
Thread-Index: AdUlrWb2UUdnhrSrTk6GyjUnqmkUeA==
Date:   Tue, 18 Jun 2019 08:37:14 +0000
Message-ID: <d1cfd937dabc44518d42038b55522c53@zhaoxin.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.64.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhaoxin CPUs have NONSTOP TSC feature, so enable the ACPI
driver support for it.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 drivers/acpi/acpi_pad.c       | 1 +
 drivers/acpi/processor_idle.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 6b3f121..e7dc013 100644
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
index e387a25..ed56c6d 100644
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
-- 
2.7.4
