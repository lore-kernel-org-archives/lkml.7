Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19467C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5632173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tz3yE44r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfEUIsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:48:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39230 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfEUIsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:48:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id w22so8235720pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/3n9FVywoExtKHdkxZu9NrddyvBpvJrl+Pr5EEoKl20=;
        b=Tz3yE44rwjDdVDy054fLpw6lLbkCNm8v+4v4WRdi7HoRGROYvZAAVe6VGaU+TDnaBn
         e4EswAaUkjmHxX2ej2XpsN3Nx2VKMx2Fk6CxEb2VS3I5LDzKwLjyv1mlmUk5hOamC4Fk
         dH2PEPRPu74RELke9sASWQ3y49bNheyKPzt+Lhqc2kOEEkqnADEOcIJ2xfqYymZt1m+9
         xoT7sRFQC2cE02g+X2lrSNU6PBrbQNjsLpPq1x2OCIDhCUuIfkvly12AwzI2XE+3hjUm
         WBewInPSccdKBi1syGNTK/mCIu/g4qQBNuSakf6xJihvYpAIybdBPLl1Xo/oU1TxeSk0
         7w0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/3n9FVywoExtKHdkxZu9NrddyvBpvJrl+Pr5EEoKl20=;
        b=JgF1R2HPSIZvKwM+DCzDGSBgD5TA18miN1RFmVvP0v4znjSK9sWNcAogE1Ui+/wG/W
         SHbm3t81bi8RoHpkKmsm2xyyKn5EjV4fBzfL68ywlAqy7n0TzhW5tPItYQHNyBhpOmiM
         Qub+kAkIeXKLDOh7KdXBpAMQxrlv6ti2uuO554kbcY/ABGZHgPHBJPN7WkoO6XTZxDZ+
         H11eA2KqMtQaxn1HhI0cLHzncjWermxjLkTGLKomglKKkWfAg4xldxxmSR0Mo8riNiYo
         hHS3slBrz2z7zIEbTfxprTZlKWqGhYEPaJhujUR/1yyNA/IZ9ojcf/l86vC2teKfIgsl
         ffvA==
X-Gm-Message-State: APjAAAXwHMyDS1fIPaeopKkGQhEJ4etrWa1W5vhAbGPV+FmBOoPUpqAl
        fk+4vM3yKMzvYrHPZJpUDRPR1+6/rKA=
X-Google-Smtp-Source: APXvYqyjQ/zFb286SQMk7mHPm5ApcGuPtLqnqttn6hA1FZBHMIXLYORDvcAq+llpPE1yIXoUddkitA==
X-Received: by 2002:a63:3190:: with SMTP id x138mr78794929pgx.402.1558428494022;
        Tue, 21 May 2019 01:48:14 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id e5sm46062940pgh.35.2019.05.21.01.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 01:48:13 -0700 (PDT)
Date:   Tue, 21 May 2019 16:47:59 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     kuznet@ms2.inr.ac.ru
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ip_sockglue: Fix a missing-check bug in
 net/ipv4/ip_sockglue.c
Message-ID: <20190521084759.GJ5263@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function ip_ra_control(), the pointer new_ra is allocated a memory 
space via kmalloc(). And it is used in the following codes. However, 
when  there is a memory allocation error, kmalloc() fails. Thus null 
pointer dereference may happen. And it will cause the kernel to crash. 
Therefore, we should check the return value and handle the error.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

---
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 82f341e..aa3fd61 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -343,6 +343,8 @@ int ip_ra_control(struct sock *sk, unsigned char on,
 		return -EINVAL;
 
 	new_ra = on ? kmalloc(sizeof(*new_ra), GFP_KERNEL) : NULL;
+	if (on && !new_ra)
+		return -ENOMEM;
 
 	mutex_lock(&net->ipv4.ra_mutex);
 	for (rap = &net->ipv4.ra_chain;
