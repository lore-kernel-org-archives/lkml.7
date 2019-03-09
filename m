Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F062FC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C062920866
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="b7zJ9O1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfCIECw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 23:02:52 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:37604 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfCIECv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 23:02:51 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id CF6909CD
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 04:02:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kS667rxTVELn for <linux-kernel@vger.kernel.org>;
        Fri,  8 Mar 2019 22:02:50 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id A435D9AF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 22:02:50 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id a9so17018784iol.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 20:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Og6l9fJCMlQv3m4hn4Y5g8y+/yXp1JLZDjMGF/Nf2UU=;
        b=b7zJ9O1WD2t45JUUZEShzGlXyjvMY2eIgF5rPmC9atuzraoFtef4eZq+P0xZciP4Vq
         oMxkpTwF+G2Rkb28Mw7eBZPIqAp8sjqqi1H7qFLh1m+TkKVyG+QOJNkt4+91HNpFHyhC
         7n7DLKMPCTpS9guKfxapPawtART/bEy8w9XCLVRTUs3HMLivPg8g/9NTx3ASC7fMNli/
         w9vXEGnzBv4NiB/xT1Hm62JaWSS8R289vx89S+gjYqaKoR6Ja4de8Bj9pdp+JtUMaaTp
         9wNGOfIBvjDdFmQWTm0pKaXZ2dWrzASmQbvsjgohnTORIars4BxJdpTk/4B0t+x6VSwD
         wvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Og6l9fJCMlQv3m4hn4Y5g8y+/yXp1JLZDjMGF/Nf2UU=;
        b=oEIB+NmDWshAi7lRynhA/L+vMsEGdw7ipfN0aOz9LnlpFcqis/uh1WnFHDooIEPLq5
         Y+6CZfw5XXBqLy6L5bWIlsFPfU743dt3xr2C7YyoRy0v7cpmDkWjoBWqeo0f9MdhBl+o
         Bhx4kTkJ1JYb5M7sYKWTwlerBKh2399FH0Xsr6U3HmYrfh5mPR2EuUbyfPUhKM3XV6FA
         b5ptcsW7d8fDIJbwERkTXA4NXROaKco83XW2eM1gYS+ddo1pU+tkitxMKJa2rk2Hr3Hu
         JEpKXBO2VJ9L9FaLsZWC44vCLYdJroic2P5r70GLtqF3PE8aIz5vreJCfkqrtFH6znET
         pmVQ==
X-Gm-Message-State: APjAAAXRYuWRZWyIBUM9oTzZXSEh0qiK1E3Ez/XPpv3sz0Y/BGgimNxK
        sOQUgYOt+WHWfHjqpacNYyNGzeA3UsSbxFP91ZBcHkmgfsTan0KS555AA3pluo0U6TPViQ7+WqR
        UUnjdpydupInrYvbStpgf51oA+OAl
X-Received: by 2002:a5d:980c:: with SMTP id a12mr12631907iol.58.1552104170250;
        Fri, 08 Mar 2019 20:02:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjtKqJscT99MA53yJupAUypXIuFOTy85wFNZIRArCRneUmf6co+/Daa6dg6b0XyN8vrj+d1Q==
X-Received: by 2002:a5d:980c:: with SMTP id a12mr12631897iol.58.1552104170006;
        Fri, 08 Mar 2019 20:02:50 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id y3sm5031683itb.2.2019.03.08.20.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 20:02:49 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: check return value of idr_find
Date:   Fri,  8 Mar 2019 22:02:39 -0600
Message-Id: <20190309040239.32431-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idr_find may return NULL, so check its return value and return an
error code.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/firmware/arm_scmi/driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 8f952f2f1a29..35faa203d549 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -709,6 +709,8 @@ scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev, int prot_id)
 
 	if (scmi_mailbox_check(np)) {
 		cinfo = idr_find(&info->tx_idr, SCMI_PROTOCOL_BASE);
+		if (!cinfo)
+			return -EINVAL;
 		goto idr_alloc;
 	}
 
-- 
2.17.1

