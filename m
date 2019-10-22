Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1293CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7040720640
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tfuy+tQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbfJVI7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:59:54 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:38884 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbfJVI7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:59:54 -0400
Received: by mail-pg1-f201.google.com with SMTP id b24so12136396pgi.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 01:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LZl6zNSvagqcd/4AyoUyx0eWouXvQtN7q4jWsmfi4io=;
        b=tfuy+tQwGzR8wBSj4bqW+++GTJLvz/JNlH7jUKHLm9iuvXEQfhb5ZNR9xHYc2Fezxa
         4JaEb5XDWhwEoZ4mxDhEpCWBwDg5Pts4SEkzpjZjI7XS1V1c/AhFAqoXPtUzk+0aa6Rk
         emCFtwda12zRaQHYEakvagoMbVU+Q0scW3GD6EJ8l6UOPl7t18ykbui3kBQZ3kSZShQ2
         ubjOmWTl30P4t5QBJ26DQzGRmoV9c9+9CY0j0iYxxaJBhcvtwsJNdoNsTbAkpK4mThGx
         7fA6ofgnYZwOsTSE63oMpJ3Hh3kYdWb4hASmlnUnKbPBWAWjY5/Xd1Yq5/KZJN55BADZ
         02IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LZl6zNSvagqcd/4AyoUyx0eWouXvQtN7q4jWsmfi4io=;
        b=VfKVS1MKZuvQJ0iiZpWo4aoAIfHxhbybfbe9PWWUmx4Vpc/M4tSzKL6YbVPsPOxyGD
         VQieOFtAywTnznOmCIZ0bkDz1Ncs3fEvnI2i9MBabwI+ewwEAmH8sj8HszIhecbPyM00
         dJiyQlFkyCkxuQZdl4KKecUX66KEZuUHDiJxZLBF61fHslEgPaVMnD66Dbs2lgxPgPoz
         /zbuOKFDtHAoGiS/P7pYQjW46AoC4Q+3ZRM4cTm5d6p2YgV9sxGqmE0bSuX0kvcIRz/z
         1/o66sMEO7dDWP4SBddodmkCOu8sPD/4MG+BC4GT1cQ06Yk+WZtigclc+Z41rz/oOd7J
         3WQw==
X-Gm-Message-State: APjAAAVnNPVNZNTw7mxxFDvgAwJBeuZ/D7HaP0w34wsC2+sxL+HnY7v1
        fRi9EPd0thYwyyANOdLNTumEjCn/xA9W
X-Google-Smtp-Source: APXvYqzQ/rX6WZj13Gy2AaMaTZY65r5k/J8i4M18FF8gz4I4aUGooW8mDpkAcV8SY3HIrxQHuXL9DYahdITE
X-Received: by 2002:a65:609a:: with SMTP id t26mr643896pgu.349.1571734791388;
 Tue, 22 Oct 2019 01:59:51 -0700 (PDT)
Date:   Tue, 22 Oct 2019 16:59:24 +0800
Message-Id: <20191022085924.92783-1-pumahsu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH V2] usb: typec: Add sysfs node to show connector orientation
From:   Puma Hsu <pumahsu@google.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, kyletso@google.com, albertccwang@google.com,
        rickyniu@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Puma Hsu <pumahsu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the Type-C connector orientation so that user space
can get this information.

Signed-off-by: Puma Hsu <pumahsu@google.com>
---
 Documentation/ABI/testing/sysfs-class-typec | 11 +++++++++++
 drivers/usb/typec/class.c                   | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
index d7647b258c3c..b22f71801671 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -108,6 +108,17 @@ Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
 Description:
 		Revision number of the supported USB Type-C specification.
 
+What:		/sys/class/typec/<port>/connector_orientation
+Date:		October 2019
+Contact:	Puma Hsu <pumahsu@google.com>
+Description:
+		Indicates which typec connector orientation is configured now.
+		cc1 is defined as "normal" and cc2 is defined as "reversed".
+
+		Valid value:
+		- unknown (nothing configured)
+		- normal (configured in cc1 side)
+		- reversed (configured in cc2 side)
 
 USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
 
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 94a3eda62add..911d06676aeb 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1245,6 +1245,23 @@ static ssize_t usb_power_delivery_revision_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(usb_power_delivery_revision);
 
+static const char * const typec_connector_orientation[] = {
+	[TYPEC_ORIENTATION_NONE]		= "unknown",
+	[TYPEC_ORIENTATION_NORMAL]		= "normal",
+	[TYPEC_ORIENTATION_REVERSE]		= "reversed",
+};
+
+static ssize_t connector_orientation_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct typec_port *p = to_typec_port(dev);
+
+	return sprintf(buf, "%s\n",
+		       typec_connector_orientation[p->orientation]);
+}
+static DEVICE_ATTR_RO(connector_orientation);
+
 static struct attribute *typec_attrs[] = {
 	&dev_attr_data_role.attr,
 	&dev_attr_power_operation_mode.attr,
@@ -1255,6 +1272,7 @@ static struct attribute *typec_attrs[] = {
 	&dev_attr_usb_typec_revision.attr,
 	&dev_attr_vconn_source.attr,
 	&dev_attr_port_type.attr,
+	&dev_attr_connector_orientation.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(typec);
-- 
2.23.0.866.gb869b98d4c-goog

