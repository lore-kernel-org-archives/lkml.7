Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC0EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EB3206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="SsbgzfND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfLCPRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:17:41 -0500
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:61252 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCPRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1575386260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UYLHBfPc9AGAfPl7TcZxUSTDCuObwRSXAKfI4wJZ6jU=;
  b=SsbgzfNDuc54cBK5uqtLbHaMJJXBLnOGBjHTp8mgQLsufnS9g+3p2KQq
   yfZsE9t/Si/9AVqQUhl6Jum8mRgBf8T82+AZwFVMk5LvA8TN3cba0zxBb
   dEHgwbG2PZh8VDp2ZSc87DxuRWxLYKPnzK6lwTFFwIRAHYnSAvTa1Az1a
   4=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: QvJG6ritkmtOG2ysPUvrVwQjr5f5ODarr/6EIlWR6DIhTyDm2XVZQeFxfIqKMoZ3nGBpRUwpJD
 c3BebJNh19/tG0f32yYlK8tKVZxzfg4GxVJSx6xeiEgqxjpH+1X49DZ/nTC72OL6laolOXuHIG
 vcbHiyFVnevrBit/ns0YG0rtbOh18lsb0OB95E+8I862krnu7LX62bJHaBKISkmgk4gZV+tcdi
 kAvCuzkQJanue6SG/0RBwHb8dIi+u9VoMZOueja7Vc+Lj3hDk0HYwymmU/IFMgV+mHiy18Nq71
 YxY=
X-SBRS: 2.7
X-MesageID: 9676871
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,273,1571716800"; 
   d="scan'208";a="9676871"
Date:   Tue, 3 Dec 2019 16:17:33 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>
CC:     <xen-devel@lists.xenproject.org>, Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        "open list" <linux-kernel@vger.kernel.org>,
        Simon Gaiser <simon@invisiblethingslab.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH v1] xen-pciback: optionally allow interrupt
 enable flag writes
Message-ID: <20191203151733.GF980@Air-de-Roger>
References: <20191203054222.7966-1-marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191203054222.7966-1-marmarek@invisiblethingslab.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 06:41:56AM +0100, Marek Marczykowski-Górecki wrote:
> QEMU running in a stubdom needs to be able to set INTX_DISABLE, and the
> MSI(-X) enable flags in the PCI config space. This adds an attribute
> 'allow_interrupt_control' which when set for a PCI device allows writes
> to this flag(s). The toolstack will need to set this for stubdoms.
> When enabled, guest (stubdomain) will be allowed to set relevant enable
> flags, but only one at a time - i.e. it refuses to enable more than one
> of INTx, MSI, MSI-X at a time.
> 
> This functionality is needed only for config space access done by device
> model (stubdomain) serving a HVM with the actual PCI device. It is not
> necessary and unsafe to enable direct access to those bits for PV domain
> with the device attached. For PV domains, there are separate protocol
> messages (XEN_PCI_OP_{enable,disable}_{msi,msix}) for this purpose.
> Those ops in addition to setting enable bits, also configure MSI(-X) in
> dom0 kernel - which is undesirable for PCI passthrough to HVM guests.
> 
> This should not introduce any new security issues since a malicious
> guest (or stubdom) can already generate MSIs through other ways, see
> [1] page 8. Additionally, when qemu runs in dom0, it already have direct
> access to those bits.
> 
> This is the second iteration of this feature. First was proposed as a
> direct Xen interface through a new hypercall, but ultimately it was
> rejected by the maintainer, because of mixing pciback and hypercalls for
> PCI config space access isn't a good design. Full discussion at [2].
> 
> [1]: https://invisiblethingslab.com/resources/2011/Software%20Attacks%20on%20Intel%20VT-d.pdf
> [2]: https://xen.markmail.org/thread/smpgpws4umdzizze
> 
> [part of the commit message and sysfs handling]
> Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
> [the rest]
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> ---
> I'm not very happy about code duplication regarding MSI/MSI-X/INTx
> exclusivity test, but I don't have better ideas how to structure it. Any
> suggestions?

Can't you create a helper that returns the currently enabled interrupt
mode?

I expect returning an enum (ie: NONE, INTX, MSI, MSIX) should be fine
since no two of those should be enabled at the same time.

> ---
>  .../xen/xen-pciback/conf_space_capability.c   | 113 ++++++++++++++++++
>  drivers/xen/xen-pciback/conf_space_header.c   |  30 +++++
>  drivers/xen/xen-pciback/pci_stub.c            |  66 ++++++++++
>  drivers/xen/xen-pciback/pciback.h             |   1 +
>  4 files changed, 210 insertions(+)
> 
> diff --git a/drivers/xen/xen-pciback/conf_space_capability.c b/drivers/xen/xen-pciback/conf_space_capability.c
> index e5694133ebe5..c5a7c58ff3e3 100644
> --- a/drivers/xen/xen-pciback/conf_space_capability.c
> +++ b/drivers/xen/xen-pciback/conf_space_capability.c
> @@ -189,6 +189,109 @@ static const struct config_field caplist_pm[] = {
>  	{}
>  };
>  
> +static struct msi_msix_field_config {
> +	u16 enable_bit;  /* bit for enabling MSI/MSI-X */
> +	int other_cap;  /* the other capability for exclusiveness check */

Nit: just one space between the declaration and the comment IMO.

Also capability ID is not a signed value, hence unsigned int would
feel more natural.

> +} msi_field_config = {
> +	.enable_bit = PCI_MSI_FLAGS_ENABLE,
> +	.other_cap = PCI_CAP_ID_MSIX,
> +}, msix_field_config = {
> +	.enable_bit = PCI_MSIX_FLAGS_ENABLE,
> +	.other_cap = PCI_CAP_ID_MSI,
> +};

I think it would be more helpful to store the current capability ID
rather the one you need to check against. Then if you had a helper
that returns the currently enabled interrupt mode you would have to
check that either it's NONE or matches the capability requested to be
enabled.

> +
> +static void *msi_field_init(struct pci_dev *dev, int offset)
> +{
> +	return &msi_field_config;
> +}
> +
> +static void *msix_field_init(struct pci_dev *dev, int offset)
> +{
> +	return &msix_field_config;
> +}
> +
> +static int msi_msix_flags_write(struct pci_dev *dev, int offset, u16 new_value,
> +			 void *data)
> +{
> +	int err;
> +	u16 old_value;
> +	struct msi_msix_field_config *field_config = data;
> +	struct xen_pcibk_dev_data *dev_data = pci_get_drvdata(dev);

const for both the above.

> +	int other_cap_offset;

unsigned int

> +	u16 other_cap_enable_bit;
> +	u16 other_cap_value;
> +
> +	if (xen_pcibk_permissive || dev_data->permissive)
> +		goto write;
> +
> +	err = pci_read_config_word(dev, offset, &old_value);
> +	if (err)
> +		return err;
> +
> +	if (new_value == old_value)
> +		return 0;
> +
> +	if (!dev_data->allow_interrupt_control ||
> +	    (new_value ^ old_value) & ~field_config->enable_bit)
> +		return PCIBIOS_SET_FAILED;
> +
> +	if (new_value & field_config->enable_bit) {
> +		/* don't allow enabling together with INTx */
> +		err = pci_read_config_word(dev, PCI_COMMAND, &other_cap_value);
> +		if (err)
> +			return err;
> +		if (!(other_cap_value & PCI_COMMAND_INTX_DISABLE))
> +			return PCIBIOS_SET_FAILED;
> +
> +		/* and the other MSI(-X) */
> +		switch (field_config->other_cap) {
> +		case PCI_CAP_ID_MSI:
> +			other_cap_offset = dev->msi_cap + PCI_MSI_FLAGS;
> +			other_cap_enable_bit = PCI_MSI_FLAGS_ENABLE;
> +			break;
> +		case PCI_CAP_ID_MSIX:
> +			other_cap_offset = dev->msix_cap + PCI_MSIX_FLAGS;
> +			other_cap_enable_bit = PCI_MSIX_FLAGS_ENABLE;
> +			break;

I think you should check whether the other capability exists. I guess
msi{x}_cap will be 0 if not present?

> +		default:
> +			BUG_ON(1);

Doesn't Linux have a plain BUG();?

> +		}
> +		err = pci_read_config_word(dev,
> +					   other_cap_offset,
> +					   &other_cap_value);
> +		if (err)
> +			return err;
> +
> +		if (other_cap_value & other_cap_enable_bit)
> +			return PCIBIOS_SET_FAILED;
> +	}
> +
> +write:
> +	return pci_write_config_word(dev, offset, new_value);
> +}
> +
> +static const struct config_field caplist_msix[] = {
> +	{
> +		.offset    = PCI_MSIX_FLAGS,
> +		.size      = 2,
> +		.init      = msix_field_init,
> +		.u.w.read  = xen_pcibk_read_config_word,
> +		.u.w.write = msi_msix_flags_write,
> +	},
> +	{}
> +};
> +
> +static const struct config_field caplist_msi[] = {
> +	{
> +		.offset    = PCI_MSI_FLAGS,
> +		.size      = 2,
> +		.init      = msi_field_init,
> +		.u.w.read  = xen_pcibk_read_config_word,
> +		.u.w.write = msi_msix_flags_write,
> +	},
> +	{}
> +};
> +
>  static struct xen_pcibk_config_capability xen_pcibk_config_capability_pm = {
>  	.capability = PCI_CAP_ID_PM,
>  	.fields = caplist_pm,
> @@ -197,11 +300,21 @@ static struct xen_pcibk_config_capability xen_pcibk_config_capability_vpd = {
>  	.capability = PCI_CAP_ID_VPD,
>  	.fields = caplist_vpd,
>  };
> +static struct xen_pcibk_config_capability xen_pcibk_config_capability_msi = {
> +	.capability = PCI_CAP_ID_MSI,
> +	.fields = caplist_msi,
> +};
> +static struct xen_pcibk_config_capability xen_pcibk_config_capability_msix = {
> +	.capability = PCI_CAP_ID_MSIX,
> +	.fields = caplist_msix,
> +};
>  
>  int xen_pcibk_config_capability_init(void)
>  {
>  	register_capability(&xen_pcibk_config_capability_vpd);
>  	register_capability(&xen_pcibk_config_capability_pm);
> +	register_capability(&xen_pcibk_config_capability_msi);
> +	register_capability(&xen_pcibk_config_capability_msix);
>  
>  	return 0;
>  }
> diff --git a/drivers/xen/xen-pciback/conf_space_header.c b/drivers/xen/xen-pciback/conf_space_header.c
> index 10ae24b5a76e..1e0fff02e21b 100644
> --- a/drivers/xen/xen-pciback/conf_space_header.c
> +++ b/drivers/xen/xen-pciback/conf_space_header.c
> @@ -64,6 +64,7 @@ static int command_write(struct pci_dev *dev, int offset, u16 value, void *data)
>  	int err;
>  	u16 val;
>  	struct pci_cmd_info *cmd = data;
> +	u16 cap_value;
>  
>  	dev_data = pci_get_drvdata(dev);
>  	if (!pci_is_enabled(dev) && is_enable_cmd(value)) {
> @@ -117,6 +118,35 @@ static int command_write(struct pci_dev *dev, int offset, u16 value, void *data)
>  		pci_clear_mwi(dev);
>  	}
>  
> +	if (dev_data && dev_data->allow_interrupt_control) {
> +		if (!(cmd->val & PCI_COMMAND_INTX_DISABLE) &&
> +		    (value & PCI_COMMAND_INTX_DISABLE)) {
> +			pci_intx(dev, 0);
> +		} else if ((cmd->val & PCI_COMMAND_INTX_DISABLE) &&
> +		    !(value & PCI_COMMAND_INTX_DISABLE)) {
> +			/* Do not allow enabling INTx together with MSI or MSI-X. */
> +			/* Do not trust dev->msi(x)_enabled here, as enabling could be done
> +			 * bypassing the pci_*msi* functions, by the qemu.
> +			 */
> +			err = pci_read_config_word(dev,
> +						   dev->msi_cap + PCI_MSI_FLAGS,
> +						   &cap_value);
> +			if (!err && (cap_value & PCI_MSI_FLAGS_ENABLE))
> +				err = -EBUSY;
> +			if (!err)
> +				err = pci_read_config_word(dev,
> +							   dev->msix_cap + PCI_MSIX_FLAGS,
> +							   &cap_value);
> +			if (!err && (cap_value & PCI_MSIX_FLAGS_ENABLE))
> +				err = -EBUSY;

Shouldn't this return PCI-style errors?

I think PCIBIOS_SET_FAILED would be more appropriate here. Note sure
whether you should terminate the function here in that case, or else
the error is lost and not returned to the caller, yet the function
failed at least partially.

> +			if (err)
> +				pr_warn("%s: cannot enable INTx (%d)\n",

This should be ratelimited since it's guest triggerable.

> +					pci_name(dev), err);
> +			else
> +				pci_intx(dev, 1);
> +		}
> +	}
> +
>  	cmd->val = value;
>  
>  	if (!xen_pcibk_permissive && (!dev_data || !dev_data->permissive))
> diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
> index 097410a7cdb7..7af93d65ed51 100644
> --- a/drivers/xen/xen-pciback/pci_stub.c
> +++ b/drivers/xen/xen-pciback/pci_stub.c
> @@ -304,6 +304,8 @@ void pcistub_put_pci_dev(struct pci_dev *dev)
>  	xen_pcibk_config_reset_dev(dev);
>  	xen_pcibk_config_free_dyn_fields(dev);
>  
> +	dev_data->allow_interrupt_control = 0;

Why do you need to do this here? I don't see any other options being
cleared here (I would expect for example permissive to also be
cleared if required).

> +
>  	xen_unregister_device_domain_owner(dev);
>  
>  	spin_lock_irqsave(&found_psdev->lock, flags);
> @@ -1431,6 +1433,65 @@ static ssize_t permissive_show(struct device_driver *drv, char *buf)
>  }
>  static DRIVER_ATTR_RW(permissive);
>  
> +static ssize_t allow_interrupt_control_store(struct device_driver *drv,
> +					     const char *buf, size_t count)
> +{
> +	int domain, bus, slot, func;
> +	int err;
> +	struct pcistub_device *psdev;
> +	struct xen_pcibk_dev_data *dev_data;
> +
> +	err = str_to_slot(buf, &domain, &bus, &slot, &func);
> +	if (err)
> +		goto out;
> +
> +	psdev = pcistub_device_find(domain, bus, slot, func);
> +	if (!psdev) {
> +		err = -ENODEV;
> +		goto out;
> +	}
> +
> +	dev_data = pci_get_drvdata(psdev->dev);
> +	/* the driver data for a device should never be null at this point */
> +	if (!dev_data) {
> +		err = -ENXIO;
> +		goto release;
> +	}
> +	dev_data->allow_interrupt_control = 1;
> +release:
> +	pcistub_device_put(psdev);
> +out:
> +	if (!err)
> +		err = count;
> +	return err;
> +}
> +
> +static ssize_t allow_interrupt_control_show(struct device_driver *drv,
> +					    char *buf)
> +{
> +	struct pcistub_device *psdev;
> +	struct xen_pcibk_dev_data *dev_data;
> +	size_t count = 0;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pcistub_devices_lock, flags);
> +	list_for_each_entry(psdev, &pcistub_devices, dev_list) {
> +		if (count >= PAGE_SIZE)
> +			break;
> +		if (!psdev->dev)
> +			continue;
> +		dev_data = pci_get_drvdata(psdev->dev);
> +		if (!dev_data || !dev_data->allow_interrupt_control)
> +			continue;
> +		count +=
> +		    scnprintf(buf + count, PAGE_SIZE - count, "%s\n",
> +			      pci_name(psdev->dev));
> +	}
> +	spin_unlock_irqrestore(&pcistub_devices_lock, flags);
> +	return count;
> +}
> +static DRIVER_ATTR_RW(allow_interrupt_control);

This is mostly a clone of permissive_{store/show}, I wonder if those
functions could be generalized since it's just repeated boilerplate
code in order to fetch allow_interrupt_control or permissive. Anyway,
likely not part of this patch.

Thanks, Roger.
