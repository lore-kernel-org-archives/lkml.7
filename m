Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F92C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C047122B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfLKNVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:21:15 -0500
Received: from foss.arm.com ([217.140.110.172]:58030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728976AbfLKNVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:21:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C66521FB;
        Wed, 11 Dec 2019 05:21:14 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 562E43F6CF;
        Wed, 11 Dec 2019 05:21:14 -0800 (PST)
Subject: Re: [PATCH 05/15] firmware: arm_scmi: Add versions and identifier
 attributes using dev_groups
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191210145345.11616-1-sudeep.holla@arm.com>
 <20191210145345.11616-6-sudeep.holla@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <91d5617d-85da-b3a3-1ef3-2438baa93ba7@arm.com>
Date:   Wed, 11 Dec 2019 13:21:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210145345.11616-6-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2019 14:53, Sudeep Holla wrote:
> Platform drivers now have the option to have the platform core create
> and remove any needed sysfs attribute files. Using the same, let's add
> the scmi firmware and protocol version attributes as well as vendor and
> sub-vendor identifiers to sysfs.
> 
> It helps to identify the firmware details from the sysfs entries similar
> to ARM SCPI implementation.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scmi/driver.c | 47 ++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 0bbdc7c9eb0f..26b2c438bd59 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -979,6 +979,52 @@ static int scmi_remove(struct platform_device *pdev)
>  	return ret;
>  }
> 
> +static ssize_t protocol_version_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct scmi_info *info = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%u.%u\n", info->version.major_ver,
> +		       info->version.minor_ver);
> +}
> +static DEVICE_ATTR_RO(protocol_version);
> +
> +static ssize_t firmware_version_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct scmi_info *info = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "0x%x\n", info->version.impl_ver);
> +}
> +static DEVICE_ATTR_RO(firmware_version);
> +
> +static ssize_t vendor_id_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct scmi_info *info = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%s\n", info->version.vendor_id);
> +}
> +static DEVICE_ATTR_RO(vendor_id);
> +
> +static ssize_t sub_vendor_id_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct scmi_info *info = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%s\n", info->version.sub_vendor_id);
> +}
> +static DEVICE_ATTR_RO(sub_vendor_id);
> +
> +static struct attribute *versions_attrs[] = {
> +	&dev_attr_firmware_version.attr,
> +	&dev_attr_protocol_version.attr,
> +	&dev_attr_vendor_id.attr,
> +	&dev_attr_sub_vendor_id.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(versions);
> +
>  static const struct scmi_desc scmi_generic_desc = {
>  	.max_rx_timeout_ms = 30,	/* We may increase this if required */
>  	.max_msg = 20,		/* Limited by MBOX_TX_QUEUE_LEN */
> @@ -997,6 +1043,7 @@ static struct platform_driver scmi_driver = {
>  	.driver = {
>  		   .name = "arm-scmi",
>  		   .of_match_table = scmi_of_match,
> +		   .dev_groups = versions_groups,
>  		   },
>  	.probe = scmi_probe,
>  	.remove = scmi_remove,
> --
> 2.17.1
> 

LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>


Cristian

