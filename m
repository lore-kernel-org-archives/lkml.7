Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5391EC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22959214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XS4EhrtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfKHFU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 00:20:27 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42201 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbfKHFU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 00:20:26 -0500
Received: by mail-pg1-f193.google.com with SMTP id q17so3292057pgt.9;
        Thu, 07 Nov 2019 21:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=abrU7G2BP5v8QeCE5OZCvci6QXqITkbp0Z5/JmfzQPA=;
        b=XS4EhrtLD7ira7yvelmd2Zy3twZdQh8w75/0Bvi5MIu/L4pOW3y8Uz4PCFCEcn0x2V
         UJRHR7EHVv4upN1s3mKOU+aXz8ou1jxdpweTYwgv4ZnBbnd7Ii4zfwrgAp55n2AvBJH3
         1jhNhhQuZvooBbddpFbLmdVJs6jwPqfRAfvZpnzrHYf0XrHgX5EGpC7yIkL5+Us9WUFx
         BakG/iV27xw1PKS7f7ib3sHdPeWqSavpn0U224EvrUgbgOKPkXXEHgU5eVlcMk3CC16K
         aYQeJ7wbJ/sy2mgsQ4LVYZXgUfbtEZQm42iDbOBbjbnNadLsIbqADQtzfg1IwqX9IdC7
         iKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=abrU7G2BP5v8QeCE5OZCvci6QXqITkbp0Z5/JmfzQPA=;
        b=NYeyBd2IDy07Iavz8tGvYp6Twf0NJYuqy4p1gxO4t7XF7xWxzdMSlm34EyIhJuT6Wv
         UPcPQztEJc7XHj2k2gs4WYyd49Ddux1JAYXu7+FhBi12wNF5KlEWRwuJfZnPLRecPZAS
         B3L+y72NEpVtdsld12ZeD4BpUBDtSlMFOeD//Lbp6Ayw7sGpwIGz/yJYqbyztd+8t1Eu
         JRqfcQn+QxpVrHEWoOR+1xH4FlurUmLRqsASqQWtWaLMqxsT/5DGLtfyG+I7vt+z1qav
         AQOdzYtSkR1juvfm6dNwHTcpJbKXKP5ImY8gDDcS3fZwkiOE1A6Y7SpWl82/4MUIY3zo
         IhMg==
X-Gm-Message-State: APjAAAWj2QVSr/46hU+4Q/zVWQWUMoZtXz9PBw/80q51m0Da4E2Tixsl
        YhkgILX+LEc5nkCbHfTaigQ=
X-Google-Smtp-Source: APXvYqzuOVQPOmNdL1oWGOMyR40/RsnF24CKyjQWAw0vN7iQicHxialcfaga7srrNVEALqe7IjKKTQ==
X-Received: by 2002:a63:495b:: with SMTP id y27mr9468935pgk.438.1573190425229;
        Thu, 07 Nov 2019 21:20:25 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
        by smtp.gmail.com with ESMTPSA id v19sm3798443pjr.14.2019.11.07.21.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 21:20:24 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsi@lists.ozlabs.org
Subject: [PATCH v2 05/11] fsi: core: Fix small accesses and unaligned offsets via sysfs
Date:   Fri,  8 Nov 2019 15:49:39 +1030
Message-Id: <20191108051945.7109-6-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191108051945.7109-1-joel@jms.id.au>
References: <20191108051945.7109-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Jeffery <andrew@aj.id.au>

Subtracting the offset delta from four-byte alignment lead to wrapping
of the requested length where `count` is less than `off`. Generalise the
length handling to enable and optimise aligned access sizes for all
offset and size combinations. The new formula produces the following
results for given offset and count values:

    offset  count | length
    --------------+-------
    0       1     | 1
    0       2     | 2
    0       3     | 2
    0       4     | 4
    0       5     | 4
    1       1     | 1
    1       2     | 1
    1       3     | 1
    1       4     | 1
    1       5     | 1
    2       1     | 1
    2       2     | 2
    2       3     | 2
    2       4     | 2
    2       5     | 2
    3       1     | 1
    3       2     | 1
    3       3     | 1
    3       4     | 1
    3       5     | 1

We might need something like this for the cfam chardevs as well, for
example we don't currently implement any alignment restrictions /
handling in the hardware master driver.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-core.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index c773c65a5058..e02ebcb0c9e6 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -544,6 +544,31 @@ static int fsi_slave_scan(struct fsi_slave *slave)
 	return 0;
 }
 
+static unsigned long aligned_access_size(size_t offset, size_t count)
+{
+	unsigned long offset_unit, count_unit;
+
+	/* Criteria:
+	 *
+	 * 1. Access size must be less than or equal to the maximum access
+	 *    width or the highest power-of-two factor of offset
+	 * 2. Access size must be less than or equal to the amount specified by
+	 *    count
+	 *
+	 * The access width is optimal if we can calculate 1 to be strictly
+	 * equal while still satisfying 2.
+	 */
+
+	/* Find 1 by the bottom bit of offset (with a 4 byte access cap) */
+	offset_unit = BIT(__builtin_ctzl(offset | 4));
+
+	/* Find 2 by the top bit of count */
+	count_unit = BIT(8 * sizeof(unsigned long) - 1 - __builtin_clzl(count));
+
+	/* Constrain the maximum access width to the minimum of both criteria */
+	return BIT(__builtin_ctzl(offset_unit | count_unit));
+}
+
 static ssize_t fsi_slave_sysfs_raw_read(struct file *file,
 		struct kobject *kobj, struct bin_attribute *attr, char *buf,
 		loff_t off, size_t count)
@@ -559,8 +584,7 @@ static ssize_t fsi_slave_sysfs_raw_read(struct file *file,
 		return -EINVAL;
 
 	for (total_len = 0; total_len < count; total_len += read_len) {
-		read_len = min_t(size_t, count, 4);
-		read_len -= off & 0x3;
+		read_len = aligned_access_size(off, count - total_len);
 
 		rc = fsi_slave_read(slave, off, buf + total_len, read_len);
 		if (rc)
@@ -587,8 +611,7 @@ static ssize_t fsi_slave_sysfs_raw_write(struct file *file,
 		return -EINVAL;
 
 	for (total_len = 0; total_len < count; total_len += write_len) {
-		write_len = min_t(size_t, count, 4);
-		write_len -= off & 0x3;
+		write_len = aligned_access_size(off, count - total_len);
 
 		rc = fsi_slave_write(slave, off, buf + total_len, write_len);
 		if (rc)
-- 
2.24.0.rc1

