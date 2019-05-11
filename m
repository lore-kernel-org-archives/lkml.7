Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30668C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 10:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6EE217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 10:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B43VkG2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfEKKzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 06:55:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47057 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfEKKzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 06:55:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id y11so4566685pfm.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 03:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=i1WqvNiTt4HBkLusuKMu6+jtpbdED5EvLLlXv9yJ1vY=;
        b=B43VkG2B7QBhBqBsGZxH8O6qKmvdU7n/gEXMN8dz7zEPY7XJLXyzlsj3M9yME185TH
         7LHE9CC6VCCUcfALYsHjUoPsCvaO09WKNyaXDROLSmAxsZ+LXwsxkPFq6GmsPrBOpniM
         W7DkIeYBPr8+2cumZgoFaXYgzphcoALgYS/kgND6s2BP5wZ78nYmcxmgzs8/oP+4tf7e
         SkEahXsA3IJpnz+e+Tk8q+41f/uMJoAApq4i/ZFhRL6/6DcXcmCHCO3nO3ixz5usV10I
         d6mmlJJV3SVmY0EBHCi5zbxtVqjB5JkD9XU3GTOn9uek+RUJ13wX3HdaAeO9JYvq/kWt
         wBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=i1WqvNiTt4HBkLusuKMu6+jtpbdED5EvLLlXv9yJ1vY=;
        b=LkFllT3/Guu7eTIo4zHOo382MWu2bDo5GaxOdwGp2dYMsc5Wu2mSGzu7ZLm/Fev6al
         TYbMF0zax5SpY3jNY9ZPKhCK1bjJWMyFHg9O9AiMI5dncwHUZVfj3hfJqjVPu7K62hDm
         fAlicReayeKPjRzdAMzM0y7HPWTLB6or5cqlZe6z6jodxvQJCUaeaAALHY9WuKoBS4Xq
         HD9rJ437Z3EYJjXvcwKR+9WTXhMx0MPRsRqgGSbSITIGFZFbZkk7glmV4ogUuF7/9PP2
         C8WTmCqq/FU/yKMKwNPXHCT6pb1RKocoEpBnqu4fqXhHidHIizwC3ho7Ycryv7nJkSTl
         /oIg==
X-Gm-Message-State: APjAAAXZL3soIGOsyB14OO38LsVAbTcn79MXIR8GHjwgL38DdBHQvE12
        i40Ood7RgK/JJEGbex2MXt8=
X-Google-Smtp-Source: APXvYqyWdpfKT4gAHzOo4w05kL4uOMlgB432bHS8ftuD+gdhoqx4Y5anoLJqBgJFXh2YF1TztfndJg==
X-Received: by 2002:a63:1d1d:: with SMTP id d29mr19848024pgd.63.1557572137899;
        Sat, 11 May 2019 03:55:37 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id b67sm8272316pfb.150.2019.05.11.03.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 03:55:37 -0700 (PDT)
Date:   Sat, 11 May 2019 16:25:31 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     jaharkes@cs.cmu.edu, coda@cs.cmu.edu
Cc:     codalist@coda.cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/code/psdev.c: Remove redundant header linux/poll.h
Message-ID: <20190511105530.GA3988@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header file #include <linux/poll.h> has been included twice.

This patch removes the redundant header.

Tested by compiling the coda filesystem.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 fs/coda/psdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index c5234c2..f2bb798 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -39,7 +39,6 @@
 #include <linux/device.h>
 #include <linux/pid_namespace.h>
 #include <asm/io.h>
-#include <linux/poll.h>
 #include <linux/uaccess.h>
 
 #include <linux/coda.h>
-- 
2.7.4

