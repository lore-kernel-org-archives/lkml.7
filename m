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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A12CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3657208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTkTKKKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfEVQB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:01:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39785 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVQB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:01:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id w22so1542726pgi.6;
        Wed, 22 May 2019 09:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=OSzCsKE2z3Is8NMcukDcO8IOidowt/GHhrQxzmMeOJ0=;
        b=KTkTKKKicgi/nRInuJBQe/T5ZoC7kq7YvttuB1SzAkzLGGLlQ0MYkumhimMc7MNTF4
         +cPC3wNg/jrKM5Tv9JKCcLUXk1pSDuXApaBaL+UscqU63ScffQLSZ4m03S8a/nriMFGf
         crBBV5FmI2NFaZh27L1H1s4LIR/+3jKIiPARBOYZmmxtQGh9fdBHf/9C7KgoiQILOM7G
         4ccLo2Am7JHEmxXnTqBessRfuU6D54Sad4pEaJGKuiDjU6Ruyrf3PYZ2n8lyYdL3Cn5l
         0iwWY8b+lKk8lxzccRBgcqnYuFA/2ySweqv/zoOxSXxtxV4gp/XsFB11JGjgqgjw9+RG
         OyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OSzCsKE2z3Is8NMcukDcO8IOidowt/GHhrQxzmMeOJ0=;
        b=iqYfqt/lfpH1vLGnB8dNq4o7afCoQw66gE0Ca9p3QdHDPgQb29dtupVG7Gt8nKhaFu
         2IKGYYV6ZaboBB2lBkoXKCIPEBv0TTGF0wdXbugcjtmXYPNy9GYXiQQZxn+GXOn0/OE4
         5ye1MzfVn9St/kS7ug2gQ7A3B9c/qFDvclBcFxlE+EgYMEJ53dgHfW2lVwujLZqKtvzN
         vLBhVzNvpheBRgsESGw/0MpJirdBBZCEIXClGka45eXMEriMucmWfKHPU4tgiP5ValSv
         MUP0LOwLGHSf4SWW4x6xvkC2GOMulBzXWwBvUvNtRHoHRqnBHSDXDfKTEAkrFKU4MiYp
         s3VA==
X-Gm-Message-State: APjAAAWuXyl660q7YGLWheC55eFvpBpH+2e6+DgTvi5Fzp5JS112cZ7e
        m1Q8sGwBHjJ3izMhUQJqphbKVBzf
X-Google-Smtp-Source: APXvYqzwpnESF32HADxlro+0YWttryeVZaxqawf0rnlTTiTjlRy4qyjplI+e6s7ZVPIQKUfsseWfCQ==
X-Received: by 2002:a63:4754:: with SMTP id w20mr3159632pgk.31.1558540916894;
        Wed, 22 May 2019 09:01:56 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id s72sm36746482pgc.65.2019.05.22.09.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 09:01:56 -0700 (PDT)
Date:   Wed, 22 May 2019 21:31:49 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     sathya.prakash@broadcom.com, suganath-prabu.subramani@broadcom.com,
        joe@perches.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] message/fusion/mptbase.c: Use kmemdup instead of memcpy
 and kmalloc
Message-ID: <20190522160149.GA19160@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc + memcpy with kmemdup.

This was reported by coccinelle.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>

---
Changes since v2:
	Removed the cast from pIoc2.
---
 drivers/message/fusion/mptbase.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index d8882b0..37876a7 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -6001,13 +6001,12 @@ mpt_findImVolumes(MPT_ADAPTER *ioc)
 	if (mpt_config(ioc, &cfg) != 0)
 		goto out;
 
-	mem = kmalloc(iocpage2sz, GFP_KERNEL);
+	mem = kmemdup(pIoc2, iocpage2sz, GFP_KERNEL);
 	if (!mem) {
 		rc = -ENOMEM;
 		goto out;
 	}
 
-	memcpy(mem, (u8 *)pIoc2, iocpage2sz);
 	ioc->raid_data.pIocPg2 = (IOCPage2_t *) mem;
 
 	mpt_read_ioc_pg_3(ioc);
-- 
2.7.4

