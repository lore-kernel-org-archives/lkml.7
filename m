Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB2EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F76206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KPpbG0aW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfLCFn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 00:43:27 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:38547 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726805AbfLCFn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:43:27 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2D2E1C8F;
        Tue,  3 Dec 2019 00:43:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 03 Dec 2019 00:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Au0sk+
        xl/cZ8hI+5WvyE3tKwAjfm2QQqUf4iEBuIseM=; b=KPpbG0aWTbWbuuFica4AC1
        ePvz1sgqjSuHxawCY/9vnuPNC+mOYXnUOAnTFQCNZXGH+54yZZauDnNjS6NMtbsR
        LVYj1Z+2FSKNLia1h+ezU1dJ+DpM3v9RANFCse6kUJh5o9Q9sUFwFsa4qycljS9I
        fecL8TydfmrA4aOYPp8MJf0WYLFm2ebvIet8lKsepO14Hflqslpr1a8bGwhD1qov
        bZwIhtAFjnNcrpRrVp+3UxssohYFlMU2om6yiGmCZq8Axh3LMiE6s7pd6q8bGvRy
        RIDJk89Owh6DeR6zug1c2DE4uGrFZup1zv2AXzQZWJdatholiFHBFuGIKDlm10xA
        ==
X-ME-Sender: <xms:_PXlXXfR9er6umCQBchZbkqvuPv_iwXvOTYlgyvLktd4gtEuIsIMSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejiedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffogggtohfgsehtkeertdertdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucffohhmrghinhepmhgrrhhkmhgr
    ihhlrdhorhhgpdhinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomhenucfkpheple
    durdeihedrfeegrdeffeenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghk
    sehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomhenucevlhhushhtvghrufhiii
    gvpedt
X-ME-Proxy: <xmx:_PXlXYsgZ4dOqNbtQXkYZtf79T_8XzNQw7iMvptSWiZJGJajuRZQdQ>
    <xmx:_PXlXWh0-r9rq9CngzcSi4VdhmQ4hHyU6MAem2FOubaSrjBEhdgavQ>
    <xmx:_PXlXWvVoHhL1XcDapcU6N0fmhE1CiKw5vMYUYhp5DsuU-JS-7I1Jg>
    <xmx:_PXlXQHnVCrGSaS9Ww_Fq-hVBnO21H_RYTBdtFVd6TxTOqf_7-Hjcw>
Received: from localhost.localdomain (ip5b412221.dynamic.kabel-deutschland.de [91.65.34.33])
        by mail.messagingengine.com (Postfix) with ESMTPA id B07B980059;
        Tue,  3 Dec 2019 00:43:22 -0500 (EST)
From:   =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     xen-devel@lists.xenproject.org
Cc:     =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Simon Gaiser <simon@invisiblethingslab.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] xen-pciback: optionally allow interrupt enable flag writes
Date:   Tue,  3 Dec 2019 06:41:56 +0100
Message-Id: <20191203054222.7966-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Invisible Things Lab
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QEMU running in a stubdom needs to be able to set INTX_DISABLE, and the
MSI(-X) enable flags in the PCI config space. This adds an attribute
'allow_interrupt_control' which when set for a PCI device allows writes
to this flag(s). The toolstack will need to set this for stubdoms.
When enabled, guest (stubdomain) will be allowed to set relevant enable
flags, but only one at a time - i.e. it refuses to enable more than one
of INTx, MSI, MSI-X at a time.

This functionality is needed only for config space access done by device
model (stubdomain) serving a HVM with the actual PCI device. It is not
necessary and unsafe to enable direct access to those bits for PV domain
with the device attached. For PV domains, there are separate protocol
messages (XEN_PCI_OP_{enable,disable}_{msi,msix}) for this purpose.
Those ops in addition to setting enable bits, also configure MSI(-X) in
dom0 kernel - which is undesirable for PCI passthrough to HVM guests.

This should not introduce any new security issues since a malicious
guest (or stubdom) can already generate MSIs through other ways, see
[1] page 8. Additionally, when qemu runs in dom0, it already have direct
access to those bits.

This is the second iteration of this feature. First was proposed as a
direct Xen interface through a new hypercall, but ultimately it was
rejected by the maintainer, because of mixing pciback and hypercalls for
PCI config space access isn't a good design. Full discussion at [2].

[1]: https://invisiblethingslab.com/resources/2011/Software%20Attacks%20on%20Intel%20VT-d.pdf
[2]: https://xen.markmail.org/thread/smpgpws4umdzizze

[part of the commit message and sysfs handling]
Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
[the rest]
Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
I'm not very happy about code duplication regarding MSI/MSI-X/INTx
exclusivity test, but I don't have better ideas how to structure it. Any
suggestions?
---
 .../xen/xen-pciback/conf_space_capability.c   | 113 ++++++++++++++++++
 drivers/xen/xen-pciback/conf_space_header.c   |  30 +++++
 drivers/xen/xen-pciback/pci_stub.c            |  66 ++++++++++
 drivers/xen/xen-pciback/pciback.h             |   1 +
 4 files changed, 210 insertions(+)

diff --git a/drivers/xen/xen-pciback/conf_space_capability.c b/drivers/xen/xen-pciback/conf_space_capability.c
index e5694133ebe5..c5a7c58ff3e3 100644
--- a/drivers/xen/xen-pciback/conf_space_capability.c
+++ b/drivers/xen/xen-pciback/conf_space_capability.c
@@ -189,6 +189,109 @@ static const struct config_field caplist_pm[] = {
 	{}
 };
 
+static struct msi_msix_field_config {
+	u16 enable_bit;  /* bit for enabling MSI/MSI-X */
+	int other_cap;  /* the other capability for exclusiveness check */
+} msi_field_config = {
+	.enable_bit = PCI_MSI_FLAGS_ENABLE,
+	.other_cap = PCI_CAP_ID_MSIX,
+}, msix_field_config = {
+	.enable_bit = PCI_MSIX_FLAGS_ENABLE,
+	.other_cap = PCI_CAP_ID_MSI,
+};
+
+static void *msi_field_init(struct pci_dev *dev, int offset)
+{
+	return &msi_field_config;
+}
+
+static void *msix_field_init(struct pci_dev *dev, int offset)
+{
+	return &msix_field_config;
+}
+
+static int msi_msix_flags_write(struct pci_dev *dev, int offset, u16 new_value,
+			 void *data)
+{
+	int err;
+	u16 old_value;
+	struct msi_msix_field_config *field_config = data;
+	struct xen_pcibk_dev_data *dev_data = pci_get_drvdata(dev);
+	int other_cap_offset;
+	u16 other_cap_enable_bit;
+	u16 other_cap_value;
+
+	if (xen_pcibk_permissive || dev_data->permissive)
+		goto write;
+
+	err = pci_read_config_word(dev, offset, &old_value);
+	if (err)
+		return err;
+
+	if (new_value == old_value)
+		return 0;
+
+	if (!dev_data->allow_interrupt_control ||
+	    (new_value ^ old_value) & ~field_config->enable_bit)
+		return PCIBIOS_SET_FAILED;
+
+	if (new_value & field_config->enable_bit) {
+		/* don't allow enabling together with INTx */
+		err = pci_read_config_word(dev, PCI_COMMAND, &other_cap_value);
+		if (err)
+			return err;
+		if (!(other_cap_value & PCI_COMMAND_INTX_DISABLE))
+			return PCIBIOS_SET_FAILED;
+
+		/* and the other MSI(-X) */
+		switch (field_config->other_cap) {
+		case PCI_CAP_ID_MSI:
+			other_cap_offset = dev->msi_cap + PCI_MSI_FLAGS;
+			other_cap_enable_bit = PCI_MSI_FLAGS_ENABLE;
+			break;
+		case PCI_CAP_ID_MSIX:
+			other_cap_offset = dev->msix_cap + PCI_MSIX_FLAGS;
+			other_cap_enable_bit = PCI_MSIX_FLAGS_ENABLE;
+			break;
+		default:
+			BUG_ON(1);
+		}
+		err = pci_read_config_word(dev,
+					   other_cap_offset,
+					   &other_cap_value);
+		if (err)
+			return err;
+
+		if (other_cap_value & other_cap_enable_bit)
+			return PCIBIOS_SET_FAILED;
+	}
+
+write:
+	return pci_write_config_word(dev, offset, new_value);
+}
+
+static const struct config_field caplist_msix[] = {
+	{
+		.offset    = PCI_MSIX_FLAGS,
+		.size      = 2,
+		.init      = msix_field_init,
+		.u.w.read  = xen_pcibk_read_config_word,
+		.u.w.write = msi_msix_flags_write,
+	},
+	{}
+};
+
+static const struct config_field caplist_msi[] = {
+	{
+		.offset    = PCI_MSI_FLAGS,
+		.size      = 2,
+		.init      = msi_field_init,
+		.u.w.read  = xen_pcibk_read_config_word,
+		.u.w.write = msi_msix_flags_write,
+	},
+	{}
+};
+
 static struct xen_pcibk_config_capability xen_pcibk_config_capability_pm = {
 	.capability = PCI_CAP_ID_PM,
 	.fields = caplist_pm,
@@ -197,11 +300,21 @@ static struct xen_pcibk_config_capability xen_pcibk_config_capability_vpd = {
 	.capability = PCI_CAP_ID_VPD,
 	.fields = caplist_vpd,
 };
+static struct xen_pcibk_config_capability xen_pcibk_config_capability_msi = {
+	.capability = PCI_CAP_ID_MSI,
+	.fields = caplist_msi,
+};
+static struct xen_pcibk_config_capability xen_pcibk_config_capability_msix = {
+	.capability = PCI_CAP_ID_MSIX,
+	.fields = caplist_msix,
+};
 
 int xen_pcibk_config_capability_init(void)
 {
 	register_capability(&xen_pcibk_config_capability_vpd);
 	register_capability(&xen_pcibk_config_capability_pm);
+	register_capability(&xen_pcibk_config_capability_msi);
+	register_capability(&xen_pcibk_config_capability_msix);
 
 	return 0;
 }
diff --git a/drivers/xen/xen-pciback/conf_space_header.c b/drivers/xen/xen-pciback/conf_space_header.c
index 10ae24b5a76e..1e0fff02e21b 100644
--- a/drivers/xen/xen-pciback/conf_space_header.c
+++ b/drivers/xen/xen-pciback/conf_space_header.c
@@ -64,6 +64,7 @@ static int command_write(struct pci_dev *dev, int offset, u16 value, void *data)
 	int err;
 	u16 val;
 	struct pci_cmd_info *cmd = data;
+	u16 cap_value;
 
 	dev_data = pci_get_drvdata(dev);
 	if (!pci_is_enabled(dev) && is_enable_cmd(value)) {
@@ -117,6 +118,35 @@ static int command_write(struct pci_dev *dev, int offset, u16 value, void *data)
 		pci_clear_mwi(dev);
 	}
 
+	if (dev_data && dev_data->allow_interrupt_control) {
+		if (!(cmd->val & PCI_COMMAND_INTX_DISABLE) &&
+		    (value & PCI_COMMAND_INTX_DISABLE)) {
+			pci_intx(dev, 0);
+		} else if ((cmd->val & PCI_COMMAND_INTX_DISABLE) &&
+		    !(value & PCI_COMMAND_INTX_DISABLE)) {
+			/* Do not allow enabling INTx together with MSI or MSI-X. */
+			/* Do not trust dev->msi(x)_enabled here, as enabling could be done
+			 * bypassing the pci_*msi* functions, by the qemu.
+			 */
+			err = pci_read_config_word(dev,
+						   dev->msi_cap + PCI_MSI_FLAGS,
+						   &cap_value);
+			if (!err && (cap_value & PCI_MSI_FLAGS_ENABLE))
+				err = -EBUSY;
+			if (!err)
+				err = pci_read_config_word(dev,
+							   dev->msix_cap + PCI_MSIX_FLAGS,
+							   &cap_value);
+			if (!err && (cap_value & PCI_MSIX_FLAGS_ENABLE))
+				err = -EBUSY;
+			if (err)
+				pr_warn("%s: cannot enable INTx (%d)\n",
+					pci_name(dev), err);
+			else
+				pci_intx(dev, 1);
+		}
+	}
+
 	cmd->val = value;
 
 	if (!xen_pcibk_permissive && (!dev_data || !dev_data->permissive))
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 097410a7cdb7..7af93d65ed51 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -304,6 +304,8 @@ void pcistub_put_pci_dev(struct pci_dev *dev)
 	xen_pcibk_config_reset_dev(dev);
 	xen_pcibk_config_free_dyn_fields(dev);
 
+	dev_data->allow_interrupt_control = 0;
+
 	xen_unregister_device_domain_owner(dev);
 
 	spin_lock_irqsave(&found_psdev->lock, flags);
@@ -1431,6 +1433,65 @@ static ssize_t permissive_show(struct device_driver *drv, char *buf)
 }
 static DRIVER_ATTR_RW(permissive);
 
+static ssize_t allow_interrupt_control_store(struct device_driver *drv,
+					     const char *buf, size_t count)
+{
+	int domain, bus, slot, func;
+	int err;
+	struct pcistub_device *psdev;
+	struct xen_pcibk_dev_data *dev_data;
+
+	err = str_to_slot(buf, &domain, &bus, &slot, &func);
+	if (err)
+		goto out;
+
+	psdev = pcistub_device_find(domain, bus, slot, func);
+	if (!psdev) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	dev_data = pci_get_drvdata(psdev->dev);
+	/* the driver data for a device should never be null at this point */
+	if (!dev_data) {
+		err = -ENXIO;
+		goto release;
+	}
+	dev_data->allow_interrupt_control = 1;
+release:
+	pcistub_device_put(psdev);
+out:
+	if (!err)
+		err = count;
+	return err;
+}
+
+static ssize_t allow_interrupt_control_show(struct device_driver *drv,
+					    char *buf)
+{
+	struct pcistub_device *psdev;
+	struct xen_pcibk_dev_data *dev_data;
+	size_t count = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pcistub_devices_lock, flags);
+	list_for_each_entry(psdev, &pcistub_devices, dev_list) {
+		if (count >= PAGE_SIZE)
+			break;
+		if (!psdev->dev)
+			continue;
+		dev_data = pci_get_drvdata(psdev->dev);
+		if (!dev_data || !dev_data->allow_interrupt_control)
+			continue;
+		count +=
+		    scnprintf(buf + count, PAGE_SIZE - count, "%s\n",
+			      pci_name(psdev->dev));
+	}
+	spin_unlock_irqrestore(&pcistub_devices_lock, flags);
+	return count;
+}
+static DRIVER_ATTR_RW(allow_interrupt_control);
+
 static void pcistub_exit(void)
 {
 	driver_remove_file(&xen_pcibk_pci_driver.driver, &driver_attr_new_slot);
@@ -1440,6 +1501,8 @@ static void pcistub_exit(void)
 	driver_remove_file(&xen_pcibk_pci_driver.driver, &driver_attr_quirks);
 	driver_remove_file(&xen_pcibk_pci_driver.driver,
 			   &driver_attr_permissive);
+	driver_remove_file(&xen_pcibk_pci_driver.driver,
+			   &driver_attr_allow_interrupt_control);
 	driver_remove_file(&xen_pcibk_pci_driver.driver,
 			   &driver_attr_irq_handlers);
 	driver_remove_file(&xen_pcibk_pci_driver.driver,
@@ -1530,6 +1593,9 @@ static int __init pcistub_init(void)
 	if (!err)
 		err = driver_create_file(&xen_pcibk_pci_driver.driver,
 					 &driver_attr_permissive);
+	if (!err)
+		err = driver_create_file(&xen_pcibk_pci_driver.driver,
+					 &driver_attr_allow_interrupt_control);
 
 	if (!err)
 		err = driver_create_file(&xen_pcibk_pci_driver.driver,
diff --git a/drivers/xen/xen-pciback/pciback.h b/drivers/xen/xen-pciback/pciback.h
index 263c059bff90..ce1077e32466 100644
--- a/drivers/xen/xen-pciback/pciback.h
+++ b/drivers/xen/xen-pciback/pciback.h
@@ -45,6 +45,7 @@ struct xen_pcibk_dev_data {
 	struct list_head config_fields;
 	struct pci_saved_state *pci_saved_state;
 	unsigned int permissive:1;
+	unsigned int allow_interrupt_control:1;
 	unsigned int warned_on_write:1;
 	unsigned int enable_intx:1;
 	unsigned int isr_on:1; /* Whether the IRQ handler is installed. */
-- 
2.21.0

