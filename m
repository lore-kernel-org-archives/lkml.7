Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F78C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D135321473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbUkLYqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfEVRFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 13:05:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36881 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbfEVRFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 13:05:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id n27so1633869pgm.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 10:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dry8Vhqj9YW/Gsi060WCLElWagqgpLJMYP0BE8xe+RE=;
        b=cbUkLYqRtFLwJAXvt6BO6XW43SoQqFSp77EVgjawQUtNQsy5MbLveeKO2HAhi0GiL2
         7Q8bUj1XxmQXIMav3U78Eg8gtZTnG+LXKGDujl3fTnElMxysw7fvX28x85h/xm8h/fOg
         e7qzOy92Arx26cdWMl+T8CFoyrSqOaV37+hkfKsP5KvZ2QqJwF7FF62P5uSFTzsSVPwl
         sSkLsz2LWxk+UYGJLoFo++g9kZNjIHawIKJcX20Rlk1PrQqyqT0LbYlpl+9SpqwCdVFW
         aerFbheaU54RXBPjhVqBIKjQb3bl8xDgTSj12nSDIIrfsLRIt9jMSquyXtf/uHYuTLPX
         O//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dry8Vhqj9YW/Gsi060WCLElWagqgpLJMYP0BE8xe+RE=;
        b=ZBQFkFIMC/ACQ9L7ohuUuZMF5VCtICho8LM2xq5VB/+jL0iFh/xFst7XBxrVN5zdqa
         zFYu0BO21FvZ4T1cL+aRRtV1Sf7ftBRh/5mgclC1QpfMh2u3W9YN63YbmmmB1wlDuvui
         5s0vgZuvY7TTCj3CRNtKLvmSGAu/tktGnqZ3QIeH+qmSDfgn1y6FGpMXvp7zDLYG8P7T
         BwRXUBbswZr1/H4s3MeKwKiUfTTjFeXlNHz69CKejpujX8DqIvpTvE/ckQpbywJ2Xnms
         lGhOvMOlNEkVK/oDIWxRFkLJUmoiUXqlrDSdK3b2jdMKNDaOpHo2dH9Gbhb/X+MPHZa8
         pvWw==
X-Gm-Message-State: APjAAAVwbHQ/VKjIg/lLJzQzanN5cVSom8pFVXdQ1e3kLWTEbC1+L0BU
        qZM+m/MZRk2Akjm23PEJXO8=
X-Google-Smtp-Source: APXvYqyN8eOn9+Arw0LQ9ToY1X4J3deYQPkE9oMwxfq24vuvSUnmi2IEWO7mc17IBy/gkG3MQt60dw==
X-Received: by 2002:a62:7a8e:: with SMTP id v136mr237711pfc.208.1558544737054;
        Wed, 22 May 2019 10:05:37 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id s2sm28417529pfe.105.2019.05.22.10.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 10:05:35 -0700 (PDT)
Date:   Wed, 22 May 2019 22:35:30 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Machata <petrm@mellanox.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jann Horn <jannh@google.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        sparmaintainer@unisys.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: unisys: visornic: Replace GFP_ATOMIC with GFP_KERNEL
Message-ID: <20190522170530.GA4331@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per below information

GFP_KERNEL  FLAG

This is a normal allocation and might block. This is the flag to use in
process context code when it is safe to sleep.

GFP_ATOMIC FLAG

The allocation is high-priority and does not sleep. This is the flag to
use in interrupt handlers, bottom halves and other situations where you
cannot sleep

And we can take advantage of GFP_KERNEL , as when system is in low
memory chances of getting success is high compared to GFP_ATOMIC.

As visornic_probe is in  process context we can use GPF_KERNEL.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/unisys/visornic/visornic_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/unisys/visornic/visornic_main.c b/drivers/staging/unisys/visornic/visornic_main.c
index 1c1a470..9d4f1da 100644
--- a/drivers/staging/unisys/visornic/visornic_main.c
+++ b/drivers/staging/unisys/visornic/visornic_main.c
@@ -1861,12 +1861,12 @@ static int visornic_probe(struct visor_device *dev)
 	skb_queue_head_init(&devdata->xmitbufhead);
 
 	/* create a cmdrsp we can use to post and unpost rcv buffers */
-	devdata->cmdrsp_rcv = kmalloc(SIZEOF_CMDRSP, GFP_ATOMIC);
+	devdata->cmdrsp_rcv = kmalloc(SIZEOF_CMDRSP, GFP_KERNEL);
 	if (!devdata->cmdrsp_rcv) {
 		err = -ENOMEM;
 		goto cleanup_rcvbuf;
 	}
-	devdata->xmit_cmdrsp = kmalloc(SIZEOF_CMDRSP, GFP_ATOMIC);
+	devdata->xmit_cmdrsp = kmalloc(SIZEOF_CMDRSP, GFP_KERNEL);
 	if (!devdata->xmit_cmdrsp) {
 		err = -ENOMEM;
 		goto cleanup_cmdrsp_rcv;
-- 
2.7.4

