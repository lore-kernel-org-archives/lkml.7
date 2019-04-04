Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381E6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0776420820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ocjKRk2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfDDAdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:33:23 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:48538 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfDDAdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:20 -0400
Received: by mail-oi1-f202.google.com with SMTP id s64so336165oia.15
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=m5EpQp8h0Y4rOl6Y1bbFAZQnIUUjTzjUqWwPJEltX0Y=;
        b=ocjKRk2uUtqZ4iOJV2jedYJKPEapKDEzvfWc8HY+i+xFfEyayOYqbLWPu8Z3xN6v7m
         7vE6H9PK8L1J2QZZhJeDyD0kawGilYXs+t0n4wzbstR/VqOE7iCdQ/AhSVLMB8zkTEkP
         hED0gN06yC/q53ohr6GM0JuqFX+wx9Lc4u4EgwAuwiiKvzPNJDyAx3lCJYmK9/Vx+bq8
         F0vaeAYBmLnAM+aAWf44QmkFfIRr3tMYARd7EInNJb2QflHlEqzW4rXTX9RM+klXPMzl
         q1PsBfL5YaDXc14Lm2QkznhvbIaNW7bGY4Luc6wiotRneuT0jRSaYY9bEDbhEFKYRmWi
         drbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m5EpQp8h0Y4rOl6Y1bbFAZQnIUUjTzjUqWwPJEltX0Y=;
        b=QRzj1WR3TbQ2DBeq6S3TTtwot+5q2ewnCdFurIh8HOZdhejFO89Ixv1jbU4YF7SLmU
         r66Rhy4Cza6sMsQ34egq4VwLM7g3EUeC/rcgqVXV0wtstiadl0w+SSTCTjpoJ80EMjTi
         Yu1ibzxEPRJl3IqB7R7Xc0wzVSD9Dc3+vSSCNFugjMtTpjXFmZpwheYt6taqNW165rFV
         ZRvhqyq+uAm2CQsl/cNmuBrWPtIpwex0ImHkEOlcSliE8+XzsHnoqKDKeGDqfX7q3MAg
         LxvjZhYFnCPGmwZZOW5+zhyh7OIyTGPEEsMa2F1lBnNAjx2u0cN6ZSW6cub3PctnfymX
         wL3A==
X-Gm-Message-State: APjAAAVSG/4Oa9kTVcPqQbwtYRS7pflKIV53n7KQIGJ97JJ4jxTSToPG
        jRPESO7JfLOv5eQp3rlI5m7t9Af3BVcMC9lzfJfpxg==
X-Google-Smtp-Source: APXvYqwi6dSpI9p/5yHXUp5zHUlVc9aBYPhvQtpRQtFUwPCGKLeTlUt0GbyXS3R2mPTpVRAld1ySv5RUcgaNvopbDpSu3Q==
X-Received: by 2002:aca:abd7:: with SMTP id u206mr329089oie.36.1554338000165;
 Wed, 03 Apr 2019 17:33:20 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:32 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-11-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 10/27] PCI: Lock down BAR access when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

Any hardware that can potentially generate DMA has to be locked down in
order to avoid it being possible for an attacker to modify kernel code,
allowing them to circumvent disabled module loading or module signing.
Default to paranoid - in future we can potentially relax this for
sufficiently IOMMU-isolated devices.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org
---
 drivers/pci/pci-sysfs.c | 9 +++++++++
 drivers/pci/proc.c      | 9 ++++++++-
 drivers/pci/syscall.c   | 3 ++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9ecfe13157c0..59d02088945e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -905,6 +905,9 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 	loff_t init_off = off;
 	u8 *data = (u8 *) buf;
 
+	if (kernel_is_locked_down("Direct PCI access", LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	if (off > dev->cfg_size)
 		return 0;
 	if (off + count > dev->cfg_size) {
@@ -1167,6 +1170,9 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	enum pci_mmap_state mmap_type;
 	struct resource *res = &pdev->resource[bar];
 
+	if (kernel_is_locked_down("Direct PCI access", LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
@@ -1242,6 +1248,9 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
 				     struct bin_attribute *attr, char *buf,
 				     loff_t off, size_t count)
 {
+	if (kernel_is_locked_down("Direct PCI access", LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
 }
 
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 6fa1627ce08d..85769f222b6d 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -117,6 +117,9 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 	int size = dev->cfg_size;
 	int cnt;
 
+	if (kernel_is_locked_down("Direct PCI access", LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	if (pos >= size)
 		return 0;
 	if (nbytes >= size)
@@ -196,6 +199,9 @@ static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
 #endif /* HAVE_PCI_MMAP */
 	int ret = 0;
 
+	if (kernel_is_locked_down("Direct PCI access", LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	switch (cmd) {
 	case PCIIOC_CONTROLLER:
 		ret = pci_domain_nr(dev->bus);
@@ -237,7 +243,8 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 	struct pci_filp_private *fpriv = file->private_data;
 	int i, ret, write_combine = 0, res_bit = IORESOURCE_MEM;
 
-	if (!capable(CAP_SYS_RAWIO))
+	if (!capable(CAP_SYS_RAWIO) ||
+	    kernel_is_locked_down("Direct PCI access", LOCKDOWN_INTEGRITY))
 		return -EPERM;
 
 	if (fpriv->mmap_state == pci_mmap_io) {
diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index d96626c614f5..0669cb09e792 100644
--- a/drivers/pci/syscall.c
+++ b/drivers/pci/syscall.c
@@ -90,7 +90,8 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
 	u32 dword;
 	int err = 0;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!capable(CAP_SYS_ADMIN) ||
+	    kernel_is_locked_down("Direct PCI access", LOCKDOWN_INTEGRITY))
 		return -EPERM;
 
 	dev = pci_get_domain_bus_and_slot(0, bus, dfn);
-- 
2.21.0.392.gf8f6787159e-goog

