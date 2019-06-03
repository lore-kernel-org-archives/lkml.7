Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B41C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDDC271FC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfFCRMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:12:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35498 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbfFCRMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:12:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B022A27C172
Subject: Re: [PATCH] platform/chrome: wilco_ec: Add version sysfs entries
To:     Raul E Rangel <rrangel@chromium.org>, ncrews@chromium.org
Cc:     Simon Glass <sjg@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Sean Paul <seanpaul@chromium.org>
References: <20190521151519.158273-1-rrangel@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <430f07ca-3880-2c2a-3432-84227bbbc6b9@collabora.com>
Date:   Mon, 3 Jun 2019 19:12:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190521151519.158273-1-rrangel@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raul,

On 21/5/19 17:15, Raul E Rangel wrote:
> Add the ability to extract version information from the EC.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> 
> This patch is rebased on platform/chrome: wilco_ec: Add Boot on AC support.
> https://lkml.org/lkml/2019/4/16/1374
> 
> That patch wasn't in the for-next branch, so I'm not 100% sure if it
> applies cleanly to for-next.
> 
> Example Output:
> /sys/bus/platform/devices/GOOG000C:00/version # tail *

I think that I already said this reviewing some of the version that Nick sent.
I'm not a big fan of having somekind of categoritzation of attributes using
directories in sysfs. Directories in sysfs are more to describe somekind of
hardware bus/device topology, however I know this is not always true.

I understand that have some private data in sysfs is useful, but as we discussed
before we should avoid as much as possible don't overuse sysfs. Said that, I'm
fine with having some private API if properly documented but without using
directories to categorize the different attributes. So, I'd remove the version
directory and put directly build_date, build_revision, label and model_number.


> ==> build_date <==
> 04/25/19
> 
> ==> build_revision <==
> d2592cae0
> 
> ==> label <==
> 00.00.14
> 
> ==> model_number <==
> 08B6
> 
>  .../ABI/testing/sysfs-platform-wilco-ec       | 33 +++++++
>  drivers/platform/chrome/wilco_ec/sysfs.c      | 97 ++++++++++++++++++-
>  2 files changed, 128 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-wilco-ec b/Documentation/ABI/testing/sysfs-platform-wilco-ec
> index 6694df8d4172f..00bc8e7c3b9c2 100644
> --- a/Documentation/ABI/testing/sysfs-platform-wilco-ec
> +++ b/Documentation/ABI/testing/sysfs-platform-wilco-ec
> @@ -102,3 +102,36 @@ KernelVersion: 5.3
>  Description:
>  		Read or write the battery percentage threshold for which the
>  		peak shift policy is used. The valid range is [15, 100].
> +
> +What:          /sys/bus/platform/devices/GOOG000C\:00/version/label

If it can be alphabetically sorted by attribute name, better, thanks.

> +Date:          May 2019
> +KernelVersion: 5.3
> +Description:
> +               Display Wilco Embedded Controller firmware version label.
> +               Output will a version string be similar to the example below:
> +               95.00.06
> +
> +What:          /sys/bus/platform/devices/GOOG000C\:00/version/build_revision
> +
> +Date:          May 2019
> +KernelVersion: 5.3
> +Description:
> +               Display Wilco Embedded Controller build revision.
> +               Output will a version string be similar to the example below:
> +               d2592cae0
> +
> +What:          /sys/bus/platform/devices/GOOG000C\:00/version/model_number
> +
> +Date:          May 2019
> +KernelVersion: 5.3
> +Description:
> +               Display Wilco Embedded Controller model number.
> +               Output will a version string be similar to the example below:
> +               08B6
> +
> +What:          /sys/bus/platform/devices/GOOG000C\:00/version/build_date
> +Date:          May 2019
> +KernelVersion: 5.3
> +Description:
> +               Display Wilco Embedded Controller firmware build date.
> +               Output will a MM/DD/YY string.
> diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
> index 6573a6cf9cb31..9bfb9dfde73d1 100644
> --- a/drivers/platform/chrome/wilco_ec/sysfs.c
> +++ b/drivers/platform/chrome/wilco_ec/sysfs.c
> @@ -43,6 +43,25 @@ struct usb_power_share_response {
>  	u8 val;		/* When getting, set by EC to either 0 or 1 */
>  } __packed;
>  
> +#define CMD_EC_INFO			0x38
> +enum get_ec_info_op {
> +	CMD_GET_EC_LABEL	= 0,
> +	CMD_GET_EC_REV		= 1,
> +	CMD_GET_EC_MODEL	= 2,
> +	CMD_GET_EC_BUILD_DATE	= 3,
> +};
> +
> +struct get_ec_info_req {
> +	u8 cmd;			/* Always CMD_EC_INFO */
> +	u8 reserved;
> +	u8 op;			/* One of enum get_ec_info_op */
> +} __packed;
> +
> +struct get_ec_info_resp {
> +	u8 reserved[2];
> +	char value[9]; /* __nonstring: might not be null terminated */
> +} __packed;
> +
>  static ssize_t boot_on_ac_store(struct device *dev,
>  				struct device_attribute *attr,
>  				const char *buf, size_t count)
> @@ -158,12 +177,86 @@ static struct attribute_group wilco_dev_attr_group = {
>  	.attrs = wilco_dev_attrs,
>  };
>  
> +static ssize_t get_info(struct device *dev, char *buf, enum get_ec_info_op op)
> +{
> +	struct wilco_ec_device *ec = dev_get_drvdata(dev);
> +	struct get_ec_info_req req = { .cmd = CMD_EC_INFO, .op = op };
> +	struct get_ec_info_resp resp;
> +	int ret;
> +
> +	struct wilco_ec_message msg = {
> +		.type = WILCO_EC_MSG_LEGACY,
> +		.request_data = &req,
> +		.request_size = sizeof(req),
> +		.response_data = &resp,
> +		.response_size = sizeof(resp),
> +	};
> +
> +	ret = wilco_ec_mailbox(ec, &msg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%.*s\n", (int)sizeof(resp.value),
> +			 (char *)&resp.value);
> +}
> +
> +static ssize_t label_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	return get_info(dev, buf, CMD_GET_EC_LABEL);
> +}
> +
> +static DEVICE_ATTR_RO(label);
> +
> +static ssize_t build_revision_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	return get_info(dev, buf, CMD_GET_EC_REV);
> +}
> +
> +static DEVICE_ATTR_RO(build_revision);
> +
> +static ssize_t build_date_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	return get_info(dev, buf, CMD_GET_EC_BUILD_DATE);
> +}
> +
> +static DEVICE_ATTR_RO(build_date);
> +
> +static ssize_t model_number_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	return get_info(dev, buf, CMD_GET_EC_MODEL);
> +}
> +
> +static DEVICE_ATTR_RO(model_number);
> +
> +static struct attribute *wilco_version_attrs[] = {
> +	&dev_attr_label.attr,
> +	&dev_attr_build_revision.attr,
> +	&dev_attr_build_date.attr,
> +	&dev_attr_model_number.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group wilco_version_group = {
> +	.name = "version",
> +	.attrs = wilco_version_attrs,
> +};
> +
> +static const struct attribute_group *wilco_dev_attr_groups[] = {
> +	&wilco_dev_attr_group,
> +	&wilco_version_group,
> +	NULL
> +};
> +
>  int wilco_ec_add_sysfs(struct wilco_ec_device *ec)
>  {
> -	return sysfs_create_group(&ec->dev->kobj, &wilco_dev_attr_group);
> +	return sysfs_create_groups(&ec->dev->kobj, wilco_dev_attr_groups);
>  }
>  
>  void wilco_ec_remove_sysfs(struct wilco_ec_device *ec)
>  {
> -	sysfs_remove_group(&ec->dev->kobj, &wilco_dev_attr_group);
> +	sysfs_remove_groups(&ec->dev->kobj, wilco_dev_attr_groups);
>  }
> 

Apart from the above comments, the patch looks good to me.

Thanks,
 Enric

