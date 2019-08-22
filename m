Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEAFC41514
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486F9206DD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494815;
	bh=F2s4r3Dc85Wwzv9Jk0wTHcyEYqKnxm5Uoi84WZ3ZM+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=huaDR3iLFLdcGYJicTdhUxcXlDi+L8TDyTLahkYK37R7PcF/XGnk2VCWBYcWeb4sM
	 i8sS8C30uecTd9nh6TW9li3l09MJgaLj/bwBTWjZRCOYU1A/iTZtHNl0XsRj4VssCv
	 d3UTBTJC8bXZdgTO+ncXOlmBpiZPlbeCPoh2IJYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404775AbfHVR0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:26:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404458AbfHVRZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:25:37 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC2D0206DD;
        Thu, 22 Aug 2019 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494736;
        bh=F2s4r3Dc85Wwzv9Jk0wTHcyEYqKnxm5Uoi84WZ3ZM+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYYXXEo2WiMXesSUeESeaCxanArdFcFUV5uSz6n3n/HWMk8GGNFYVAZv9qIT42Zah
         VShFStTP7DsmVJvZX70rbRFr+LMtyIQCw7yMqccRpccJFkE39cDt197/SxakXbGezr
         DFjbMghF6PWt9CPLsf2ynMIVxHYfJDz18ksRwzek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 29/85] xen/pciback: remove set but not used variable old_state
Date:   Thu, 22 Aug 2019 10:19:02 -0700
Message-Id: <20190822171732.591441660@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 09e088a4903bd0dd911b4f1732b250130cdaffed ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/xen/xen-pciback/conf_space_capability.c: In function pm_ctrl_write:
drivers/xen/xen-pciback/conf_space_capability.c:119:25: warning:
 variable old_state set but not used [-Wunused-but-set-variable]

It is never used so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/xen-pciback/conf_space_capability.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/xen/xen-pciback/conf_space_capability.c b/drivers/xen/xen-pciback/conf_space_capability.c
index 73427d8e01161..e5694133ebe57 100644
--- a/drivers/xen/xen-pciback/conf_space_capability.c
+++ b/drivers/xen/xen-pciback/conf_space_capability.c
@@ -116,13 +116,12 @@ static int pm_ctrl_write(struct pci_dev *dev, int offset, u16 new_value,
 {
 	int err;
 	u16 old_value;
-	pci_power_t new_state, old_state;
+	pci_power_t new_state;
 
 	err = pci_read_config_word(dev, offset, &old_value);
 	if (err)
 		goto out;
 
-	old_state = (pci_power_t)(old_value & PCI_PM_CTRL_STATE_MASK);
 	new_state = (pci_power_t)(new_value & PCI_PM_CTRL_STATE_MASK);
 
 	new_value &= PM_OK_BITS;
-- 
2.20.1



