Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC2AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4882075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfwQR/3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbfCYVNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:13:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39025 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbfCYVNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:13:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so11883183wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9hh0UtstUufdI6oxhnW/JDjtvvBT1twz+bejTeM5TiQ=;
        b=EfwQR/3dtiJborn9dsbYdvzQIdh6ixYP2n2HVc5bGj7n9kkJRVCwcU11LsO5AmCDrj
         Xb+MAbFuX31a/8widC+69fapDxo7NWsTnU+UzxZnqvxtivYfinvJLbLvypOEfom1KxV6
         um58sjw7go7EIUhlynYvcLFUmXnRgX8EIVmdSTRjfDvLlqI5UsrftpQEOubEnFAIw1lU
         ayZV72+8j4ilFnCXWXqsjYhujB6oDC8jFYxkA1CDoyHM17Fwy8MJJzDI848pMT5ApaD2
         w8h30/r1KPpeJM9VfjjZ3WOgkhEXjnJdwLFMscP+kNju19Vg+khuNQer/MIGPvV4cqzR
         A5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9hh0UtstUufdI6oxhnW/JDjtvvBT1twz+bejTeM5TiQ=;
        b=p6USPaWxVkzkEL4S8lPrFuYTkpyww4X46XyepdbQkm/MWMIH/RudxAJTJah4S52C8f
         isS/ugKtJi7+09Sl1Qa41+Q0+JHkAaRnXvmjSgdGdNd9IZtZFUWhqsgNL+F69PBSucQu
         RWUhmXOqDD4kUB/njsFTssGmmOl71j+S00W8y1RfBQLwRv9IYnO5o8hg6hfTOqIafE2A
         j6aVjyUVJAN9aqGzMWUiwFThdoDPzdOaVwIooR6PJdEbZPdBM+h7131yrQLtN/13kNq6
         An5oKsqYeVQAKPdSOHCjpufElYDzR7+sh9VsAO45So1cAiTkJo9RvqtBdS5f+/l34G3h
         7w+g==
X-Gm-Message-State: APjAAAUxoX6EExZLlZmjWcPbuyYslaoInE17shR6MYmnrb+mozhtbzbZ
        3HiSrMtNudeyFY1rBFD81dZdxzvu
X-Google-Smtp-Source: APXvYqyBd+Wb287AlKHkzQMx0xwCaTd3x8ed8VSTHfzp4wEYkosXssZ0cHyDnFBXj/WqP0naSqJB2w==
X-Received: by 2002:a5d:4907:: with SMTP id x7mr18278837wrq.133.1553548409804;
        Mon, 25 Mar 2019 14:13:29 -0700 (PDT)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id w16sm20609974wrt.84.2019.03.25.14.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 14:13:29 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] parport: daisy: do not try to load lowlevel driver
Date:   Mon, 25 Mar 2019 21:13:25 +0000
Message-Id: <20190325211325.21411-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some distros like Suse has an alias for "parport_lowlevel" and that
alias points to "parport_pc". Now when the parport bus registers, it
also initialises the daisy driver as the daisy driver is needed to
check the port when the port is first found. Due to the new device
model daisy driver will now try to find the parallel ports while trying
to register its driver so that it can bind with them. Now, since daisy
driver is loaded while parport bus is initialising the list of parport
is still empty and it tries to load the lowlevel driver, which has an
alias set to parport_pc, now causes a deadlock.

We do not need to search for ports and bind the initial list of ports
to daisy driver as daisy driver is always the first driver to use the
new found parport and we know when the parport bus is registering the
list of parport will always be empty. So, proceed with the daisy_drv
registration even if the list of parport is empty.

Fixes: 1aec4211204d ("parport: daisy: use new parport device model")
Reported-by: Michal Kubecek <mkubecek@suse.cz>
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Tested-by: Michal Kubecek <mkubecek@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/share.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 0171b8dbcdcd..f87948fbfc34 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -274,7 +274,7 @@ static int port_check(struct device *dev, void *dev_drv)
 int __parport_register_driver(struct parport_driver *drv, struct module *owner,
 			      const char *mod_name)
 {
-	if (list_empty(&portlist))
+	if (list_empty(&portlist) && strcmp(drv->name, "daisy_drv"))
 		get_lowlevel_driver();
 
 	if (drv->devmodel) {
-- 
2.11.0

