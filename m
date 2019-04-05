Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF7AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA8E21871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkYoDdQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbfDELui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:50:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39681 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDELuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:50:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so7630259wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=apVZzohEFjAx188m1C/O81lsXu0DC3YBEkwMIH0+clM=;
        b=nkYoDdQ8jPf6ADAJIBtCb5DBeFENQdusec1E3cBQbdsTnWLKL38NaAxvM0wDBE+kUT
         aXjvHzbq1Md4TxjX80JFdGGhP813wt0zorr7sKlg8VJvJj0jIRB9E8oIJaLutgk7ZFlY
         FpPCIyAV+JGiy54CepCQg+9zSGQFtgB+GlcwCYRS7KbzstcLdCq0NJz00fSUSDzeIZ7V
         VpxFBhvMtgYJ/UF5ayfaky3ukAAJubr3ShLVH+07U8Pp6P0DQm7zM/JELZVOPQRbfimx
         GW3oeWvXH8lf7NFeYNN67vSpUlM8H9GGlIVCGRmTfz8lM9Ql7KmvqWgLRvfvGk+v8TcK
         u1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=apVZzohEFjAx188m1C/O81lsXu0DC3YBEkwMIH0+clM=;
        b=tRSPGmYqTaY7sWkTdQPbWPKURNjM9RI96EuOLGHd76RY35zgLRkLjhMOD/froXgp6a
         HtPjPmmghSKmdTEo1yAthuFOKPEMt6wAgIyykDzPE3F25wpzRd3LEcUcEJmZ7TAUn1rY
         R3NyKSEIH8L8hk/AKWaYDrE55YYJzTvo0BUBy9WJKdUqoAfwIssur0YciAmk+SLkZ+6I
         CTDM7veGIRarp1pyLrGxDf9A3Mv4UI0Wp6PW+QkuhMF/ldjcO9sfdP4irxXZk1/h4xx5
         UvYdJB30f5iBj92b11AC+npwJW14dpcMWMTnUdpB2qHQx9h3gVqOGSVmEnaIUDDvHfjd
         M63w==
X-Gm-Message-State: APjAAAWuaEXxMH9/j9+QiiPD3ktyogaDtllz6jKN26bxdsi6lDx/kbwr
        3kMaJc0OgdB+iGBcut1XCfU=
X-Google-Smtp-Source: APXvYqxl7t0t4oCjNKlEERtxsQUKK3k5zVjxxop+uOoikQg3sVc00uhaZ0zWydOy2MA1no93pSnA6A==
X-Received: by 2002:a5d:63c5:: with SMTP id c5mr8513251wrw.82.1554465035675;
        Fri, 05 Apr 2019 04:50:35 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:50:35 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 01/20] ASoC: imx-pcm: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:49:51 +0300
Message-Id: <20190405115010.28838-2-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190405115010.28838-1-andradanciu1997@gmail.com>
References: <20190405115010.28838-1-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 sound/soc/fsl/imx-pcm.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
index 133c4470acad..5dd406774d3e 100644
--- a/sound/soc/fsl/imx-pcm.h
+++ b/sound/soc/fsl/imx-pcm.h
@@ -1,13 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
  *
  * This code is based on code copyrighted by Freescale,
  * Liam Girdwood, Javier Martin and probably others.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #ifndef _IMX_PCM_H
-- 
2.11.0

