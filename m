Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33ACC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C4B2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="FvyIhtqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfLQVWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:22:21 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:52826 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfLQVWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:22:20 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 47crgv6Qbrz9vYTl
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 21:22:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L93353aeJXco for <linux-kernel@vger.kernel.org>;
        Tue, 17 Dec 2019 15:22:19 -0600 (CST)
Received: from mail-yw1-f72.google.com (mail-yw1-f72.google.com [209.85.161.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 47crgv5Cjcz9vYV8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 15:22:19 -0600 (CST)
Received: by mail-yw1-f72.google.com with SMTP id q130so9152411ywh.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 13:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xKSXDJGEfO6XnQrXdIqcw1t4M7GCKuGkDlvUOYzoj9E=;
        b=FvyIhtqi2TU6dCcZtEq40XFqYCUpKactMnMWvPoLcHOE9a7z+IblwJjvMhVVwWPxew
         m/n+MdzJ2U442WIYSPvp8Kts3/SOHeEomUEyux07PFqecBWnGNOZcbDjw1n5zWRsvxKn
         sjcoIsj3FFfgdymVtZDdKoYDd9NnuDpymNvESEGgmpDLnWQT8ZO7+66Jr5XZayEDiEWl
         5G5fbB53ZC81eAW+R/uip0uEIjmSjqJMPk/+HI5KhrTmkpzM2aDCgO6YZcnqmhwZz0PW
         MhowlFaOU3sJQ7aYfmyaE8viHJfljLoKzAIGOk+JcqqmJXMNA6HWwTXV7QLCdmvnhbLq
         n3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xKSXDJGEfO6XnQrXdIqcw1t4M7GCKuGkDlvUOYzoj9E=;
        b=nn3egDqaLiFDOMNy8C71yjVEVqB1RxyiypudTHj/B+tu/CfVseUNFntGXoLn2slfrO
         aN2/V53/DhwEkzBh/8RJj1c5zapy8cKFxC4glCUH6hWnVZUkEvvPtcYd0HCO6IJlwCZM
         uGtUILQLoBNleWVgPY/Bn7HV8zmov8MGL8JQXkFKGlQXab6QHYUjlPE2JjOHLlGYEtl8
         A/Q/TE5EW1D0YrWwvt37QNSThmA3tynRxDs/lsh+wOPMMjxSzmt1vLZ2bDhhlvqMSd8I
         2SxA+4spRKax1VAfc6BKNhiihYqgiUSCQnkywVOXyAKSLxeUU43HsmiYj4HrPVfFpROy
         Rs4A==
X-Gm-Message-State: APjAAAWM/0WFT7obFxDhcEWhb76845VlSla2d/0AnvB2uQSEyh6jOD0p
        0N+nVOEjUdgUXbUn5bw/pGdVvGmc1QVq5os9Qo/Y8VrUhWahxkqjsXv52E4YbTdUCP3x/thEoKW
        g1hyYnnWmFnpyjUFAxoPHJYO6LUg3
X-Received: by 2002:a81:de03:: with SMTP id k3mr693555ywj.504.1576617739219;
        Tue, 17 Dec 2019 13:22:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6+drdAHEBR8pRqveMcJwWGEBYCzK6y5x7+hFckUzevP2NHLT1ZNcmcUQ00ImO6UEXbJBcgw==
X-Received: by 2002:a81:de03:: with SMTP id k3mr693534ywj.504.1576617738960;
        Tue, 17 Dec 2019 13:22:18 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id m7sm22002ywh.24.2019.12.17.13.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 13:22:18 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, "Martin K. Petersen" <martin.petersen@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: libfc: remove unnecessary assertion on ep variable
Date:   Tue, 17 Dec 2019 15:22:13 -0600
Message-Id: <20191217212214.30722-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ft_recv_write_data(), the pointer ep is dereferenced first and
then asserts for NULL. The patch removes the unnecessary assertion.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/target/tcm_fc/tfc_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/target/tcm_fc/tfc_io.c b/drivers/target/tcm_fc/tfc_io.c
index 1354a157e9af..6a38ff936389 100644
--- a/drivers/target/tcm_fc/tfc_io.c
+++ b/drivers/target/tcm_fc/tfc_io.c
@@ -221,7 +221,6 @@ void ft_recv_write_data(struct ft_cmd *cmd, struct fc_frame *fp)
 	ep = fc_seq_exch(seq);
 	lport = ep->lp;
 	if (cmd->was_ddp_setup) {
-		BUG_ON(!ep);
 		BUG_ON(!lport);
 		/*
 		 * Since DDP (Large Rx offload) was setup for this request,
-- 
2.20.1

