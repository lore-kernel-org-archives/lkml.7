Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB7FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 05:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6024A21726
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 05:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCnZ18hw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfCaFdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 01:33:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43136 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfCaFdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 01:33:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so3113127pgu.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 22:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Gk//tgaFJ7Onze/bmRzL6O9Iwcla3mEgkKQrAZ6AIPo=;
        b=CCnZ18hwRcCzRIKNRjTcovtyFzp6aypZzlwfnYDKqWKZAXMexaXziymDCI2o5cJW22
         5T1+TEboxWfWvdi5bdyWQpQdHva93nwx9DXxdeXI8yqnDOnEbSndZZka0B38TXQYz95y
         rQ5iI7LGWSFV6Nb9cFpWPprhZr4eZwRUcFkLgIkJj+NA6FrfgaElsYpV6Ia/gBpv5pmX
         PgYOdB9UwJpKQhPqrfOC4pKETN1FIXtZwfpStT5YsL0RLJruS0m2JE+jutbJCItXNx/+
         17gEazELsUTeXeMG7qAsRhIkLIcu2q9a7SSLd+aIsvWY605PpjpBnjB7/+DkT1IReAUQ
         9CWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Gk//tgaFJ7Onze/bmRzL6O9Iwcla3mEgkKQrAZ6AIPo=;
        b=VG9wnA6gowp2p/RN8pq7KrLKyQsXWteu+F7z0fg5xgdpFrkwMnG3HseENJxSmt6tGS
         A049Lz9l6Ml8ubItrYm3mQJGqbEuRu+N5ioV2kTDA3+6XrUtgoZtukCVtY1oQC3fjAiq
         4tCjXlOz4NJmwY/jOVHkBqxYKGkiUNQHsXGlYb+RIO/bhpgbpCQ3N+iXL/zOdNCZcFBh
         MgFuGJgWIwKuKyktawhnD2SdybNbMMxy4bsl0Yj9gPVSm1QzWI3PXm/XsZrRo31r3BUl
         Oczg8dI1ZlRgKaXDy2TFLSxugQ2UplI/MdQjoj5ufqyO4HAKwptYDGg75g8SJiK2P1GE
         UkEw==
X-Gm-Message-State: APjAAAXCzpACjh5pTi3fKwKlW3i0loqwsd7nA9JASFoTbbwOjFl5eO+y
        dU2gh1f3BcAjJms+fwd5fsnSJGlppes=
X-Google-Smtp-Source: APXvYqzIhSp4eXSQl6tMHMwSgwl8Hr0/YNyRAd+UHcuEfNIqLPkgs6aL2qZkfHWOJqEBY4Us3tWRKQ==
X-Received: by 2002:a65:6259:: with SMTP id q25mr26695210pgv.103.1554010380055;
        Sat, 30 Mar 2019 22:33:00 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id f7sm9290032pgf.48.2019.03.30.22.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 22:32:59 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: rocket: Fix a kernel address leak in rp_ioctl
Date:   Sun, 31 Mar 2019 13:32:06 +0800
Message-Id: <20190331053207.17337-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the cmd is RCPK_GET_STRUCT, copy_to_user will copy
info to user space. As info->port.ops is the address of
a constant object rocket_port_ops (assigned in init_r_port),
a kernel address leakage happens.

This patch sets all the pointer fields to NULL before copy the
object to user space to avoid kernel address leakage.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/tty/rocket.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index b121d8f8f3d7..a7bcf44b61bd 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1271,6 +1271,34 @@ static int get_version(struct r_port *info, struct rocket_version __user *retver
 	return 0;
 }
 
+static int get_struct(struct r_port *info, void *argp)
+{
+	struct r_port *new;
+	int ret = 0;
+
+	new = kzalloc(sizeof (struct r_port), GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+	memcpy(new, info, sizeof (struct r_port));
+	new->port.tty = NULL;
+	new->port.itty = NULL;
+	new->port.ops = NULL;
+	new->port.client_ops = NULL;
+	memset(&new->port.open_wait.head, 0, sizeof (struct list_head));
+	memset(&new->port.delta_msr_wait.head, 0, sizeof (struct list_head));
+	memset(&new->port.mutex.wait_list, 0, sizeof (struct list_head));
+	memset(&new->port.buf_mutex.wait_list, 0, sizeof (struct list_head));
+	new->port.xmit_buf = NULL;
+	new->port.client_data = NULL;
+	new->ctlp = NULL;
+	new->xmit_buf = NULL;
+	memset(&new->write_mtx.wait_list, 0, sizeof (struct list_head));
+	if (copy_to_user(argp, new, sizeof (struct r_port)))
+		ret = -EFAULT;
+	kfree(new);
+	return ret;
+}
+
 /*  IOCTL call handler into the driver */
 static int rp_ioctl(struct tty_struct *tty,
 		    unsigned int cmd, unsigned long arg)
@@ -1284,8 +1312,7 @@ static int rp_ioctl(struct tty_struct *tty,
 
 	switch (cmd) {
 	case RCKP_GET_STRUCT:
-		if (copy_to_user(argp, info, sizeof (struct r_port)))
-			ret = -EFAULT;
+		ret = get_struct(info, argp);
 		break;
 	case RCKP_GET_CONFIG:
 		ret = get_config(info, argp);
-- 
2.11.0

