Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92891C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E31020823
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PM+y/iWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfCBAsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:48:35 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45228 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727272AbfCBAsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 19:48:35 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x220jKEi029310
        for <linux-kernel@vger.kernel.org>; Fri, 1 Mar 2019 16:48:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=MIHq4tU7qcFfmoetfTM1EQJ3mdEJ7twxaH8aGN9v1uk=;
 b=PM+y/iWaGv/PYPVKt8lXB8z1tFpwMYAF+s9HZqn/hYHDMe7sXPRrAMJ5fTgN4Il263lB
 DYRIxwhfhw3jtBH1OynwpkMYuQzKRO9xgXj70v1uYbcJtFZkmcEzzIFIazxYF6C0cyqB
 L+2/7uUtx74VlfLOuCyXBpjq7KuMNlmajwQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qycv50gn5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 16:48:34 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 1 Mar 2019 16:48:33 -0800
Received: by devbig008.ftw2.facebook.com (Postfix, from userid 10532)
        id 1AD9E23A5AB7; Fri,  1 Mar 2019 16:48:32 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Calvin Owens <calvinowens@fb.com>
Smtp-Origin-Hostname: devbig008.ftw2.facebook.com
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Calvin Owens <calvinowens@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 4/4] printk: Add a device attribute for the per-console loglevel
Date:   Fri, 1 Mar 2019 16:48:20 -0800
Message-ID: <4f71564063a07837e3c4df41326bad25e7dc4db4.1551486733.git.calvinowens@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551486732.git.calvinowens@fb.com>
References: <cover.1551486732.git.calvinowens@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Calvin Owens <calvinowens@fb.com>
---
 kernel/printk/printk.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 67e1e993ab80..e7e602fa2d0b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2560,8 +2560,48 @@ static int __init keep_bootcon_setup(char *str)
 
 early_param("keep_bootcon", keep_bootcon_setup);
 
+static ssize_t loglevel_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct console *con = container_of(dev, struct console, dev);
+	return sprintf(buf, "%d\n", con->level);
+}
+
+static ssize_t loglevel_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct console *con = container_of(dev, struct console, dev);
+	ssize_t ret;
+	int tmp;
+
+	ret = kstrtoint(buf, 10, &tmp);
+	if (ret < 0)
+		return ret;
+
+	if (tmp < LOGLEVEL_EMERG)
+		return -ERANGE;
+
+	/*
+	 * Mimic the behavior of /dev/kmsg with respect to minimum_loglevel.
+	 */
+	if (tmp < minimum_console_loglevel)
+		tmp = minimum_console_loglevel;
+
+	con->level = tmp;
+	return ret;
+}
+
+static DEVICE_ATTR_RW(loglevel);
+
+static struct attribute *console_sysfs_attrs[] = {
+	&dev_attr_loglevel.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(console_sysfs);
+
 static struct bus_type console_subsys = {
 	.name = "console",
+	.dev_groups = console_sysfs_groups,
 };
 
 static void console_release(struct device *dev)
-- 
2.17.1

