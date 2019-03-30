Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D067C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212EA2082C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+TwMfj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbfC3SaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:30:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45114 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731028AbfC3SaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:30:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id y6so4631848ljd.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 11:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=syCSLdZUygR2irP3Dt4dkGth8Ul25f2kR+nZnXbK8DA=;
        b=V+TwMfj5OJW4q+cbs/e3s6OMCbKAP84cto4V4PD7QRRboe0JJPkRJ8wk5QWWy/u3Fp
         CiJlcYuwVkWVZdcWDjsRPfhnfSHj2sTgON1VQiUJsLUIpDOu8+npuXlba81ZulfgQ3MR
         scF/fxfzbSg9CMc2ITmRmLk2jbemfF50xOmBkwiaXj6jGipQqb8SFeHlIG4+QFPCJVa4
         r9+nXWYu48/jcpp6z/KKuku3bEXpNFhnL0wNpY4mSc10qr4ZfDEAEO4iFLAOKq3AzjA/
         VFPg8Sl2Z1f99wgziBr9MKx1cA07JiZwYnJkXPTbtg4DXyRnr/E5JWP/5gxqu5YTda2y
         F+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=syCSLdZUygR2irP3Dt4dkGth8Ul25f2kR+nZnXbK8DA=;
        b=e73GOG3YnRPnhx/AUhIAGeYVZLBs9yEbtg8ORh8jy9Qs/jiHPxOy5VWBZs2T/Cweb4
         Sc2Fqq230XTVU/PlZHTWas0X3CDTm0XtEQUahfiKvaC61e/GW8kmRs9LX9mTx6n3K4Z4
         aGvozVKmwwOWyOOnrKH9dA9O0ZrgJolOSwXirfI+ph2Fw/DN+f46JMpebGppb4s6i0aW
         i/GuAqkD/7uXsmDRiv+zzSq6TfPG1MEu5tSe8zpbil6ck3J7N45IUOMw+hAMXim+8aGn
         1B33PbZy9vXmAqp0esEqUMY7pMq8hOa5glQzWJ3OeVOp0mnZ0pxbpurdA9hG8YR5PVRF
         NOqg==
X-Gm-Message-State: APjAAAUIsMEZvCHgVo3hftJeilxsUfYEvpuCDCUaRPVeMbmywd2LeMSg
        lTdpbb9PbaCFAu8R0+UavW07yXxf
X-Google-Smtp-Source: APXvYqyF4hauOeM0ji/bMZ8CVXPIMjMenp5VFzJBE9DOz+DvkwF97H8GAAbmjsoSI8OD0r9hI24u3g==
X-Received: by 2002:a2e:8648:: with SMTP id i8mr31718622ljj.166.1553970611817;
        Sat, 30 Mar 2019 11:30:11 -0700 (PDT)
Received: from localhost.localdomain (v902-731.aalto.fi. [130.233.10.238])
        by smtp.gmail.com with ESMTPSA id o7sm1060058ljj.23.2019.03.30.11.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 11:30:11 -0700 (PDT)
From:   Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 3/7] rslib: decode_rs: Fix length parameter check
Date:   Sat, 30 Mar 2019 20:29:43 +0200
Message-Id: <20190330182947.8823-4-ferdinand.blomqvist@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com>
References: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The length of the data load must be at least one. Or in other words,
there must be room for at least 1 data and nroots parity symbols after
shortening the RS code.

Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
---
 lib/reed_solomon/decode_rs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 3313bf944ff1..22006eaa41e6 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -39,7 +39,7 @@
 
 	/* Check length parameter for validity */
 	pad = nn - nroots - len;
-	BUG_ON(pad < 0 || pad >= nn);
+	BUG_ON(pad < 0 || pad >= nn - nroots);
 
 	/* Does the caller provide the syndrome ? */
 	if (s != NULL)
-- 
2.17.2

