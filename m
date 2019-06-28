Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520A7C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247052086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561683089;
	bh=W9ywKGPc6VrMFTBxL2Ki/ODCE/eLB9WgKu08TKAJr1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WbDukdf0kKyzmdDdh6ehjOL8hWOFwz1+lUCN6Mo/xyPj4jaCcbWpbu4X0ojwmQyoj
	 kmgsabHzcCPdqrPuonhSKhnA5ekiW1pe7XZAsbFVSbXpqIZjd7M8uu6CSmpK35154O
	 4+N59QtNsc5PnY8LiSmC6280j7te9GuY8Vb5Z3Vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfF1AuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:50:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33000 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfF1AuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:50:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id c14so2223062plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 17:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+CwaiEJYAeRor4kEz6OTKmpKkJwK4ZSop7mjZ0336M=;
        b=CDJ4kJXUZHPcpwFJsiFcek7U8bU+x+L/3cCmfVeQZ1gi7Xl+mHVIbD/XKvnemkrEEo
         t1+uVPVssuDrPSdgyWmsX1R0iPekttqQu8lfx5x+wnAdwaobAlOfmIes+2dlPmGu7cPa
         3KMf4w0sQeGR7oU+d6UGKJ588wqOPKekHhv/nRIO/RFACo4fRa2qQ/5sGnBk+BzW0wuD
         iWMNbfN1M6i4bYLMjr8+cCpP+5GBpXNbP416z9nfUTpV/AdGmMAs7NME932cyMTLhAdR
         XlE5OFPgGEI2U5VOzXieQHPPTnejq9YCDNpt3sM291HP470Opm2ppbjZd35Znsg0uDW6
         WXCw==
X-Gm-Message-State: APjAAAVXj4LnKO7INAJishSLOok4t2zkwL4R1BiblgpJfOacuAkUsukY
        8KeT8niI3HG6vRCz3m/vw2+hsw==
X-Google-Smtp-Source: APXvYqxzsP8xXGKl/Qhpt656m8uctj1yVi0IGiMIRv0+QZIxubDjbGfRWK4tm5YMCPI/V1y2ZpPiEg==
X-Received: by 2002:a17:902:7443:: with SMTP id e3mr8041660plt.176.1561683016190;
        Thu, 27 Jun 2019 17:50:16 -0700 (PDT)
Received: from localhost (c-76-21-109-208.hsd1.ca.comcast.net. [76.21.109.208])
        by smtp.gmail.com with ESMTPSA id i3sm270313pfo.138.2019.06.27.17.50.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 17:50:15 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>, Alan Tull <atull@kernel.org>,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 01/15] fpga: dfl-fme-mgr: fix FME_PR_INTFC_ID register address.
Date:   Thu, 27 Jun 2019 17:49:37 -0700
Message-Id: <20190628004951.6202-2-mdf@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628004951.6202-1-mdf@kernel.org>
References: <20190628004951.6202-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu Hao <hao.wu@intel.com>

FME_PR_INTFC_ID is used as compat_id for fpga manager and region,
but high 64 bits and low 64 bits of the compat_id are swapped by
mistake. This patch fixes this problem by fixing register address.

Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/dfl-fme-mgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index 76f37709dd1a..b3f7eee3c93f 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -30,8 +30,8 @@
 #define FME_PR_STS		0x10
 #define FME_PR_DATA		0x18
 #define FME_PR_ERR		0x20
-#define FME_PR_INTFC_ID_H	0xA8
-#define FME_PR_INTFC_ID_L	0xB0
+#define FME_PR_INTFC_ID_L	0xA8
+#define FME_PR_INTFC_ID_H	0xB0
 
 /* FME PR Control Register Bitfield */
 #define FME_PR_CTRL_PR_RST	BIT_ULL(0)  /* Reset PR engine */
-- 
2.22.0

