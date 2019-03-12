Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4636C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C29C21734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="SrhfHimQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfCLFbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:31:34 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:59956 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfCLFbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:31:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 5B5E6AA1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 05:31:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oWOiM0G2EdSc for <linux-kernel@vger.kernel.org>;
        Tue, 12 Mar 2019 00:31:30 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 2B006A3D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:31:30 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id a9so991677iol.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qO/rCpuBodEkloMdIkUNCA/uOUm0aMljN4/zI/6ygLk=;
        b=SrhfHimQ6rI8W1KvqRKkj1iPyfKerOEX49LpaLKy8YT9JA83+BezmciiCb+G4DSSLJ
         B4FFPr6MB+Fb3M4319tqnEtnQDZ5APhSN2rm9dVWoyw/JKGuw7Xp1rkmAMCXaRE468qr
         Bv0LElc2aDdLZaBcpmBrbL2DOeHYrUsYBCecnyiKWip8SF4GKnbuUxcXc+0NXV52SSmG
         CkmXDGkEY108HrGMqQj1F0Fd6G1/817xtV6uUPCohvCPhw7YQolpVds9ejrfJ2CCgHeT
         gSro2Z7jFejbkyrITT6DfR8hEE1aFXGy2rapvHQyubXqcxeigQQa71Pn9NJfIzgRD2Zk
         crFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qO/rCpuBodEkloMdIkUNCA/uOUm0aMljN4/zI/6ygLk=;
        b=VSf/tKXsfA0YB1k4w+Zqv058wGcUwLdNgSFtajfsUrzwAPbF7AObwUIlTOetYviK2Q
         mmf0UxyM9jN247XpMlzW/SdCLshjZ/Gpmp4ZRVRA9/VRF39UDzvpg1E9qRDTR7MaVp0l
         h3dUWFSy1Z6WUrKnULLQYxpIDmIfsMiqQM6lK7HJdu2VatAQrCcuxBxXT2Gaq5IOMAM4
         ECXvvvHfTY9nfNIBQHWYfj5SNJyLnE+/FbXTKDzNPeF9Bhrhc/azfeLGHHHZFIBkigDs
         brpg8II7zyslH6jAbDW0UcbIpAHm/KJ4qcX18QJoyVrGOEbL6Eoh4VLRjHURy9iT5r4B
         ciFA==
X-Gm-Message-State: APjAAAUPLJj6suJUS8V80Ba7HsshyKCMxqLiHenuDtoRaG8Vfaod4YZB
        BOKaMerTAxQx0UHskiKE0TECQr3ZzKOlhxHX1ek32JRbIepFyP5wjdnVfKTMk8rFonZ+0whDW5k
        5uG2MKcfnmSlkC2hsFyF0RS+4DPmH
X-Received: by 2002:a5d:8b42:: with SMTP id c2mr2130658iot.192.1552368689759;
        Mon, 11 Mar 2019 22:31:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxdBSTxobvPbXRF4tDfCHuxv1PyWpNNw4i37iz/swgwm1hsK96LrHZP+AQcdMI8d/me2NR2pg==
X-Received: by 2002:a5d:8b42:: with SMTP id c2mr2130648iot.192.1552368689481;
        Mon, 11 Mar 2019 22:31:29 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id p141sm789754itb.39.2019.03.11.22.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 22:31:28 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: mwifiex: fix a NULL pointer dereference
Date:   Tue, 12 Mar 2019 00:31:07 -0500
Message-Id: <20190312053107.5790-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case dev_alloc_skb fails, the fix returns -ENOMEM to avoid
NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 60db2b969e20..8c35441fd9b7 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -341,6 +341,12 @@ static int mwifiex_dnld_sleep_confirm_cmd(struct mwifiex_adapter *adapter)
 		sleep_cfm_tmp =
 			dev_alloc_skb(sizeof(struct mwifiex_opt_sleep_confirm)
 				      + MWIFIEX_TYPE_LEN);
+		if (!sleep_cfm_tmp) {
+			mwifiex_dbg(adapter, ERROR,
+				    "SLEEP_CFM: dev_alloc_skb failed\n");
+			return -ENOMEM;
+		}
+
 		skb_put(sleep_cfm_tmp, sizeof(struct mwifiex_opt_sleep_confirm)
 			+ MWIFIEX_TYPE_LEN);
 		put_unaligned_le32(MWIFIEX_USB_TYPE_CMD, sleep_cfm_tmp->data);
-- 
2.17.1

