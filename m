Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EB2C74261
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499F2208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMt8nkUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfGKRjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:39:42 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43955 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfGKRjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 13:39:41 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so4251246qka.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wzqHLodjklfHBMQ2oXwe3rSiKOixJEtNc2HYoaPd72g=;
        b=KMt8nkUKKA3uNV7EXX0FRWWqjZoFiTLUSIlTfEtUCMpKw3a1tDgd75azHHO1rVn4cz
         9xRJWnkyXg+ABgLeUnfO9S03qDAIxen6nJiXSH8yFDBkhKaLcfV2bT2LG9MmmjvuCkt9
         AvZzz17tqWEvpMsVedJYNIdVKeRqKwmhcCD66UA7YAjVRKjGzK1pPEQ7TCpAZgKGRR47
         WtZ8RoOesLb/iuIlLx4c4wTeoIk11eZe2g8SaVuCZUJRhEpwezC2+aJblwwHvM/ponVG
         ZLT9wbQEaGSl55GF260PK21NXHXc0GMcfCB/KVMQC/J9tkWq9XHGSw+wl/3W/8Lb3WsU
         E0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wzqHLodjklfHBMQ2oXwe3rSiKOixJEtNc2HYoaPd72g=;
        b=ubuS21LJ1UmEMMhsx8e0cxFYbt9TbP0UeP2cCEFcIl20oerJSJxo+UQK0r3TeW64u9
         eBv3738zGIT68i3pS2quFvO4NvNAp38VgYlHnlPw9lBv9CLLvHGBjePRZkIHcWaTVhQL
         hfjG8TlBtywpn3kvyDbqVjlkXZLa7v4AA/bogiOzhUb898kDeNcZBUvNPjgLXo2Ms/PT
         DUybjFyO/yzICR/nLi+PgxxfKpV+BDf3Z+Y0ey0r+Rg0UjWBcQpYVZM4MfR8cx72FB8d
         rFueve7+l3adLNlydQsUxZpNGONxdan+p1QyZI9f4eM4J9dEItTDCCUunqjz0uQWlDK1
         mDmw==
X-Gm-Message-State: APjAAAVcXUDzk3wOGb2JhaxcGs9BHRzsPOOVm7Km9PgfvKcAZRK31urP
        RGMzp/s9wDqZDFEJphN3aw==
X-Google-Smtp-Source: APXvYqy/EP/CSPda0hTxfFy92POdFWAYBW2oeddiFyl8zyVPrCCXK2k0Mo8FTGCs+Hrkne/W6zE2Yw==
X-Received: by 2002:a37:624b:: with SMTP id w72mr3124272qkb.368.1562866780185;
        Thu, 11 Jul 2019 10:39:40 -0700 (PDT)
Received: from localhost.localdomain (modemcable148.230-83-70.mc.videotron.ca. [70.83.230.148])
        by smtp.googlemail.com with ESMTPSA id i23sm2266094qtm.17.2019.07.11.10.39.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 10:39:39 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
Cc:     iamkeyur96@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Colin Ian King <colin.king@canonical.com>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: most: remove redundant print statement when 
Date:   Thu, 11 Jul 2019 13:39:12 -0400
Message-Id: <20190711173915.24200-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190711110809.17089-1-iamkeyur96@gmail.com>
References: <20190711110809.17089-1-iamkeyur96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This print statement is redundant as kfifo_alloc just calls kmalloc_array=0D
and without the __GFP_NOWARN flag, already does a dump_stack().=0D
=0D
Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>=0D
---=0D
Changes in v2:=0D
- Edit subject line.=0D
---=0D
 drivers/staging/most/cdev/cdev.c | 5 ++---=0D
 1 file changed, 2 insertions(+), 3 deletions(-)=0D
=0D
diff --git a/drivers/staging/most/cdev/cdev.c b/drivers/staging/most/cdev/c=
dev.c=0D
index d0cc0b746107..bc0219ceac50 100644=0D
--- a/drivers/staging/most/cdev/cdev.c=0D
+++ b/drivers/staging/most/cdev/cdev.c=0D
@@ -463,10 +463,9 @@ static int comp_probe(struct most_interface *iface, in=
t channel_id,=0D
 	spin_lock_init(&c->unlink);=0D
 	INIT_KFIFO(c->fifo);=0D
 	retval =3D kfifo_alloc(&c->fifo, cfg->num_buffers, GFP_KERNEL);=0D
-	if (retval) {=0D
-		pr_info("failed to alloc channel kfifo");=0D
+	if (retval)=0D
 		goto err_del_cdev_and_free_channel;=0D
-	}=0D
+=0D
 	init_waitqueue_head(&c->wq);=0D
 	mutex_init(&c->io_mutex);=0D
 	spin_lock_irqsave(&ch_list_lock, cl_flags);=0D
-- =0D
2.22.0=0D
=0D
