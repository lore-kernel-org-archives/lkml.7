Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DF0C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9705424683
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781356;
	bh=VX4tEIn9Rby6BBxce5FwGOE/aMXyX4JhJeIOApnzwIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nSLFSghzOZDJzb2VFXUaBZ/2gWaXeByfMS05e7XKbkTfeXAQxKEHQQb2BxryMxEyR
	 QnR9/uHY5GmrV0grJ/m+Tk2m3zMpX4eSVd/RGqJNIiPE23uuqw2GYIHYZaGwYdM8xS
	 uo6V489Np39Hpheemdr2Hi72DOMAgPB3za4vT2wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfLSStP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:49:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729745AbfLSStN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:49:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96C7924676;
        Thu, 19 Dec 2019 18:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781352;
        bh=VX4tEIn9Rby6BBxce5FwGOE/aMXyX4JhJeIOApnzwIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wLg44zkyY5k8/SyAAQiuGWYmJH3Ive1dJK6/PgOMUeYjOTNJcNnZ6OYu1DclGrMv5
         QtgypAjnPsprrPKdKPnS8Wcj9UbqXZcxZrkgyaVIGP0Fy/BJRseJpKD4D0/NxnUeap
         S1z9anxYmLu53I/Q+g0R9Zd7qYCdKOlKgVkUYq2Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Steffen Liebergeld <steffen.liebergeld@kernkonzept.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 4.9 186/199] PCI: Fix Intel ACS quirk UPDCR register address
Date:   Thu, 19 Dec 2019 19:34:28 +0100
Message-Id: <20191219183225.980161171@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steffen Liebergeld <steffen.liebergeld@kernkonzept.com>

commit d8558ac8c93d429d65d7490b512a3a67e559d0d4 upstream.

According to documentation [0] the correct offset for the Upstream Peer
Decode Configuration Register (UPDCR) is 0x1014.  It was previously defined
as 0x1114.

d99321b63b1f ("PCI: Enable quirks for PCIe ACS on Intel PCH root ports")
intended to enforce isolation between PCI devices allowing them to be put
into separate IOMMU groups.  Due to the wrong register offset the intended
isolation was not fully enforced.  This is fixed with this patch.

Please note that I did not test this patch because I have no hardware that
implements this register.

[0] https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-mobile-i-o-datasheet.pdf (page 325)
Fixes: d99321b63b1f ("PCI: Enable quirks for PCIe ACS on Intel PCH root ports")
Link: https://lore.kernel.org/r/7a3505df-79ba-8a28-464c-88b83eefffa6@kernkonzept.com
Signed-off-by: Steffen Liebergeld <steffen.liebergeld@kernkonzept.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Acked-by: Ashok Raj <ashok.raj@intel.com>
Cc: stable@vger.kernel.org	# v3.15+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/quirks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4446,7 +4446,7 @@ int pci_dev_specific_acs_enabled(struct
 #define INTEL_BSPR_REG_BPPD  (1 << 9)
 
 /* Upstream Peer Decode Configuration Register */
-#define INTEL_UPDCR_REG 0x1114
+#define INTEL_UPDCR_REG 0x1014
 /* 5:0 Peer Decode Enable bits */
 #define INTEL_UPDCR_REG_MASK 0x3f
 


