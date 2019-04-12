Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5761C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8451B2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfS3Uq3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfDLHXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:23:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34491 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfDLHXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:23:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so4723023pfd.1;
        Fri, 12 Apr 2019 00:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZxBLWrZQ/7BkSjnWGK2Pntf0RPNeI75SM8sNdVgncXo=;
        b=YfS3Uq3ieftG9y1f0tbqUxkkCbjt1R20Yc75wn2UOgRAfcDwgrIZCop8L9jPnxrh1g
         J5IA6U9Vn2/QBKlSKi1guz7buPWZS7uwwRpwfNw85vzyHK9AuiyyqNKE+Yj++5OXya6M
         AHIA9yZnPexlaz2/CQaAW4OUrRPaKy+Wh3FWDNVQccGLVAXPJB/2xuSRCQxqdwo/ocBE
         95ZCf0+nuTziUJkrOQBUnOQ/Vq19F8YzkLsGgRD+l3JEACv+2T4rfrq1aIa/5lJbMqhx
         PAzAkFj3MebLMPyULC9b+nW0fkExi8/WxQvl7jpQ5Q4ws9XaJW27LoWyWgpUwjpcxLEP
         WmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZxBLWrZQ/7BkSjnWGK2Pntf0RPNeI75SM8sNdVgncXo=;
        b=n7dXIyhaz5UoirZML9f+abKNoKmWfaFSUfrw0QIedHfOE+HlIp419ytwA8QQfp5+fV
         2vTdSv6m/cNvzk/1PwVW3gKp71iS/oD079feGauWUvTHP18ISrsmBnWBgsQjbSv7thfx
         0Cj43idf+ZJkBtHulGKwR9p5ON1FKs029n6X0fPQSpxXF6m94F4+6/dKh1hyPUXYrsCR
         s2Q6jqQArIMIEgO6xc8ybKnFX5A4of0xtEnY7AA1pwvVr5BR0XDkWG1yrUiYBj2x4AGF
         l9wdCuVmTNu/3Pp/tgBke5BgMdZBbzkqcm7FEdbwrp1NeTRqjSvekNnmBff0viX1hf4q
         aV0w==
X-Gm-Message-State: APjAAAVjnGh78BPdz52z0YCDRglXXem9+FeOVnWQQprreAqfOYymW1lA
        0kOF2zzk8aiI3TmUkub8VLaPvoqqOTQu/g==
X-Google-Smtp-Source: APXvYqx0+nDNbQ2pxsaRwFbYiO1DD3bjjxdtEvYCtmcWVryogz55y/WBRD879PecKcxeG9K0Q8juHw==
X-Received: by 2002:a62:424b:: with SMTP id p72mr36812528pfa.167.1555053811510;
        Fri, 12 Apr 2019 00:23:31 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id 18sm55640226pfp.18.2019.04.12.00.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 00:23:30 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net,
        viro@zeniv.linux.org.uk, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Young Xiao <YangX92@hotmail.com>
Subject: [PATCH] Bluetooth: hidp: fix buffer overflow
Date:   Fri, 12 Apr 2019 15:24:30 +0800
Message-Id: <1555053870-31588-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Young Xiao <YangX92@hotmail.com>

Struct ca is copied from userspace. It is not checked whether the "name"
field is NULL terminated, which allows local users to obtain potentially
sensitive information from kernel stack memory, via a HIDPCONNADD command.

This vulnerability is similar to CVE-2011-1079.

Signed-off-by: Young Xiao <YangX92@hotmail.com>
---
 net/bluetooth/hidp/sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
index 9f85a19..2151913 100644
--- a/net/bluetooth/hidp/sock.c
+++ b/net/bluetooth/hidp/sock.c
@@ -75,6 +75,7 @@ static int do_hidp_sock_ioctl(struct socket *sock, unsigned int cmd, void __user
 			sockfd_put(csock);
 			return err;
 		}
+		ca.name[sizeof(ca.name)-1] = 0;
 
 		err = hidp_connection_add(&ca, csock, isock);
 		if (!err && copy_to_user(argp, &ca, sizeof(ca)))
-- 
1.9.1

