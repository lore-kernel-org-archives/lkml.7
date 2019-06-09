Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EB7C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABB5206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099967;
	bh=K3HweLCpeokOm366BXIvoHi/dJtHz0DI3sdBKIKEuDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RaH3L9GkDVXpE6KVTzbwA9TGsoh3Z23N9jkvF+37Se52qBoc2ttpiKhNLaKgK4ae2
	 1EfYMK4QxJBnQS6ng7dIPoS5HND5bVsQYmOSjf+mgl6stge5tp9RUzGaS/eAI3rDPz
	 SWeZIuXuWa5nebdWJL2K9bN5vKnjAtXqzpsXfouk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388960AbfFIRGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388514AbfFIRGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:06:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62E4E20840;
        Sun,  9 Jun 2019 17:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099963;
        bh=K3HweLCpeokOm366BXIvoHi/dJtHz0DI3sdBKIKEuDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YPZM+iSVsevG/wMg1gM394R7IWbCkTv/xnzawpcFUqdtRyl1sF9WZ3NOdnYW3cFhV
         50hnTnWbzijYnvAg5bOLyNhzuebcKoI/yTlLDiWdj4471aAJld06v9x0/cjzuVDir9
         6hKzRBujROfldJjbGuwxQI5cAXRCYes/OtvqaRK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Beulich <jbeulich@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 189/241] xen/pciback: Dont disable PCI_COMMAND on PCI device reset.
Date:   Sun,  9 Jun 2019 18:42:11 +0200
Message-Id: <20190609164153.368548323@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
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


