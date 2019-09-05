Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B56C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A26820692
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zmastz/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388557AbfIENNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:13:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45097 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388243AbfIENNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:13:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id x3so1267963plr.12;
        Thu, 05 Sep 2019 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ptZLHQ1J+Ct+T0uB2ajpX+RvL5VEPREpdkE/veVM7GM=;
        b=Zmastz/gxQ4vmfAfi2QeIIzzAirZrh4VskadspM4qowBOEKy6IKjEATwI5R6oYzW4H
         o8E7mzlpcCLA1xDKM+BzjAgycqLqWQ+PVNY6Ent4J0ZtQKtZQ/LHdXtDffOxIP5854VI
         g6TvSt2BsULbv+T9p0byL8nAdo2DZ8MoxPkgcyJbJkNn3U7NFOwlvPVrM+fat4slphok
         A14DUZWrpLj57335kr8uEWHA1pqIPwVqvEIDm1zexv4oc3Q6NBgQXRsxvf2Yf9autsWS
         Qp+O0VTyUeYAGa44vQYdVrXMB9w0MCwytKGtzFepS7S+SVEGGsZaSWQd1ZpnS89CiTVQ
         AWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ptZLHQ1J+Ct+T0uB2ajpX+RvL5VEPREpdkE/veVM7GM=;
        b=Jl1DR2FMMPAn13wlRw11oUxiZHqmrPTPKBsVBya24GjNBmnoNvSiRcZwN3GN4HB8V4
         4jJUgEPMG3ng2pj9IG6QnhDPNfRWHBr86zT9SBfxoxZsms1MSFcGfoLqaa1oi2OjhAXp
         B0QCUNOTYteccU6MY4E+CIDliYZ4DVxUDpNkmCpCft+tMKpQjo9xJHruXyJdNhH1XoPj
         R8ZUytR22vyjtQHbnpDCe3X8cmmXIsI5KxewdQjUwcR08CkSk43Mj1l8o/tTu+jbZXiJ
         vcQyI2P+pPT2w+zUnu5TVVYqluUTbU9HOVPrHyMdCMjbSuoxhMfT6a89ftweEQ3FcBLU
         WIbA==
X-Gm-Message-State: APjAAAVtDZ2OizSD2yJrPPZaIH43XEYN+kq8pBzGK9eJBP/Lw9Fng6pX
        ZNFAWTTgALZgasbYxjwp/qkCxXck
X-Google-Smtp-Source: APXvYqxy70mGQpqIud6JAWMI76CEQgzdxYAkDUxyKnKK4jbHMIiN9+96n2lvo//uEAIE+ZxDGmr4Hw==
X-Received: by 2002:a17:902:aa91:: with SMTP id d17mr3231903plr.74.1567689209526;
        Thu, 05 Sep 2019 06:13:29 -0700 (PDT)
Received: from SD.eic.com ([106.222.7.175])
        by smtp.gmail.com with ESMTPSA id z21sm2532546pfn.183.2019.09.05.06.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 06:13:28 -0700 (PDT)
Date:   Thu, 5 Sep 2019 18:43:18 +0530
From:   Saiyam Doshi <saiyamdoshi.in@gmail.com>
To:     linux@roeck-us.net, peda@axentia.se
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: muxes: pca9541: use BIT() macro
Message-ID: <20190905131318.GA21280@SD.eic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bit mask macro BIT() for definition where appropriate.

Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 9e75d6b9140b..bd4cf8341a06 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -43,20 +43,20 @@
 #define PCA9541_CONTROL		0x01
 #define PCA9541_ISTAT		0x02
 
-#define PCA9541_CTL_MYBUS	(1 << 0)
-#define PCA9541_CTL_NMYBUS	(1 << 1)
-#define PCA9541_CTL_BUSON	(1 << 2)
-#define PCA9541_CTL_NBUSON	(1 << 3)
-#define PCA9541_CTL_BUSINIT	(1 << 4)
-#define PCA9541_CTL_TESTON	(1 << 6)
-#define PCA9541_CTL_NTESTON	(1 << 7)
-
-#define PCA9541_ISTAT_INTIN	(1 << 0)
-#define PCA9541_ISTAT_BUSINIT	(1 << 1)
-#define PCA9541_ISTAT_BUSOK	(1 << 2)
-#define PCA9541_ISTAT_BUSLOST	(1 << 3)
-#define PCA9541_ISTAT_MYTEST	(1 << 6)
-#define PCA9541_ISTAT_NMYTEST	(1 << 7)
+#define PCA9541_CTL_MYBUS	BIT(0)
+#define PCA9541_CTL_NMYBUS	BIT(1)
+#define PCA9541_CTL_BUSON	BIT(2)
+#define PCA9541_CTL_NBUSON	BIT(3)
+#define PCA9541_CTL_BUSINIT	BIT(4)
+#define PCA9541_CTL_TESTON	BIT(6)
+#define PCA9541_CTL_NTESTON	BIT(7)
+
+#define PCA9541_ISTAT_INTIN	BIT(0)
+#define PCA9541_ISTAT_BUSINIT	BIT(1)
+#define PCA9541_ISTAT_BUSOK	BIT(2)
+#define PCA9541_ISTAT_BUSLOST	BIT(3)
+#define PCA9541_ISTAT_MYTEST	BIT(6)
+#define PCA9541_ISTAT_NMYTEST	BIT(7)
 
 #define BUSON		(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
 #define MYBUS		(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
-- 
2.20.1

