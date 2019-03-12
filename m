Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C09C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67677214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="XT1Js9uH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfCLHQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:16:40 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:60126 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCLHQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:16:39 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4E378B29
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:16:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aa3_indjXi8s for <linux-kernel@vger.kernel.org>;
        Tue, 12 Mar 2019 02:16:38 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 1BA0EB00
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 02:16:38 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id z131so1406762itb.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JbYdK9TLgMjN2m+HJjyBto5ewkOlwA8azTgBQrkIs3c=;
        b=XT1Js9uHDFrO+bcKCEnp8WQBz9jkYI9afmvjI80+ur1r/OS3Whu0LknDEoCs1Wn3wy
         tIRTE+PpdRnAggfbKxcJPzMhUSDbZuhOMkXDk4QrvOUkzV/mXZIoo+tBwxxXjGd1H5y2
         wp+efLkp3+nu4um11351JcDEL3Kn84o91mcgF8ZxHfYZaPYLf7JGB+cLdOeSyRSyRFie
         Rmk9cSM2Dfl4Ifv++PjO0X1TxMbZF4tPXInVCyZEAsPzfQ7Y7dorBd/V5hGl00mJrosu
         brecz1oeg0X8IkGD7WD9CcB5BlCpCjCcHzQzMSrxwUWnC5bUDxulJjI5b1DYkf8V//ac
         c1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JbYdK9TLgMjN2m+HJjyBto5ewkOlwA8azTgBQrkIs3c=;
        b=INf+wU1tYHPvz3+IQtJq5xsaq+RBimj0ZUlFhklntCIo0MzVt4Qy3+p5dc7Ezcnbn9
         FXeuZ5inmRX5uzJmBfVmAM40aXwP3qHjEio4lRtxjeYXiN7CB0o7io61l3zdCSCuXJal
         0voaYM+TbiqZQXbsXlpM7N3E6tzVCaFQSczM+4HTKASTseV7+6TN8eJaNWoujSfiPTSU
         a5l+XOOG/UpLUGz39t53qdRSiTI8W/VnBk8Hs6V3ep+qbReljsmoIr+g3/VCwNmsZnLy
         W1w4SOgiB+pBOGZOZQ8W7DrYQg/4JB2l0+RFAMnU/GcLtcuNPDH1Yxit/BpFmaVSJ4+7
         Ox7g==
X-Gm-Message-State: APjAAAXlRJs5Vds5abRIv4MlFU9utToAcylWBEPe0pvWlJjo3NhmhPIL
        dhSXpvWXvPkOdfr9idNUFECSM7IQvfIWfeCNO+VfGGVuXLQ7BUtFZ0O1sYZuvlbt1p+QqKFvHdq
        lFEay7VaEbdDU+9aYPh9WDINNaktn
X-Received: by 2002:a5d:9157:: with SMTP id y23mr19346269ioq.129.1552374997191;
        Tue, 12 Mar 2019 00:16:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyDiNP1Jj6Up+9el4FarwReGASLa+ompkC5djtnXuc5FZNvW6LNBlsz9p7uzC2UpFrxABDDpQ==
X-Received: by 2002:a5d:9157:: with SMTP id y23mr19346261ioq.129.1552374996918;
        Tue, 12 Mar 2019 00:16:36 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id 123sm3090203iov.69.2019.03.12.00.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 00:16:36 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: fujitsu: fix a potential NULL pointer dereference
Date:   Tue, 12 Mar 2019 02:16:21 -0500
Message-Id: <20190312071622.23851-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190311.133710.1969649183468126991.davem@davemloft.net>
References: <20190311.133710.1969649183468126991.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case ioremap fails, the fix releases the pcmcia window and
returns -ENOMEM to avoid the NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/fujitsu/fmvj18x_cs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/fujitsu/fmvj18x_cs.c b/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
index a69cd19a55ae..1eca0fdb9933 100644
--- a/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
+++ b/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
@@ -547,6 +547,11 @@ static int fmvj18x_get_hwinfo(struct pcmcia_device *link, u_char *node_id)
 	return -1;
 
     base = ioremap(link->resource[2]->start, resource_size(link->resource[2]));
+    if (!base) {
+	    pcmcia_release_window(link, link->resource[2]);
+	    return -ENOMEM;
+    }
+
     pcmcia_map_mem_page(link, link->resource[2], 0);
 
     /*
-- 
2.17.1

