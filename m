Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D7DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 11:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E0320872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 11:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1ZbgYG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbfCaLvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 07:51:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44756 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfCaLvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 07:51:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id i2so3321693pgj.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 04:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ye9NKXyQ2kgccXNO4CCydixZHamTv6nYRycKp5dsMJM=;
        b=Y1ZbgYG9pvotmFMpLNNDbf3F6Ri+nuvyQHt4FRKQo1gktH0dNSKM8WcoXxhXltPcax
         L4loSfR/J/Pp3e+ZnraxCuLo/wHYLgNDxCFjGNDJQFX8M8QAVGNbzRmwtxcl6MnuxfhU
         tPEGyR7LyrX+smznMpHOeDX146yDzn0e/iWcBbopsVZnwADStJvz5gUkTzmdvZjKv7vV
         0QpGLiJf3PQ97H82E3RbrRCA4FPpQggBfKixTg0NmFoWzHH57z/a7hQHF5ofwQ8kM0W8
         thdlxoHM17te8XmX079tJSFZqGiuEafATasyMgS4GcgKoiHsltb34PKyhTO2jxOkqrhJ
         mWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ye9NKXyQ2kgccXNO4CCydixZHamTv6nYRycKp5dsMJM=;
        b=tD9dM2Fx7FgcZYO8CxisTY8PMey2vduuGR0hX/W+pxGNTLgDLhDw5qfuSVcBGp2xZ2
         VsnphFYouApNB99hIXjwURXVR1jqkm297jYT+laA4QOZftLNCQHzdyeHAkPkxbKWEs4b
         4bxgnW2TLJdsgBrjYpQg3sjR1OaJGNXtmWNQrzpWGx/87QjZG6H8HcKrTx8yf/puf6H2
         OS6DmV9tjuoN+M/qHkDtfa0s0OIjYRKpXHy20SHdKDBZ4150l6fGC+Tjjyf8d5UKQTNA
         bYwEcoIC4DAB8GW57oSJYhFJRjTuSfxxmXM6ZlBwEUmaQ7Qlw1fxyfi9iUasjYeryHNq
         mCDQ==
X-Gm-Message-State: APjAAAU/M6TyaczJvpiJ/tnJlC1b9msU10map8OFyWteHg7uftbSxOlw
        QFAqKYbeAAUf6FyoRK4VR2Q=
X-Google-Smtp-Source: APXvYqw2N+4vhz+Ewtzake/00v4nAL7yHVtD7I2VBe4k5L3J8JVFPalUS6IIozRWlIXoDJELIpyeZA==
X-Received: by 2002:a63:61d7:: with SMTP id v206mr54694160pgb.349.1554033099873;
        Sun, 31 Mar 2019 04:51:39 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id z13sm2848246pgc.25.2019.03.31.04.51.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 04:51:39 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] tty: rocket: Fix a kernel address leakage in rp_ioctl
Date:   Sun, 31 Mar 2019 19:51:27 +0800
Message-Id: <20190331115127.29731-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the cmd is RCPK_GET_STRUCT, copy_to_user will copy info to
user space. As info->port.ops is the address of a constant object
rocket_port_ops (assigned in init_r_port), a kernel address leakage.

This patch sets all the pointer fields to NULL before copy the
object to user space to avoid kernel address leakage.

All pointer fields except
.magic field and the pointer in .dep_map field in struct mutex
which only exist under debug configurations of CONFIG_DEBUG_MUTEXES
and CONFIG_DEBUG_LOCK_ALLOC
are set to NULL.

The set NULL pointer fields are address of kernel objects:
 - pointers to constant objects: port.ops, port.client_ops
 - pointers to tty_struct instance
 - pointer.xmit_buf (allocated in rp_open)
 - pointer fields of wait_queue_head_t and struct mutex

I cannot think of a scenario where user space needs the address of
these kernel objects. So I set them all NULL before copy_to_user.
Another reason is that I have checked all uses of copy_to_user and
copy_from_user in this file, they do not use any of these pointer
fields. So these pointer fields can be set NULL safely.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/tty/rocket.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index b121d8f8f3d7..df0b8ebab266 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1271,6 +1271,48 @@ static int get_version(struct r_port *info, struct rocket_version __user *retver
 	return 0;
 }
 
+static int get_struct(struct r_port *info, void *argp)
+{
+	struct r_port *new;
+	int ret = 0;
+
+	new = kzalloc(sizeof(struct r_port), GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+	memcpy(new, info, sizeof(struct r_port));
+	new->port.buf.head = NULL;
+	memset(&new->port.buf.work.entry, 0, sizeof(struct list_head));
+	new->port.buf.work.func = NULL;
+#ifdef CONFIG_LOCKDEP
+	new->port.buf.work.lockdep_map.key = NULL;
+	memset(&new->port.buf.work.lockdep_map.class_cache, 0,
+		sizeof(struct lock_class *) * NR_LOCKDEP_CACHING_CLASSES);
+	new->port.buf.work.lockdep_map.name = NULL;
+#endif
+	memset(&new->port.buf.lock.wait_list, 0, sizeof(struct list_head));
+	new->port.buf.sentinel.next = NULL;
+	memset(&new->port.buf.free, 0, sizeof(struct llist_head));
+	new->port.buf.tail = NULL;
+	new->port.tty = NULL;
+	new->port.itty = NULL;
+	new->port.ops = NULL;
+	new->port.client_ops = NULL;
+	memset(&new->port.open_wait.head, 0, sizeof(struct list_head));
+	memset(&new->port.delta_msr_wait.head, 0, sizeof(struct list_head));
+	memset(&new->port.mutex.wait_list, 0, sizeof(struct list_head));
+	memset(&new->port.buf_mutex.wait_list, 0, sizeof(struct list_head));
+	new->port.xmit_buf = NULL;
+	new->port.client_data = NULL;
+	new->ctlp = NULL;
+	new->channel.CtlP = NULL;
+	new->xmit_buf = NULL;
+	memset(&new->write_mtx.wait_list, 0, sizeof(struct list_head));
+	if (copy_to_user(argp, new, sizeof(struct r_port)))
+		ret = -EFAULT;
+	kfree(new);
+	return ret;
+}
+
 /*  IOCTL call handler into the driver */
 static int rp_ioctl(struct tty_struct *tty,
 		    unsigned int cmd, unsigned long arg)
@@ -1284,8 +1326,7 @@ static int rp_ioctl(struct tty_struct *tty,
 
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

