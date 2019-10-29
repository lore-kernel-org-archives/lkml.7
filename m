Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C0CCA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B72C20717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjkBTnV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfJ2IWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 04:22:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34933 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfJ2IWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 04:22:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id x6so3153418pln.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 01:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zXO/8cyF+ovBR8syYWZ7NPcga9VHQrumYWTLb4MSqY0=;
        b=sjkBTnV7Guvfs+Z8OZf0gV7sHV3mo4ataXjg0YyLe1icOgl0DkniiSCNJ9V3IUcH7K
         fDFkRuE1KtzGNnXClFSVBF+ZRLIRakPwsg9U6BDigR98Z+IWEPxZk/AliCJA3zZtnTol
         8kBjbRKHAxRFUYThH6CB6iJooVE91bUhtoeXrlmF1XyBALfxMxtySwM58KldQDvWGmsq
         bz/fUqKhQCATsh7d23i3aPV79mnPqfTb8UJSVsiLWAqaXj0iip5f0KrKzFQvGFZALHGd
         D9o7WzTGcm0xcaoIsnnXIbJd/yVllqBCrCxhEid+ITY+3y9Lwrk2eXVYGyDhgwP9rh6V
         xI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zXO/8cyF+ovBR8syYWZ7NPcga9VHQrumYWTLb4MSqY0=;
        b=gX8JEttJPfgYpJkqMBr9HIXoK867SEby6A3XVVMtaQP2RYTUGC2w+Q+ChwNtfJkK+5
         OCpwStlfZBgFvLX/EIyt/scuVaeSBmWHcobBcJoJPauU6Ip4sBWb4mca8Ai3DsN+iUfV
         ANR6GLglU1JeZQw/DsIUNd2X8jHlOf+/+gj7bY6fkfXfbldhSu3t0qPEi8oAfH9Duqwd
         JfA0n+ziYSh2DBXOpC291xmfPUiY2MMsLjlFm3vdsKVOI0SIrKRqPENYnB+iqljBDYrW
         vohVb4siLtOSb3bRBuZ5INvS3VcGlz/CYcPgejT6768GICxQABP3EDBA4iDV3hofOvWJ
         oBsQ==
X-Gm-Message-State: APjAAAXNesT0QsmFALh3eoTYN+WI9m/JWgju1DD29ivCV4fkmqRFblvg
        eXZ11oPmP8p9EihWR5x1tfg=
X-Google-Smtp-Source: APXvYqyx4LMCvmSv6QXJ6Ogdrxw4bFy8T8q1hPnjUl3fZmaGvH4aDCo3IRGLQ5KdvFJiL6INIU9xCA==
X-Received: by 2002:a17:902:7c07:: with SMTP id x7mr2717230pll.210.1572337359983;
        Tue, 29 Oct 2019 01:22:39 -0700 (PDT)
Received: from saurav ([27.62.167.137])
        by smtp.gmail.com with ESMTPSA id c69sm11848071pga.69.2019.10.29.01.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 01:22:39 -0700 (PDT)
Date:   Tue, 29 Oct 2019 13:52:16 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        groug@kaod.org, clg@kaod.org, christophe.jaillet@wanadoo.fr,
        saurav.girepunje@gmail.com, tglx@linutronix.de,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] powerpc: sysdev: xive: Use true/false for bool type
Message-ID: <20191029082215.GA7160@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use true/false for bool return type in xive_spapr_cleanup_queue
function. issue found using coccicheck .

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 arch/powerpc/sysdev/xive/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index 33c10749edec..74e3ffae0be6 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -533,7 +533,7 @@ static void xive_spapr_cleanup_queue(unsigned int cpu, struct xive_cpu *xc,
 static bool xive_spapr_match(struct device_node *node)
 {
 	/* Ignore cascaded controllers for the moment */
-	return 1;
+	return true;
 }
 
 #ifdef CONFIG_SMP
-- 
2.20.1

