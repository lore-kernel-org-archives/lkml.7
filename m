Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6F0C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83022073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079084;
	bh=0kkvMRZ/npEE3ZOX3qFqvZr/yONXMfNvvPFi75Q63SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HL2X85lFG1NVtrwy9ryUIUBDFUunBX7yK8vsqCEqVRbgLiim2+CMPwc/6zY8eG+pD
	 2mvvA62uuItrAhl2whufww5x2IAY1EEhbnRLJ+4xnBd5J2umDnd3aRaBo2gpKJyGCs
	 WixgUxq3yeHpznE6JOuvggKDTISacFiImk6k8/Js=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbfLKPon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:44:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:33004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732975AbfLKP1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:27:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CBE322527;
        Wed, 11 Dec 2019 15:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078043;
        bh=0kkvMRZ/npEE3ZOX3qFqvZr/yONXMfNvvPFi75Q63SE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxjEja541X3RKkhiZ5d2w+ULOO0mS1iAELDhbmOh2hJZKvQbTAuaS7B0F7HkOjLSh
         mjUXscKhmJfPLLHpG4dePEptlNttceaQsL6HlvJNFbmzogVGgxRoyxyrgqlkZTax4e
         o+rU0z98EA8jBSn7UAyZmdgp/q9HnFstNgVkJLWA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 37/79] PCI: rpaphp: Fix up pointer to first drc-info entry
Date:   Wed, 11 Dec 2019 10:26:01 -0500
Message-Id: <20191211152643.23056-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211152643.23056-1-sashal@kernel.org>
References: <20191211152643.23056-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tyrel Datwyler <tyreld@linux.ibm.com>

[ Upstream commit 9723c25f99aff0451cfe6392e1b9fdd99d0bf9f0 ]

The first entry of the ibm,drc-info property is an int encoded count
of the number of drc-info entries that follow. The "value" pointer
returned by of_prop_next_u32() is still pointing at the this value
when we call of_read_drc_info_cell(), but the helper function
expects that value to be pointing at the first element of an entry.

Fix up by incrementing the "value" pointer to point at the first
element of the first drc-info entry prior.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/1573449697-5448-5-git-send-email-tyreld@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/rpaphp_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index cc860c5f7d26f..f56004243591f 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -239,6 +239,8 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
 	value = of_prop_next_u32(info, NULL, &entries);
 	if (!value)
 		return -EINVAL;
+	else
+		value++;
 
 	for (j = 0; j < entries; j++) {
 		of_read_drc_info_cell(&info, &value, &drc);
-- 
2.20.1

