Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E5CC73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 16:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DDD2089C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 16:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azYm/S4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfGNQmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 12:42:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42291 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbfGNQmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 12:42:03 -0400
Received: by mail-qt1-f194.google.com with SMTP id h18so13269128qtm.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 09:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=17NxJyOTQqneQKqILFL+Kfh800SL9vsxcwn5ys2+a/0=;
        b=azYm/S4FEqrQmVAbcBXUA6zpmF8+qsRMlb0Iw/3XhUBI11liAps/povLyoAK4mhhAO
         AYQcFmhCNtupDtAkM8O1WAPqT0Bc+Jqzmk3MT7a1+ZnQCvj9xY2JMvBs38Yhh+XOzzGf
         S32xdtCs1ZtfnwVGeXmzX+GOUIt4+4jN5O/Poo2fMrrJpoDg31kaKvA4C7JoMFycAYRO
         PpiA+gp/vyXUIoZ3Mr5wYktb3ROFHzUa6df8XB8hm+KYiXFXCdJAFLQqWrFCU1FzM1en
         6KY9Jc/K4Vsu4C1pe9/8vaWB9UiiFF0rmekTWiKb7TAtx5DNGHtSHeDIVurmpR8OpAmk
         INig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=17NxJyOTQqneQKqILFL+Kfh800SL9vsxcwn5ys2+a/0=;
        b=rmh601o88lcWIYRbh4yjBxyTF/e7qLSjO+Aj4G/JUb9yrsGbsotTh9/Wr9P5ji7Omp
         hmRIO7k68xW5ccK6afZUtDKgi8eVc6ovnUz4KuQne2hUCfbohyQEoGlm4XER4NY3Y1zf
         7gtC8kIXXu5ESBVLg+4F+jPQVk2BTZDTGdb1NQytGAyoNkb7q9F8VM8fZ18aMmDyMUnZ
         IsRLk4+6tuGYabrBL7ModEVb4MO2rKeMKoEyho5kbKejSbyMBShiICxGjWL+JqfWl/00
         g8aR/DPMwsrUMnMgrA68llDsqaNdhu0iQvf+W+Z63dFLV6HsabKA4DrdHdZnnw81ldOt
         jnlA==
X-Gm-Message-State: APjAAAUgE4EO6jF6HteubT3JU/5O4Ik6mAou0AkIEJFjnyCHSO7ji4gb
        popgd8MZ9OjOodwIlCvTXg==
X-Google-Smtp-Source: APXvYqzAUvUcaEQydKd/FSJDHy6MdU8Yh5n5z/RNVzU41mdnfWQLZBZNa5viueSs61UMYMViwDn4Lg==
X-Received: by 2002:ac8:2bdc:: with SMTP id n28mr14811226qtn.197.1563122522773;
        Sun, 14 Jul 2019 09:42:02 -0700 (PDT)
Received: from localhost.localdomain (modemcable148.230-83-70.mc.videotron.ca. [70.83.230.148])
        by smtp.googlemail.com with ESMTPSA id h18sm5704034qkk.93.2019.07.14.09.42.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 09:42:02 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
Cc:     markus.elfring@web.de, Keyur Patel <iamkeyur96@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: most: Delete an error message for a failed memory allocation
Date:   Sun, 14 Jul 2019 12:41:23 -0400
Message-Id: <20190714164126.3159-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190711175055.25157-1-iamkeyur96@gmail.com>
References: <20190711175055.25157-1-iamkeyur96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This error message for a failed memory allocation is redundant as 
kfifo_alloc just calls kmalloc_array without the __GFP_NOWARN flag,
already does a dump_stack().

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
Changes in v4:
- change subject line
- improve commit description
- fix checkpatch warning

 drivers/staging/most/cdev/cdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/most/cdev/cdev.c b/drivers/staging/most/cdev/cdev.c
index d0cc0b746107..724d098aeef0 100644
--- a/drivers/staging/most/cdev/cdev.c
+++ b/drivers/staging/most/cdev/cdev.c
@@ -463,10 +463,8 @@ static int comp_probe(struct most_interface *iface, int channel_id,
 	spin_lock_init(&c->unlink);
 	INIT_KFIFO(c->fifo);
 	retval = kfifo_alloc(&c->fifo, cfg->num_buffers, GFP_KERNEL);
-	if (retval) {
-		pr_info("failed to alloc channel kfifo");
+	if (retval)
 		goto err_del_cdev_and_free_channel;
-	}
 	init_waitqueue_head(&c->wq);
 	mutex_init(&c->io_mutex);
 	spin_lock_irqsave(&ch_list_lock, cl_flags);
-- 
2.22.0

