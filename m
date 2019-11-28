Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9996C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02EA21771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="e4aBLwHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfK1O5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:57:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33339 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfK1O5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:39 -0500
Received: by mail-lj1-f196.google.com with SMTP id t5so28869777ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MvM6nM6rYnMj/7VFTI0rv5G9KH57+NDrgUtr1bVU1Oo=;
        b=e4aBLwHSEzy8sONERW/IwRDhDSYmz2xR72o/4T0/8DlresPv1aHRcv2mF/UxFqnVYZ
         dr0Cd9fhZZRCC+/2Z7pzkTYZpfIa5RO/B5S5colgeJW38Clo2Jv9cfK7JNcF+4votG96
         jEiOkgJ4r2LBjozkTCIyUlgmBI9ZKS6LH7WCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MvM6nM6rYnMj/7VFTI0rv5G9KH57+NDrgUtr1bVU1Oo=;
        b=ReDBNCZKDWTknJuhfpMNZiPrWZu+0/PFOgxGUbyYTz8Z822S6xm4e7IxBgOMAKHSEu
         D8MrIYw8AvM3S5DOtwFiM+6QWrTKQn2qMhEqG9CmMiFlO6ZdLerTEJ3pjcuEopqsyczh
         qEssCfIf19rDUVlwIm71/rMWN/eK6HC9SLT5nCRwxFyw15b6tnu4O1EeHF7E1TA6W1q0
         8KcTF+RtoNkl42J45FPN6xmK++x3y/zAyOuu41vl+cAkVhdw6Njt6Ft+l6u9Iq0DoYOy
         iJ8LEqLP1DE/sgbLGlCAohD5bOZyCgdTeJWqbxPVNOcAgccsAyCEcsM8SCYP+n7X8g/h
         1SQQ==
X-Gm-Message-State: APjAAAWByLnm2kVdwKeAnnJqnsN5EOiYlfa8oBD/H9m2PbtC/V6yHcIF
        yWJUvdk7BB3VHhO/4iYo3eogkQ==
X-Google-Smtp-Source: APXvYqxmpuOqtK7ASzusSfLJEMa3pAop3ficVhHUNDn6fZ5q7zMOSDs2fGSSox4I3LFNqV3q5D+1oQ==
X-Received: by 2002:a2e:3a15:: with SMTP id h21mr34921217lja.256.1574953057257;
        Thu, 28 Nov 2019 06:57:37 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:36 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 25/49] soc: fsl: qe: qe_io.c: use of_property_read_u32() in par_io_init()
Date:   Thu, 28 Nov 2019 15:55:30 +0100
Message-Id: <20191128145554.1297-26-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is necessary for this to work on little-endian hosts.

Reviewed-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_io.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
index 61dd8eb8c0fe..11ea08e97db7 100644
--- a/drivers/soc/fsl/qe/qe_io.c
+++ b/drivers/soc/fsl/qe/qe_io.c
@@ -28,7 +28,7 @@ int par_io_init(struct device_node *np)
 {
 	struct resource res;
 	int ret;
-	const u32 *num_ports;
+	u32 num_ports;
 
 	/* Map Parallel I/O ports registers */
 	ret = of_address_to_resource(np, 0, &res);
@@ -36,9 +36,8 @@ int par_io_init(struct device_node *np)
 		return ret;
 	par_io = ioremap(res.start, resource_size(&res));
 
-	num_ports = of_get_property(np, "num-ports", NULL);
-	if (num_ports)
-		num_par_io_ports = *num_ports;
+	if (!of_property_read_u32(np, "num-ports", &num_ports))
+		num_par_io_ports = num_ports;
 
 	return 0;
 }
-- 
2.23.0

