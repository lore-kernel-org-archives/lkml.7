Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0917ACA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED3321872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390357AbfJWIc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:32:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:4257 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390020AbfJWIc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:32:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 01:32:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="209874161"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 23 Oct 2019 01:32:22 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 23 Oct 2019 11:32:21 +0300
Date:   Wed, 23 Oct 2019 11:32:21 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Puma Hsu <pumahsu@google.com>, Guenter Roeck <linux@roeck-us.net>
Cc:     gregkh@linuxfoundation.org, badhri@google.com, kyletso@google.com,
        albertccwang@google.com, rickyniu@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] usb: typec: Add sysfs node to show connector
 orientation
Message-ID: <20191023083221.GB8828@kuha.fi.intel.com>
References: <20191022085924.92783-1-pumahsu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022085924.92783-1-pumahsu@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Guenter

On Tue, Oct 22, 2019 at 04:59:24PM +0800, Puma Hsu wrote:
> Export the Type-C connector orientation so that user space
> can get this information.
> 
> Signed-off-by: Puma Hsu <pumahsu@google.com>
> ---
>  Documentation/ABI/testing/sysfs-class-typec | 11 +++++++++++
>  drivers/usb/typec/class.c                   | 18 ++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index d7647b258c3c..b22f71801671 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -108,6 +108,17 @@ Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
>  Description:
>  		Revision number of the supported USB Type-C specification.
>  
> +What:		/sys/class/typec/<port>/connector_orientation
> +Date:		October 2019
> +Contact:	Puma Hsu <pumahsu@google.com>
> +Description:
> +		Indicates which typec connector orientation is configured now.
> +		cc1 is defined as "normal" and cc2 is defined as "reversed".
> +
> +		Valid value:
> +		- unknown (nothing configured)

"unknown" means we do not know the orientation.

> +		- normal (configured in cc1 side)
> +		- reversed (configured in cc2 side)

Guenter, do you think "connector_orientation" OK. I proposed it, but
I'm now wondering if something like "polarity" would be better?

>  USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
>  
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 94a3eda62add..911d06676aeb 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1245,6 +1245,23 @@ static ssize_t usb_power_delivery_revision_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(usb_power_delivery_revision);
>  
> +static const char * const typec_connector_orientation[] = {
> +	[TYPEC_ORIENTATION_NONE]		= "unknown",
> +	[TYPEC_ORIENTATION_NORMAL]		= "normal",
> +	[TYPEC_ORIENTATION_REVERSE]		= "reversed",
> +};
> +
> +static ssize_t connector_orientation_show(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct typec_port *p = to_typec_port(dev);
> +
> +	return sprintf(buf, "%s\n",
> +		       typec_connector_orientation[p->orientation]);
> +}
> +static DEVICE_ATTR_RO(connector_orientation);
> +
>  static struct attribute *typec_attrs[] = {
>  	&dev_attr_data_role.attr,
>  	&dev_attr_power_operation_mode.attr,
> @@ -1255,6 +1272,7 @@ static struct attribute *typec_attrs[] = {
>  	&dev_attr_usb_typec_revision.attr,
>  	&dev_attr_vconn_source.attr,
>  	&dev_attr_port_type.attr,
> +	&dev_attr_connector_orientation.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(typec);

thanks,

-- 
heikki
