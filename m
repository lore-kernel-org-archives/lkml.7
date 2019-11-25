Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAE2C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B056207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfKYRCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 12:02:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32860 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbfKYRCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 12:02:38 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id EA82428FF94
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Add response tracing
To:     Raul Rangel <rrangel@chromium.org>
Cc:     Akshu Agrawal <akshu.agrawal@amd.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>
References: <20191121115542.1.Iaf98f0ab455b626537e77cfa71cef6ff2ab6f37b@changeid>
 <4eef47ad-8d42-1ab4-0c99-028a121cc27c@collabora.com>
 <CAHQZ30BOmBBHnDR2fTWA1_uoTd6c5+66PbpA57MpiWZcnU5y+A@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <ee188678-70cf-62ba-eb64-e9011be305a7@collabora.com>
Date:   Mon, 25 Nov 2019 18:02:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHQZ30BOmBBHnDR2fTWA1_uoTd6c5+66PbpA57MpiWZcnU5y+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raul,

On 25/11/19 17:49, Raul Rangel wrote:
> On Mon, Nov 25, 2019 at 8:45 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
>> Hi Raul,
>>
>> Many tanks for sending this patch upstream, some few comments below.
>>
>> On 21/11/19 19:55, Raul E Rangel wrote:
>>> Add the ability to view response codes as well.
>>>
>>> I renamed the trace event from cros_ec_cmd to cros_ec_request and added
>>> a cros_ec_response.
>>>
>>> Example:
>>> $ echo 1 > /sys/kernel/debug/tracing/events/cros_ec/enable
>>> $ cat /sys/kernel/debug/tracing/trace
>>>
>>> cros_ec_request: version: 1, command: EC_CMD_CONSOLE_READ
>>> cros_ec_response: version: 1, command: EC_CMD_CONSOLE_READ, result: EC_RES_SUCCESS, rc: 0
>>
>> I don't see the advantage of have two traces, one for the request and another
>> one for the response. Do you expect get stuck between them?
> 
> It might if there is a bug in xfer_fxn, we miss an interrupt, or some
> kind of communication problem on the bus (early bring up issues). It's
> also possible to compute the latency of a transaction by having both.
> The mmc subsystem has both mmc_request_start and mmc_request_done. If
> you feel strongly, I can record just the response.

That's a good reason, I am fine with having both. Can we follow the same naming
as used in mmc though?

trace_cros_ec_request_start
trace_cros_ec_request_done


>>
>> What about just move the trace_cros_ec_cmd after the xfer_fnx call and add the
>> results?
>>
>> Thanks,
>>  Enric
>>
>>> cros_ec_request: version: 0, command: EC_CMD_USB_PD_POWER_INFO
>>> cros_ec_response: version: 0, command: EC_CMD_USB_PD_POWER_INFO, result: EC_RES_SUCCESS, rc: 16

Could I suggest the following changes?

 s/result/ec result/
 s/rc/retval/

>>>
>>> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
>>> ---
>>>
>>>  drivers/platform/chrome/cros_ec_proto.c |  7 +++++-
>>>  drivers/platform/chrome/cros_ec_trace.c | 24 +++++++++++++++++++
>>>  drivers/platform/chrome/cros_ec_trace.h | 32 +++++++++++++++++++++++--
>>>  3 files changed, 60 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
>>> index bd485ce98a42..ef2229047e0f 100644
>>> --- a/drivers/platform/chrome/cros_ec_proto.c
>>> +++ b/drivers/platform/chrome/cros_ec_proto.c
>>> @@ -54,7 +54,7 @@ static int send_command(struct cros_ec_device *ec_dev,
>>>       int ret;
>>>       int (*xfer_fxn)(struct cros_ec_device *ec, struct cros_ec_command *msg);
>>>
>>> -     trace_cros_ec_cmd(msg);
>>> +     trace_cros_ec_request(msg);
>>>
>>>       if (ec_dev->proto_version > 2)
>>>               xfer_fxn = ec_dev->pkt_xfer;
>>> @@ -73,6 +73,8 @@ static int send_command(struct cros_ec_device *ec_dev,
>>>       }
>>>
>>>       ret = (*xfer_fxn)(ec_dev, msg);
>>> +
>>> +     trace_cros_ec_response(msg, ret);
>>>       if (msg->result == EC_RES_IN_PROGRESS) {
>>>               int i;
>>>               struct cros_ec_command *status_msg;
>>> @@ -95,7 +97,10 @@ static int send_command(struct cros_ec_device *ec_dev,
>>>               for (i = 0; i < EC_COMMAND_RETRIES; i++) {
>>>                       usleep_range(10000, 11000);
>>>
>>> +                     trace_cros_ec_request(status_msg);
>>>                       ret = (*xfer_fxn)(ec_dev, status_msg);
>>> +                     trace_cros_ec_response(status_msg, ret);
>>> +
>>>                       if (ret == -EAGAIN)
>>>                               continue;
>>>                       if (ret < 0)
>>> diff --git a/drivers/platform/chrome/cros_ec_trace.c b/drivers/platform/chrome/cros_ec_trace.c
>>> index 6f80ff4532ae..28eb94d99ba2 100644
>>> --- a/drivers/platform/chrome/cros_ec_trace.c
>>> +++ b/drivers/platform/chrome/cros_ec_trace.c
>>> @@ -120,5 +120,29 @@
>>>       TRACE_SYMBOL(EC_CMD_PD_GET_LOG_ENTRY), \
>>>       TRACE_SYMBOL(EC_CMD_USB_PD_MUX_INFO)
>>>
>>> +// See enum ec_status
>>
>> Use the C comment style, please.
> I used // because that was the comment format used above `#define
> EC_CMDS`. Do you want me to change that as well?
> 

Yes, use C-style by default. The reason why it is used the C++ style above is
because contains '*/' in the script that broke the C comment.

Thanks,
 Enric

> Thanks
> 
