Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94938C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7C72070B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbfKTPp6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:45:58 -0500
Received: from mx1.unisoc.com ([222.66.158.135]:21667 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732444AbfKTPpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:45:53 -0500
Received: from ig2.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTPS id xAKFi1ml093237
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 20 Nov 2019 23:44:01 +0800 (CST)
        (envelope-from Orson.Zhai@unisoc.com)
Received: from localhost (10.0.74.112) by BJMBX02.spreadtrum.com (10.0.64.8)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 20 Nov 2019 23:43:56
 +0800
From:   Orson Zhai <orson.zhai@unisoc.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kevin.tang@unisoc.com>, <baolin.wang@unisoc.com>,
        <chunyan.zhang@unisoc.com>, Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH V2 2/2] mfd: syscon: Find syscon by names with arguments support
Date:   Wed, 20 Nov 2019 23:41:48 +0800
Message-ID: <20191120154148.22067-3-orson.zhai@unisoc.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191120154148.22067-1-orson.zhai@unisoc.com>
References: <20191120154148.22067-1-orson.zhai@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.0.74.112]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
Content-Transfer-Encoding: 8BIT
X-MAIL: SHSQR01.spreadtrum.com xAKFi1ml093237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a lot of global registers used across multiple similar SoCs
from Unisoc. It is not easy to manage all of them very well by current
syscon helper functions.

Add helper functions to get regmap and arguments by syscon-names all
together.

This patch does not affect original syscon code and usage. It may help
other SoC vendors if they have the same trouble as well.

Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
---
 drivers/mfd/syscon.c       | 75 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/syscon.h | 26 +++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 660723276481..e818decc7bf2 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -225,6 +225,81 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle);

+struct regmap *syscon_regmap_lookup_by_name(struct device_node *np,
+                                       const char *list_name,
+                                       const char *cell_name)
+{
+       struct device_node *syscon_np;
+       struct of_phandle_args args;
+       struct regmap *regmap;
+       unsigned int index = 0, cell_count = 0;
+       int rc;
+
+       if (list_name)
+               index = of_property_match_string(np, "syscon-names", list_name);
+
+       if (index < 0)
+               return ERR_PTR(-EINVAL);
+
+
+       if (cell_name && of_property_read_u32(np, cell_name, &cell_count))
+               return ERR_PTR(-EINVAL);
+
+       rc = of_parse_phandle_with_fixed_args(np, "syscons", cell_count,
+                                                index, &args);
+       if (rc)
+               return ERR_PTR(rc);
+
+       syscon_np = args.np;
+
+       if (!syscon_np)
+               return ERR_PTR(-ENODEV);
+
+       regmap = syscon_node_to_regmap(syscon_np);
+
+       of_node_put(syscon_np);
+
+       return regmap;
+}
+EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_name);
+
+int syscon_get_args_by_name(struct device_node *np,
+                       const char *list_name,
+                       const char *cell_name,
+                       int arg_count,
+                       unsigned int *out_args)
+{
+       struct of_phandle_args args;
+       unsigned int index = 0, cell_count = 0;
+
+       int rc;
+
+       if (list_name)
+               index = of_property_match_string(np, "syscon-names", list_name);
+
+       if (index < 0)
+               return -EINVAL;
+
+       if (cell_name && of_property_read_u32(np, cell_name, &cell_count))
+               return -EINVAL;
+
+       rc = of_parse_phandle_with_fixed_args(np, "syscons", cell_count,
+                                               index, &args);
+       if (rc)
+               return rc;
+
+       if (arg_count > args.args_count)
+               arg_count = args.args_count;
+
+       for (index = 0; index < arg_count; index++)
+               out_args[index] = args.args[index];
+
+       of_node_put(args.np);
+
+       return arg_count;
+}
+EXPORT_SYMBOL_GPL(syscon_get_args_by_name);
+
 static int syscon_probe(struct platform_device *pdev)
 {
        struct device *dev = &pdev->dev;
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index 112dc66262cc..96bdaf3e63fd 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -23,6 +23,15 @@ extern struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
 extern struct regmap *syscon_regmap_lookup_by_phandle(
                                        struct device_node *np,
                                        const char *property);
+extern struct regmap *syscon_regmap_lookup_by_name(
+                                       struct device_node *np,
+                                       const char *list_name,
+                                       const char *cell_name);
+extern int syscon_get_args_by_name(struct device_node *np,
+                               const char *list_name,
+                               const char *cell_name,
+                               int arg_count,
+                               unsigned int *out_args);
 #else
 static inline struct regmap *device_node_to_regmap(struct device_node *np)
 {
@@ -45,6 +54,23 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle(
 {
        return ERR_PTR(-ENOTSUPP);
 }
+
+static inline struct regmap *syscon_regmap_lookup_by_name(
+                                       struct device_node *np,
+                                       const char *list_name,
+                                       const char *cell_name)
+{
+       return ERR_PTR(-ENOTSUPP);
+}
+
+static int syscon_get_args_by_name(struct device_node *np,
+                               const char *list_name,
+                               const char *cell_name,
+                               int arg_count,
+                               unsigned int *out_args)
+{
+       return -ENOTSUPP;
+}
 #endif

 #endif /* __LINUX_MFD_SYSCON_H__ */
--
2.18.0

________________________________
 This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。
