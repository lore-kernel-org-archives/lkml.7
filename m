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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09C5C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A8E2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVyM1m5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfEVOPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:15:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44710 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVOPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:15:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id g9so1399346pfo.11;
        Wed, 22 May 2019 07:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=BdjqEMSeAFloAhLZoevUhTsAoKWad+eEnvBrlK9h5Ls=;
        b=vVyM1m5LGNs32T4OK63/Qsv4WbJQYIAXZUgoj/+U/GJ2opHdUdGbXsp+GHaoAJb24B
         /itXDGRPV1UW8OlYJciZ94Q4cLUk0wbItQ8yWVxmG0zoKHr3skVzj8WylzY26PPz1/YW
         PiR/0E2yT3h0lf0sgTGu7Q1c3Zg6yQI980RSrrOoLx1tr3dp9bu9KXDvfgj0NuQlXujx
         8Rm0VFeIcNre6IUolWfP7ACSjMdnsKzbOkkL8HyVUvvDinXdeVUI9o6Qg3O6nR5GO610
         6G+AKH068NUki7DIZhbPdAPp/i2Tsffs3u/fkwJt2TFQ1OyMGFeUQCB1h9xcCu6mGomC
         Ltpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BdjqEMSeAFloAhLZoevUhTsAoKWad+eEnvBrlK9h5Ls=;
        b=Bov5v6y9s8QQE69Thto1PytAWEydSoB8cMwgh+l6/OnjcLPgc6Kde++wlX9SnnNZxo
         T2XyRjNQ+rUVDn6BkaGEHi23vQuYhqOtcImgSX3bAzWItdAc7TJhvv5lnTomQO+ACTfo
         yykLxKGxdbRQnnkK7MCtXn82eQCYjvEXqLG2JhDJmGhLEUk5ryhHs3F5q/6IC/nETO7C
         RrcdS0sQlz2Nxi3FgBQm7Du+igYMtcTkWHZ5xtelO2RwHdqN9b8xXAOnCzXoWmUtBLku
         O8vaTbrkqJzlmOKx8gnQdRAAKLSPvM6h1DgRLCU57x/OGLJr0ly/tkVXSt0YImws9BMm
         x1bg==
X-Gm-Message-State: APjAAAXtcBOI64P2izx8gVhCEwIcYGLLza7LOYdXsMw6Xh+etfVLvrL+
        LO0nchG6KQIrQEeP3Bk6dtc+g9AK7PdLdQ==
X-Google-Smtp-Source: APXvYqzQhWbS6Pm8haOF3/M3sj53+CbQxFH5NQXoNZVCSq1dFBF67KQkS6xZTIiHvPVbemi0rrHxfQ==
X-Received: by 2002:aa7:930e:: with SMTP id 14mr38740442pfj.262.1558534536328;
        Wed, 22 May 2019 07:15:36 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id k13sm21489805pgr.90.2019.05.22.07.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 07:15:35 -0700 (PDT)
Date:   Wed, 22 May 2019 22:15:09 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     sathya.prakash@broadcom.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mpt3sas_ctl: Fix a double-fetch bug in
 drivers/scsi/mpt3sas/mpt3sas_ctl.c
Message-ID: <20190522141509.GA9625@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In _ctl_ioctl_main(), 'ioctl_header' is fetched the first time from 
userspace. 'ioctl_header.ioc_number' is then checked. The legal result 
is saved to 'ioc'. Then, in condition MPT3COMMAND, the whole struct is
fetched again from the userspace. Then _ctl_do_mpt_command() is called,
'ioc' and 'karg' as inputs.

However, a malicious user can change the 'ioc_number' between the two 
fetches, which will cause a potential security issues.  Moreover, a 
malicious user can provide a valid 'ioc_number' to pass the check in 
first fetch, and then modify it in the second fetch.

To fix this, we need to recheck the 'ioc_number' in the second fetch.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index b2bb47c..5181c03 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -2319,6 +2319,10 @@ _ctl_ioctl_main(struct file *file, unsigned int cmd, void __user *arg,
 			break;
 		}
 
+		if (karg.hdr.ioc_number != ioctl_header.ioc_number) {
+			ret = -EINVAL;
+			break;
+		}
 		if (_IOC_SIZE(cmd) == sizeof(struct mpt3_ioctl_command)) {
 			uarg = arg;
 			ret = _ctl_do_mpt_command(ioc, karg, &uarg->mf);
