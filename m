Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99970CA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D04A21D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZvTWtpJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408991AbfJRAuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:50:02 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46721 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407341AbfJRAtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:49:55 -0400
Received: by mail-il1-f196.google.com with SMTP id c4so3905146ilq.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4tqK11FCKTtpeNb/kdkdcZSh26BkLSHk7+0eLJudgpA=;
        b=ZvTWtpJ+nGkxprJPx8rmfN7XS5Qq2GtsH0AcO7eQ4AA+DVUuYgTUYKgLOfBC58zTdg
         MkX46qmHUxwbyjT5I+b4s5zYTfoA8wAdQi8yudp0VZQBtBDzIYvChI0fsvsHNsvl1Vjy
         K106IKyMVkt4xyN7MeQb5BXp3SKlNKfNnfGgi1WHub9iOlUnq9inCvPNvdvLrXp0+QdX
         SLc+d4YyumaMZ8yio9VNa4Eoe208BDnbf6RCi7UvBFdFUg300TbvbefHgxVTXLH75uSW
         i9I65+Y2vS28kr5uacQqvIrsyjCv8nmfdKdSY4aJOBRzFTGTGR/2K3BInGi+5HNHl5Ps
         /qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4tqK11FCKTtpeNb/kdkdcZSh26BkLSHk7+0eLJudgpA=;
        b=daQkuwSxyJupoFdf7znVZx7NTRbAljjA0eBhaWiTwW0lHQpvQrOAv+bHAygxmdz0rz
         hGykwFxqMIpPIS92PUGFFbxTftkKbxWngvgMsaWQSNg5jA53inZx/C3SPDBXAlPSBiY4
         vU/Y4IJagNGsRv3tNswoa4T6wai/BPX/m3gHcRKZiotcg5QXd9N6BygNIPbsD9KUUb8M
         tYzXrU/jpERQM1ieuROpyBDCyNUWoFrf5wwqtizHMaS2hP5XuwK6CFAfWIGpPBcMBvT/
         hEhPpIms1Z9GOqvwSiHUdYBKUNWH+UCv+FB32zHI66mIBlCSFh0wgV4ofdHRDThYtRD1
         Rpdg==
X-Gm-Message-State: APjAAAXMRfBg+fFYo4lCMO8sAKBlD/qjHfOz9mtpSU5u+D1M+zK5GAKa
        sEg+FdTEBD8VEYylleKflQBH+A==
X-Google-Smtp-Source: APXvYqx61FSX1Z9aRADptVioZHqTaHtzqSS3y6mMidOa+MlccNOkjPJf8zqFwN5wT354dI1p5zD0wA==
X-Received: by 2002:a92:c6ca:: with SMTP id v10mr7634877ilm.133.1571359794270;
        Thu, 17 Oct 2019 17:49:54 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z20sm1493891iof.38.2019.10.17.17.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 17:49:53 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] riscv: ensure RISC-V C model definitions are passed to static analyzers
Date:   Thu, 17 Oct 2019 17:49:25 -0700
Message-Id: <20191018004929.3445-5-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018004929.3445-1-paul.walmsley@sifive.com>
References: <20191018004929.3445-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static analysis tools such as sparse don't set the RISC-V C model
preprocessor directives such as "__riscv_cmodel_medany", set by the C
compilers.  This causes the static analyzers to evaluate different
preprocessor paths than C compilers would.  Fix this by defining the
appropriate C model macros in the static analyzer command lines.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index f5e914210245..0247a90bd4d8 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -47,9 +47,11 @@ KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)
 
 ifeq ($(CONFIG_CMODEL_MEDLOW),y)
 	KBUILD_CFLAGS += -mcmodel=medlow
+	CHECKFLAGS += -D__riscv_cmodel_medlow
 endif
 ifeq ($(CONFIG_CMODEL_MEDANY),y)
 	KBUILD_CFLAGS += -mcmodel=medany
+	CHECKFLAGS += -D__riscv_cmodel_medany
 endif
 ifeq ($(CONFIG_MODULE_SECTIONS),y)
 	KBUILD_LDS_MODULE += $(srctree)/arch/riscv/kernel/module.lds
-- 
2.23.0

