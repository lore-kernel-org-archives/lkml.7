Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF21DC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A395D20644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560443049;
	bh=xFxWqGYLn7n6qxXr1EVnUOBdOKYOjByVilGSpEX/rW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KszfLtkXvjWeBa4tPtHuKZi+HOTb6mpmlP+cwSZdNe7xQMOqLUbA2PEhLWVjR10Nh
	 rREc6HmFbcCm05XlD0JRpx0LlmjdldxewGSF3wCLt4e3bx1kN+FfQiHMO2b+pbfzb9
	 XOwNO4HrJ59zn9xvN9yQoIfJRqQy65tpE/gB+WIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403991AbfFMQYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731003AbfFMIhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:37:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C95C120896;
        Thu, 13 Jun 2019 08:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415043;
        bh=xFxWqGYLn7n6qxXr1EVnUOBdOKYOjByVilGSpEX/rW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wDoZmerReLquoqdyGabDwP6BGUjPGt0HQonLNwgDcyngWpEnrrDOCdap+2cXhFal9
         slWtfKInAOwKWPd9lPxFvpD8wY/DgjQiDikBzt5R4EoneFg9JpGGnvMiNcBYb+dZ7q
         SGtBSaRmhoEFe4MBvzSGUEfsx9rAGRdZhZF25m4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 39/81] misc: pci_endpoint_test: Fix test_reg_bar to be updated in pci_endpoint_test
Date:   Thu, 13 Jun 2019 10:33:22 +0200
Message-Id: <20190613075652.221593497@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075649.074682929@linuxfoundation.org>
References: <20190613075649.074682929@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8f220664570e755946db1282f48e07f26e1f2cb4 ]

commit 834b90519925 ("misc: pci_endpoint_test: Add support for
PCI_ENDPOINT_TEST regs to be mapped to any BAR") while adding
test_reg_bar in order to map PCI_ENDPOINT_TEST regs to be mapped to any
BAR failed to update test_reg_bar in pci_endpoint_test, resulting in
test_reg_bar having invalid value when used outside probe.

Fix it.

Fixes: 834b90519925 ("misc: pci_endpoint_test: Add support for PCI_ENDPOINT_TEST regs to be mapped to any BAR")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index e089bb6dde3a..9849bf183299 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -479,6 +479,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	data = (struct pci_endpoint_test_data *)ent->driver_data;
 	if (data) {
 		test_reg_bar = data->test_reg_bar;
+		test->test_reg_bar = test_reg_bar;
 		test->alignment = data->alignment;
 		no_msi = data->no_msi;
 	}
-- 
2.20.1



