Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BB2C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5233E2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfDLIP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:15:29 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54725 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDLIP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:15:28 -0400
Received: from 79.184.255.221.ipv4.supernova.orange.pl (79.184.255.221) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 4b5092bbe3964eb8; Fri, 12 Apr 2019 10:15:25 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] device property: Add fwnode_is_compatible() and device_is_compatible() helpers
Date:   Fri, 12 Apr 2019 10:13:11 +0200
Message-ID: <2845758.HqtfGXT4y5@aspire.rjw.lan>
In-Reply-To: <20190327164339.31205-2-heikki.krogerus@linux.intel.com>
References: <20190327164339.31205-1-heikki.krogerus@linux.intel.com> <20190327164339.31205-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 27, 2019 5:43:37 PM CEST Heikki Krogerus wrote:
> Since there are also some ACPI platforms where the
> "compatible" property is used, introducing a generic helper
> function fwnode_is_compatible() that can be used with
> DT, ACPI and swnodes, and a wrapper function
> device_is_compatible() with it.
> 
> The function calls of_device_is_comaptible() with OF nodes,
> and with ACPI and swnodes it matches the given string
> against the "compatible" string property array.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/property.c  | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/property.h |  3 +++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 8b91ab380d14..af9f5aac5d02 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1006,3 +1006,38 @@ const void *device_get_match_data(struct device *dev)
>  	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
>  }
>  EXPORT_SYMBOL_GPL(device_get_match_data);
> +
> +/**
> + * fwnode_is_compatible - Check does fwnode have the given compatible string
> + * @fwnode: fwnode with the "compatible" property
> + * @compat: The compatible string
> + *
> + * Match the compatible strings of @fwnode against @compat. Returns positive
> + * value on match, and 0 when no matching compatible string is found.
> + */
> +int fwnode_is_compatible(struct fwnode_handle *fwnode, const char *compat)
> +{
> +	int ret;
> +
> +	if (is_of_node(fwnode))
> +		return of_device_is_compatible(to_of_node(fwnode), compat);
> +
> +	ret = fwnode_property_match_string(fwnode, "compatible", compat);
> +
> +	return ret < 0 ? 0 : 1;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_is_compatible);
> +
> +/**
> + * device_is_compatible - Check does a device have the given compatible string
> + * @dev: Device with the "compatible" property
> + * @compat: The compatible string
> + *
> + * Match the compatible strings of @dev against @compat. Returns positive value
> + * on match, and 0 when no matching compatible string is found.
> + */
> +int device_is_compatible(struct device *dev, const char *compat)
> +{
> +	return fwnode_is_compatible(dev_fwnode(dev), compat);
> +}
> +EXPORT_SYMBOL_GPL(device_is_compatible);
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 65d3420dd5d1..d22788ec36cd 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -311,6 +311,9 @@ fwnode_graph_get_remote_node(const struct fwnode_handle *fwnode, u32 port,
>  int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>  				struct fwnode_endpoint *endpoint);
>  
> +int fwnode_is_compatible(struct fwnode_handle *fwnode, const char *compat);
> +int device_is_compatible(struct device *dev, const char *compat);
> +
>  /* -------------------------------------------------------------------------- */
>  /* Software fwnode support - when HW description is incomplete or missing */
>  
> 

The new helpers would not be used anywhere for the time being, so it is better to
add them along with the first user IMO.

Please resend when this is needed.

