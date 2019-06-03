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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB9FC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 23:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D66D25D50
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 23:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oD9NwKTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfFCXom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 19:44:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32929 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfFCXol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 19:44:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id y17so11185404edr.0;
        Mon, 03 Jun 2019 16:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iUy17fN7770FCrI/QNupqS+ou4at1wV04TcSjndKp2g=;
        b=oD9NwKTJf5z2zrDzsi8009pHmlRtw9kWEpI1bZ5z1Tj9w5XKm++lvrwDcBtM2GoOYR
         tAfx0fsmedFy5tadWiGYRb+d5oK+l1T6ue/4JMyzKO+l59ihgiA9Bi4FRsgYNRR4YqZA
         MGhldpQR2s0y1ahkROxL4LPO6pNwrsQ5zSyjLY8jLjrpIE/h2xoXaCSF1uK058Fdby+1
         cRTVrlbB5Fxc+5SssC/A/x5r/XJFzpWYMsIuH6tsPgr1g7ISxP7Z0fUkSukxwE4PyQvJ
         vYrPtbAGZ8kbyQAvWXlVsUUnqcUfOBEQSIyb4k9yc2Q6xV8Yqs0I3G88yxl5jgPWucbK
         iXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iUy17fN7770FCrI/QNupqS+ou4at1wV04TcSjndKp2g=;
        b=qwNWzBF5ovdmAtTLPzuhFPbi83ZvdC0PmnQK0JaEaic5QNSLmh+4y+AtWLFarhy6WU
         9Gvz9l2nfj/SsnVUun43b3X3Ow3sjoF3Wu1Z01GRz8UncWfovToIM2cxCmDQhdevxsZM
         nuQb8Qq3AEMJHdA2+xnG7CufcT4JVNupQN5+Gb6fR0AyRxqFpoPEh2X06ebVCkDV5ON6
         +tlzZ0aJbvXea8t+BZd4ynvZF3F5WJBc+aYYiGxKGkntS5y/yxVLI/Jo0VPuNqIaC8Hd
         foj3Di4Ggn8XwxoxZ2vq64+0OEZEKr8UKoaMVIO7pstcb4/YyGOcf++Te1oNGW3C4P79
         Pcfw==
X-Gm-Message-State: APjAAAUzM35+xX0JXO1grgzvpJ+xygBGifIbx2oN8kG1DzTgUUoV1f0z
        C0LQJhN2+ZibYLFHc448MDE=
X-Google-Smtp-Source: APXvYqweCDTicOF+93cu952noxE9ZtNmcV/VMB+JSgKYoYKuLBG2FVMsTqn3lsN1cj2084kluUPO1w==
X-Received: by 2002:a50:9413:: with SMTP id p19mr9742843eda.224.1559605480020;
        Mon, 03 Jun 2019 16:44:40 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id gu4sm137011ejb.52.2019.06.03.16.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 16:44:39 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3] scsi: ibmvscsi: Don't use rc uninitialized in ibmvscsi_do_work
Date:   Mon,  3 Jun 2019 16:44:06 -0700
Message-Id: <20190603234405.29600-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0.rc3
In-Reply-To: <20190603221941.65432-1-natechancellor@gmail.com>
References: <20190603221941.65432-1-natechancellor@gmail.com>
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

Initialize rc in the IBMVSCSI_HOST_ACTION_UNBLOCK case statement then
shuffle IBMVSCSI_HOST_ACTION_NONE down to the default case statement and
make it return early so that rc is never used uninitialized in this
function.

Fixes: 035a3c4046b5 ("scsi: ibmvscsi: redo driver work thread to use enum action states")
Link: https://github.com/ClangBuiltLinux/linux/issues/502
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Suggested-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Initialize rc in the case statements, rather than at the top of the
  function, as suggested by Michael.
  
v2 -> v3:

* default and IBMVSCSI_HOST_ACTION_NONE now return early from the
  function, as requested by Tyrel.

 drivers/scsi/ibmvscsi/ibmvscsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 65053daef5f7..7f66a7783209 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -2109,8 +2109,8 @@ static void ibmvscsi_do_work(struct ibmvscsi_host_data *hostdata)
 
 	spin_lock_irqsave(hostdata->host->host_lock, flags);
 	switch (hostdata->action) {
-	case IBMVSCSI_HOST_ACTION_NONE:
 	case IBMVSCSI_HOST_ACTION_UNBLOCK:
+		rc = 0;
 		break;
 	case IBMVSCSI_HOST_ACTION_RESET:
 		spin_unlock_irqrestore(hostdata->host->host_lock, flags);
@@ -2128,8 +2128,10 @@ static void ibmvscsi_do_work(struct ibmvscsi_host_data *hostdata)
 		if (!rc)
 			rc = ibmvscsi_send_crq(hostdata, 0xC001000000000000LL, 0);
 		break;
+	case IBMVSCSI_HOST_ACTION_NONE:
 	default:
-		break;
+		spin_unlock_irqrestore(hostdata->host->host_lock, flags);
+		return;
 	}
 
 	hostdata->action = IBMVSCSI_HOST_ACTION_NONE;
-- 
2.22.0.rc3

