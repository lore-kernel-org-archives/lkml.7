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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA5DC18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02BE2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGtpbo/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfEVJxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:53:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41367 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfEVJxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:53:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id q17so1045157pfq.8;
        Wed, 22 May 2019 02:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/lhVdO3oJRAv/K0o2rwF57FW6eQgW9otKjhGHSr9m9s=;
        b=HGtpbo/cP6dUgDCcydXQnFiwYrS51OTEMsvFsT1XCBv4yBvutnd9M6QNOoM3waPWjL
         /kVPL/dLv2qoDbO1ociUxsb3XfX34573p2PjHt51D+6Nq0bwTP02btwxGhkNk/UBfwKw
         Tcb75AlmpIVyIiMGWIEPPFXDSdSruFY/VTYraWvUD6HUrl4NqZRFkOaGhEl1Tdm/FFXn
         nR2Bwa+25sICL8f9GzVk/kLAUJkz4/aicATPP5zoJDV7YX4TRpfoh8eISXHuPhuupYUD
         Woc4/CX5QzidJMxs8OuO0b5Vhn+Lh6lswO0ufvfMoHvr/mh4QRuyX7ym/9AFDyBqNUij
         8BbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/lhVdO3oJRAv/K0o2rwF57FW6eQgW9otKjhGHSr9m9s=;
        b=p20NowupNTB2pyR4+xbNSPv8rgIyA5FVpoalqLVtfRMizt8vI4eOpePjEvIF0UhfvX
         +/yb/kYDtaC4x3VcFdV42A4XbgQKPaAO8QyEEa2f6Uz+jSnxERfFXZ3InT/zwf0JjRSq
         VVTxHyfjKRMGuvAhzXZiE2XIy7yjKxn2LPQrvOzmF5Z6viMAFB+is8WipVwSkmiD8dOf
         csJolT/6p6O3tls3r/OJic8ppWzU+YvZ5xzR5p7GTywepERCkRai38HzqI0kmH4cg6yz
         qkq7+BC3+xSWAcsjpv1IfIDl9Va8JV5nYU9Jhmw2+4Uq9bJvLhx7Iklct4qYO8VbHI4Z
         hW7A==
X-Gm-Message-State: APjAAAW0o2IoyjJbJQzpAHc9zQhE7yR9xZ2qzObX9nmfkCH02jLNaCjC
        k6rjbk+HYCjNlLSFNLAiL9E=
X-Google-Smtp-Source: APXvYqzhQCkUeNiCISHoAM+EpyQpTGOYbl5erl6xd5ClzSZdcKsM3a04IQsg4BpGbH7nF+FYomm23g==
X-Received: by 2002:a63:534f:: with SMTP id t15mr90409887pgl.445.1558518820862;
        Wed, 22 May 2019 02:53:40 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.31])
        by smtp.gmail.com with ESMTPSA id v66sm46749883pfa.38.2019.05.22.02.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 02:53:40 -0700 (PDT)
Date:   Wed, 22 May 2019 15:23:35 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     sathya.prakash@broadcom.com, chaitra.basappa@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] message/fusion/mptbase.c: Use kmemdup instead of memcpy and
 kmalloc
Message-ID: <20190522095335.GA3212@bharath12345-Inspiron-5559>
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
+	mem = kmemdup((u8 *)pIoc2, iocpage2sz, GFP_KERNEL);
 	if (!mem) {
 		rc = -ENOMEM;
 		goto out;
 	}
 
-	memcpy(mem, (u8 *)pIoc2, iocpage2sz);
 	ioc->raid_data.pIocPg2 = (IOCPage2_t *) mem;
 
 	mpt_read_ioc_pg_3(ioc);
-- 
2.7.4

