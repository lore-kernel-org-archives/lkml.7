Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB183C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82765217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558638509;
	bh=FtYbvIv3gOl5LAcrN+tt1XTYQKijAsSZSVhpgmTQNSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i8hZ77jQRRt/y8K48z4M7GSXdcZVn/CWuqJLPiCkJkzhfWO2+wt2VlxHLOD/z47vl
	 EYJ3t9aj7pwFLOg+I64gLYgBdR0upnHobftvn7Gzg/jSlNAZO72dWl+0ueVLW5CPjw
	 sKi9hPnjtJj31ScpuKDNgA97LBXzDiY4UwjFMT20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfEWTI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731464AbfEWTI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:08:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E5492133D;
        Thu, 23 May 2019 19:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638506;
        bh=FtYbvIv3gOl5LAcrN+tt1XTYQKijAsSZSVhpgmTQNSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qClh0fTBWIJ+ZFpQxra0BRMB88UWQKmhi76H/gpEgRuzsFc8vAstK57NEKj8OXMn8
         BZH34ElUP+wUasikPZ6NsGRlHszMI3AQGT2DTJBCgdvDMUusqnJ8RFIfQ4p/taWPlt
         ERo5O4w35SAPIlfxr2Dc4kjF31EYEO3UxObttLS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Christian Lamparter <chunkeey@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.9 14/53] p54: drop device reference count if fails to enable device
Date:   Thu, 23 May 2019 21:05:38 +0200
Message-Id: <20190523181713.118777884@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181710.981455400@linuxfoundation.org>
References: <20190523181710.981455400@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

commit 8149069db81853570a665f5e5648c0e526dc0e43 upstream.

The function p54p_probe takes an extra reference count of the PCI
device. However, the extra reference count is not dropped when it fails
to enable the PCI device. This patch fixes the bug.

Cc: stable@vger.kernel.org
Signed-off-by: Pan Bian <bianpan2016@163.com>
Acked-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intersil/p54/p54pci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/intersil/p54/p54pci.c
+++ b/drivers/net/wireless/intersil/p54/p54pci.c
@@ -554,7 +554,7 @@ static int p54p_probe(struct pci_dev *pd
 	err = pci_enable_device(pdev);
 	if (err) {
 		dev_err(&pdev->dev, "Cannot enable new PCI device\n");
-		return err;
+		goto err_put;
 	}
 
 	mem_addr = pci_resource_start(pdev, 0);
@@ -639,6 +639,7 @@ static int p54p_probe(struct pci_dev *pd
 	pci_release_regions(pdev);
  err_disable_dev:
 	pci_disable_device(pdev);
+err_put:
 	pci_dev_put(pdev);
 	return err;
 }


