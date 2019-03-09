Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC32C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAFB207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Mw0eLfnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbfCIFTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 00:19:30 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:48760 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfCIFTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 00:19:30 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 6ED7ECF9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 05:19:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3WSFtsgcqbdV for <linux-kernel@vger.kernel.org>;
        Fri,  8 Mar 2019 23:19:28 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 3D3A6CB8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 23:19:28 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id i63so13634039itb.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 21:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1ccjGL2ebG1aZJjkQE0qOhAWYoAYE783IUfqTQxI1YA=;
        b=Mw0eLfnkUzVIO3sn2+bqovoUOutw0qSDx7pTjIRZ/ipXI9zII/DN0rz5LPhPTnnFkO
         2K9ftrL1blNn+jrF/0LtIQ1zfQW/vwRvB80FCeH1Yhs5UZKjM2u1vH8OtdAB2Ur/n36r
         BCNF2gAc7SI7nU6FMiapRUCsPkYmJG+wofUE847oLLHKIt4CiImGsCIq3qfotJ0bVv8r
         p4IIe4DCVu1h1ZrPBH0NRLjr42ZPDAoHyScac/L7obToH7v5KXXjoKdHO0sdfKE/X0+U
         4IKV8AQVVe558CHAfrR3N8WTanABZL0wO1sWjGvNh2WqJorscPQMj4j8VEkV5dKGKY1Z
         VhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1ccjGL2ebG1aZJjkQE0qOhAWYoAYE783IUfqTQxI1YA=;
        b=dSaoz6CWZtkg9yloI6X9ettJv3VCYCjrfcZTaWsBU03GAuD8P08JhnDTFKO3yTCe9f
         W/d/27g5tPc3+BIU9wYSvqSbjYaoB8LsrhdE/vkCl9KasZBjrGVAojpLks0vh+mPWxe/
         xXQfPClMEKvbx5razhCetC5r1ATK0kYKLvUs2UTNtG4x61zFYCOt/VfwXZYHDUo8yr0S
         gnpvB9/cKPyk4HdGMaRNDC5HTX3KxZ6OUZlhH1+4jr7FVCB2NYGk4ZkQnVzQptFiUJnR
         t0WI1K8Ar73BIaK35KtugCcpt+ZwzLV7Krquf/kz6Z72D30dfC+vDeEiMR2dcMd/mo8p
         9BXQ==
X-Gm-Message-State: APjAAAXgTlcEOQ6UmbtfAF6T5Ekbd4Kh4HssvRWaCax/exxP6hi3rmZk
        RCE1C9DJZxyEMVU8ChMKdtnVgFEo3X4gvir4/D+QSiu01B31XaindsKbTBUzTKsztap5bT2zI8+
        rVJTQAg1nOgPMdeZ1Q82G0i4lIMZJ
X-Received: by 2002:a6b:ea19:: with SMTP id m25mr1026571ioc.291.1552108767403;
        Fri, 08 Mar 2019 21:19:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqxo7kJFvyzVLyhUXa4IbysXLkvQ0I7qsJqJDD4ClnIJteT42U8kVDLAU7/KBOetsP73RT/ouA==
X-Received: by 2002:a6b:ea19:: with SMTP id m25mr1026560ioc.291.1552108767155;
        Fri, 08 Mar 2019 21:19:27 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id a80sm4992249ita.0.2019.03.08.21.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 21:19:26 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Steve Wise <swise@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] infiniband: cxgb4: fix a potential NULL pointer dereference
Date:   Fri,  8 Mar 2019 23:19:21 -0600
Message-Id: <20190309051921.15212-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_skb may fail and return NULL. The fix returns "ENOMEM"
when it fails to avoid NULL dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/infiniband/hw/cxgb4/cm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 8221813219e5..502a54d57e2c 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -1919,6 +1919,9 @@ static int send_fw_act_open_req(struct c4iw_ep *ep, unsigned int atid)
 	int win;
 
 	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
 	req = __skb_put_zero(skb, sizeof(*req));
 	req->op_compl = htonl(WR_OP_V(FW_OFLD_CONNECTION_WR));
 	req->len16_pkd = htonl(FW_WR_LEN16_V(DIV_ROUND_UP(sizeof(*req), 16)));
-- 
2.17.1

