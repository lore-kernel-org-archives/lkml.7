Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F81C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E751F26A32
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHbA+7oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfFCWU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:20:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42556 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfFCWU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:20:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id z25so2965139edq.9;
        Mon, 03 Jun 2019 15:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6SwsUdnmJqsKjqmMv1ig0nFgLQISlIZ4mL0Bgh3d+ww=;
        b=rHbA+7ojNx2L8Y/O1X17tjfQ/ccJkMcflnR9LyPSByMs/+CaDM7588Ir9t9RCF6Tin
         lNZZwQ9Gf0eaxcIBJmjzcKt2W/7xPDdtLNk3lqUkdPFDIqLQfWYVNK1FRCS6m8izMj8o
         CR8zKd+dzcYJmoPDewqMUtr0ZbSeKyM9zcbLqCVtcX+d99RD0IWoF/R+GdWe40Jb+ghp
         5EOciicMprv68Ht7k4mZyACACMbu85DqHslBZ5G3Oo68aNWaOSqAEOq69+ZZj5//eY+r
         LpdPgsxdma7p37jEdVF6X/XXb3au94zh2bUhNBDUHRdrMUmk0e4c3GsyikXDu4Bjt3eQ
         PDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6SwsUdnmJqsKjqmMv1ig0nFgLQISlIZ4mL0Bgh3d+ww=;
        b=j3eIMRCrgDkGoAWQ8zUldsnwj55+6HcRqmJO5zs5ipr8avXK5OFFMd7uqodoooVE/Y
         Sq7ik0zpx+XuWAdAEDxvp+AdA46jaL0GBXvjqDxCKVtfrrV/FfcxYETnO/CHFN1qCwKC
         U394R4M5AGMo2iqtQYiwL2p2uaiJ1yAOVPqpqwS548+s5djDGELvGA3H1BdPWNBj72HD
         Wh76v71yG6O+vutQvTIECvFZkZVKgAivtVG0xNU1bh/dLJlPz/gxQjHZnWUM69rWpSJg
         fbfFhQMkKj3I4u5VPCACFPoaNnBFpkpEmL3OiCC6EGlDDiehmYY8QBMKNAuQHeZSuqWm
         /N2g==
X-Gm-Message-State: APjAAAWM00YO1Y0WYy6B/WocBB35GiJRjYtkYFhsgwrmo/ZhSTlyrPVS
        pyTmr2HZ74nAnCQwSG83lLg=
X-Google-Smtp-Source: APXvYqzntAHVC76B3HN+FQleN5MXwP0M+Bge4licIbThASXbaFHS9A4UtGAue+zV3RciZP5zzKQGDw==
X-Received: by 2002:a50:a4f7:: with SMTP id x52mr31464852edb.86.1559600457550;
        Mon, 03 Jun 2019 15:20:57 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id j9sm1515579ejm.68.2019.06.03.15.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 15:20:56 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] scsi: ibmvscsi: Don't use rc uninitialized in ibmvscsi_do_work
Date:   Mon,  3 Jun 2019 15:19:42 -0700
Message-Id: <20190603221941.65432-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0.rc3
In-Reply-To: <20190531185306.41290-1-natechancellor@gmail.com>
References: <20190531185306.41290-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang warns:

drivers/scsi/ibmvscsi/ibmvscsi.c:2126:7: warning: variable 'rc' is used
uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
        case IBMVSCSI_HOST_ACTION_NONE:
             ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/ibmvscsi/ibmvscsi.c:2151:6: note: uninitialized use occurs
here
        if (rc) {
            ^~

Initialize rc to zero in the case statements that clang mentions so that
the atomic_set and dev_err statement don't trigger for them.

Fixes: 035a3c4046b5 ("scsi: ibmvscsi: redo driver work thread to use enum action states")
Link: https://github.com/ClangBuiltLinux/linux/issues/502
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Initialize rc in the case statements, rather than at the top of the
  function, as suggested by Michael.

 drivers/scsi/ibmvscsi/ibmvscsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 65053daef5f7..3b5647d622d9 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -2109,9 +2109,6 @@ static void ibmvscsi_do_work(struct ibmvscsi_host_data *hostdata)
 
 	spin_lock_irqsave(hostdata->host->host_lock, flags);
 	switch (hostdata->action) {
-	case IBMVSCSI_HOST_ACTION_NONE:
-	case IBMVSCSI_HOST_ACTION_UNBLOCK:
-		break;
 	case IBMVSCSI_HOST_ACTION_RESET:
 		spin_unlock_irqrestore(hostdata->host->host_lock, flags);
 		rc = ibmvscsi_reset_crq_queue(&hostdata->queue, hostdata);
@@ -2128,7 +2125,10 @@ static void ibmvscsi_do_work(struct ibmvscsi_host_data *hostdata)
 		if (!rc)
 			rc = ibmvscsi_send_crq(hostdata, 0xC001000000000000LL, 0);
 		break;
+	case IBMVSCSI_HOST_ACTION_NONE:
+	case IBMVSCSI_HOST_ACTION_UNBLOCK:
 	default:
+		rc = 0;
 		break;
 	}
 
-- 
2.22.0.rc3

