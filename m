Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92E6C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C017721019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfEUHpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:45:17 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:19606 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726719AbfEUHpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:45:17 -0400
X-UUID: abed8824c125450b9678ab85644ecc39-20190521
X-UUID: abed8824c125450b9678ab85644ecc39-20190521
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1337020285; Tue, 21 May 2019 15:44:55 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 21 May
 2019 15:44:54 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 21 May 2019 15:44:53 +0800
Message-ID: <1558424693.10179.374.camel@mhfsdcap03>
Subject: Re: [PATCH v5 5/6] usb: roles: add USB Type-B GPIO connector driver
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        "Badhri Jagan Sridharan" <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 21 May 2019 15:44:53 +0800
In-Reply-To: <20190520083151.GD1887@kuha.fi.intel.com>
References: <1557823643-8616-1-git-send-email-chunfeng.yun@mediatek.com>
         <1557823643-8616-6-git-send-email-chunfeng.yun@mediatek.com>
         <20190520083151.GD1887@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2019-05-20 at 11:31 +0300, Heikki Krogerus wrote:
> On Tue, May 14, 2019 at 04:47:22PM +0800, Chunfeng Yun wrote:
> > +static int usb_conn_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *node = dev->of_node;
> > +	struct device_node *remote_node;
> > +	struct usb_conn_info *info;
> > +	int ret = 0;
> > +
> > +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> > +	if (!info)
> > +		return -ENOMEM;
> > +
> > +	info->dev = dev;
> > +	info->id_gpiod = devm_gpiod_get_optional(dev, "id", GPIOD_IN);
> > +	if (IS_ERR(info->id_gpiod))
> > +		return PTR_ERR(info->id_gpiod);
> > +
> > +	info->vbus_gpiod = devm_gpiod_get_optional(dev, "vbus", GPIOD_IN);
> > +	if (IS_ERR(info->vbus_gpiod))
> > +		return PTR_ERR(info->vbus_gpiod);
> > +
> > +	if (!info->id_gpiod && !info->vbus_gpiod) {
> > +		dev_err(dev, "failed to get gpios\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	if (info->id_gpiod)
> > +		ret = gpiod_set_debounce(info->id_gpiod, USB_GPIO_DEB_US);
> > +	if (!ret && info->vbus_gpiod)
> > +		ret = gpiod_set_debounce(info->vbus_gpiod, USB_GPIO_DEB_US);
> > +	if (ret < 0)
> > +		info->debounce_jiffies = msecs_to_jiffies(USB_GPIO_DEB_MS);
> > +
> > +	INIT_DELAYED_WORK(&info->dw_det, usb_conn_detect_cable);
> > +
> > +	info->vbus = devm_regulator_get(dev, "vbus");
> > +	if (IS_ERR(info->vbus)) {
> > +		dev_err(dev, "failed to get vbus\n");
> > +		return PTR_ERR(info->vbus);
> > +	}
> > +
> > +	remote_node = of_graph_get_remote_node(node, -1, 0);
> 
> This is really not ideal. In practice this code will only work if
> there is only one endpoint described for this device, or if the first
> endpoint is always the one we are looking for. There is no way to
> guarantee that.
Yes, it is.
I'll modify it as case 2, see reply [v5, 4/6] in this series.

> 
> The code really has to walk through the entire graph, and identify the
> remote endpoint it's looking for (and for that we have the boolean
> device property).
> 
> > +	if (!remote_node) {
> > +		dev_err(dev, "failed to get remote node\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	info->role_sw =
> > +		fwnode_usb_role_switch_get(of_fwnode_handle(remote_node));
> 
> So fwnode_usb_role_switch_get() needs be the one that walks through
> the graph, not the drivers. Otherwise every driver will do the same
> exact steps (boilerplate). Here you need to be able to just pass the
> node of this device, not the remote endpoint:
> 
>         info->role_sw = fwnode_usb_role_switch_get(dev_fwnode(&client->dev));
> 
> But why do you need that function at all? Why wouldn't
> usb_role_switch_get() work?
> 
>         info->role_sw = usb_role_switch_get(&client->dev);
> 
see reply [v5, 4/6] in this series

Thanks a lot.

> > +	of_node_put(remote_node);
> > +	if (IS_ERR(info->role_sw)) {
> > +		dev_err(dev, "failed to get role switch\n");
> > +		return PTR_ERR(info->role_sw);
> > +	}
> > +
> > +	if (info->id_gpiod) {
> > +		info->id_irq = gpiod_to_irq(info->id_gpiod);
> > +		if (info->id_irq < 0) {
> > +			dev_err(dev, "failed to get ID IRQ\n");
> > +			ret = info->id_irq;
> > +			goto put_role_sw;
> > +		}
> > +
> > +		ret = devm_request_threaded_irq(dev, info->id_irq, NULL,
> > +						usb_conn_isr, USB_CONN_IRQF,
> > +						pdev->name, info);
> > +		if (ret < 0) {
> > +			dev_err(dev, "failed to request ID IRQ\n");
> > +			goto put_role_sw;
> > +		}
> > +	}
> > +
> > +	if (info->vbus_gpiod) {
> > +		info->vbus_irq = gpiod_to_irq(info->vbus_gpiod);
> > +		if (info->vbus_irq < 0) {
> > +			dev_err(dev, "failed to get VBUS IRQ\n");
> > +			ret = info->vbus_irq;
> > +			goto put_role_sw;
> > +		}
> > +
> > +		ret = devm_request_threaded_irq(dev, info->vbus_irq, NULL,
> > +						usb_conn_isr, USB_CONN_IRQF,
> > +						pdev->name, info);
> > +		if (ret < 0) {
> > +			dev_err(dev, "failed to request VBUS IRQ\n");
> > +			goto put_role_sw;
> > +		}
> > +	}
> > +
> > +	platform_set_drvdata(pdev, info);
> > +
> > +	/* Perform initial detection */
> > +	usb_conn_queue_dwork(info, 0);
> > +
> > +	return 0;
> > +
> > +put_role_sw:
> > +	usb_role_switch_put(info->role_sw);
> > +	return ret;
> > +}
> 
> thanks,
> 


