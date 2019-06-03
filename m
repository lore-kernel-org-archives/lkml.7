Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45DBC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BAB27937
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfFCPpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:45:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:41150 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727698AbfFCPpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:45:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 08:45:01 -0700
X-ExtLoop1: 1
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by orsmga006.jf.intel.com with ESMTP; 03 Jun 2019 08:44:59 -0700
Subject: A potential broken at platform driver?
From:   Richard Gong <richard.gong@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org,
        atull@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sen.li@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1559074833-1325-1-git-send-email-richard.gong@linux.intel.com>
 <1559074833-1325-3-git-send-email-richard.gong@linux.intel.com>
 <20190528232224.GA29225@kroah.com>
 <1e3b5447-b776-f929-bca6-306f90ac0856@linux.intel.com>
Message-ID: <b608d657-9d8c-9307-9290-2f6b052a71a9@linux.intel.com>
Date:   Mon, 3 Jun 2019 10:57:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1e3b5447-b776-f929-bca6-306f90ac0856@linux.intel.com>
Content-Type: multipart/mixed;
 boundary="------------58DC67A8AB4E5FBBD2CB2F4D"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------58DC67A8AB4E5FBBD2CB2F4D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Greg,

Following your suggestion, I replaced devm_device_add_groups() with 
.group = rus_groups in my version #4 submission. But I found out that 
RSU driver outputs the garbage data if I use .group = rsu_groups.

To make RSU driver work properly, I have to revert the change at version 
#4 and use devm_device_add_groups() again. Sorry, I didn't catch this 
problem early.

I did some debug & below are captured log, you can see priv pointer get 
messed at current_image_show(). I am not sure if something related to 
platform driver work properly. I attach my debug patch in this mail.

1. Using .groups = rsu_groups,

[    1.191115] *** rsu_status_callback:
[    1.194782] res->a1=2000000
[    1.197588] res->a1=0
[    1.199865] res->a2=0
[    1.202150] res->a3=0
[    1.204433] priv=0xffff80007aa28e80
[    1.207933] version=0, state=0, current_image=2000000, fail_image=0, 
error_location=0, error_details=0
[    1.217249] *** stratix10_rsu_probe: priv=0xffff80007aa28e80
root@stratix10:/sys/bus/platform/drivers/stratix10-rsu# cat current_image
[   38.849341] *** current_image_show: priv=0xffff80007aa28d00
... output garbage data
priv pointer got changed

2. Using devm_device_add_groups

[    1.191196] *** rsu_status_callback:
[    1.194864] res->a1=2000000
[    1.197660] res->a1=0
[    1.199928] res->a2=0
[    1.202204] res->a3=0
[    1.204479] priv=0xffff80007a427e80
[    1.207968] version=0, state=0, current_image=2000000, fail_image=0, 
error_location=0, error_details=0
[    1.217322] *** stratix10_rsu_probe: priv=0xffff80007a427e80
root@stratix10:/sys/devices/platform/stratix10-rsu.0# cat current_image
[   39.032648] *** current_image_show: priv=0xffff80007a427e80
0x2000000
 ... output all correct data and correct priv pointer

I checked kernel sources and observed that .groups = xx_groups are 
widely used in 
device/misdevice/device_type/device_driver/bus_driver/pci_driver etc, 
but not in platform driver.

A few platform drivers which does utilize groups,
1. driver/s390/char/sclp.c does use .group = xx_groups, but it use the 
global variables for data exchanges between functions.
2. driver/firmware/arm_scpi.c doesn't use .group = xx_groups, instead it 
use devm_device_add_groups().

Regards,
Richard



On 5/29/19 9:55 AM, Richard Gong wrote:
> 
> Hi Greg,
> 
> On 5/28/19 6:22 PM, Greg KH wrote:
>> On Tue, May 28, 2019 at 03:20:31PM -0500, richard.gong@linux.intel.com 
>> wrote:
>>> +/**
>>> + * rsu_send_msg() - send a message to Intel service layer
>>> + * @priv: pointer to rsu private data
>>> + * @command: RSU status or update command
>>> + * @arg: the request argument, the bitstream address or notify status
>>> + * @callback: function pointer for the callback (status or update)
>>> + *
>>> + * Start an Intel service layer transaction to perform the SMC call 
>>> that
>>> + * is necessary to get RSU boot log or set the address of bitstream to
>>> + * boot after reboot.
>>> + *
>>> + * Returns 0 on success or -ETIMEDOUT on error.
>>> + */
>>> +static int rsu_send_msg(struct stratix10_rsu_priv *priv,
>>> +            enum stratix10_svc_command_code command,
>>> +    unsigned long arg,
>>> +    void (*callback)(struct stratix10_svc_client *client,
>>> +             struct stratix10_svc_cb_data *data))
>>> +{
>>> +    struct stratix10_svc_client_msg msg;
>>> +    int ret;
>>> +
>>> +    mutex_lock(&priv->lock);
>>> +    reinit_completion(&priv->completion);
>>> +    priv->client.receive_cb = callback;
>>> +
>>> +    msg.command = command;
>>> +    if (arg)
>>> +        msg.arg[0] = arg;
>>> +
>>> +    ret = stratix10_svc_send(priv->chan, &msg);
>>
>> meta-question, can you send messages that are on the stack and not in
>> DMA-able memory?  Or should this be a dynamicly created variable so you
>> know it can work properly with DMA?
>>
>> And how big is that structure, will it mess with stack sizes?
>>
> 
> stratix10_svc_send() is a function from Intel Stratix10 service layer 
> driver, which is used by service clients (RSU and FPGA manager drivers 
> as now) to add a message to the service layer driver's queue for being 
> sent to the secure world via SMC call.
> 
> It is not DMA related, we send messages via FIFO API.
> 
> The size of FIFO is sizeof(struct stratix10_svc_data) * 
> SVC_NUM_DATA_IN_FIFO, SVC_NUM_DATA_IN_FIFO is defined as 32.
> 
> fifo_size = sizeof(struct stratix10_svc_data) *     SVC_NUM_DATA_IN_FIFO;
> ret = kfifo_alloc(&controller->svc_fifo, fifo_size, GFP_KERNEL);
> if (ret) {
>      dev_err(dev, "failed to allocate FIFO\n");
>          return ret;
> }
> spin_lock_init(&controller->svc_fifo_lock);
> 
> It will not mess with stack sizes.
> 
>> thanks,
>>
>> greg k-h
>>
> 
> Regards,
> Richard

--------------58DC67A8AB4E5FBBD2CB2F4D
Content-Type: text/x-patch;
 name="0001-add-just-for-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-add-just-for-debug.patch"

From 2b07d31cf349b1353e7405e196e8e3dd7196ad2d Mon Sep 17 00:00:00 2001
From: Richard Gong <richard.gong@intel.com>
Date: Wed, 29 May 2019 15:51:45 -0500
Subject: [PATCH] add just for debug, this patch will be removed from the
 upstream version 5 submission

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 drivers/firmware/stratix10-rsu.c | 42 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
index 8028d0d..c868d97 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -23,6 +23,13 @@
 
 #define RSU_TIMEOUT	(msecs_to_jiffies(SVC_RSU_REQUEST_TIMEOUT_MS))
 
+/*
+ * for debug purpose:
+ * set the global variable to make sure data is
+ * data is correct with cat command
+ */
+//static int currentImage = 0;
+
 typedef void (*rsu_callback)(struct stratix10_svc_client *client,
 			     struct stratix10_svc_cb_data *data);
 
@@ -69,6 +76,14 @@ static void rsu_status_callback(struct stratix10_svc_client *client,
 	struct stratix10_rsu_priv *priv = client->priv;
 	struct arm_smccc_res *res = (struct arm_smccc_res *)data->kaddr1;
 
+	/* for debug purpose */
+	printk("*** %s: \n", __func__);
+	printk("res->a1=%lx\n", res->a0);
+	printk("res->a1=%lx\n", res->a1);
+	printk("res->a2=%lx\n", res->a2);
+	printk("res->a3=%lx\n", res->a3);
+	printk("priv=%pf\n", priv);
+
 	if (data->status == BIT(SVC_STATUS_RSU_OK)) {
 		priv->status.version = FIELD_GET(RSU_VERSION_MASK,
 						 res->a2);
@@ -79,6 +94,15 @@ static void rsu_status_callback(struct stratix10_svc_client *client,
 			FIELD_GET(RSU_ERROR_LOCATION_MASK, res->a3);
 		priv->status.error_details =
 			FIELD_GET(RSU_ERROR_DETAIL_MASK, res->a3);
+
+		/* for debug purpose */
+		printk("version=%lx\, state=%lx, current_image=%lx, fail_image=%lx, error_location=%lx, error_details=%lx\n",
+			priv->status.version, priv->status.state, priv->status.current_image, priv->status.fail_image,
+			priv->status.error_location, priv->status.error_details);
+
+		/* for debug purpose */
+		//currentImage = res->a0;
+
 	} else {
 		dev_err(client->dev, "COMMAND_RSU_STATUS returned 0x%lX\n",
 			res->a0);
@@ -177,9 +201,12 @@ static ssize_t current_image_show(struct device *dev,
 {
 	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
 
+	printk("*** %s: priv=%pf\n", __func__, priv);
 	if (!priv)
 		return -ENODEV;
 
+	/* for debug purpose */
+	//return sprintf(buf, "%ld", currentImage);
 	return sprintf(buf, "%ld", priv->status.current_image);
 }
 
@@ -368,7 +395,6 @@ static int stratix10_rsu_probe(struct platform_device *pdev)
 	}
 
 	init_completion(&priv->completion);
-	platform_set_drvdata(pdev, priv);
 
 	/* status is only updated after reboot */
 	ret = rsu_send_msg(priv, COMMAND_RSU_STATUS,
@@ -378,6 +404,18 @@ static int stratix10_rsu_probe(struct platform_device *pdev)
 		stratix10_svc_free_channel(priv->chan);
 	}
 
+#if 1 
+	/* data will be correct if use devm_device_add_groups()*/
+	ret = devm_device_add_groups(dev, rsu_groups);
+	if (ret) {
+		dev_err(dev, "unable to create sysfs group");
+		stratix10_svc_free_channel(priv->chan);
+	}
+#endif
+
+	printk("*** %s: priv=%pf\n", __func__, priv);
+	platform_set_drvdata(pdev, priv);
+
 	return ret;
 }
 
@@ -394,7 +432,7 @@ static struct platform_driver stratix10_rsu_driver = {
 	.remove = stratix10_rsu_remove,
 	.driver = {
 		.name = "stratix10-rsu",
-		.groups = rsu_groups,
+//		.groups = rsu_groups,
 	},
 };
 
-- 
2.7.4


--------------58DC67A8AB4E5FBBD2CB2F4D--
