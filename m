Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F0BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0A72173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfC1HsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:48:08 -0400
Received: from emcscan.emc.com.tw ([192.72.220.5]:26424 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1HsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:48:08 -0400
X-IronPort-AV: E=Sophos;i="5.56,253,1539619200"; 
   d="scan'208";a="30057683"
Received: from unknown (HELO webmail.emc.com.tw) ([192.168.10.1])
  by emcscan.emc.com.tw with SMTP; 28 Mar 2019 15:48:05 +0800
Received: from 192.168.10.23
        by webmail.emc.com.tw with MailAudit ESMTP Server V5.0(29403:0:AUTH_RELAY)
        (envelope-from <kt.liao@emc.com.tw>); Thu, 28 Mar 2019 15:48:03 +0800 (CST)
Received: from 192.168.81.85
        by webmail.emc.com.tw with Mail2000 ESMTPA Server V7.00(119328:0:AUTH_LOGIN)
        (envelope-from <kt.liao@emc.com.tw>); Thu, 28 Mar 2019 15:48:03 +0800 (CST)
From:   =?big5?B?ufmxUrph?= <kt.liao@emc.com.tw>
To:     "'Dmitry Torokhov'" <dmitry.torokhov@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <ulrik.debie-os@e2big.org>, <Roger.Whittaker@suse.com>
References: <1549094096-4082-1-git-send-email-kt.liao@emc.com.tw> <20190327043423.GD40550@dtor-ws>
In-Reply-To: <20190327043423.GD40550@dtor-ws>
Subject: RE: [PATCH] Input: elan_i2c - Add i2c_reset in sysfs for ELAN touchpad recovery
Date:   Thu, 28 Mar 2019 15:48:02 +0800
Message-ID: <010a01d4e53a$9272fbe0$b758f3a0$@emc.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="big5"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQG0kOx+IUsscmN0iiFFk58WU8mE8gG3bL4UplOXSxA=
Content-Language: zh-tw
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcOTIwNzNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1jZmRjNTJiOC01MTJkLTExZTktYjliZC01YzUxNGY0NmFhNDVcYW1lLXRlc3RcY2ZkYzUyYmEtNTEyZC0xMWU5LWI5YmQtNWM1MTRmNDZhYTQ1Ym9keS50eHQiIHN6PSIzNDExIiB0PSIxMzE5ODIzMjg4MjQ1MjM3NjgiIGg9Ik16NHBqazJkMEROQkJlWE50YzZXRk1HNFpoST0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

-----Original Message-----
From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
Sent: Wednesday, March 27, 2019 12:34 PM
To: KT Liao
Cc: linux-kernel@vger.kernel.org; linux-input@vger.kernel.org;
ulrik.debie-os@e2big.org; Roger.Whittaker@suse.com
Subject: Re: [PATCH] Input: elan_i2c - Add i2c_reset in sysfs for ELAN
touchpad recovery

Hi KT,

On Sat, Feb 02, 2019 at 03:54:56PM +0800, KT Liao wrote:
> Roger from SUSE reported the touchpad on Lenovo yoga2 crush sometimes.
> He found that rmmod/modprobe elan_i2c will recover the issue.
> He add the workaround on SUSE and solve the problem.
> Recently, the workaround fails in kernel 4.20 becasue IRQ mismatch.
> genirq: Flags mismatch irq 0. 00002002 (ELAN0600:00) vs. 00015a00 
> (timer) I can't reproduce the issue in SUSE with the same kernel.
> And it's a 5 years old laptop, ELAN can't find the module for testing.
> Instead of IRQ debugging IRQ, I tried another approach.
> I added i2c_reset in sysfs to avoid IRQ requesting in probe.

How will users discover this flag? I do not think this is the best approach.
Can we detect that the touchpad firmware crashed from the kernel and reset
automatically?
Agree your better idea.
I will modify the driver for Roger's testing.
Will upstream after his testing.

Thanks.

> 
> Signed-off-by: KT Liao <kt.liao@emc.com.tw>
> Acked-by: Roger Whittaker <Roger.Whittaker@suse.com>
> ---
>  drivers/input/mouse/elan_i2c_core.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c 
> b/drivers/input/mouse/elan_i2c_core.c
> index 2690a4b..388b1f0 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -670,6 +670,29 @@ static ssize_t calibrate_store(struct device *dev,
>  	return retval ?: count;
>  }
>  
> +static ssize_t i2c_reset_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count) {
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct elan_tp_data *data = i2c_get_clientdata(client);
> +	int retval;
> +
> +	retval = mutex_lock_interruptible(&data->sysfs_mutex);
> +	if (retval)
> +		return retval;
> +
> +	disable_irq(client->irq);
> +
> +	retval = elan_initialize(data);
> +	if (retval)
> +		dev_err(dev, "failed to re-initialize touchpad: %d\n",
retval);
> +
> +	enable_irq(client->irq);
> +	mutex_unlock(&data->sysfs_mutex);
> +	return retval ?: count;
> +}
> +
>  static ssize_t elan_sysfs_read_mode(struct device *dev,
>  				    struct device_attribute *attr,
>  				    char *buf)
> @@ -702,6 +725,7 @@ static DEVICE_ATTR(mode, S_IRUGO, 
> elan_sysfs_read_mode, NULL);  static DEVICE_ATTR(update_fw, S_IWUSR, 
> NULL, elan_sysfs_update_fw);
>  
>  static DEVICE_ATTR_WO(calibrate);
> +static DEVICE_ATTR_WO(i2c_reset);
>  
>  static struct attribute *elan_sysfs_entries[] = {
>  	&dev_attr_product_id.attr,
> @@ -710,6 +734,7 @@ static struct attribute *elan_sysfs_entries[] = {
>  	&dev_attr_iap_version.attr,
>  	&dev_attr_fw_checksum.attr,
>  	&dev_attr_calibrate.attr,
> +	&dev_attr_i2c_reset.attr,
>  	&dev_attr_mode.attr,
>  	&dev_attr_update_fw.attr,
>  	NULL,
> --
> 2.7.4
> 

-- 
Dmitry

