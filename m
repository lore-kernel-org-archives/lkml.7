Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB6EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4A520830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVrgZ8MM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDCBEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:04:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34438 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDCBEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 21:04:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id k2so17670810qtm.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 18:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=VFsL0vLiPyehSrSGKfgAV/dOCLVxn5fde2IiJdtuRQI=;
        b=YVrgZ8MMM+Gk1ZXQLCtfJOxdqiFoG4Y8F1P7Lwxpaf5swYu8qBzf/jlha8xU15Z1BG
         uPZ5K8mqRz96jPRzNbRz/kUwoVFtGjNCi8kyKCnFJAollYTRbZCRK7YXVyS4Udt9UwtK
         aVLrKneAgWZHWJwgyGmdgCrY7uif4H9NsVmoevVuRNNx8JKJ3VeJQmFsrg1aZZMAw7Co
         a9y+zb5bFc0KoiRaynt/mcAscRSDqv1tGhjLwCrrg+WJ3t1aawTMiLXFt9PTO+s6M2D2
         1573NEAry50+EyzYbA4Od5XIkBQqcwTT/E7SsP5IAnAqV4pkqQ/EOICScsTr3eoQBq0b
         hYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=VFsL0vLiPyehSrSGKfgAV/dOCLVxn5fde2IiJdtuRQI=;
        b=lU20ddb7T3lVxq8zXo9wzWYZfKxQYXrqnrnJVh3a9n4nJfipXMwMpDBeGsqDIcw11C
         5AbfTTJz0V18BJueh8llzRZxFQX4+I8EBJ5bMGusJvNomrL0feftyStmtyNvdtaa40L2
         2PEK71Wx++X6v7MzoFHZ/YldVu1ZDADcM9Wf82wqHDuyaUBsCG5Qm454xc2Uhc7QEwXv
         nwwwy+FfOoojAl0t9xs81J7gr0E4bRJ8d9zKUn0XGL+FvGeibmNy7W4nm1xZy1ZpYYL4
         ZWGJ37f3osK3MxZuWfY++zgRyT4g0vnEsbCxaamN57f+jg37l5EuzIh9DK46YlRPNFWw
         CslQ==
X-Gm-Message-State: APjAAAXUADMvNhyRAvFIzvAT3x4N233eFOHfnVtl8oFNTPi6tHJM+6HY
        38O5I0EgO7qNPhYINNmdMGs=
X-Google-Smtp-Source: APXvYqzaDBrvpc6wLT1hS/+alRCd36Du7JEzai0P407eM+UbqR1RzIr/RMqkXgwvr1CLRpjBAnkDgw==
X-Received: by 2002:ac8:33ad:: with SMTP id c42mr61714641qtb.318.1554253470843;
        Tue, 02 Apr 2019 18:04:30 -0700 (PDT)
Received: from sh4ck3r.ic.unicamp.br (wifi-177-220-84-91.wifi.ic.unicamp.br. [177.220.84.91])
        by smtp.gmail.com with ESMTPSA id i63sm7523499qkd.82.2019.04.02.18.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Apr 2019 18:04:30 -0700 (PDT)
From:   Andre Dainez <andredainez@gmail.com>
To:     lkcamp@lists.libreplanetbr.org, gregkh@linuxfoundation.org,
        realwakka@gmail.com, straube.linux@gmail.com, hle@owl.eu.com,
        rico.schrage@gmail.com, sophie.matter@web.de,
        Valentin.Vidic@CARNet.hr, simon@nikanor.nu,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gdm724x: Add parenthesis to Macro arguments
Date:   Tue,  2 Apr 2019 22:04:05 -0300
Message-Id: <1554253445-28635-1-git-send-email-andredainez@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch errors:

CHECK: Macro argument 'len' may be better as '(len)' to avoid precedence issues
CHECK: Macro argument 'nlh' may be better as '(nlh)' to avoid precedence issues

Signed-off-by: Andre Dainez <andredainez@gmail.com>
---
 drivers/staging/gdm724x/netlink_k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gdm724x/netlink_k.c b/drivers/staging/gdm724x/netlink_k.c
index 92440c3..36d88f4 100644
--- a/drivers/staging/gdm724x/netlink_k.c
+++ b/drivers/staging/gdm724x/netlink_k.c
@@ -19,8 +19,8 @@ static DEFINE_MUTEX(netlink_mutex);
 #define ND_NLMSG_SPACE(len)	(NLMSG_SPACE(len) + ND_IFINDEX_LEN)
 #define ND_NLMSG_DATA(nlh)	((void *)((char *)NLMSG_DATA(nlh) + \
 						  ND_IFINDEX_LEN))
-#define ND_NLMSG_S_LEN(len)	(len + ND_IFINDEX_LEN)
-#define ND_NLMSG_R_LEN(nlh)	(nlh->nlmsg_len - ND_IFINDEX_LEN)
+#define ND_NLMSG_S_LEN(len)	((len) + ND_IFINDEX_LEN)
+#define ND_NLMSG_R_LEN(nlh)	((nlh)->nlmsg_len - ND_IFINDEX_LEN)
 #define ND_NLMSG_IFIDX(nlh)	NLMSG_DATA(nlh)
 #define ND_MAX_MSG_LEN		(1024 * 32)
 
-- 
2.7.4

