Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACB4C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3882075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355751;
	bh=4q2dI5ZE8EpVbnWlxW/BPlgtj+tnDTeQnfqI5mML2Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dbF1aHzgITukzxGR2So3a4WHcYFpCP/Nh5wx4otjvWBGhn++uYxZDqMqneOXrboEZ
	 Fc/ROh/3458LIJElSbowvUe3gvI1uLBeQSlao2yqJOIYCp4cMjIvevV4PMcwUhMVy2
	 RGmxU4S2avip39u5QSlQn9Cm5PLu5konBAOmL87Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbfDOTNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730478AbfDOTNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:13:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB29721906;
        Mon, 15 Apr 2019 19:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355627;
        bh=4q2dI5ZE8EpVbnWlxW/BPlgtj+tnDTeQnfqI5mML2Pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v3neYJCSD7dX//LBwG7X1IORyaMmbSZgGLOQTPBtZuj647j5DiXMJNdqty8qL3AyC
         6r6nMZ1DDeA6sFVNpT5sFHuOcNXSrjOPml7qzvpoSwliVdPXRqBGvwrMXWrzNx2hcY
         dcoHrxDcPQuaa9VVijkFid4/b/0lMECr23CswQD4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Micah Parrish <micah.parrish@hpe.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 5.0 107/117] PCI: pciehp: Ignore Link State Changes after powering off a slot
Date:   Mon, 15 Apr 2019 21:01:17 +0200
Message-Id: <20190415183750.195796084@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>

commit 3943af9d01e94330d0cfac6fccdbc829aad50c92 upstream.

During a safe hot remove, the OS powers off the slot, which may cause a
Data Link Layer State Changed event.  The slot has already been set to
OFF_STATE, so that event results in re-enabling the device, making it
impossible to safely remove it.

Clear out the Presence Detect Changed and Data Link Layer State Changed
events when the disabled slot has settled down.

It is still possible to re-enable the device if it remains in the slot
after pressing the Attention Button by pressing it again.

Fixes the problem that Micah reported below: an NVMe drive power button may
not actually turn off the drive.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=203237
Reported-by: Micah Parrish <micah.parrish@hpe.com>
Tested-by: Micah Parrish <micah.parrish@hpe.com>
Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
[bhelgaas: changelog, add bugzilla URL]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org	# v4.19+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/hotplug/pciehp_ctrl.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -115,6 +115,10 @@ static void remove_board(struct controll
 		 * removed from the slot/adapter.
 		 */
 		msleep(1000);
+
+		/* Ignore link or presence changes caused by power off */
+		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
+			   &ctrl->pending_events);
 	}
 
 	/* turn off Green LED */


