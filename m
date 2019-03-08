Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06074C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC03620449
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049793;
	bh=iXYjR0+S88zszmVa0WlccbnsqUV9o2iaVdzHCRQrdZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z/gI/m8TL1uXXr4Xu5BYBrqBOLQVhafhTiP9vD0eez5GoeVoshFAlaZVwYxcDJcfb
	 JuMpOd858C6WfKkEBUJGHMdXvDvl8enEH3YKOthogYybKKvXz+pDWFaRhDdlkH0QVJ
	 7PjU9U6HoxAu1U7EWK96jhdzSnZKr1l3hiNy8tlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfCHM4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:56:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:60876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbfCHM43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:56:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C001C2085A;
        Fri,  8 Mar 2019 12:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049788;
        bh=iXYjR0+S88zszmVa0WlccbnsqUV9o2iaVdzHCRQrdZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IDSZZvPkFfCp0Nap++6AvVKM/+ejI3R8sy1yTJ5sEdfhTlyy3xO4WDVi6G+NnSm2t
         wSzMbP0eZIo+Vd+ynmDlFVo+8GDtGIhsYPikXxYnKVHdwm3KOayNoAhiKYvDJP3g4O
         lAN3VpmvgalCu+z4ScbqxNajaj9FJRZvI4bnVIkw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.20 63/76] xhci: tegra: Prevent error pointer dereference
Date:   Fri,  8 Mar 2019 13:50:15 +0100
Message-Id: <20190308124917.030891199@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thierry Reding <treding@nvidia.com>

commit 0326ccb5feac6eac35ba6254260e2774277cd976 upstream.

During initialization, the host and super-speed power domains will
contain an ERR_PTR() encoded error code rather than being NULL. To
avoid a crash, use a !IS_ERR_OR_NULL() condition during cleanup.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Fixes: 6494a9ad86de ("usb: xhci: tegra: Add genpd support")
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-tegra.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -941,9 +941,9 @@ static void tegra_xusb_powerdomain_remov
 		device_link_del(tegra->genpd_dl_ss);
 	if (tegra->genpd_dl_host)
 		device_link_del(tegra->genpd_dl_host);
-	if (tegra->genpd_dev_ss)
+	if (!IS_ERR_OR_NULL(tegra->genpd_dev_ss))
 		dev_pm_domain_detach(tegra->genpd_dev_ss, true);
-	if (tegra->genpd_dev_host)
+	if (!IS_ERR_OR_NULL(tegra->genpd_dev_host))
 		dev_pm_domain_detach(tegra->genpd_dev_host, true);
 }
 


