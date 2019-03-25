Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999BCC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7220220989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfCYQUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:20:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:11863 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfCYQUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:20:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 09:20:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="155016042"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2019 09:20:49 -0700
Message-ID: <000d6a3a402461974a1ab4e3186173da1c47c118.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] hid: hid-sensor-custom: simplify getting
 .driver_data
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Date:   Mon, 25 Mar 2019 09:20:48 -0700
In-Reply-To: <20190319163638.31003-1-wsa+renesas@sang-engineering.com>
References: <20190319163638.31003-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 17:36 +0100, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> 
> Build tested only. buildbot is happy.
> 
>  drivers/hid/hid-sensor-custom.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> sensor-custom.c
> index bb012bc032e0..462e653a7bbb 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -157,8 +157,7 @@ static int usage_id_cmp(const void *p1, const
> void *p2)
>  static ssize_t enable_sensor_show(struct device *dev,
>  				  struct device_attribute *attr, char
> *buf)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct hid_sensor_custom *sensor_inst =
> platform_get_drvdata(pdev);
> +	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
>  
>  	return sprintf(buf, "%d\n", sensor_inst->enable);
>  }
> @@ -237,8 +236,7 @@ static ssize_t enable_sensor_store(struct device
> *dev,
>  				   struct device_attribute *attr,
>  				   const char *buf, size_t count)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct hid_sensor_custom *sensor_inst =
> platform_get_drvdata(pdev);
> +	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
>  	int value;
>  	int ret = -EINVAL;
>  
> @@ -283,8 +281,7 @@ static const struct attribute_group
> enable_sensor_attr_group = {
>  static ssize_t show_value(struct device *dev, struct
> device_attribute *attr,
>  			  char *buf)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct hid_sensor_custom *sensor_inst =
> platform_get_drvdata(pdev);
> +	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
>  	struct hid_sensor_hub_attribute_info *attribute;
>  	int index, usage, field_index;
>  	char name[HID_CUSTOM_NAME_LENGTH];
> @@ -392,8 +389,7 @@ static ssize_t show_value(struct device *dev,
> struct device_attribute *attr,
>  static ssize_t store_value(struct device *dev, struct
> device_attribute *attr,
>  			   const char *buf, size_t count)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct hid_sensor_custom *sensor_inst =
> platform_get_drvdata(pdev);
> +	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
>  	int index, field_index, usage;
>  	char name[HID_CUSTOM_NAME_LENGTH];
>  	int value;

