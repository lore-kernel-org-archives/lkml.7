Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA5FC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BAFB23A78
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfE2On2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:43:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:49062 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfE2On1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:43:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 07:43:09 -0700
X-ExtLoop1: 1
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by fmsmga004.fm.intel.com with ESMTP; 29 May 2019 07:43:09 -0700
Subject: Re: [PATCHv4 2/4] firmware: add Intel Stratix10 remote system update
 driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org,
        atull@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sen.li@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1559074833-1325-1-git-send-email-richard.gong@linux.intel.com>
 <1559074833-1325-3-git-send-email-richard.gong@linux.intel.com>
 <20190528232224.GA29225@kroah.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <1e3b5447-b776-f929-bca6-306f90ac0856@linux.intel.com>
Date:   Wed, 29 May 2019 09:55:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528232224.GA29225@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg,

On 5/28/19 6:22 PM, Greg KH wrote:
> On Tue, May 28, 2019 at 03:20:31PM -0500, richard.gong@linux.intel.com wrote:
>> +/**
>> + * rsu_send_msg() - send a message to Intel service layer
>> + * @priv: pointer to rsu private data
>> + * @command: RSU status or update command
>> + * @arg: the request argument, the bitstream address or notify status
>> + * @callback: function pointer for the callback (status or update)
>> + *
>> + * Start an Intel service layer transaction to perform the SMC call that
>> + * is necessary to get RSU boot log or set the address of bitstream to
>> + * boot after reboot.
>> + *
>> + * Returns 0 on success or -ETIMEDOUT on error.
>> + */
>> +static int rsu_send_msg(struct stratix10_rsu_priv *priv,
>> +			enum stratix10_svc_command_code command,
>> +	unsigned long arg,
>> +	void (*callback)(struct stratix10_svc_client *client,
>> +			 struct stratix10_svc_cb_data *data))
>> +{
>> +	struct stratix10_svc_client_msg msg;
>> +	int ret;
>> +
>> +	mutex_lock(&priv->lock);
>> +	reinit_completion(&priv->completion);
>> +	priv->client.receive_cb = callback;
>> +
>> +	msg.command = command;
>> +	if (arg)
>> +		msg.arg[0] = arg;
>> +
>> +	ret = stratix10_svc_send(priv->chan, &msg);
> 
> meta-question, can you send messages that are on the stack and not in
> DMA-able memory?  Or should this be a dynamicly created variable so you
> know it can work properly with DMA?
> 
> And how big is that structure, will it mess with stack sizes?
> 

stratix10_svc_send() is a function from Intel Stratix10 service layer 
driver, which is used by service clients (RSU and FPGA manager drivers 
as now) to add a message to the service layer driver's queue for being 
sent to the secure world via SMC call.

It is not DMA related, we send messages via FIFO API.

The size of FIFO is sizeof(struct stratix10_svc_data) * 
SVC_NUM_DATA_IN_FIFO, SVC_NUM_DATA_IN_FIFO is defined as 32.

fifo_size = sizeof(struct stratix10_svc_data) * 	SVC_NUM_DATA_IN_FIFO;
ret = kfifo_alloc(&controller->svc_fifo, fifo_size, GFP_KERNEL);
if (ret) {
	dev_err(dev, "failed to allocate FIFO\n");
         return ret;
}
spin_lock_init(&controller->svc_fifo_lock);

It will not mess with stack sizes.

> thanks,
> 
> greg k-h
> 

Regards,
Richard
