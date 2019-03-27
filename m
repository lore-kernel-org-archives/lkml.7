Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053FBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C880620700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="DpL3TPST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfC0MM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:12:28 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:56372 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfC0MM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:12:28 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 7D35225B7E2;
        Wed, 27 Mar 2019 23:12:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1553688744; bh=/QCCk80oDMoAo1wgsH0Q2/EP1YlJrcBIgjD3Y/y+u8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DpL3TPSTCBRz6QASa6pK9CN3RamH/nXta8ys3DM/h/aICWsZd68VvK7si+kGulAbg
         gZQlPqx4/mhA/gRSQpQa6ZYR3mw5isQA82roW/Qhe5VYOXgXdzlOFSebUqeq6HBliY
         Ib7C+kgJhPE2W58D0DlTR/uUsw5MJHKgtx2ikvJY=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id CDB16940376; Wed, 27 Mar 2019 13:12:22 +0100 (CET)
Date:   Wed, 27 Mar 2019 13:12:22 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] hid: hid-sensor-custom: simplify getting .driver_data
Message-ID: <20190327121222.sltrubslygeafoi2@verge.net.au>
References: <20190319163638.31003-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319163638.31003-1-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 05:36:38PM +0100, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> 
> Build tested only. buildbot is happy.
> 
>  drivers/hid/hid-sensor-custom.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> index bb012bc032e0..462e653a7bbb 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -157,8 +157,7 @@ static int usage_id_cmp(const void *p1, const void *p2)
>  static ssize_t enable_sensor_show(struct device *dev,
>  				  struct device_attribute *attr, char *buf)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
> +	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
>  
>  	return sprintf(buf, "%d\n", sensor_inst->enable);
>  }
> @@ -237,8 +236,7 @@ static ssize_t enable_sensor_store(struct device *dev,
>  				   struct device_attribute *attr,
>  				   const char *buf, size_t count)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
> +	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
>  	int value;
>  	int ret = -EINVAL;
>  
> @@ -283,8 +281,7 @@ static const struct attribute_group enable_sensor_attr_group = {
>  static ssize_t show_value(struct device *dev, struct device_attribute *attr,
>  			  char *buf)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
> +	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
>  	struct hid_sensor_hub_attribute_info *attribute;
>  	int index, usage, field_index;
>  	char name[HID_CUSTOM_NAME_LENGTH];
> @@ -392,8 +389,7 @@ static ssize_t show_value(struct device *dev, struct device_attribute *attr,
>  static ssize_t store_value(struct device *dev, struct device_attribute *attr,
>  			   const char *buf, size_t count)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
> +	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
>  	int index, field_index, usage;
>  	char name[HID_CUSTOM_NAME_LENGTH];
>  	int value;
> -- 
> 2.11.0
> 
