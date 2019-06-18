Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A499C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5822920B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfFRIhc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:37:32 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:21808 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729122AbfFRIhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:37:31 -0400
Received: from zxbjmbx3.zhaoxin.com (10.29.252.165) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 18 Jun
 2019 16:37:30 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx3.zhaoxin.com
 (10.29.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 18 Jun
 2019 16:37:29 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Tue, 18 Jun 2019 16:37:29 +0800
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
Subject: [PATCH v2 3/3] x86/acpi/cstate: add Zhaoxin processors support for
 cache flush policy in C3
Thread-Topic: [PATCH v2 3/3] x86/acpi/cstate: add Zhaoxin processors support
 for cache flush policy in C3
Thread-Index: AdUlrXyaXF+iCRFCSOO5QfgXRuCt6w==
Date:   Tue, 18 Jun 2019 08:37:29 +0000
Message-ID: <a370503660994669991a7f7cda7c5e98@zhaoxin.com>
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

Same as Intel, Zhaoxin MP CPUs support C3 share cache and on all
recent Zhaoxin platforms ARB_DISABLE is a nop. So set related
flags correctly in the same way as Intel does.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/acpi/cstate.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index a5e5484..caf2edc 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -64,6 +64,21 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 		    c->x86_stepping >= 0x0e))
 			flags->bm_check = 1;
 	}
+
+	if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
+		/*
+		 * All Zhaoxin CPUs that support C3 share cache.
+		 * And caches should not be flushed by software while
+		 * entering C3 type state.
+		 */
+		flags->bm_check = 1;
+		/*
+		 * On all recent Zhaoxin platforms, ARB_DISABLE is a nop.
+		 * So, set bm_control to zero to indicate that ARB_DISABLE
+		 * is not required while entering C3 type state.
+		 */
+		flags->bm_control = 0;
+	}
 }
 EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
 
-- 
2.7.4
