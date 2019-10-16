Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68962FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399582168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtLlJFfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405776AbfJPOpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:45:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36214 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfJPOpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:45:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so28416507wrd.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 07:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OqWLyb2BG8Sok2vGbygAuB5dtFUQpwFRtHupkgR5yCg=;
        b=dtLlJFfrr+8E71lRdhXf0907/EJJZdg7mf0+MkvIqzq6Lx0I6NDcpOZSyLu2llONZp
         YETOIeS09sgle1b1Cu//fC2rlSxa6WMkA3DP2Gn+FNjnlYJXHhyzcuGKa8tIXE46SdPK
         kBj9OHhhAzFnc6XN9/d+q7LvQShiW58S9WdSgroBLWLPeqF4eNNe/9JMLbhXwc+tJv30
         pj/svO6d0xZ2QRryeys3OEi+Gi+hf2aBULvfCR5DEr+EgBpeU1mOyJKCGtRHC/N8/4Cg
         3l1w+A56EqSpdfV0d/6/WUgYKj3rG5aCl1Ge7NtCfWOqZONm4KG9wQBtqigadjfZhzZs
         uV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OqWLyb2BG8Sok2vGbygAuB5dtFUQpwFRtHupkgR5yCg=;
        b=OViw4Qq4WTOiWzMjSFy40AcLcExUD018ilxNgrEUIyY0P/npHlECe1p+3vutNUzXl/
         tw/aLOmsxC6PRu4DvTNYS+JXHPafSuogIOpxSEE2XTL7Ll2o3XBMobi5w42zSQqtkfDy
         Hkfg50FyoaHxfgySGmgVfWtTblWVM61lXNxNJ19Z6Ro52MNZiCvfocmun+p4rnXJMqde
         c9rBENeQYd4j2eZG1jYMX6V77tERz0sJ7S+WIlrNI6saoKj9+W6eVLR9tOc+bj3yQGt8
         zUklWiyEsesyfHgG1GgM+ifxQuPOhea59IyMv83v3ud0AZyE2I/5t24Skh04ZOO2ZTdF
         C4Ng==
X-Gm-Message-State: APjAAAWmGW4w3tEAgaZkmVjd6Ruj0A+GoIaVyyPJdyYgHf9MKcpwVa5q
        gfu0G5cWmq6KbwsY5TWhaOc=
X-Google-Smtp-Source: APXvYqwf95sC2Wvbbo5QZxX6nVpD7F+Dy1DWm2Q/ChY0HuEzuKHmvO9mWqGrXkspBBCTHmw14UOZSA==
X-Received: by 2002:a5d:55ce:: with SMTP id i14mr1648260wrw.169.1571237144632;
        Wed, 16 Oct 2019 07:45:44 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id q3sm22211733wru.33.2019.10.16.07.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 07:45:43 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 2/4] parport: do not check portlist when using device-model
Date:   Wed, 16 Oct 2019 15:45:38 +0100
Message-Id: <20191016144540.18810-2-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191016144540.18810-1-sudipm.mukherjee@gmail.com>
References: <20191016144540.18810-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not need to maintain a list of ports when we are using the
device-model. The base layer is going to maintain the list for us and
we can get the list of ports just using bus_for_each_dev().

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/share.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 7b4ee33c1935..96538b7975e5 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -266,9 +266,6 @@ static int port_check(struct device *dev, void *dev_drv)
 int __parport_register_driver(struct parport_driver *drv, struct module *owner,
 			      const char *mod_name)
 {
-	if (list_empty(&portlist))
-		get_lowlevel_driver();
-
 	if (drv->devmodel) {
 		/* using device model */
 		int ret;
@@ -292,6 +289,8 @@ int __parport_register_driver(struct parport_driver *drv, struct module *owner,
 
 		drv->devmodel = false;
 
+		if (list_empty(&portlist))
+			get_lowlevel_driver();
 		mutex_lock(&registration_lock);
 		list_for_each_entry(port, &portlist, list)
 			drv->attach(port);
-- 
2.11.0

