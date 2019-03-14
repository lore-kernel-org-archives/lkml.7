Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663482184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="db/phBQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfCNIH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:07:57 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:39020 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfCNIH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:07:57 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 0BD0DC5C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 08:07:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DpbvCWIskuo2 for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 03:07:55 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id CCB1EBAF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 03:07:55 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id w200so3975583itc.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 01:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kb2MUkZrbDxyWVobIVoD47XbUyDSTUuGSgsDc9X7Vv0=;
        b=db/phBQPaF9vHVY26K/yZUaF1vg/gHllaz8t716IUQj36Sxc+X52bmEjptTugm+chI
         hrmZRKH0LxwSwLRLVIX6nGypGLsSDLU64cpHyOGjEzGhn3EqL1VrC2eyzYQyo7dRcFBl
         rXFKN+TUgHq+MWHbL7eccoEHWrnz1n7nXp2vU8B1hT7m5TwhIJalg/NA2q4B3s4YUGZL
         KeLbajJiuBn4OAvD0LENW6GpC3ip124g5bkNCpqLNljJM+kZejCJixwRfe8Y+EFxM44q
         A7ywwIOHzbEEp3aVz1AGglJYAZqxUWW8tIVLEYoXHg+63Ec1MjAeqN5zloxWsqQQDays
         VEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kb2MUkZrbDxyWVobIVoD47XbUyDSTUuGSgsDc9X7Vv0=;
        b=oTOyfZwhj1Jgy4WB5c6I4qV9VR7zg3/ZeQUM1fTvYdona41ZS+QTQgqgOlACi/eSMa
         /rjRlgL/sbnBdHVXexL6mS1WQOUT3ZXJ+Hl+Mrgr93kiOiocEejA1lVDu1sqK8hVoPNp
         RSd25m0rk5BKtlI5SdkDlKgrF5nRxWXf8HMDf0UZrAerjkz/+qbW3txw+rdRvigwx16t
         NwveZc1mvE/FKhbsDvSfldoitXd9k42RK/wzbeNpPc9LWP4Yw2yhv37rVwVvOINYqMWK
         ZnC0WtTlmBTeC/sYZqmaqgLxlPZQG5xxmUHIBIC/0r+ddL+zVfIwVXNONx3zfbOFeL3S
         T7FQ==
X-Gm-Message-State: APjAAAW3B+SRddZ8mpK9LyuGBzU/mT11n+w8ACCY5et+pMEs/ix56W0W
        tijPJECX/8/MU2U0ce+1B9VRf698LfveXWQR6q/AQ5Mwhqbd4HWJWqibTqMxu8U9SBty/5jQpvV
        WlMtxF017ym4RdcBDQX3Xck7u73N0
X-Received: by 2002:a24:1947:: with SMTP id b68mr1108971itb.121.1552550875413;
        Thu, 14 Mar 2019 01:07:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwIZzecVW+eNuyJqTFO+OusWO33nkN4TIgsXOao6i2Mq7RWpnDyAtq3PO+IFT+hCM7ipOMi/w==
X-Received: by 2002:a24:1947:: with SMTP id b68mr1108966itb.121.1552550875171;
        Thu, 14 Mar 2019 01:07:55 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id b202sm786154itb.36.2019.03.14.01.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 01:07:54 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] pci: pcie-rcar: fix a potential NULL pointer dereference
Date:   Thu, 14 Mar 2019 03:07:41 -0500
Message-Id: <20190314080741.31983-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAMuHMdVJENz5wnOV=TX5cVdTsOZD25SwprSLpetZpAsMcPtvEA@mail.gmail.com>
References: <CAMuHMdVJENz5wnOV=TX5cVdTsOZD25SwprSLpetZpAsMcPtvEA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case __get_free_pages fails and returns NULL, the fix returns
-ENOMEM and releases resources to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>

---
V2 removes the error message.
---
 drivers/pci/controller/pcie-rcar.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index c8febb009454..71e55995c058 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -929,6 +929,10 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 
 	/* setup MSI data target */
 	msi->pages = __get_free_pages(GFP_KERNEL, 0);
+	if (!msi->pages) {
+		err = -ENOMEM;
+		goto err;
+	}
 	base = virt_to_phys((void *)msi->pages);
 
 	rcar_pci_write_reg(pcie, base | MSIFE, PCIEMSIALR);
-- 
2.17.1

