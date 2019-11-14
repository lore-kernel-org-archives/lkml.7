Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AD6C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B587206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfKNQx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 11:53:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:42134 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbfKNQx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:53:27 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 08:53:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208,223";a="214575460"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 14 Nov 2019 08:53:23 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 14 Nov 2019 18:53:22 +0200
Date:   Thu, 14 Nov 2019 18:53:22 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jon Flatley <jflat@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bleung@chromium.org,
        groeck@chromium.org, sre@kernel.org
Subject: Re: [PATCH 3/3] platform: chrome: Added cros-ec-typec driver
Message-ID: <20191114165322.GE4013@kuha.fi.intel.com>
References: <20191113031044.136232-1-jflat@chromium.org>
 <20191113031044.136232-4-jflat@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191113031044.136232-4-jflat@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Nov 12, 2019 at 07:10:44PM -0800, Jon Flatley wrote:
> Adds the cros-ec-typec driver for implementing the USB Type-C connector
> class for cros-ec devices.
> 
> Signed-off-by: Jon Flatley <jflat@chromium.org>
> ---
>  drivers/mfd/cros_ec_dev.c               |   7 +-
>  drivers/platform/chrome/Kconfig         |  11 +
>  drivers/platform/chrome/Makefile        |   1 +
>  drivers/platform/chrome/cros_ec_typec.c | 457 ++++++++++++++++++++++++
>  4 files changed, 473 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/platform/chrome/cros_ec_typec.c
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 6e6dfd6c1871..1136ef986695 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -78,9 +78,10 @@ static const struct mfd_cell cros_ec_rtc_cells[] = {
>  	{ .name = "cros-ec-rtc", },
>  };
>  
> -static const struct mfd_cell cros_usbpd_charger_cells[] = {
> +static const struct mfd_cell cros_usbpd_cells[] = {
>  	{ .name = "cros-usbpd-charger", },
>  	{ .name = "cros-usbpd-logger", },
> +	{ .name = "cros-ec-typec" },
>  };
>  
>  static const struct cros_feature_to_cells cros_subdevices[] = {
> @@ -96,8 +97,8 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
>  	},
>  	{
>  		.id		= EC_FEATURE_USB_PD,
> -		.mfd_cells	= cros_usbpd_charger_cells,
> -		.num_cells	= ARRAY_SIZE(cros_usbpd_charger_cells),
> +		.mfd_cells	= cros_usbpd_cells,
> +		.num_cells	= ARRAY_SIZE(cros_usbpd_cells),
>  	},
>  };
>  
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index d4a55b64bc29..1be5c86f2aad 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -210,6 +210,17 @@ config CROS_EC_SYSFS
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cros_ec_sysfs.
>  
> +config CROS_EC_TYPEC
> +	tristate "ChromeOS Embedded Controller USB Type-C class subdriver"
> +	depends on TYPEC && CROS_EC_USBPD_NOTIFY
> +	default n
> +	help
> +	  Say Y here to enable the USB Type-C class subdriver for ChromeOS
> +	  devices.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called cros-ec-typec.
> +
>  config CROS_USBPD_LOGGER
>  	tristate "Logging driver for USB PD charger"
>  	depends on CHARGER_CROS_USBPD
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index efa355ab526f..bb298c083f1e 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -22,5 +22,6 @@ obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
>  obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
>  obj-$(CONFIG_CROS_USBPD_LOGGER)		+= cros_usbpd_logger.o
>  obj-$(CONFIG_CROS_EC_USBPD_NOTIFY)      += cros_ec_usbpd_notify.o
> +obj-$(CONFIG_CROS_EC_TYPEC) 		+= cros_ec_typec.o
>  
>  obj-$(CONFIG_WILCO_EC)			+= wilco_ec/
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> new file mode 100644
> index 000000000000..262b914f0a2e
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -0,0 +1,457 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * cros_ec_usbpd - ChromeOS EC Power Delivery Driver
> + *
> + * Copyright (C) 2019 Google, Inc
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/kthread.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_usbpd_notify.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/usb/typec.h>
> +#include <linux/slab.h>
> +
> +#define DRV_NAME "cros-ec-typec"
> +
> +struct port_data {
> +	int port_num;
> +	struct typec_port *port;
> +	struct typec_partner *partner;
> +	struct usb_pd_identity p_identity;
> +	struct typec_data *typec;
> +	struct typec_capability caps;
> +};
> +
> +struct typec_data {
> +	struct device *dev;
> +	struct cros_ec_dev *ec_dev;
> +	struct port_data *ports[EC_USB_PD_MAX_PORTS];
> +	unsigned int num_ports;
> +	struct notifier_block notifier;
> +
> +	int (*port_update)(struct typec_data *typec, int port_num);
> +};
> +
> +#define caps_to_port_data(_caps_) container_of(_caps_, struct port_data, caps)
> +
> +static int cros_typec_ec_command(struct typec_data *typec,
> +				 unsigned int version,
> +				 unsigned int command,
> +				 void *outdata,
> +				 unsigned int outsize,
> +				 void *indata,
> +				 unsigned int insize)
> +{
> +	struct cros_ec_dev *ec_dev = typec->ec_dev;
> +	struct cros_ec_command *msg;
> +	int ret;
> +	char host_cmd[32];
> +
> +	msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	msg->version = version;
> +	msg->command = ec_dev->cmd_offset + command;
> +	msg->outsize = outsize;
> +	msg->insize = insize;
> +
> +	if (outsize)
> +		memcpy(msg->data, outdata, outsize);
> +
> +	sprintf(host_cmd, "typec HC 0x%x req: ", command);
> +	print_hex_dump(KERN_DEBUG, host_cmd, DUMP_PREFIX_NONE, 16, 1, outdata,
> +			outsize, 0);
> +
> +	ret = cros_ec_cmd_xfer_status(typec->ec_dev->ec_dev, msg);
> +	if (ret >= 0 && insize)
> +		memcpy(indata, msg->data, insize);
> +	sprintf(host_cmd, "typec HC 0x%x res: ", command);
> +	print_hex_dump(KERN_DEBUG, host_cmd, DUMP_PREFIX_NONE, 16, 1, indata,
> +			insize, 0);
> +
> +	kfree(msg);
> +	return ret;
> +}
> +
> +static int cros_typec_get_cmd_version(struct typec_data *typec, int cmd,
> +		uint8_t *version_mask)
> +{
> +	struct ec_params_get_cmd_versions req_v0;
> +	struct ec_params_get_cmd_versions_v1 req_v1;
> +	struct ec_response_get_cmd_versions res;
> +	int ret;
> +
> +	req_v1.cmd = cmd;
> +	ret = cros_typec_ec_command(typec, 1, EC_CMD_GET_CMD_VERSIONS, &req_v1,
> +			sizeof(req_v1), &res, sizeof(res));
> +	if (ret < 0) {
> +		req_v0.cmd = cmd;
> +		ret = cros_typec_ec_command(typec, 0, EC_CMD_GET_CMD_VERSIONS,
> +				&req_v0, sizeof(req_v0), &res, sizeof(res));
> +		if (ret < 0)
> +			return ret;
> +	}
> +	*version_mask = res.version_mask;
> +	dev_dbg(typec->dev, "EC CMD 0x%hhx has version mask 0x%hhx\n", cmd,
> +			*version_mask);
> +	return 0;
> +}
> +
> +static int cros_typec_query_pd_port_count(struct typec_data *typec)
> +{
> +	struct ec_response_usb_pd_ports res;
> +	int ret;
> +
> +	ret = cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
> +			&res, sizeof(res));
> +	if (ret < 0)
> +		return ret;
> +	typec->num_ports = res.num_ports;
> +	return 0;
> +}
> +
> +static int cros_typec_port_update(struct typec_data *typec,
> +				  int port_num,
> +				  struct ec_response_usb_pd_control *res,
> +				  size_t res_size,
> +				  int cmd_ver)
> +{
> +	struct port_data *port;
> +	struct ec_params_usb_pd_control req;
> +	int ret;
> +
> +	if (port_num < 0 || port_num >= typec->num_ports) {
> +		dev_err(typec->dev, "cannot get status for invalid port %d\n",
> +				port_num);
> +		return -EPERM;
> +	}
> +	port = typec->ports[port_num];
> +
> +	req.port = port_num;
> +	req.role = USB_PD_CTRL_ROLE_NO_CHANGE;
> +	req.mux = USB_PD_CTRL_MUX_NO_CHANGE;
> +	req.swap = USB_PD_CTRL_SWAP_NONE;

Unless I'm mistaken, those constants are all 0. How about this:

	struct ec_params_usb_pd_control req = { };
        ...
        req.port = port_num;

> +	ret = cros_typec_ec_command(typec, cmd_ver, EC_CMD_USB_PD_CONTROL, &req,
> +			sizeof(req), res, res_size);
> +	if (ret < 0)
> +		return ret;
> +	dev_dbg(typec->dev, "Enabled %d: 0x%hhx\n", port_num, res->enabled);
> +	dev_dbg(typec->dev, "Role %d: 0x%hhx\n", port_num, res->role);
> +	dev_dbg(typec->dev, "Polarity %d: 0x%hhx\n", port_num, res->polarity);
> +
> +	return 0;
> +}
> +
> +static int cros_typec_query_pd_info(struct typec_data *typec, int port_num)
> +{
> +	struct ec_params_usb_pd_info_request req;
> +	struct ec_params_usb_pd_discovery_entry res;
> +	int ret;
> +
> +	req.port = port_num;
> +	ret = cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_DISCOVERY, &req,
> +			sizeof(req), &res, sizeof(res));
> +	if (ret < 0)
> +		return ret;
> +	/* FIXME Needs the rest of the info in PD Spec 6.4.4.3.1.1 */
> +	typec->ports[port_num]->p_identity.id_header = res.vid;
> +
> +	/* FIXME Needs bcdDevice to match PD Spec 6.4.4.3.1.3 */
> +	typec->ports[port_num]->p_identity.product = res.pid << 16;
> +	return 0;
> +}
> +
> +static int cros_typec_port_update_v0(struct typec_data *typec, int port_num)
> +{
> +	struct port_data *port;
> +	struct ec_response_usb_pd_control res;
> +	enum typec_orientation polarity;
> +	int ret;
> +
> +	port = typec->ports[port_num];
> +	ret = cros_typec_port_update(typec, port_num, &res, sizeof(res), 0);
> +	if (ret < 0)
> +		return ret;
> +	dev_dbg(typec->dev, "State %d: %hhx\n", port_num, res.state);
> +
> +	if (!res.enabled)
> +		polarity = TYPEC_ORIENTATION_NONE;
> +	else if (!res.polarity)
> +		polarity = TYPEC_ORIENTATION_NORMAL;
> +	else
> +		polarity = TYPEC_ORIENTATION_REVERSE;
> +
> +	typec_set_pwr_role(port->port, res.role ? TYPEC_SOURCE : TYPEC_SINK);
> +	typec_set_orientation(port->port, polarity);
> +
> +	return 0;
> +}
> +
> +static int cros_typec_add_partner(struct typec_data *typec, int port_num,
> +		bool pd_enabled)
> +{
> +	struct port_data *port;
> +	struct typec_partner_desc p_desc;
> +	int ret;
> +
> +	port = typec->ports[port_num];
> +	p_desc.usb_pd = pd_enabled;
> +	p_desc.identity = &port->p_identity;
> +
> +	port->partner = typec_register_partner(port->port, &p_desc);
> +	if (IS_ERR_OR_NULL(port->partner)) {
> +		dev_err(typec->dev, "Port %d partner register failed\n",
> +				port_num);
> +		port->partner = NULL;
> +		return PTR_ERR(port->partner);

That is the same as:
                return PTR_ERR(NULL);

> +	}
> +
> +	ret = cros_typec_query_pd_info(typec, port_num);
> +	if (ret < 0) {
> +		dev_err(typec->dev, "Port %d PD query failed\n", port_num);
> +		typec_unregister_partner(port->partner);
> +		port->partner = NULL;
> +		return ret;
> +	}
> +
> +	ret = typec_partner_set_identity(port->partner);
> +	return ret;
> +}
> +
> +static int cros_typec_set_port_params_v1_v2(struct typec_data *typec,
> +		int port_num, struct ec_response_usb_pd_control_v1 *res)
> +{
> +	struct port_data *port;
> +	enum typec_orientation polarity;
> +	int ret;
> +
> +	port = typec->ports[port_num];
> +	if (!(res->enabled & PD_CTRL_RESP_ENABLED_CONNECTED))
> +		polarity = TYPEC_ORIENTATION_NONE;
> +	else if (!res->polarity)
> +		polarity = TYPEC_ORIENTATION_NORMAL;
> +	else
> +		polarity = TYPEC_ORIENTATION_REVERSE;
> +	typec_set_orientation(port->port, polarity);
> +	typec_set_data_role(port->port, res->role & PD_CTRL_RESP_ROLE_DATA ?
> +			TYPEC_HOST : TYPEC_DEVICE);
> +	typec_set_pwr_role(port->port, res->role & PD_CTRL_RESP_ROLE_POWER ?
> +			TYPEC_SOURCE : TYPEC_SINK);
> +	typec_set_vconn_role(port->port, res->role & PD_CTRL_RESP_ROLE_VCONN ?
> +			TYPEC_SOURCE : TYPEC_SINK);
> +
> +	if (res->enabled & PD_CTRL_RESP_ENABLED_CONNECTED && !port->partner) {
> +		bool pd_enabled =
> +			res->enabled & PD_CTRL_RESP_ENABLED_PD_CAPABLE;
> +		ret = cros_typec_add_partner(typec, port_num, pd_enabled);
> +		if (!ret)
> +			return ret;
> +	}
> +	if (!(res->enabled & PD_CTRL_RESP_ENABLED_CONNECTED) && port->partner) {
> +		typec_unregister_partner(port->partner);
> +		port->partner = NULL;
> +	}
> +	return 0;
> +}
> +
> +static int cros_typec_port_update_v1(struct typec_data *typec, int port_num)
> +{
> +	/*struct port_data *port;*/
> +	struct ec_response_usb_pd_control_v1 res;
> +	struct ec_response_usb_pd_control *res_v0 =
> +		(struct ec_response_usb_pd_control *) &res;
> +	int ret;
> +
> +	ret = cros_typec_port_update(typec, port_num, res_v0, sizeof(res), 1);
> +	if (ret < 0)
> +		return ret;
> +	dev_dbg(typec->dev, "State %d: %s\n", port_num, res.state);
> +
> +	ret = cros_typec_set_port_params_v1_v2(typec, port_num, &res);
> +	return ret;
> +}
> +
> +static int cros_typec_try_role(const struct typec_capability *cap, int role)
> +{
> +	return 0;
> +}
> +
> +static int cros_typec_dr_set(const struct typec_capability *cap,
> +		enum typec_data_role role)
> +{
> +	return 0;
> +}
> +
> +static int cros_typec_pr_set(const struct typec_capability *cap,
> +		enum typec_role role)
> +{
> +	return 0;
> +}
> +
> +static int cros_typec_vconn_set(const struct typec_capability *cap,
> +		enum typec_role role)
> +{
> +	return 0;
> +}

Those stubs are not needed.

> +static int cros_typec_ec_event(struct notifier_block *nb,
> +			       unsigned long queued_during_suspend,
> +			       void *_notify)
> +{
> +	struct typec_data *typec;
> +	int i;
> +
> +	typec = container_of(nb, struct typec_data, notifier);
> +
> +	for (i = 0; i < typec->num_ports; ++i)
> +		typec->port_update(typec, i);
> +
> +	return NOTIFY_DONE;
> +
> +}
> +
> +static void cros_typec_unregister_notifier(void *data)
> +{
> +	struct typec_data *typec = data;
> +
> +	cros_ec_usbpd_unregister_notify(&typec->notifier);
> +}
> +
> +static int cros_typec_probe(struct platform_device *pd)
> +{
> +	struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
> +	struct device *dev = &pd->dev;
> +	struct typec_data *typec;
> +	uint8_t ver_mask;
> +	int i;
> +	int ret;
> +
> +	dev_dbg(dev, "Probing Cros EC Type-C device.\n");
> +
> +	typec = devm_kzalloc(dev, sizeof(*typec), GFP_KERNEL);
> +	if (!typec)
> +		return -ENOMEM;
> +
> +	typec->dev = dev;
> +	typec->ec_dev = ec_dev;
> +
> +	platform_set_drvdata(pd, typec);
> +
> +	ret = cros_typec_query_pd_port_count(typec);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get PD port count from EC\n");
> +		return ret;
> +	}
> +	if (typec->num_ports > EC_USB_PD_MAX_PORTS) {
> +		dev_err(dev, "EC reported too many ports. got: %d, max: %d\n",
> +				typec->num_ports, EC_USB_PD_MAX_PORTS);
> +		return -EOVERFLOW;
> +	}

This step should to be done in the mfd driver. You can then register
a separate device for each port.

For exact hardware description you will need a software node that
represents the "port controller" that you'll give to this device. That
software node will need a child node named "connector" that represents
the Type-C connector. That child node has the actual capability
properties.

I just remembered that the MFD framework does not yet support software
nodes directly, but I have a patch for that. I'm attaching here.

For examples how to use software nodes you can check
drivers/platform/x86/intel_cht_int33fe_typec.c

Or if you prefer, I can also write the mfd patch for you?

> +	ret = cros_typec_get_cmd_version(typec, EC_CMD_USB_PD_CONTROL,
> +			&ver_mask);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get supported PD command versions\n");
> +		return ret;
> +	}
> +	/* No reason to support EC_CMD_USB_PD_CONTROL v2 as it doesn't add any
> +	 * useful information
> +	 */
> +	if (ver_mask & EC_VER_MASK(1)) {
> +		dev_dbg(dev, "Using PD command ver 1\n");
> +		typec->port_update = cros_typec_port_update_v1;
> +	} else {
> +		dev_dbg(dev, "Using PD command ver 0\n");
> +		typec->port_update = cros_typec_port_update_v0;
> +	}
> +
> +	for (i = 0; i < typec->num_ports; ++i) {

After there is a one device per port, this loop is of course no longer
needed. This driver just needs to know the port number that its port
has, and that it can get also from a device property. That property
you need to give to the parent software node that represents the
"port controller", so not the "connector" child node.

> +		struct port_data *port;
> +
> +		port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +		if (!port) {
> +			ret = -ENOMEM;
> +			goto unregister_ports;
> +		}
> +		port->typec = typec;
> +		port->port_num = i;
> +		typec->ports[i] = port;
> +
> +		/* TODO Make sure these values are accurate */
> +		port->caps.type = TYPEC_PORT_DRP;
> +		port->caps.data = TYPEC_PORT_DFP;
> +		port->caps.prefer_role = TYPEC_SINK;

These are details that we can get from the device properties.

> +		port->caps.try_role = cros_typec_try_role;
> +		port->caps.dr_set = cros_typec_dr_set;
> +		port->caps.pr_set = cros_typec_pr_set;
> +		port->caps.vconn_set = cros_typec_vconn_set;
> +		port->caps.port_type_set = NULL; /* Not permitted by PD spec */
> +
> +		port->port = typec_register_port(dev, &port->caps);
> +		if (IS_ERR_OR_NULL(port->port)) {
> +			dev_err(dev, "Failed to register typec port %d\n", i);
> +			ret = PTR_ERR(port->port);
> +			goto unregister_ports;
> +		}
> +
> +		ret = typec->port_update(typec, i);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to update typec port %d\n", i);
> +			goto unregister_ports;
> +		}
> +	}
> +
> +	typec->notifier.notifier_call = cros_typec_ec_event;
> +	ret = cros_ec_usbpd_register_notify(&typec->notifier);
> +	if (ret < 0) {
> +		dev_warn(dev, "Failed to register notifier\n");
> +	} else {
> +		ret = devm_add_action_or_reset(dev,
> +				cros_typec_unregister_notifier, typec);
> +		if (ret < 0)
> +			goto unregister_ports;
> +		dev_dbg(dev, "Registered EC notifier\n");
> +	}
> +
> +	return 0;
> +
> +unregister_ports:
> +	for (i = 0; i < typec->num_ports; ++i) {
> +		if (typec->ports[i] && typec->ports[i]->port)
> +			typec_unregister_port(typec->ports[i]->port);
> +	}
> +
> +	return ret;
> +}
> +
> +static struct platform_driver cros_ec_typec_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +	},
> +	.probe = cros_typec_probe
> +};
> +
> +module_platform_driver(cros_ec_typec_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ChromeOS EC USB-C connectors");
> +MODULE_AUTHOR("Jon Flatley <jflat@chromium.org>");
> +MODULE_ALIAS("platform:" DRV_NAME);


thanks,

-- 
heikki

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-mfd-core-Propagate-software-fwnode-to-the-sub-device.patch"

From dc204a8644fd4bb7aac9492e6ee304d81be7dbbd Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Mon, 5 Aug 2019 14:54:37 +0300
Subject: [PATCH] mfd: core: Propagate software fwnode to the sub devices

When ever device properties are supplied for a sub device, a
software node (fwnode) is actually created and then
associated with that device. By allowing the drivers to
supply the complete software node instead of just the
properties in it, the drivers can take advantage of the
other features the software nodes have on top of supplying
the device properties.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/mfd/mfd-core.c   | 8 ++++++++
 include/linux/mfd/core.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index cb3e0a14bbdd..3fda7e420c5d 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -174,6 +174,14 @@ static int mfd_add_device(struct device *parent, int id,
 			goto fail_alias;
 	}
 
+	if (cell->node) {
+		ret = software_node_register(cell->node);
+		if (ret)
+			goto fail_alias;
+
+		pdev->dev.fwnode = software_node_fwnode(cell->node);
+	}
+
 	for (r = 0; r < cell->num_resources; r++) {
 		res[r].name = cell->resources[r].name;
 		res[r].flags = cell->resources[r].flags;
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index d01d1299e49d..5ec90ba5865a 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -72,6 +72,9 @@ struct mfd_cell {
 	/* device properties passed to the sub devices drivers */
 	struct property_entry *properties;
 
+	/* Software fwnode for the sub device */
+	const struct software_node *node;
+
 	/*
 	 * Device Tree compatible string
 	 * See: Documentation/devicetree/usage-model.txt Chapter 2.2 for details
-- 
2.24.0


--W/nzBZO5zC0uMSeA--
