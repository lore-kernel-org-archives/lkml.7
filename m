Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21E0C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 11:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8353F20700
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 11:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UuCC7ZgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfJBLDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 07:03:38 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:41612 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfJBLDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 07:03:38 -0400
Received: by mail-vs1-f74.google.com with SMTP id w21so2165177vsi.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 04:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=F+NGpTeaeb0MugbRhc2tQ0Tvk6r4JBYeMAAiqO9gTaM=;
        b=UuCC7ZgC3p8JQXrhMdkXzhrP4kUWZxALvN4v4MjrjdsguP6afQybOQaXsLYwCp6huj
         mywwRxIALZswR4H943Zk6VsigwKkcbHqm+mA8I/oosnIq5+3rLUjQRcmuKFlYGDLxPBw
         Gky5fxirIx/uOZRd7tfBYT56VodoX5EXipY634HuX/Rwl3HqUTRryNqHE9Lcb0zxkiMl
         ekvaPBW98oar6qwfBGQXgaPLoAONxJXCYYBlWS10l9yNm/jFzfxm3oU2e9iraGaanFnk
         6/sve/ZU6HAU2aYoDBzyuRIbrtvb8uLY/ZrtHPM9qGY8dRQYyysYgEeL6tKi2x+osIIz
         2SJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F+NGpTeaeb0MugbRhc2tQ0Tvk6r4JBYeMAAiqO9gTaM=;
        b=d6C7h16Fx/btz1vyaBHCFGMpVz4OqFuvXprSy5TzojgmOBXujuSBUUW3MaqsJ8Q6TH
         UgXQEwr+iDdxWQZemh+BMT+GDtvrv8BIpn9rKs5feMA/F7AX5sOlaN8WqFsxb4wPHGib
         Uc24If8vzqA1L3ug9MIGjxk2aFP4GQWifiIAD7HSUfnsBpVvZbirgUPvJRiKkFNAsEGh
         dJz8Dl49rDkDsFmAxW1QPzlzmMtuZ7LKDC7Deub6l2QBSTFPsePneXNnEqkBXAsx5woL
         iUc9XoH9/w9DSNOjI3BkreuRA3uSQM4LqZJAumhBu3e/mTaReyxEou2bibMq4Tf3odk/
         XcQg==
X-Gm-Message-State: APjAAAXM8LuWN+eTCPqMG2cidKYvPrM3LESu3tHKnqqwY2fNVaSr0Bld
        Dn8ENcdyOMJ3X+0ddr5Ka3D81Ds/jMmodvRfAxr0KO8rQZQ1EM9WSeiB31oZO6hsCzO19BrTLP7
        RdAABZHhW1M+ZQ5tQOKJDD9l6vcxymxDUEt3ZGMqP4tmRsJXFdag9qlcLB+0+fmG0tT/7nLlTBI
        c=
X-Google-Smtp-Source: APXvYqxwDxrgl62NuWhGvIiYkm7N2vF3ncBQ66ZIySYKaxgMLJfRNnrjUZNyyuy557usKbBLCIGFeh7EOvrVXA==
X-Received: by 2002:ab0:6607:: with SMTP id r7mr1307035uam.27.1570014215724;
 Wed, 02 Oct 2019 04:03:35 -0700 (PDT)
Date:   Wed,  2 Oct 2019 12:03:12 +0100
In-Reply-To: <20190917231031.81341-1-maennich@google.com>
Message-Id: <20191002110312.75749-1-maennich@google.com>
Mime-Version: 1.0
References: <20190917231031.81341-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH v3] usb-storage: SCSI glue: use dev_err instead of printk
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        usb-storage@lists.one-eyed-alien.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow common practice and retire printk(KERN_ERR ...) in favor of
dev_err().

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: usb-storage@lists.one-eyed-alien.net
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 drivers/usb/storage/scsiglue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index 6737fab94959..4c0c247e4101 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -379,8 +379,8 @@ static int queuecommand_lck(struct scsi_cmnd *srb,
 
 	/* check for state-transition errors */
 	if (us->srb != NULL) {
-		printk(KERN_ERR "usb-storage: Error in %s: us->srb = %p\n",
-			__func__, us->srb);
+		dev_err(&us->pusb_intf->dev,
+			"Error in %s: us->srb = %p\n", __func__, us->srb);
 		return SCSI_MLQUEUE_HOST_BUSY;
 	}
 
-- 
2.23.0.581.g78d2f28ef7-goog

