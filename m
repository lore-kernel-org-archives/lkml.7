Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9599C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEE0205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413510;
	bh=pSHuXd5pFJAh3JI2ovhIZNezMe69/vs1dovexXVwLTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CKC5o0n1SZjVmtmgLvcv+qITCZ58nyVMe7XY6dlp1K2pvGIeqkO5LIeFyMj7VOktK
	 pB+oYd2KHQ+4vYXMyZqrexv9aedh/Z7QedaCzotw79Jmed8AmGEgMThGInt+I3JNRb
	 g44AZiUXpgDIVXe3lFnuqP0XTsot7WsavpQySRzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfCLR63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbfCLRNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:41 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF7321741;
        Tue, 12 Mar 2019 17:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410820;
        bh=pSHuXd5pFJAh3JI2ovhIZNezMe69/vs1dovexXVwLTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CaZV4yh1m6V+iTgxweCaxH1UgwIKNfHbbZGEFJcXvNSKT7KR1wMwy16PzlJ7ivYkM
         5nrIXM9DCKBAjxIa/5SZydw0e5oPSdBrjcYTbkK2YyVnMpdUmySNRbNPmmFz6HyfrT
         4GX1bBB5K2AxR4f4t92CyfCfwJlIQZl3sohbZwfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.20 153/171] x86/PCI: Fixup RTIT_BAR of Intel Denverton Trace Hub
Date:   Tue, 12 Mar 2019 10:08:53 -0700
Message-Id: <20190312170400.690758654@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit 2e095ce7b6ecce2f3e2ff330527f12056ed1e1a1 upstream.

On Denverton's integration of the Intel(R) Trace Hub (for a reference and
overview see Documentation/trace/intel_th.rst) the reported size of one of
its resources (RTIT_BAR) doesn't match its actual size, which leads to
overlaps with other devices' resources.

In practice, it overlaps with XHCI MMIO space, which results in the xhci
driver bailing out after seeing its registers as 0xffffffff, and perceived
disappearance of all USB devices:

  intel_th_pci 0000:00:1f.7: enabling device (0004 -> 0006)
  xhci_hcd 0000:00:15.0: xHCI host controller not responding, assume dead
  xhci_hcd 0000:00:15.0: xHC not responding in xhci_irq, assume controller is dead
  xhci_hcd 0000:00:15.0: HC died; cleaning up
  usb 1-1: USB disconnect, device number 2

For this reason, we need to resize the RTIT_BAR on Denverton to its actual
size, which in this case is 4MB.  The corresponding erratum is DNV36 at the
link below:

  DNV36.       Processor Host Root Complex May Incorrectly Route Memory
               Accesses to Intel® Trace Hub

  Problem:     The Intel® Trace Hub RTIT_BAR (B0:D31:F7 offset 20h) is
	       reported as a 2KB memory range.  Due to this erratum, the
	       processor Host Root Complex will forward addresses from
	       RTIT_BAR to RTIT_BAR + 4MB -1 to Intel® Trace Hub.

  Implication: Devices assigned within the RTIT_BAR to RTIT_BAR + 4MB -1
               space may not function correctly.

  Workaround:  A BIOS code change has been identified and may be
               implemented as a workaround for this erratum.

  Status:      No Fix.

Note that 5118ccd34780 ("intel_th: pci: Add Denverton SOC support") updates
the Trace Hub driver so it claims the Denverton device, but the resource
overlap exists regardless of whether that driver is loaded or that commit
is included.

Link: https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/atom-c3000-family-spec-update.pdf
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
[bhelgaas: include erratum text, clarify relationship with 5118ccd34780]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/pci/fixup.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -635,6 +635,22 @@ static void quirk_no_aersid(struct pci_d
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_no_aersid);
 
+static void quirk_intel_th_dnv(struct pci_dev *dev)
+{
+	struct resource *r = &dev->resource[4];
+
+	/*
+	 * Denverton reports 2k of RTIT_BAR (intel_th resource 4), which
+	 * appears to be 4 MB in reality.
+	 */
+	if (r->end == r->start + 0x7ff) {
+		r->start = 0;
+		r->end   = 0x3fffff;
+		r->flags |= IORESOURCE_UNSET;
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x19e1, quirk_intel_th_dnv);
+
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 
 #define AMD_141b_MMIO_BASE(x)	(0x80 + (x) * 0x8)


