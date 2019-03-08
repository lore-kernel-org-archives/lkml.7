Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA3AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D6D20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049544;
	bh=wL1lv6rd90Q6YJOcJdIhH0Q5p8dL4wVoDLgeGPtUXTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wFEPkW+0v85HeJXM353s/ywrjxxBrYZ/t5PuiGdv6kIqJIz082UzrA26YqcmzB9y4
	 /Q/DkTMqMZM2cIAG9uj0vABDQjA3Of6utKfKhY0g7zsEm/tX/J/ta19loS/fJ3jCDO
	 kcbQrbv5UuxEGykD4jLTg+4Hh3L4KTSazfpqSH+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfCHMwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:52:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfCHMwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:52:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 366992085A;
        Fri,  8 Mar 2019 12:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049538;
        bh=wL1lv6rd90Q6YJOcJdIhH0Q5p8dL4wVoDLgeGPtUXTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D0SJQtIzno7EwElC+HYkQHS5emrmQIlYoSRoV4mXlvvfccULEJUt0pioBPvErJwR0
         S0raB2h9zX8YvxfEatbrn9cTIRc+Wn4ucVAcb3uvAIjQFhWjrmgiMzld4oaAl/0FaO
         2A0mWaXrfLeKv8F1ptHDR/F3XucTFREpGiW0+L7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 5.0 32/46] xhci: tegra: Prevent error pointer dereference
Date:   Fri,  8 Mar 2019 13:50:05 +0100
Message-Id: <20190308124904.348733379@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
 


