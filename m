Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2E0C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E062084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfDZOGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:06:12 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.113]:45563 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbfDZOGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:06:11 -0400
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-central-1.aws.symcld.net id 18/9A-23082-15013CC5; Fri, 26 Apr 2019 14:06:09 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRWlGSWpSXmKPExsVy8IPnUd1AgcM
  xBgdXiFnc/3qU0eLyrjlsDkwed67tYfP4vEkugCmKNTMvKb8igTWjc8NnloLzHBVrXrWwNjAe
  YO9i5OIQEljPKDH/8xnmLkZOIKdC4mjbWjCbTcBQYt6b94xdjBwcLAKqEtueiYCEhQUSJLobV
  4CFRQRUJM69MQcJMwvESpyft5QFJMwr4CDR/koLJMwrIChxcuYTFogSCYmDL14wg5QICWhJLD
  8WCRKWELCXmP7+KlhYQkBfovFYLETYUOL7rG8sELa5xMS111kmMPLPQjJ0FpKhCxiZVjFaJBV
  lpmeU5CZm5ugaGhjoGhoa65rqmpjpJVbpJumlluomp+aVFCUCJfUSy4v1iitzk3NS9PJSSzYx
  AsMypZBVbwfjrOXphxglOZiURHnrPx2KEeJLyk+pzEgszogvKs1JLT7EKMPBoSTB+4zvcIyQY
  FFqempFWmYOMEJg0hIcPEoivFNB0rzFBYm5xZnpEKlTjLocD1s/z2UWYsnLz0uVEuftAykSAC
  nKKM2DGwGL1kuMslLCvIwMDAxCPAWpRbmZJajyrxjFORiVhHlLQabwZOaVwG16BXQEE9ARKSs
  PgRxRkoiQkmpg7PGqOnp1lf+OiPSu63qhDZ9cHvxl42SvNZyTZl8eI/lGWnmV0ObyruvCxyac
  Mz/zRK+t9+YjZyaLw+s/1W669HaV07LPhrmTAzYLst+QeG+mK5Qf0Xz65WL580WVbB/rO37kG
  n0vvNVUViTtYJG3THDnnrNGPA99U0+09ikbaL6Nk+5b5nJSiaU4I9FQi7moOBEAkZZx49ECAA
  A=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-5.tower-246.messagelabs.com!1556287568!5189568!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5579 invoked from network); 26 Apr 2019 14:06:09 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-5.tower-246.messagelabs.com with AES128-SHA256 encrypted SMTP; 26 Apr 2019 14:06:09 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Fri, 26 Apr 2019 15:06:07 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 9D2553FBD0; Fri, 26 Apr 2019 15:06:07 +0100 (BST)
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Fri, 26 Apr 2019 14:33:35 +0100
Subject: [PATCH] mfd: da9063: Fix OTP control register names to match
 datasheets for DA9063/63L
To:     Lee Jones <lee.jones@linaro.org>
CC:     Support Opensource <support.opensource@diasemi.com>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <20190426140607.9D2553FBD0@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 26/04/2019 11:25:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mismatch between what is found in the Datasheets for DA9063 and DA9063L
provided by Dialog Semiconductor, and the register names provided in the
MFD registers file. The changes are for the OTP (one-time-programming)
control registers. The two naming errors are OPT instead of OTP, and
COUNT instead of CONT (i.e. control).

Cc: Stable <stable@vger.kernel.org>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
 include/linux/mfd/da9063/registers.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mfd/da9063/registers.h b/include/linux/mfd/da9063/registers.h
index 5d42859..844fc29 100644
--- a/include/linux/mfd/da9063/registers.h
+++ b/include/linux/mfd/da9063/registers.h
@@ -215,9 +215,9 @@
 
 /* DA9063 Configuration registers */
 /* OTP */
-#define	DA9063_REG_OPT_COUNT		0x101
-#define	DA9063_REG_OPT_ADDR		0x102
-#define	DA9063_REG_OPT_DATA		0x103
+#define	DA9063_REG_OTP_CONT		0x101
+#define	DA9063_REG_OTP_ADDR		0x102
+#define	DA9063_REG_OTP_DATA		0x103
 
 /* Customer Trim and Configuration */
 #define	DA9063_REG_T_OFFSET		0x104
-- 
1.9.3

