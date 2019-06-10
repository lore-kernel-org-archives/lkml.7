Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F1BC468D8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8B02089E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390750AbfFJOMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 10:12:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:45455 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390691AbfFJOMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:12:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 07:12:31 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 10 Jun 2019 07:12:31 -0700
Received: from achugh-mobl.amr.corp.intel.com (unknown [10.254.100.69])
        by linux.intel.com (Postfix) with ESMTP id 4F03F5800FF;
        Mon, 10 Jun 2019 07:12:30 -0700 (PDT)
Subject: Re: [alsa-devel] [RFC PATCH 6/6] soundwire: qcom: add support for
 SoundWire controller
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, vkoul@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-7-srinivas.kandagatla@linaro.org>
 <249f9647-94d0-41d7-3b95-64c36d90f8e8@linux.intel.com>
 <40ea774c-8aa8-295d-e91e-71423b03c88d@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7269521a-ac89-3856-c18c-ffaaf64c0806@linux.intel.com>
Date:   Mon, 10 Jun 2019 09:12:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <40ea774c-8aa8-295d-e91e-71423b03c88d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +#define SWRM_COMP_HW_VERSION                    0x00
>>
>> Can we please use SDW_ or QCOM_SDW_ as prefix?
>>
> 
> SWRM prefix is as per the data sheet register names, If it help am happy 
> to add QCOM_ prefix it.

That'd be fine. As long as there is no duplication and two 
terms/prefixes used for the same thing I am happy.

>>> +
>>> +    val = SWRM_REG_VAL_PACK(cmd_data, dev_addr, cmd_id, reg_addr);
>>> +    ret = ctrl->reg_write(ctrl, SWRM_CMD_FIFO_WR_CMD, val);
>>> +    if (ret < 0) {
>>> +        dev_err(ctrl->dev, "%s: reg 0x%x write failed, err:%d\n",
>>> +            __func__, val, ret);
>>> +        goto err;
>>> +    }
>>> +
>>> +    if (dev_addr == SDW_BROADCAST_DEV_NUM) {
>>> +        ctrl->fifo_status = 0;
>>> +        ret = wait_for_completion_timeout(&ctrl->sp_cmd_comp,
>>> +                          msecs_to_jiffies(TIMEOUT_MS));
>>
>> This is odd. The SoundWire spec does not handle writes to a single 
>> device or broadcast writes differently. I don't see a clear reason why 
>> you would only timeout for a broadcast write.
>>
> 
> There is danger of blocking here without timeout.

Right, and it's fine to add a timeout. The question is why add a timeout 
*only* for a broadcast operation? It should be added for every 
transaction IMO, unless you have a reason not to do so.

>>
>>> +
>>> +    /* Mask soundwire interrupts */
>>> +    ctrl->reg_write(ctrl, SWRM_INTERRUPT_MASK_ADDR,
>>> +                    SWRM_INTERRUPT_STATUS_RMSK);
>>> +
>>> +    /* Configure No pings */
>>> +    val = ctrl->reg_read(ctrl, SWRM_MCP_CFG_ADDR);
>>
>> If there is any sort of PREQ signaling for Slave-initiated interrupts, 
>> disabling PINGs is likely a non-conformant implementation since the 
>> master is required to issue a PING command within 32 frames. That's 
>> also the only way to know if a device is attached, so additional 
>> comments are likely required.
> This is the value of Maximum number of consiecutive read/write commands 
> without ping command in between. I will try to collect more details and 
> add some comments here.

Right, so it's probably the comment that's too strict. It's not no pings 
it's no pings during a sequence of up to N read/writes.

