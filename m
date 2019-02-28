Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94FCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772E92133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uuxcthmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387801AbfB1XMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:35 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:41163 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387768AbfB1XMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:33 -0500
Received: by mail-pf1-f201.google.com with SMTP id z1so17292801pfz.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1iAkG3SYFFYNE2aS5Uy/nPaL9mRV8qNg8EUrtDxONjY=;
        b=uuxcthmJNDGwdJv5YpH6uELSKb27+zpDpVvWg4XUCi1qsYzIbaO/WzbJbI+FgFxYhX
         dE7U/DyEntkC0oMXihkOtsUYnqczFs5zCG7GTKBTHGNGyWTpKm1VUAqOofwik/d813qQ
         7VdLvbS/fIlHFvB4aqFgXFYFlNMbXyWCmI8WS6VxtPJ22aLyi84bOTFoHZGlcDDCjs/f
         oO0rWxy+g0QrufGhvSnM6CFXDpQZ03yp4cB07nQnZh5nhmK7jVs+7cm3oWaNZMLmX6oJ
         OxDq66oYZhm7uLm4/9uHd1kiLBAx9QV9Oi+Ug6tLh+5Mj8A07cFYfrMZtLK5d2xYxN5x
         ETpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1iAkG3SYFFYNE2aS5Uy/nPaL9mRV8qNg8EUrtDxONjY=;
        b=he1y4wAh2ehkX8CCRobZJMBWkjApSx0XSyeprzmXKCV+el6ZKIrpAmNrQ3XlXJZzOt
         AmpgVjBLv/hNgFzaipAHfa6o6HlKcd8/GFPpUwaZqLZ/1s6ae+izNzqujWEMEUOrlmSW
         Gsvi9Y8AaTEHJgmaDVnLsQ33t+3zqaPSbsZYrWys0+bENBJnt+vFZ7hULXYnibhh6Jqn
         FnT01SmlUa+hmRET/uiwNMlulS21VLYhg/1UkInuP8aCoqaVaMmJT1b6x48/i/4BXhSz
         UYT6ZurY+vJDv7BvZGVdhMBDBr/uqNwrPwnOqP7TT88cbKTvK885oBpGQSeI6n56r6+N
         J4tw==
X-Gm-Message-State: APjAAAWi/lvFa+DCgcG3sdOCYjiKNUnfYGV5RCHDQc3unBAoVCuoPY/D
        2wsqQ9fsrvh394/VkynZsCEac7Jh3Q4czBpZ9a4nhw==
X-Google-Smtp-Source: APXvYqxAbpqSdYwQtV399CqmoPDFoqEoZZNTH4jRNtVv0TtSWcEXqkpl9CGuRySxRH0c2gqIp23VtCLK006xVbMvMGRfgg==
X-Received: by 2002:a17:902:b682:: with SMTP id c2mr652302pls.107.1551395552587;
 Thu, 28 Feb 2019 15:12:32 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:47 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-11-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 11/27] PCI: Lock down BAR access when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
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

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: linux-pci@vger.kernel.org
---
 drivers/pci/pci-sysfs.c | 9 +++++++++
 drivers/pci/proc.c      | 9 ++++++++-
 drivers/pci/syscall.c   | 3 ++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9ecfe13157c0..40c14574fcf8 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -905,6 +905,9 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 	loff_t init_off = off;
 	u8 *data = (u8 *) buf;
 
+	if (kernel_is_locked_down("Direct PCI access"))
+		return -EPERM;
+
 	if (off > dev->cfg_size)
 		return 0;
 	if (off + count > dev->cfg_size) {
@@ -1167,6 +1170,9 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	enum pci_mmap_state mmap_type;
 	struct resource *res = &pdev->resource[bar];
 
+	if (kernel_is_locked_down("Direct PCI access"))
+		return -EPERM;
+
 	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
@@ -1242,6 +1248,9 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
 				     struct bin_attribute *attr, char *buf,
 				     loff_t off, size_t count)
 {
+	if (kernel_is_locked_down("Direct PCI access"))
+		return -EPERM;
+
 	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
 }
 
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 6fa1627ce08d..1549cdd0710e 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -117,6 +117,9 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 	int size = dev->cfg_size;
 	int cnt;
 
+	if (kernel_is_locked_down("Direct PCI access"))
+		return -EPERM;
+
 	if (pos >= size)
 		return 0;
 	if (nbytes >= size)
@@ -196,6 +199,9 @@ static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
 #endif /* HAVE_PCI_MMAP */
 	int ret = 0;
 
+	if (kernel_is_locked_down("Direct PCI access"))
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
+	    kernel_is_locked_down("Direct PCI access"))
 		return -EPERM;
 
 	if (fpriv->mmap_state == pci_mmap_io) {
diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index d96626c614f5..b8a08d3166a1 100644
--- a/drivers/pci/syscall.c
+++ b/drivers/pci/syscall.c
@@ -90,7 +90,8 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
 	u32 dword;
 	int err = 0;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!capable(CAP_SYS_ADMIN) ||
+	    kernel_is_locked_down("Direct PCI access"))
 		return -EPERM;
 
 	dev = pci_get_domain_bus_and_slot(0, bus, dfn);
-- 
2.21.0.352.gf09ad66450-goog

