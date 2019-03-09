Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AB3C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991FC2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="bkPoAYtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfCIDcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 22:32:04 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:56368 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfCIDcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 22:32:04 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4C370C92
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 03:32:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NcYdBPMetupN for <linux-kernel@vger.kernel.org>;
        Fri,  8 Mar 2019 21:32:02 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 2655DC6A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 21:32:02 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id r21so17234305ioa.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 19:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tVwmnqvwoAFICf/1Dr09ZnF/dcwXmtrlc3FFHeFeNQ0=;
        b=bkPoAYtcz/IDTnQe0OUboWzLF+b6PHsadLO1qc44d2f5fglBM8kxGA4eu8yqzfjVvh
         FXoiGUvhmuN6nwP51p7RsWAmTAPhhGPCgBllMiu9fLSjdrWWU+jbKn/ukBVmHVAKzpTi
         q6iNMLu2e5J3AkEhz6isjoPeNIg4kRTdu8qUG8CCRp3iDJXsWae8J3clsq2WRD0NMbFz
         fIbsxt571iuPRXhKIfFREVee+QE14w6XuTYs0F2xebGCWRZ4PI5BD6odHT6XrSWbtRdb
         oM4KhVQyaoJXlE424u9iiAQqm4UycsQlRVzodNb65ablHW63rpa+xG8OVWft/tMG9oqX
         sfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tVwmnqvwoAFICf/1Dr09ZnF/dcwXmtrlc3FFHeFeNQ0=;
        b=GzAX7aFHoVyP2T8ST5bAio2FYbRzgcyAyYKvA12sHZZIOG/fIYG7q7JCRdsljA8s6M
         +RZ4J0MKv0vZf7DRv/+nLbeU1jnxpamm6EOoViZkamTjYRholNS6XOx1TbqzphHfGDp9
         mYS1i8arCRqpFr+Lq6PKkx53hBZCp9GP6gtBROfE4hCJFndjapSwQt8Swk/NvlztlGT9
         GUXx38wYOcQUNRXLquxqMrPZXV0ixD4Yk8eSmZl9poZMenLp57AGoB7s3eoTI3AsJLpP
         QDEB+bf84hoTdSnddyLt/OxJ6BQWOSXeWr+DFXi7V4OEWT/1P6srmXLKQ+9n93kJB/mR
         is+A==
X-Gm-Message-State: APjAAAW9JHKGdPsEuZ//abe4gWNGxddW3iIp+OgR95AEZyn3qz1sLxOG
        cYbozCN0mzCnF0f/Q/pdCl8wte8gWIdKUpHbEbessf6CLWX4jqHs/nCgvijga2aX6tJokSHAesA
        suHey7Xf1FR4PKkkLnF5BCq/IqdmP
X-Received: by 2002:a24:4087:: with SMTP id n129mr9794254ita.140.1552102321733;
        Fri, 08 Mar 2019 19:32:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxAVazD3IKzIoZ4AsIPxInjHCcxRHx8D8Gj6nPKptHsEcXQKtTr+xJ7xZ9WRv3eTpG8Q0Oi1g==
X-Received: by 2002:a24:4087:: with SMTP id n129mr9794247ita.140.1552102321434;
        Fri, 08 Mar 2019 19:32:01 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id i26sm1751792ioj.86.2019.03.08.19.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 19:32:00 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: ixgbevf: fix a missing check of ixgbevf_write_msg_read_ack
Date:   Fri,  8 Mar 2019 21:31:23 -0600
Message-Id: <20190309033123.30001-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ixgbevf_write_msg_read_ack fails, return its error code upstream

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/intel/ixgbevf/vf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index cd3b81300cc7..d5ce49636548 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -508,9 +508,8 @@ static s32 ixgbevf_update_mc_addr_list_vf(struct ixgbe_hw *hw,
 		vector_list[i++] = ixgbevf_mta_vector(hw, ha->addr);
 	}
 
-	ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf, IXGBE_VFMAILBOX_SIZE);
-
-	return 0;
+	return ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
+			IXGBE_VFMAILBOX_SIZE);
 }
 
 /**
-- 
2.17.1

