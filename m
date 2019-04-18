Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2D8C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCE4217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBvaovYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfDREgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 00:36:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37827 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfDREgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 00:36:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so512423pfr.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 21:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1a+rckFm9Txo+QL+qVJn8e/4Ofa1OouYcXIyWXSPDiM=;
        b=fBvaovYrcfv5FVi22LSGRr1ouOvL7SohzFezzTVjLvK3NJl/6/8nCCaikBHCwNHveH
         FTvYHkT81oHB+xy7DImOb9RK1FOks4dc7NqwmuKbusCtJ6sP/fCwLuAJ6DG11itxTbrK
         6undYicmGbwnnp5UmFvXK2eR93/I7is3FIIhJh5v9sUJ10VhWFLvUND/7J+eR6Qk88cc
         WJo5Vcx8bhpwUuM2kicSy78L4HE9ChrHoShXlEU+c5Fvekbdcn1pXgyRO7svEXfohJfP
         0AM6oA3lUAOoiPGwKuBTuxoevxOESn3ZwzcqeKCC4AHzoPhclyUoqcKyHWx2NoNBKNPT
         WHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1a+rckFm9Txo+QL+qVJn8e/4Ofa1OouYcXIyWXSPDiM=;
        b=SCqJ/b7xtgY1mAQ/7RaqcHaKRZ6aLdmgW6H+KyVbPxsB9bIQOpUPYcCCAv6daHqvwV
         KIZ453dRXuSMY8dP3TRDhIiaWLavxtOSwl3d/D+hUlq+84MzR9CUZoQhQGJBXqoo8MLQ
         CS+vdEypp2ssxlzhudzl/EGPZ7kik+r1r5Xqvyc6GYblsvJDkdYKWmrqNuT4Y7/+VzJc
         fXEM3tqk3KlvtrkhHV4X2+DSNHUeAmGLAk8QFTR6t4dZbuKQeTgtXqyWBHeyEy1OJcuR
         M/YfzwdBOEKbGwIMed39yNDoeuzBmmgCr9NjmAZKajMXNvZmPgh54zoa38nkbrgXWWd/
         CSaA==
X-Gm-Message-State: APjAAAWlX8BAcFvEKhvNAhQxNaF4DVMN1VU14SnZo/ZcqT0Hux7u8RIG
        BycbjDnyjIQjvEr2EjArkTU=
X-Google-Smtp-Source: APXvYqwb6TdiNzBqQuHM+/CQOPdTflX2YwYEInW2IqxcbvsityaYHVDjOMnApJrrBReW/fLeq53w7A==
X-Received: by 2002:aa7:8694:: with SMTP id d20mr95110238pfo.81.1555562214295;
        Wed, 17 Apr 2019 21:36:54 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id a3sm1109363pfn.182.2019.04.17.21.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 21:36:53 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/02] tty: rocket: Remove RCPK_GET_STRUCT ioctl
Date:   Thu, 18 Apr 2019 12:35:57 +0800
Message-Id: <20190418043558.10577-1-huangfq.daxian@gmail.com>
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

Remove the RCPK_GET_STRUCT ioctl.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/tty/rocket.c | 4 ----
 drivers/tty/rocket.h | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index b121d8f8f3d7..b6543e28bd8b 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1283,10 +1283,6 @@ static int rp_ioctl(struct tty_struct *tty,
 		return -ENXIO;
 
 	switch (cmd) {
-	case RCKP_GET_STRUCT:
-		if (copy_to_user(argp, info, sizeof (struct r_port)))
-			ret = -EFAULT;
-		break;
 	case RCKP_GET_CONFIG:
 		ret = get_config(info, argp);
 		break;
diff --git a/drivers/tty/rocket.h b/drivers/tty/rocket.h
index d0560203f215..d62ed6587f32 100644
--- a/drivers/tty/rocket.h
+++ b/drivers/tty/rocket.h
@@ -71,7 +71,6 @@ struct rocket_version {
 /*
  * Rocketport ioctls -- "RP"
  */
-#define RCKP_GET_STRUCT		0x00525001
 #define RCKP_GET_CONFIG		0x00525002
 #define RCKP_SET_CONFIG		0x00525003
 #define RCKP_GET_PORTS		0x00525004
-- 
2.11.0

