Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82970C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1EF21852
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="g/7v0J10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfCNGpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:45:34 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:49800 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCNGpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:45:33 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 2355DCFD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 06:45:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z1vAY8RVD26w for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 01:45:32 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id E47FECE4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 01:45:31 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id e1so3512780iod.23
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 23:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=51dtazrixZ+eTQObCrC9HFKq7DKw4LZuxV/HZx2plG4=;
        b=g/7v0J10GkkTJkla846VfVOOHPFPg1609qo7U3aMMp800yLn1JG9rQizOYcs4nERyx
         SN/sC9cI/JUKcLNbw+CW72gut9UJ07T8VE/+71mt4e2VXDwkoJj8rX2B+FfYI8zyuTKA
         NrkLt1lQ4C95J8kScuJBagr3pRqh69YK/KOYe//IhHBNUvi+WSBE8rtS8wP5YmTLnQ9a
         GxYSfO3/dhTOF/sThWUa1A+6xaFxYZm5xmXuF/jOj9hMEx9V4Qf14jmsVTpxDNHuyKhg
         iBqxc8X4com/MmnKMAyyNNMRs/l8JJDxoJMFVOgjE4hXPOSrNe61MUJzOiRHuzOMS5s9
         Ak/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=51dtazrixZ+eTQObCrC9HFKq7DKw4LZuxV/HZx2plG4=;
        b=ScKt1Dm/NnTKrcnRrXuANaPo/zqwL45tJkXnZR+Ofc4M5nqLgbMfhSKxseDIRPKyS5
         BXnyx2/4jxjWw09BbFIZlaKFIR1cwyjx4/iHgFL4Lktf4CK2PIiBm+axMDMSWC1sjOwd
         589uPxtpwOB2TUJ4HRcW6ToNYv0DdL9UGj7TWI/V2chZjpDcJBjAgos573n9L6Ce7q48
         XRgaJ/a/jlZAtGh0kx614hhZYciYULacW0a0wzwRpBBPVAR2qBsxMjqsDPalHe2TDlrh
         89dGrzrdHZVGwGFOK8h4Xi5Hpv05GL4M+N6z5fnNtkyGE7KvdeXFEeZWljb2sT9kGYvl
         8wIg==
X-Gm-Message-State: APjAAAX8hygSfAe4ECD9vzVgv8QM4f/aP4zK7SsCu3OGiv/HZBE0N4j9
        d3bjKYDyHiT9T4SWMGR4S9HDAGfJSuGZY8ntVRPV1s0RlR9pdLxFAmPtxEq79bwyTISGkeZ/iXt
        YD+3YFwmghItFItpYKJ/mKAaT8h4k
X-Received: by 2002:a5e:c742:: with SMTP id g2mr10631270iop.56.1552545931410;
        Wed, 13 Mar 2019 23:45:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxX/oyo4XDoCcMN8aT+8XEiJrgGTPAotXMZdKMe4V0JbbeTT5c8zq4YYc0B18MmYfJQuH4LmA==
X-Received: by 2002:a5e:c742:: with SMTP id g2mr10631266iop.56.1552545931211;
        Wed, 13 Mar 2019 23:45:31 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id c1sm703711itd.23.2019.03.13.23.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:45:30 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] greybus: audio_manager: fix a missing check of ida_simple_get
Date:   Thu, 14 Mar 2019 01:45:24 -0500
Message-Id: <20190314064525.15756-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_simple_get could fail. The fix inserts a check for its
return value.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/staging/greybus/audio_manager.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/greybus/audio_manager.c b/drivers/staging/greybus/audio_manager.c
index d44b070d8862..c2a4af4c1d06 100644
--- a/drivers/staging/greybus/audio_manager.c
+++ b/drivers/staging/greybus/audio_manager.c
@@ -45,6 +45,9 @@ int gb_audio_manager_add(struct gb_audio_manager_module_descriptor *desc)
 	int err;
 
 	id = ida_simple_get(&module_id, 0, 0, GFP_KERNEL);
+	if (id < 0)
+		return id;
+
 	err = gb_audio_manager_module_create(&module, manager_kset,
 					     id, desc);
 	if (err) {
-- 
2.17.1

