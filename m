Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F4FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FDE2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhcOHQSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfDPG6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:58:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36408 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfDPG6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:58:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id ck15so9857356plb.3;
        Mon, 15 Apr 2019 23:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+ZsCOIZmIT45BAD6e9//SaUJOakIvZeD9Y5z2a3+sZE=;
        b=lhcOHQSRiwhdZybfOy4RXcNpyQp8VpYb272ztUaWQULr3KyYGQ+cSyJSOxXA3qDVfI
         KODuGcK0Ue0E02iV0geulNjVS838jmCciEwX0E/vkmOl8c+vBFEuaS+CoctiFzyBmGFZ
         1QHk7/p+Egn1JQR6w1d7BSjkz6wQE5sHy3/BsrVKYM378aHrB4J+EQTQ+uRjeU9uPmdM
         y0845TPgInU2KRu2RpCcQZ9R75gu7PF6i76q7WA1GlT0xklqUm7r5FRzZ5JHtFtZBXuk
         yERZWkQxZvc/ia1mAN9JFbBGGqqWeomc8Zpq23OBxAzYlR7gXd+dKLbv/1DQmoAauClJ
         n5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+ZsCOIZmIT45BAD6e9//SaUJOakIvZeD9Y5z2a3+sZE=;
        b=jEunenXbTXBZA/YNdOkOv8b6/udNn3IgG2sCB5AneeXm9737AbYd8wOKBjE+P5Qg1u
         SlEWwdXDY5Jh0C0TS6cnxJQkC6VprrkAStu2QZqV859xMtFLTNkZXwR7oRsiGV3dmQ7i
         QFbLb9lz6Q6T+EKqcsr+arXcRt8vXx6IZ1VB/o3ZkU0Tdf+La2NXNcvztBsgp3V0ax5R
         vfYJB+R91LB9qURoPqEmlqG7jG+NRynOqO3DP5+ohe0mdbylZXMlpNmyW/DdiQ7RBC9e
         UXWf8IQmXiUvJOwJc1pbmyDg/AutuiGviXDNEK1NydA7BdmUPckAtUW+jqwyhX8kHphZ
         z3tQ==
X-Gm-Message-State: APjAAAWYtk07B94hGmZVtgt9oRDGeIEcsOA3uNu15/LLeORS6SSYcRDz
        7xZ05q1om+vhUMWlMwTRSKg=
X-Google-Smtp-Source: APXvYqyH6ojB5pPtdfEfZFyjLShu3wBYDA26LaYZs9/7QOkpbp9OpKhzhEBhOQWWZq6C0S30ie3gAA==
X-Received: by 2002:a17:902:7885:: with SMTP id q5mr81524780pll.12.1555397893697;
        Mon, 15 Apr 2019 23:58:13 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id z8sm63677356pgz.3.2019.04.15.23.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 23:58:13 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     stable@vegr.kernel.org, gregkh@linuxfoundation.org,
        Fuqian Huang <huangfq.daxian@gmail.com>,
        Chas Williams <3chas3@gmail.com>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.14] atm:idt77252: Fix a kernel address leakage in idt77252
Date:   Tue, 16 Apr 2019 14:57:27 +0800
Message-Id: <20190416065727.13303-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Outputting kernel addresses will reveal the locations of kernel code
and data. And there is no need to print the address of 
function idt77252_init in idt77252_init. 
This case is similar to CVE-2018-7273[1].
Just remove the print statement.

[1] https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7273

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/atm/idt77252.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index 47f3c4a..76e7736 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -3743,8 +3743,6 @@ static int __init idt77252_init(void)
 {
 	struct sk_buff *skb;
 
-	printk("%s: at %p\n", __func__, idt77252_init);
-
 	if (sizeof(skb->cb) < sizeof(struct atm_skb_data) +
 			      sizeof(struct idt77252_skb_prv)) {
 		printk(KERN_ERR "%s: skb->cb is too small (%lu < %lu)\n",
-- 
2.11.0

