Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5D3C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3928C207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521319;
	bh=eQEYk3hsg5U7Y447uIu01pmEqjJAJ+2eg7UBtJWsVcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fvPlXKmodw+GDsO+IS0Mm2/h0QI3F6kgqVPBQEA3/+m2SIJlrXc2dKivtZdK2HwFc
	 5MSNx0MH//wtP724YoS/o+0Wsf7NTVpj1pPh2iUD5ZKvK9ngvndwS9EFaOdPT/pNE4
	 LJzDu5FJ3YTJ0nlklc9i+mL8eZrxj1/dyhH5hmgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfLPSIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:08:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730219AbfLPSIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:08:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94BA22072B;
        Mon, 16 Dec 2019 18:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519689;
        bh=eQEYk3hsg5U7Y447uIu01pmEqjJAJ+2eg7UBtJWsVcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vbcawg/AfwLT9Bl7kMrkb8AgdkVCHac54JGPzFpMZjjSYflpMy/uYQy4sRBSyCHq1
         n3iq6M3soH1G4QhoxRZUjA7v0wz5avqNSu8Vdidnx2w3y9tjKSSaEQRab5AkJ1kycl
         l55ZGMvLXInQCLs+7vR7M7NCClg0SFaVWWXqi2F4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5.3 003/180] Revert "nvme: Add quirk for Kingston NVME SSD running FW E8FK11.T"
Date:   Mon, 16 Dec 2019 18:47:23 +0100
Message-Id: <20191216174806.609454626@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian-Hong Pan <jian-hong@endlessm.com>

commit 655e7aee1f0398602627a485f7dca6c29cc96cae upstream.

Since e045fa29e893 ("PCI/MSI: Fix incorrect MSI-X masking on resume") is
merged, we can revert the previous quirk now.

This reverts commit 19ea025e1d28c629b369c3532a85b3df478cc5c6.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=204887
Fixes: 19ea025e1d28 ("nvme: Add quirk for Kingston NVME SSD running FW E8FK11.T")
Link: https://lore.kernel.org/r/20191031093408.9322-1-jian-hong@endlessm.com
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/core.c |   10 ----------
 1 file changed, 10 deletions(-)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2270,16 +2270,6 @@ static const struct nvme_core_quirk_entr
 		.vid = 0x14a4,
 		.fr = "22301111",
 		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
-	},
-	{
-		/*
-		 * This Kingston E8FK11.T firmware version has no interrupt
-		 * after resume with actions related to suspend to idle
-		 * https://bugzilla.kernel.org/show_bug.cgi?id=204887
-		 */
-		.vid = 0x2646,
-		.fr = "E8FK11.T",
-		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
 	}
 };
 


