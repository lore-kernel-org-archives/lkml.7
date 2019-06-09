Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9B2C468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069EF20652
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100644;
	bh=K3HweLCpeokOm366BXIvoHi/dJtHz0DI3sdBKIKEuDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MEw8kMRANod/8c0han3QHKwqwqXpp273mMyn+Rxk+VRy7Gqakl6o8PCX1IC5LIU/I
	 yOKwTCQjmFcJyy9v1sgMKk+R3YuB3IuvcFeSed58qvTGiH5DBfmnSb7NW9bD6KYzi5
	 ntuldiynb58rjBYeVrOS6BfF6k+a4Tw1I1wHReDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbfFIQv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732059AbfFIQvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:51:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B651205ED;
        Sun,  9 Jun 2019 16:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099114;
        bh=K3HweLCpeokOm366BXIvoHi/dJtHz0DI3sdBKIKEuDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kAz6yprGT6JRtrnM7bkoJgJzAAoFrIahNcsu9hl//GEzYx9ndAXSDeDhytk4Oo8mF
         TmnhiWQdyCJotBuJJOerXuqNvlMgGCzCbG8rHbvd7Pghv9x852sRPTNC5W1nhqN+WB
         3DAvqKEcjCzCMIiR0BJGu27VFUMEOw8uNXx9XOjM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Beulich <jbeulich@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 15/83] xen/pciback: Dont disable PCI_COMMAND on PCI device reset.
Date:   Sun,  9 Jun 2019 18:41:45 +0200
Message-Id: <20190609164128.850524258@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.843327870@linuxfoundation.org>
References: <20190609164127.843327870@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 7681f31ec9cdacab4fd10570be924f2cef6669ba upstream.

There is no need for this at all. Worst it means that if
the guest tries to write to BARs it could lead (on certain
platforms) to PCI SERR errors.

Please note that with af6fc858a35b90e89ea7a7ee58e66628c55c776b
"xen-pciback: limit guest control of command register"
a guest is still allowed to enable those control bits (safely), but
is not allowed to disable them and that therefore a well behaved
frontend which enables things before using them will still
function correctly.

This is done via an write to the configuration register 0x4 which
triggers on the backend side:
command_write
  \- pci_enable_device
     \- pci_enable_device_flags
        \- do_pci_enable_device
           \- pcibios_enable_device
              \-pci_enable_resourcess
                [which enables the PCI_COMMAND_MEMORY|PCI_COMMAND_IO]

However guests (and drivers) which don't do this could cause
problems, including the security issues which XSA-120 sought
to address.

Reported-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/xen-pciback/pciback_ops.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/xen/xen-pciback/pciback_ops.c
+++ b/drivers/xen/xen-pciback/pciback_ops.c
@@ -126,8 +126,6 @@ void xen_pcibk_reset_device(struct pci_d
 		if (pci_is_enabled(dev))
 			pci_disable_device(dev);
 
-		pci_write_config_word(dev, PCI_COMMAND, 0);
-
 		dev->is_busmaster = 0;
 	} else {
 		pci_read_config_word(dev, PCI_COMMAND, &cmd);


