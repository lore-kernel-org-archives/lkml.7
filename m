Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E356DC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD15C2146F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QP3emyhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbfGASAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 14:00:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45876 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfGASAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:00:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so6926340pfq.12;
        Mon, 01 Jul 2019 11:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fA4z/zGO1uoPnsV4YhTNRfiYI2+JEgtpBRkd7XtEqQI=;
        b=QP3emyhEAtXYs0ZZiN3gCElkYGW/ksK1CsZvpzVNUMAuZDzvXUeb0AwP4qLUvmcehE
         blIpnOBNH0napTkztZ8aDlzH5JVhlvsvWosmmXM9mP3qb/DGaUI3rP29tWxJKYPYDWcq
         KuOVqZLYtl0eeA1JddMDPvkWhpGhKublYPdWMSPcMnTEVsMtOkKHM+zhfyH5RmJ7wtHt
         wDyoHQayrWGfHkP/aceEzkac5n/FeGmBta0bcD58X2oUIHmHZMSNPHPCBacQxdqJYY5S
         2snL9tm+LySaBUwpiaDWcURjMNf2kePHBeh9SrbytLmDJGhbxSLhClzrfzqbAISbOTt0
         HiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fA4z/zGO1uoPnsV4YhTNRfiYI2+JEgtpBRkd7XtEqQI=;
        b=pTh7U0LYNicK03djyfOgyjCjJV+fkTKfrQ6Gc0gCetOHHBrGJS/42tZ+1PL8ed1qm2
         oYUkGW0jE9IvI4/ra5v+u0qAlVjSUcK3NpYRBHbkNtv+blpBACOjwxMZo/diHRh3scHj
         KEzKI7+JHCgy6YAeAg2A+O/esQwaL+8U61MEqRafR5+LzSjNlG8Z/MjW8sefWO2L+e0j
         41myH248lVjax0yMQS+g3x28QU119qIsW5dtWH83R2lFzErCFOvnCrjQlblXNsnwjLV5
         aSKFSoR2bor+CKnM3btXVMTj2vAFgHco63dYz4oxg6VhqwSREwzK+PVtImhEcNEnZX6u
         FL3Q==
X-Gm-Message-State: APjAAAWx/bdrOfLyqc2cSW7Wo3C5bdcl96SD+EiseK9XMWX+YW/lQtBg
        2oKz2x6XFzuPjADQsAoQNnQDGndE
X-Google-Smtp-Source: APXvYqwWosEezqY7s9Ok6BPumLsi0DGPkHooJZkD80ZEvV2H3g7y/L8hNHOsAAbhb5X75/61hKz2xA==
X-Received: by 2002:a63:1208:: with SMTP id h8mr25004406pgl.377.1562004004356;
        Mon, 01 Jul 2019 11:00:04 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id i36sm11608512pgl.70.2019.07.01.11.00.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 11:00:03 -0700 (PDT)
Date:   Mon, 1 Jul 2019 23:29:58 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Oliver Neukum <oliver@neukum.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: image: microtek: Unneeded variable: "err". Return "0"
 on line 616
Message-ID: <20190701175958.GA9826@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below issue reported by coccicheck
drivers/usb/image/microtek.c:569:5-8: Unneeded variable: "err". Return
"0" on line 616

We can not change return type of mts_scsi_queuecommand_lck as it is part
of DEF_SCSI_QCMD

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/usb/image/microtek.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/image/microtek.c b/drivers/usb/image/microtek.c
index 0a57c2c..ebe1362 100644
--- a/drivers/usb/image/microtek.c
+++ b/drivers/usb/image/microtek.c
@@ -566,7 +566,6 @@ static int
 mts_scsi_queuecommand_lck(struct scsi_cmnd *srb, mts_scsi_cmnd_callback callback)
 {
 	struct mts_desc* desc = (struct mts_desc*)(srb->device->host->hostdata[0]);
-	int err = 0;
 	int res;
 
 	MTS_DEBUG_GOT_HERE();
@@ -613,7 +612,7 @@ mts_scsi_queuecommand_lck(struct scsi_cmnd *srb, mts_scsi_cmnd_callback callback
 
 	}
 out:
-	return err;
+	return 0;
 }
 
 static DEF_SCSI_QCMD(mts_scsi_queuecommand)
-- 
2.7.4

