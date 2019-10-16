Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C0AECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9BD20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bvUvLkCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389707AbfJPDrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:47:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfJPDrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lEWx+UcLpjc4KWKcEW1+PWSmi50tgZmjOZfoB8gc4Z0=; b=bvUvLkCZ/lM3nfg8dRn4Rby90
        6tm5t6HgvANdT8lfI4/c1AUt0cV9N9yzP+bTBJcDpfIA0f5eD8ikUUFb2L3ZujeofE9rFB+DcTrQ3
        vfqXZPUGrMiebMroUw17r/Fcri6IrpiQr0SoD6YyGJ4Cs+GP8oC1AiJd6wrnJgOnvQcm63kRo76TR
        AWR9Mrvib9X42zArYzWXiq9V8cm7BuqIynEuufKHGk1v2rmRF+D8xJDY7nSP9YNGaW1GCVIbZL/cF
        W8zE3XxzNdTak5wGCc6vy8PablKcKpdWahoWyxuF/pdYNw42bju7QTEXf4cLjBNR7UHVkyAgnHaD2
        wtWal3F6Q==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKaHA-0004MI-Al; Wed, 16 Oct 2019 03:47:04 +0000
Subject: Re: [PATCH] usb: typec: Add sysfs node to show cc orientation
To:     pumahsu <pumahsu@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, kyletso@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191016034314.231363-1-pumahsu@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <577ac2f6-f073-1bd0-0adb-33fa8243773c@infradead.org>
Date:   Tue, 15 Oct 2019 20:47:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016034314.231363-1-pumahsu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/19 8:43 PM, pumahsu wrote:
> Export the Type-C cc orientation so that user space can
> get this information.
> 
> Signed-off-by: pumahsu <pumahsu@google.com>

Hi,
what the * is cc orientation?

> ---
>  Documentation/ABI/testing/sysfs-class-typec |  7 +++++++
>  drivers/usb/typec/class.c                   | 11 +++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index d7647b258c3c..419f952c991d 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -108,6 +108,13 @@ Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
>  Description:
>  		Revision number of the supported USB Type-C specification.
>  
> +What:		/sys/class/typec/<port>/cc_orientation
> +Date:		September 2019
> +Contact:	Puma Hsu <pumahsu@google.com>
> +Description:
> +		Indicates which cc orientation is active now, or 0 when
> +		nothing is connected.
> +
>  
>  USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
>  
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 7d8805d9bf37..00edae63da8e 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1238,6 +1238,16 @@ static ssize_t usb_power_delivery_revision_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(usb_power_delivery_revision);
>  
> +static ssize_t cc_orientation_show(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct typec_port *p = to_typec_port(dev);
> +
> +	return sprintf(buf, "%d\n", typec_get_orientation(p));
> +}
> +static DEVICE_ATTR_RO(cc_orientation);
> +
>  static struct attribute *typec_attrs[] = {
>  	&dev_attr_data_role.attr,
>  	&dev_attr_power_operation_mode.attr,
> @@ -1248,6 +1258,7 @@ static struct attribute *typec_attrs[] = {
>  	&dev_attr_usb_typec_revision.attr,
>  	&dev_attr_vconn_source.attr,
>  	&dev_attr_port_type.attr,
> +	&dev_attr_cc_orientation.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(typec);
> 


-- 
~Randy
