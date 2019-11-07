Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258ECFA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E132F217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8gbdzYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbfKGBZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 20:25:57 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34856 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfKGBZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 20:25:57 -0500
Received: by mail-pl1-f194.google.com with SMTP id s10so272396plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 17:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HZQZ+QN8IcCANweURFLD872HZDrHwnyJPcIvgEMxFVY=;
        b=M8gbdzYICn+MWkDBFF1+lka3iIWAzt7qryGm8rBazx27eQHBbnvYwX0ERS4Uzp0eRu
         CKjC/Dzb9uKHPWEZCHx6XQLu3hT2/dyAt2ysz98WXGrTYvTY1s9mreG/GSAc+ieaa9ab
         l0Mi04rAS48fy+ccnCbqTAE/sUNR8am7Kl1sqxG2The+epIIo+fwNdnk9azL7aW77xhm
         gaD/th52AiSNNpgy10cyoWWmry4+R6PpQLVJiEr8De+r7XHD3RDyML5lxSuDPDyNV+Hn
         EYrNh0K5TtYQbaJoKxc9Tfh7iJu4clg9GLvXKpFkmNYI7Wo/mOM17TUudk5oGEnPnyvd
         ssGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HZQZ+QN8IcCANweURFLD872HZDrHwnyJPcIvgEMxFVY=;
        b=fUTgdahgKgiYWlqs1fSFOJ/5puSBkRkJmidDrjlgKJmLRJiaiokzWLC47q3fWUAa5f
         9xRNWD9QFGzb/Z+pzvQr9Y1GNJdxGzpuXdViZ1L0OaRuc4lwJ1xSYISPjKZpQwP/V1LJ
         uSNn+js5VstDESxkViwxojn/Xa4eg7EiX7zgepkEw8kOUXhmfYb6tofH5aVgIKt4rbQM
         4N/ga2dAj/nd6sPdrkLmiu8YfVuwesQU73XzVFfE0ke6kKn9ZF0LQViaNy9Zt8Lhyb8f
         U8jgemHec6t8MvXVAp1Rfh3RiPUc3DOTqnmOWfv7ZQD6eo08UXTZbV9hR8IhFY3LE4jc
         o1sA==
X-Gm-Message-State: APjAAAVOFs6bO73vCQt1+q/2MaX5Hp957yZ5eN/APr4Cuy6nWSfl1Qah
        B/9ScW9oj7oosfT/VCfqbWo=
X-Google-Smtp-Source: APXvYqxb5Z3SzzsKZj4I9XTqCntS3cUrEObLSUKeJxUhmcwdCT6pqmuUbVdL6m/VxPFXGcu4UobIyw==
X-Received: by 2002:a17:902:a717:: with SMTP id w23mr731086plq.177.1573089955342;
        Wed, 06 Nov 2019 17:25:55 -0800 (PST)
Received: from localhost ([103.102.7.162])
        by smtp.gmail.com with ESMTPSA id b82sm250215pfb.33.2019.11.06.17.25.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 17:25:54 -0800 (PST)
From:   Cheng Chao <cs.os.kernel@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, nico@fluxnic.net,
        textshell@uchuujin.de, sam@ravnborg.org, daniel.vetter@ffwll.ch,
        mpatocka@redhat.com, ghalat@redhat.com
Cc:     linux-kernel@vger.kernel.org, Cheng Chao <cs.os.kernel@gmail.com>
Subject: [PATCH] tty: fill console_driver->driver_name
Date:   Thu,  7 Nov 2019 09:25:48 +0800
Message-Id: <1573089948-5944-1-git-send-email-cs.os.kernel@gmail.com>
X-Mailer: git-send-email 2.4.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cat /proc/tty/drivers
...
unknown              /dev/tty        4 1-63 console

----------------------------------
after this patch:

cat /proc/tty/drivers
...
console              /dev/tty        4 1-63 console

Signed-off-by: Cheng Chao <cs.os.kernel@gmail.com>
---
 drivers/tty/vt/vt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 34aa39d..981eee9 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3440,6 +3440,7 @@ int __init vty_init(const struct file_operations *console_fops)
 	if (!console_driver)
 		panic("Couldn't allocate console driver\n");
 
+	console_driver->driver_name = "console";
 	console_driver->name = "tty";
 	console_driver->name_base = 1;
 	console_driver->major = TTY_MAJOR;
-- 
2.4.11

